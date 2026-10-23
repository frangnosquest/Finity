local CHOICES = 2

local function showdown_jokers_left()
	local count = 0
	for _, center in ipairs(G.P_JOKER_RARITY_POOLS.finity_showdown or {}) do
		if not G.GAME.used_jokers[center.key] and not G.GAME.banned_keys[center.key] and SMODS.add_to_pool(center) then
			count = count + 1
		end
	end
	return count
end

local function has_room(card)
	return (card.edition and card.edition.negative) or #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
end

local save_run_ref = save_run
function save_run(...)
	if Finity.showdown_choice then return end
	return save_run_ref(...)
end

local function remember_hand()
	local hand = {}
	for _, v in ipairs(G.hand.cards) do
		hand[#hand + 1] = { card = v, hidden = v.facing == "back" }
	end
	return hand
end

local function in_deck(card)
	for _, v in ipairs(G.deck.cards) do
		if v == card then return true end
	end
	return false
end

local function redraw_hand(hand)
	local pending = {}
	for _, entry in ipairs(hand) do
		if in_deck(entry.card) then
			pending[#pending + 1] = entry
		end
	end
	for i, entry in ipairs(pending) do
		draw_card(G.deck, G.hand, i * 100 / #pending, "up", true, entry.card)
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			for _, entry in ipairs(pending) do
				if entry.hidden and entry.card.facing == "front" then
					entry.card:flip()
				end
			end
			return true
		end,
	}))
end

local function hide_menus(choice)
	choice.hidden = {}
	for _, name in ipairs({ "booster_pack", "shop", "blind_select", "round_eval" }) do
		local box = G[name]
		if box and box.alignment and not box.alignment.offset.py then
			box.alignment.offset.py = box.alignment.offset.y
			box.alignment.offset.y = G.ROOM.T.y + 29
			choice.hidden[#choice.hidden + 1] = box
		end
	end
	local prompt = G.blind_prompt_box
	if prompt and prompt.alignment then
		choice.prompt_y = prompt.alignment.offset.y
		prompt.alignment.offset.y = -15
	end
end

local function show_menus(choice)
	for _, box in ipairs(choice.hidden) do
		if box.alignment and box.alignment.offset.py then
			box.alignment.offset.y = box.alignment.offset.py
			box.alignment.offset.py = nil
		end
	end
	if choice.prompt_y and G.blind_prompt_box and G.blind_prompt_box.alignment then
		G.blind_prompt_box.alignment.offset.y = choice.prompt_y
	end
end

local function start_look(choice)
	ease_colour(G.C.DYN_UI.MAIN, G.C.RARITY.finity_showdown)
	ease_background_colour { new_colour = G.C.BLUE, special_colour = G.C.RED, tertiary_colour = darken(G.C.BLACK, 0.4), contrast = 3 }
	if G.booster_pack_sparkles and not G.booster_pack_sparkles.REMOVED then return end
	local colour = G.C.RARITY.finity_showdown
	G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
		timer = 0.015,
		scale = 0.2,
		initialize = true,
		lifespan = 1,
		speed = 1.1,
		padding = -1,
		attach = G.ROOM_ATTACH,
		colours = { G.C.WHITE, lighten(G.C.BLUE, 0.4), lighten(colour, 0.4), lighten(G.C.GOLD, 0.2) },
		fill = true,
	})
	G.booster_pack_sparkles.fade_alpha = 1
	G.booster_pack_sparkles:fade(1, 0)
	choice.sparkles = G.booster_pack_sparkles
end

local function end_look(choice)
	local pack = SMODS.OPENED_BOOSTER
	if choice.prev_state == G.STATES.SMODS_BOOSTER_OPENED and pack and pack.config.center.ease_background_colour then
		pack.config.center:ease_background_colour()
	else
		ease_background_colour_blind(choice.prev_state)
	end
	local sparkles = choice.sparkles
	if not sparkles then return end
	sparkles:fade(1)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 1,
		blocking = false,
		blockable = false,
		func = function()
			sparkles:remove()
			if G.booster_pack_sparkles == sparkles then G.booster_pack_sparkles = nil end
			return true
		end,
	}))
end

