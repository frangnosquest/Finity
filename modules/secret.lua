local IDLE = 20
local SPREAD = 50
local MAX_GAP = 3.4
local BUTTON_GAP = 2.8
local OVERLAP = 0.1875
local COCONUT_SIZE = 3.6

local function smooth(progress)
	return progress * progress * (3 - 2 * progress)
end

local function button_definition(back, text)
	return { n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR }, nodes = {
		{ n = G.UIT.R, config = { align = "cm", r = 0.1, padding = 0.12, minw = 2.2, minh = 0.7, hover = true, shadow = true, colour = back, button = "finity_open_coconut", one_press = true }, nodes = {
			{ n = G.UIT.T, config = { text = localize("k_finity_secret_button"), scale = 0.6, colour = text, shadow = true } },
		} },
	} }
end

local function show_button(box)
	local slot = box:get_UIE_by_ID("finity_secret_slot")
	if not slot then return end
	local back, text = { 0.45, 0.05, 0.07, 0 }, { 1, 1, 1, 0 }
	slot.config.object:remove()
	slot.config.object = UIBox {
		definition = button_definition(back, text),
		config = { offset = { x = 0, y = 0 }, align = "cm", parent = slot },
	}
	ease_value(back, 4, 1, false, nil, true, 1.5)
	ease_value(text, 4, 1, false, nil, true, 1.5)
	box:recalculate()
	play_sound("holo1", 1.2, 0.4)
end

local function advance(area)
	local state = area.finity_secret
	local box = area.parent and area.parent.UIBox
	if not box or (state.button and state.gap >= MAX_GAP) then return end
	state.elapsed = state.elapsed + G.real_dt
	local gap = MAX_GAP * smooth(math.min(1, math.max(0, (state.elapsed - IDLE) / SPREAD)))
	if math.abs(gap - state.gap) >= 0.01 then
		local spacer = box:get_UIE_by_ID("finity_secret_gap")
		if spacer then
			spacer.config.minw = gap + 0.001
			state.gap = gap
			box:recalculate()
		end
	end
	if not state.button and gap >= BUTTON_GAP then
		state.button = true
		show_button(box)
	end
end

local function credit_area(key, side, state)
	local area = CardArea(
		G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
		G.CARD_W,
		0.95 * G.CARD_H,
		{ card_limit = 1, type = "title", highlight_limit = 0, collection = true }
	)
	area:emplace(Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, Finity.credit_center(key)))
	area.finity_secret = state
	function area:align_cards()
		CardArea.align_cards(self)
		local wobble = G.SETTINGS.reduced_motion and 0 or 0.02
		local pull = side * 0.5 * OVERLAP * G.CARD_W * (1 - state.gap / MAX_GAP)
		for _, card in ipairs(self.cards) do
			card.T.x = card.T.x + pull
			card.T.r = -side * 0.05 + wobble * math.sin(2 * G.TIMERS.REAL + card.T.x)
		end
	end
	return area
end

function Finity.secret_credits_row(left_key, right_key)
	local state = { elapsed = 0, gap = 0, button = false }
	local left, right = credit_area(left_key, 1, state), credit_area(right_key, -1, state)
	function left:update(dt)
		CardArea.update(self, dt)
		advance(self)
	end
	return {
		n = G.UIT.R,
		config = { align = "cm", padding = 0, no_fill = true },
		nodes = {
			{ n = G.UIT.C, config = { align = "cm" }, nodes = { { n = G.UIT.O, config = { object = left } } } },
			{ n = G.UIT.C, config = { align = "cm", id = "finity_secret_gap", minw = 0.001 }, nodes = {
				{ n = G.UIT.O, config = { id = "finity_secret_slot", object = Moveable() } },
			} },
			{ n = G.UIT.C, config = { align = "cm" }, nodes = { { n = G.UIT.O, config = { object = right } } } },
		},
	}
end

function G.FUNCS.finity_open_coconut(e)
	local sprite = Sprite(0, 0, COCONUT_SIZE, COCONUT_SIZE, G.ASSET_ATLAS["finity_coconut"], { x = 0, y = 0 })
	G.FUNCS.overlay_menu({
		definition = create_UIBox_generic_options({
			back_func = "openModUI_finity",
			contents = { { n = G.UIT.O, config = { object = sprite } } },
		}),
	})
	Finity.coconut_menu = G.OVERLAY_MENU
end

if NFS.getInfo(SMODS.current_mod.path .. "assets/sounds/music_what.ogg") then
	SMODS.Sound {
		key = "music_what",
		path = "music_what.ogg",
		select_music_track = function(self)
			return Finity.coconut_menu ~= nil and G.OVERLAY_MENU == Finity.coconut_menu and 1000000
		end,
	}
end
