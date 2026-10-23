local jd_def = JokerDisplay.Definitions

local function xmult_node(ref_value, colour)
	return {
		border_nodes = {
			{ text = "X" },
			{ ref_table = "card.joker_display_values", ref_value = ref_value, retrigger_type = "exp" },
		},
		border_colour = colour,
	}
end

local function reminder(ref_value)
	return {
		{ text = "(", colour = G.C.UI.TEXT_INACTIVE },
		{ ref_table = "card.joker_display_values", ref_value = ref_value, colour = G.C.ORANGE },
		{ text = ")", colour = G.C.UI.TEXT_INACTIVE },
	}
end

local function scaling_xmult(key)
	jd_def[key] = {
		text = { xmult_node("xmult") },
		calc_function = function(card)
			card.joker_display_values.xmult = card.ability.extra.xmult
		end,
	}
end

for _, key in ipairs({
	"j_finity_violetvessel",
	"j_finity_amberacorn",
	"j_finity_chamomilecloud",
	"j_finity_lilaclasso",
}) do
	scaling_xmult(key)
end

jd_def["j_finity_razzleraindrop"] = {
	text = { xmult_node("xmult") },
	reminder_text = reminder("suit"),
	calc_function = function(card)
		card.joker_display_values.xmult = card.ability.extra.xmult
		local suit = card.ability.suit
		card.joker_display_values.suit = suit ~= "none" and localize(suit, "suits_singular") or "-"
	end,
}

jd_def["j_finity_turquoisetornado"] = {
	text = {
		{ text = "+" },
		{ ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" },
	},
	text_config = { colour = G.C.CHIPS },
}

jd_def["j_finity_lavenderloop"] = {
	reminder_text = reminder("time"),
	calc_function = function(card)
		card.joker_display_values.time = card.ability.time
	end,
}

jd_def["j_finity_velvetvapour"] = {
	reminder_text = reminder("ranks"),
	calc_function = function(card)
		local ranks = card.ability.ranks
		local function name(rank)
			return rank == "none" and "-" or localize(tostring(rank), "ranks")
		end
		card.joker_display_values.ranks = name(ranks.first) .. ", " .. name(ranks.second)
	end,
}

jd_def["j_finity_luminouslemonade"] = {
	text = {
		xmult_node("xmult"),
		{ text = " " },
		xmult_node("xchips", G.C.CHIPS),
	},
	calc_function = function(card)
		local extra = card.ability.extra
		card.joker_display_values.xmult = extra.exmult * (G.GAME.unused_discards or 0) + 1
		card.joker_display_values.xchips = extra.exchips * (G.GAME.hands_played or 0) + 1
	end,
}

jd_def["j_finity_silversword"] = {
	text = { xmult_node("xmult") },
	calc_function = function(card)
		card.joker_display_values.xmult = 1 + card.ability.extra.xmult * (G.jokers and #G.jokers.cards or 0)
	end,
}

jd_def["j_finity_taupetreble"] = {
	text = { xmult_node("xmult") },
	reminder_text = reminder("per_card"),
	calc_function = function(card)
		card.joker_display_values.xmult = card.ability.extra.xMult
		card.joker_display_values.per_card = localize("k_finity_per_enhanced")
	end,
}
