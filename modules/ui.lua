local function text_row(text, scale)
	return { n = G.UIT.R, config = { align = "tm" }, nodes = { { n = G.UIT.T, config = { text = text, colour = G.C.WHITE, scale = scale } } } }
end

local function text_rows(key, scale)
	local lines = localize(key)
	if type(lines) ~= "table" then lines = { lines } end
	local rows = {}
	for _, line in ipairs(lines) do
		rows[#rows + 1] = text_row(line, scale)
	end
	rows[#rows + 1] = text_row("", 0.5)
	return rows
end

local function credits_row(keys)
	local area = CardArea(
		G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
		4.25 * G.CARD_W,
		0.95 * G.CARD_H,
		{ card_limit = 5, type = "title", highlight_limit = 0, collection = true }
	)
	for _, key in ipairs(keys) do
		area:emplace(Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, Finity.credit_center(key)))
	end
	return {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.07, no_fill = true },
		nodes = { { n = G.UIT.O, config = { object = area } } },
	}
end

local function credits_page(rows)
	return {
		n = G.UIT.ROOT,
		config = { r = 0.1, minw = 10, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK },
		nodes = rows,
	}
end

SMODS.current_mod.extra_tabs = function()
	return {
		{
			label = localize("b_finity_credits"),
			tab_definition_function = function()
				local rows = text_rows("k_finity_credits_title", 1)
				rows[#rows + 1] = Finity.secret_credits_row("freh", "missingnumber")
				return credits_page(rows)
			end,
		},
		{
			label = localize("b_finity_thanks"),
			tab_definition_function = function()
				local rows = text_rows("ml_finity_thanks_text", 0.5)
				rows[#rows + 1] = credits_row({ "aikoyori", "paya", "notmario", "jpenguin" })
				rows[#rows + 1] = credits_row({ "ee", "unik", "cruel", "madcap" })
				return credits_page(rows)
			end,
		},
	}
end

local loaded_config = { spectral = Finity.config.spectral, olderortalab = Finity.config.olderortalab }
local restart_pending = {}

local function restarts_game(field)
	return function(value)
		local needs_restart = value ~= loaded_config[field]
		if needs_restart == (restart_pending[field] or false) then return end
		restart_pending[field] = needs_restart
		SMODS.full_restart = (SMODS.full_restart or 0) + (needs_restart and 1 or -1)
	end
end

local finity_mod = SMODS.current_mod
local mods_button_ref = G.FUNCS.mods_button

local function restart_requested()
	for _, pending in pairs(restart_pending) do
		if pending then return true end
	end
	return false
end

function G.FUNCS.mods_button(e)
	if G.ACTIVE_MOD_UI == finity_mod and restart_requested() then
		return G.FUNCS.exit_mods()
	end
	return mods_button_ref(e)
end

SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK },
		nodes = {
			{ n = G.UIT.R, config = { align = "cm" }, nodes = {
				create_toggle({ label = localize("finity_config_spectral"), ref_table = Finity.config, ref_value = "spectral", active_colour = G.C.BLUE, right = true, callback = restarts_game("spectral") }),
			} },
			{ n = G.UIT.R, config = { align = "cm" }, nodes = {
				create_toggle({ label = localize("finity_config_olderortalab"), ref_table = Finity.config, ref_value = "olderortalab", active_colour = G.C.RED, right = false, callback = restarts_game("olderortalab") }),
			} },
		},
	}
end
