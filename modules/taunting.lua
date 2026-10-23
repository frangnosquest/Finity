local DEFAULT_BLIND = "bl_final_bell"
local COLUMNS, ROWS = 5, 2

Finity.taunting = {
	blind = DEFAULT_BLIND,
}

local function deck_sprite(blind)
	local showdown = Finity.get_showdown(blind)
	local sprite = showdown and showdown.deck
	if not (sprite and G.ASSET_ATLAS[sprite.atlas]) then
		sprite = Finity.placeholder_deck
	end
	return sprite.atlas, sprite.pos
end

local function set_taunting_blind(blind)
	Finity.taunting.blind = blind
	local center = G.P_CENTERS.b_finity_taunting
	center.atlas, center.pos = deck_sprite(blind)
end

SMODS.Back {
	key = "taunting",
	atlas = "blinddeck",
	pos = { x = 5, y = 0 },
	loc_vars = function(self, info_queue, back)
		return { vars = { Finity.showdown_name(Finity.taunting.blind) } }
	end,
	apply = function(self, back)
		G.GAME.finity_taunting_blind = Finity.taunting.blind
		G.GAME.banned_keys["v_directors_cut"] = true
		G.GAME.banned_keys["v_retcon"] = true
	end,
}

local function saved_blind()
	local data = G.PROFILES[G.SETTINGS.profile].finityblinddeckdata
	if type(data) ~= "table" then return end
	return data.blind or data[3]
end

function Finity.load_taunting()
	local blind = saved_blind()
	set_taunting_blind(G.P_BLINDS[blind] and blind or DEFAULT_BLIND)
end

local function taunting_choices()
	local keys = {}
	for k, v in pairs(G.P_BLINDS) do
		if v.boss and v.boss.showdown and not k:match("_dx$") then
			keys[#keys + 1] = k
		end
	end
	table.sort(keys, function(a, b)
		return Finity.showdown_name(a) < Finity.showdown_name(b)
	end)
	return keys
end

local function stick_back(card, atlas, pos)
	if card.children.back then card.children.back:remove() end
	local back = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[atlas], pos)
	back.states.hover = card.states.hover
	back.states.click = card.states.click
	back.states.drag = card.states.drag
	back.states.collide.can = false
	back:set_role({ major = card, role_type = "Glued", draw_major = card })
	card.children.back = back
end

local function choice_column(blind)
	local area = CardArea(G.ROOM.T.x, G.ROOM.T.h, G.CARD_W, G.CARD_H, { card_limit = 1, type = "title", highlight_limit = 0, collection = true })
	local card = Card(area.T.x, area.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.b_finity_taunting)
	card.sprite_facing = "back"
	card.facing = "back"
	stick_back(card, deck_sprite(blind))
	card.no_ui = true
	card.finity_taunting_choice = blind
	area:emplace(card, nil, true)
	local selected = blind == Finity.taunting.blind
	return {
		n = G.UIT.C,
		config = { align = "cm", padding = 0.05 },
		nodes = {
			{ n = G.UIT.R, config = { align = "cm" }, nodes = { { n = G.UIT.O, config = { object = area } } } },
			{ n = G.UIT.R, config = { align = "cm", minh = 0.35 }, nodes = {
				{ n = G.UIT.O, config = { object = DynaText({
					string = Finity.showdown_name(blind),
					colours = { selected and G.C.GOLD or G.C.WHITE },
					scale = 0.32,
					maxw = G.CARD_W * 1.1,
					shadow = true,
					silent = true,
				}) } },
			} },
		},
	}
end

local function open_taunting_menu(page)
	local choices = taunting_choices()
	local per_page = COLUMNS * ROWS
	local pages = math.max(1, math.ceil(#choices / per_page))
	page = math.min(math.max(page or 1, 1), pages)

	local rows = {}
	local first = (page - 1) * per_page + 1
	for row = 1, ROWS do
		local columns = {}
		for column = 1, COLUMNS do
			local blind = choices[first + (row - 1) * COLUMNS + column - 1]
			if blind then
				columns[#columns + 1] = choice_column(blind)
			end
		end
		if next(columns) then
			rows[#rows + 1] = { n = G.UIT.R, config = { align = "cm" }, nodes = columns }
		end
	end

	local page_options = {}
	for i = 1, pages do
		page_options[i] = localize("k_page") .. " " .. i .. "/" .. pages
	end

	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "finity_taunting_back",
			snap_back = true,
			contents = {
				{ n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
					{ n = G.UIT.T, config = { text = localize("k_finity_taunting_choose"), scale = 0.5, colour = G.C.WHITE, shadow = true } },
				} },
				{ n = G.UIT.R, config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = rows },
				pages > 1 and { n = G.UIT.R, config = { align = "cm" }, nodes = {
					create_option_cycle({
						options = page_options,
						current_option = page,
						opt_callback = "finity_taunting_page",
						w = 4.5,
						cycle_shoulders = true,
						colour = G.C.RED,
						no_pips = true,
						focus_args = { snap_to = true, nav = "wide" },
					}),
				} } or nil,
			},
		}),
	})