local function close_choice(choice, picked)
	if choice.closing then return end
	choice.closing = true
	end_look(choice)
	G.hand.states.visible = choice.hand_visible
	if picked then
		picked.finity_showdown_choice = nil
		if picked.highlighted then
			picked.area:remove_from_highlighted(picked, true)
		end
		picked.area:remove_card(picked)
	end
	if choice.ui then
		choice.ui.alignment.offset.y = G.ROOM.T.y + 9
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.3,
			blocking = false,
			blockable = false,
			func = function()
				choice.ui:remove()
				return true
			end,
		}))
	end
	show_menus(choice)
	if picked then
		picked:add_to_deck()
		G.jokers:emplace(picked)
		play_sound("card1", 0.8, 0.6)
		play_sound("generic1")
	end
	redraw_hand(choice.hand)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.2,
		func = function()
			G.STATE = choice.prev_state
			Finity.showdown_choice = nil
			return true
		end,
	}))
end

function G.FUNCS.finity_showdown_skip(e)
	local choice = Finity.showdown_choice
	if choice then close_choice(choice, nil) end
end

function G.FUNCS.finity_can_select(e)
	if has_room(e.config.ref_table) then
		e.config.colour = G.C.GREEN
		e.config.button = "finity_select_showdown"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

function G.FUNCS.finity_select_showdown(e)
	local choice = Finity.showdown_choice
	if choice and not choice.closing then
		close_choice(choice, e.config.ref_table)
	end
end

local use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	if not card.finity_showdown_choice then
		return use_and_sell_buttons_ref(card)
	end
	return { n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {
		{ n = G.UIT.R, config = { ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5 * card.T.w - 0.15, maxw = 0.9 * card.T.w - 0.15, minh = 0.3 * card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = "finity_select_showdown", func = "finity_can_select" }, nodes = {
			{ n = G.UIT.T, config = { text = localize("b_select"), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true } },
		} },
	} }
end

local function create_choices(area)
	local cards = {}
	for _ = 1, CHOICES do
		local joker = SMODS.create_card { set = "Joker", rarity = "finity_showdown", area = area, skip_materialize = true, soulable = false, key_append = "finity_choice" }
		if joker.config.center.rarity == "finity_showdown" then
			cards[#cards + 1] = joker
		else
			joker:remove()
		end
	end
	return cards
end

local function choice_definition(area)
	return { n = G.UIT.ROOT, config = { align = "tm", r = 0.15, colour = G.C.CLEAR, padding = 0.15 }, nodes = {
		{ n = G.UIT.R, config = { align = "cm", colour = G.C.CLEAR, r = 0.15, padding = 0.1, minh = 2, shadow = true }, nodes = {
			{ n = G.UIT.R, config = { align = "cm" }, nodes = {
				{ n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
					{ n = G.UIT.C, config = { align = "cm", r = 0.2, colour = G.C.CLEAR, shadow = true }, nodes = {
						{ n = G.UIT.O, config = { object = area } },
					} },
				} },
			} },
		} },
		{ n = G.UIT.R, config = { align = "cm" }, nodes = {} },
		{ n = G.UIT.R, config = { align = "tm" }, nodes = {
			{ n = G.UIT.C, config = { align = "tm", padding = 0.05, minw = 2.4 }, nodes = {} },
			{ n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {
				UIBox_dyn_container({
					{ n = G.UIT.C, config = { align = "cm", padding = 0.05, minw = 4 }, nodes = {
						{ n = G.UIT.R, config = { align = "bm", padding = 0.05 }, nodes = {
							{ n = G.UIT.O, config = { object = DynaText({
								string = localize("k_finity_choose_one"),
								colours = { G.C.WHITE },
								shadow = true,
								rotate = true,
								bump = true,
								spacing = 2,
								scale = 0.7,
								maxw = 4,
								pop_in = 0.5,
							}) } },
						} },
					} },
				}),
			} },
			{ n = G.UIT.C, config = { align = "tm", padding = 0.05, minw = 2.4 }, nodes = {
				{ n = G.UIT.R, config = { minh = 0.2 }, nodes = {} },
				{ n = G.UIT.R, config = { align = "tm", padding = 0.2, minh = 1.2, minw = 1.8, r = 0.15, colour = G.C.GREY, one_press = true, button = "finity_showdown_skip", hover = true, shadow = true }, nodes = {
					{ n = G.UIT.T, config = { text = localize("b_skip"), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = { button = "y", orientation = "bm" }, func = "set_button_pip" } },
				} },
			} },
		} },
	} }
