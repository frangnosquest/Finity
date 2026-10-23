function Finity.partner_linked(card)
	return Finity.has_joker(card.ability.extra.related_card)
end

function Finity.partner_bonus(card, linked_value, base_value)
	if Finity.partner_linked(card) then return linked_value end
	return base_value or 1
end

function Finity.Partner(t)
	local related = t.config.extra.related_card
	t.unlocked = false
	t.discovered = true
	t.individual_quips = true
	t.atlas = "partners"
	t.link_config = t.link_config or { [related] = 1 }
	t.check_for_unlock = function(self, args)
		local center = G.P_CENTERS[related]
		return center ~= nil and get_joker_win_sticker(center, true) >= 8
	end
	return Partner_API.Partner(t)
end

function Finity.partner_quip(card, key)
	G.E_MANAGER:add_event(Event({
		func = function()
			card:add_partner_speech_bubble(key)
			return true
		end,
	}))
	card:partner_say_stuff(5)
end

Finity.Partner {
	key = "scrooge",
	name = "The Scrooge",
	pos = { x = 3, y = 0 },
	config = { extra = { related_card = "j_finity_verdantleaf", money = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money * Finity.partner_bonus(card, 2) } }
	end,
	calculate = function(self, card, context)
		if context.selling_card then
			return {
				dollars = card.ability.extra.money * Finity.partner_bonus(card, 2),
				card = card,
			}
		end
	end,
}

Finity.Partner {
	key = "glutton",
	name = "The Glutton",
	pos = { x = 4, y = 0 },
	config = { extra = { related_card = "j_finity_violetvessel", previous_score = 0 } },
	loc_vars = function(self, info_queue, card)
		return { key = Finity.partner_linked(card) and "pnr_finity_glutton_linked" or nil }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if G.GAME.blind.config.blind.key == "bl_cry_tornado" then
				Finity.partner_quip(card, "pnr_finity_special_glutton_tornado")
			end
			local blind_chips = to_number(G.GAME.blind.chips)
			local previous = to_number(card.ability.extra.previous_score)
			local difference = to_number(G.GAME.chips) + blind_chips - previous
			if previous ~= 0 and difference > 0 then
				G.GAME.chips = difference * Finity.partner_bonus(card, 1, 0.5)
			end
			card.ability.extra.previous_score = blind_chips
		end
	end,
}

Finity.Partner {
	key = "klutz",
	name = "The Klutz",
	pos = { x = 2, y = 0 },
	config = { extra = { related_card = "j_finity_amberacorn", mult = 0, mult_mod = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod * Finity.partner_bonus(card, 2) } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult } },
				mult_mod = card.ability.extra.mult,
			}
		end
		if context.setting_blind then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod * Finity.partner_bonus(card, 2)
			for _ = 1, 3 do
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						G.E_MANAGER:add_event(Event({ delay = 0.15, func = function() G.jokers:shuffle("aajk"); play_sound("cardSlide1", 0.85); return true end }))
						G.E_MANAGER:add_event(Event({ delay = 0.15, func = function() G.jokers:shuffle("aajk"); play_sound("cardSlide1", 1.15); return true end }))
						G.E_MANAGER:add_event(Event({ delay = 0.5, func = function() G.jokers:shuffle("aajk"); play_sound("cardSlide1", 1); return true end }))
						return true
					end,
				}))
			end
			return {
				message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult } },
				colour = G.C.RED,
				card = card,
			}
		end
	end,
}

Finity.Partner {
	key = "lovesick",
	name = "The Lovesick",
	pos = { x = 0, y = 0 },
	config = { extra = { related_card = "j_finity_crimsonheart", mult = 0, mult_mod = 0.5 }, hand_played = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod * Finity.partner_bonus(card, 2) } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.hand_played = true
		end
		if (context.hand_drawn and card.ability.hand_played and not context.blueprint) or (context.end_of_round and not context.repetition and not context.individual) then
			Finity.remove_marks(G.jokers.cards, "finitycrimsonheartmark", "lovesick")
			if context.hand_drawn then
				card.ability.hand_played = false
				local target = Finity.mark_random(G.jokers.cards, "finitycrimsonheartmark", "lovesick", "lovesick", "finity_lovesick", function(v)
					return v.config.center.key == "j_finity_crimsonheart"
				end)
				if target then
					card:juice_up(0.3, 0.5)
				end
			end
		end
		if context.post_trigger and context.other_card and context.other_card.ability and context.other_card.ability.finitycrimsonheartmark then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod * Finity.partner_bonus(card, 2)
			return {
				message = localize("k_finity_partner_upgrade"),
				colour = G.C.RED,
				card = card,
			}
		end
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = "variable", key = "a_mult", vars = { card.ability.extra.mult } },
			}
		end
	end,
}

Finity.Partner {
	key = "controlling",
	name = "The Controlling",
	pos = { x = 1, y = 0 },
	config = { extra = { related_card = "j_finity_ceruleanbell" } },
	loc_vars = function(self, info_queue, card)
		return { key = Finity.partner_linked(card) and "pnr_finity_controlling_linked" or nil }
	end,
	calculate = function(self, card, context)
		if (context.hand_drawn and not context.blueprint) or (context.end_of_round and not context.repetition and not context.individual) then
			Finity.remove_marks(G.playing_cards, "finityceruleanbellmark", "controlling")
			if context.hand_drawn and Finity.mark_random(G.hand.cards, "finityceruleanbellmark", "controlling", "controlling", "finity_controlling") then
				card:juice_up(0.3, 0.5)
			end
		end
		if context.repetition and not context.repetition_only and context.other_card.ability.finityceruleanbellmark then
			return {
				message = localize("k_again_ex"),
				repetitions = Finity.partner_bonus(card, 2),
				card = card,
			}
		end
	end,
}