end

local DECK_CYCLE_KEY = "deck_choice_select_cycle"

local function find_deck_cycler(node)
	if not node then return end
	local config = node.config
	if config and config.pass_through and config.pass_through.key == DECK_CYCLE_KEY then return node end
	for _, child in pairs(node.children or {}) do
		local found = find_deck_cycler(child)
		if found then return found end
	end
	local object = config and config.object
	if object and object.UIRoot then return find_deck_cycler(object.UIRoot) end
end

local function current_deck_grid_page()
	local cycler = G.OVERLAY_MENU and find_deck_cycler(G.OVERLAY_MENU.UIRoot)
	return cycler and cycler.config.pass_through.page_label.page
end

local function restore_deck_grid_page(page)
	local cycler = page and page > 1 and G.OVERLAY_MENU and find_deck_cycler(G.OVERLAY_MENU.UIRoot)
	if not cycler then return end
	local args = cycler.config.pass_through
	if page > args.total_pages or not cycler.config.switch_func then return end
	args.page_label.page = page
	args.page_label.text = localize("k_page") .. " " .. page .. "/" .. args.total_pages
	cycler.config.switch_func({ from = 1, to = page })
end

local function restore_page(page)
	local run_select = SMODS.RunSelect
	local next_button = G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID("next_selection")
	if not (run_select and next_button and page and page > 1 and run_select.Internals.pages[page]) then return end
	run_select.Internals.current_page = page - 1
	run_select.Functions.change_page(next_button)
end

local function return_to_setup()
	local taunting = Finity.taunting
	local main_menu_ui = G.MAIN_MENU_UI
	G.MAIN_MENU_UI = nil
	taunting.returning = true
	local built, definition = pcall(G.UIDEF.run_setup)
	taunting.returning = nil
	G.MAIN_MENU_UI = main_menu_ui
	taunting.saved_choices = nil
	if not built then error(definition) end
	G.FUNCS.overlay_menu({ definition = definition })
	restore_page(taunting.saved_page)
	restore_deck_grid_page(taunting.saved_grid_page)
	taunting.saved_page, taunting.saved_grid_page = nil, nil
end

local setup_run_ref = G.FUNCS.setup_run
G.FUNCS.setup_run = function(e)
	set_taunting_blind(Finity.taunting.blind)
	return setup_run_ref(e)
end

G.FUNCS.finity_taunting_page = function(args)
	open_taunting_menu(args.cycle_config.current_option)
end

G.FUNCS.finity_taunting_back = function(e)
	return_to_setup()
end

if G.UIDEF.run_select_galdur then
	local run_select_ref = G.UIDEF.run_select_galdur
	G.UIDEF.run_select_galdur = function(...)
		local saved = Finity.taunting.returning and Finity.taunting.saved_choices
		if not saved then return run_select_ref(...) end
		local profile = G.PROFILES[G.SETTINGS.profile]
		local last = profile.last_choices
		profile.last_choices = saved
		local ret = run_select_ref(...)
		profile.last_choices = last
		return ret
	end
end

local function is_taunting_opener(card)
	if card.params and card.params.run_select_preview_card == "deck_choice" then
		local internals = SMODS.RunSelect.Internals
		return card.config.center.key == "b_finity_taunting" and internals.pages[internals.current_page] == "deck_choice"
	end
	if Galdur then
		return Finity.safely_get(Galdur, "run_setup", "current_page") == 1
			and card.config.center.key == "b_finity_taunting"
			and card.area == Finity.safely_get(Galdur, "run_setup", "selected_deck_area")
	end
	return card.back == "viewed_back"
		and Finity.safely_get(G.GAME, "viewed_back", "effect", "center", "key") == "b_finity_taunting"
end

local card_click_ref = Card.click
function Card:click()
	if self.finity_taunting_choice then
		set_taunting_blind(self.finity_taunting_choice)
		G.PROFILES[G.SETTINGS.profile].finityblinddeckdata = { blind = Finity.taunting.blind }
		G:save_progress()
		play_sound("card1")
		return_to_setup()
		return
	end
	if is_taunting_opener(self) then
		if self.params.run_select_preview_card then
			Finity.taunting.saved_choices = copy_table(SMODS.RunSelect.Setup.choices)
			Finity.taunting.saved_page = SMODS.RunSelect.Internals.current_page
			Finity.taunting.saved_grid_page = current_deck_grid_page()
			SMODS.RunSelect.Functions.clean_up()
		end
		open_taunting_menu(1)
		return
	end
	card_click_ref(self)
end