end

local function show_choice(choice)
	local area = CardArea(
		G.ROOM.T.x + 9 + G.hand.T.x,
		G.hand.T.y,
		3 * G.CARD_W,
		1.05 * G.CARD_H,
		{ card_limit = CHOICES, type = "consumeable", highlight_limit = 0 }
	)
	choice.cards = create_choices(area)
	if not next(choice.cards) then
		area:remove()
		close_choice(choice, nil)
		return
	end
	choice.ui = UIBox {
		definition = choice_definition(area),
		config = { align = "tmi", offset = { x = 0, y = G.ROOM.T.y + 9 }, major = G.hand, bond = "Weak" },
	}
	choice.ui.alignment.offset.y = -2.2
	G.ROOM.jiggle = G.ROOM.jiggle + 3
	start_look(choice)
	play_sound("holo1", 1.2, 0.5)
	for _, joker in ipairs(choice.cards) do
		joker.finity_showdown_choice = true
		area:emplace(joker)
		joker:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.5)
	end
end

local function open_showdown_choice()
	local choice = { prev_state = G.STATE, hand = remember_hand(), hand_visible = G.hand.states.visible }
	Finity.showdown_choice = choice
	G.STATE = G.STATES.PLAY_TAROT
	hide_menus(choice)
	if next(choice.hand) then
		G.FUNCS.draw_from_hand_to_deck()
	end
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.5,
		func = function()
			G.hand.states.visible = false
			show_choice(choice)
			return true
		end,
	}))
end

local start_dissolve_ref = Card.start_dissolve
function Card:start_dissolve(...)
	if self.finity_used and not self.finity_exploding then
		self.finity_exploding = true
		self:explode({ G.C.WHITE, lighten(G.C.RARITY.finity_showdown, 0.4), G.C.GOLD }, 0.6)
		return
	end
	return start_dissolve_ref(self, ...)
end

SMODS.Consumable {
	key = "finity",
	name = "Finity",
	set = "Spectral",
	hidden = true,
	soul_set = "Spectral",
	soul_rate = 0.006,
	atlas = "consumables",
	pos = { x = 0, y = 0 },
	cost = 4,
	use = function(self, card, area, copier)
		card.finity_used = true
		local ends_pack = G.GAME.PACK_INTERRUPT and area == G.pack_cards and (G.GAME.pack_choices or 0) <= 1
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.3,
			blocking = false,
			blockable = false,
			func = function()
				if G.STATE == G.STATES.PLAY_TAROT or G.TAROT_INTERRUPT then return false end
				if card.finity_exploding and not card.removed then return false end
				if ends_pack and (G.GAME.PACK_INTERRUPT or G.booster_pack) then return false end
				open_showdown_choice()
				return true
			end,
		}))
	end,
	can_use = function(self, card)
		return #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and showdown_jokers_left() > 0
	end,
}

local set_sprites_ref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_sprites_ref(self, _center, _front)
	if _center and _center.key == "c_finity_finity" then
		self.children.floating_sprite = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], { x = 1, y = 0 })
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite.states.hover.can = false
		self.children.floating_sprite.states.click.can = false
	end
end

SMODS.DrawStep {
	key = "finity",
	order = 51,
	func = function(self)
		if self.config.center.key ~= "c_finity_finity" or not (self.config.center.discovered or self.bypass_discovery_center) then return end
		if not self.children.floating_sprite then return end
		local scale_mod = 0.07 + 0.02 * math.cos(1.8 * G.TIMERS.REAL)
		local rotate_mod = 0.5 * G.TIMERS.REAL
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite:draw_shader("dissolve", 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, -0.07 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
		self.children.floating_sprite:draw_shader("dissolve", nil, nil, nil, self.children.center, scale_mod, rotate_mod, nil, -0.2)
	end,
	conditions = { vortex = false, facing = "front" },
}
