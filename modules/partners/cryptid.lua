local edition_upgrades = {
	{ "foil", "e_holo" },
	{ "holo", "e_polychrome" },
	{ "polychrome", "e_cry_astral" },
}

local function upgrade_edition(card)
	if not card.edition then
		card:set_edition("e_foil", true)
		return
	end
	for _, step in ipairs(edition_upgrades) do
		if card.edition[step[1]] then
			card:set_edition(step[2], true)
			return
		end
	end
end

Finity.Partner {
	key = "infectee",
	name = "The Infectee",
	pos = { x = 0, y = 1 },
	config = { extra = { related_card = "j_finity_vermillionvirus" } },
	loc_vars = function(self, info_queue, card)
		return { key = Finity.partner_linked(card) and "pnr_finity_infectee_linked" or nil }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss and #G.jokers.cards >= 1 then
			upgrade_edition(G.jokers.cards[1])
			if Finity.partner_linked(card) then
				upgrade_edition(G.jokers.cards[#G.jokers.cards])
			end
			card:juice_up()
		end
	end,
}

Finity.Partner {
	key = "forgetful",
	name = "The Forgetful",
	pos = { x = 1, y = 1 },
	config = { extra = { related_card = "j_finity_sapphirestamp", used = false, selection_add = 1, hand_size = 2 } },
	loc_vars = function(self, info_queue, card)
		if Finity.partner_linked(card) then
			return { key = "pnr_finity_forgetful_linked", vars = { card.ability.extra.hand_size } }
		end
		return { vars = { card.ability.extra.selection_add } }
	end,
	calculate = function(self, card, context)
		local extra = card.ability.extra
		if context.setting_blind then
			if Finity.partner_linked(card) then
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand:change_size(extra.hand_size)
						G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + extra.hand_size
						card_eval_status_text(card, "extra", nil, nil, nil, { message = localize { type = "variable", key = "a_handsize", vars = { extra.hand_size } } })
						return true
					end,
				}))
			elseif not extra.used then
				extra.used = true
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.change_play_limit(extra.selection_add)
						SMODS.change_discard_limit(extra.selection_add)
						card_eval_status_text(card, "extra", nil, nil, nil, { message = localize { type = "variable", key = "a_finity_selection", vars = { extra.selection_add } } })
						return true
					end,
				}))
			end
		end
		if context.end_of_round and not context.repetition and not context.individual and extra.used then
			extra.used = false
			SMODS.change_play_limit(-extra.selection_add)
			SMODS.change_discard_limit(-extra.selection_add)
		end
	end,
}

Finity.Partner {
	key = "snob",
	name = "The Snob",
	pos = { x = 5, y = 1 },
	config = { extra = { related_card = "j_finity_turquoisetornado", odds = 3, chips = 10 } },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "finity_snob")
		return { vars = { numerator, denominator, card.ability.extra.chips * Finity.partner_bonus(card, 2) } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and G.GAME.blind.config.blind.key == "bl_final_vessel" then
			Finity.partner_quip(card, "pnr_finity_special_snob_vessel")
		end
		if context.before then
			local bonus = card.ability.extra.chips * Finity.partner_bonus(card, 2)
			local upgraded = false
			for _, v in ipairs(context.full_hand) do
				if SMODS.pseudorandom_probability(card, "snob", 1, card.ability.extra.odds, "finity_snob") then
					v.ability.perma_bonus = (v.ability.perma_bonus or 0) + bonus
					v:juice_up()
					upgraded = true
				end
			end
			if upgraded then
				return { message = localize("k_upgrade_ex") }
			end
		end
	end,
}

Finity.Partner {
	key = "haunt",
	name = "The Haunt",
	pos = { x = 2, y = 1 },
	config = { extra = { related_card = "j_finity_obsidianorb", odds = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal * Finity.partner_bonus(card, 2), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		local chance = G.GAME.probabilities.normal * Finity.partner_bonus(card, 2) / card.ability.extra.odds
		local effects = {}
		for _, other in ipairs(G.jokers.cards) do
			if other.config.center.key ~= "j_finity_obsidianorb" and pseudorandom("haunt") < chance then
				local effect = SMODS.blueprint_effect(card, other, context)
				if effect then
					effect.colour = G.C.BLACK
					effects[#effects + 1] = effect
				end
			end
		end
		return Finity.merge_effects(effects)
	end,
}

local function is_daytime()
	local hour = tonumber(os.date("%H"))
	return hour >= 6 and hour < 18
end

Finity.Partner {
	key = "busybody",
	name = "The Busybody",
	pos = { x = 3, y = 1 },
	config = { extra = { related_card = "j_finity_lavenderloop", money = 2, storedmoney = 0, odds = 3 } },
	loc_vars = function(self, info_queue, card)
		local bonus = Finity.partner_bonus(card, 2)
		if is_daytime() then
			return { vars = { card.ability.extra.money * bonus } }
		end
		local numerator, denominator = SMODS.get_probability_vars(card, bonus, card.ability.extra.odds, "finity_busybody")
		return { key = "pnr_finity_busybody_night", vars = { numerator, denominator } }
	end,
	calculate = function(self, card, context)
		if not context.before then return end
		local extra = card.ability.extra
		local bonus = Finity.partner_bonus(card, 2)
		if is_daytime() then
			for _, v in ipairs(context.scoring_hand) do
				if v:is_suit("Hearts") or v:is_suit("Diamonds") then
					extra.storedmoney = extra.storedmoney + extra.money * bonus
					return {
						message = localize("$") .. extra.storedmoney,
						colour = G.C.MONEY,
						card = card,
					}
				end
			end
			return
		end
		for _, v in ipairs(context.scoring_hand) do
			if v:is_suit("Spades") or v:is_suit("Clubs") then
				if SMODS.pseudorandom_probability(card, "busybody", bonus, extra.odds, "finity_busybody")
					and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card { set = "Spectral", key_append = "finity_busybody" }
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					return {
						message = localize("k_plus_spectral"),
						colour = G.C.SECONDARY_SET.Spectral,
						card = card,
					}
				end
				return
			end
		end
	end,
	calculate_cash = function(self, card)
		local bonus = card.ability.extra.storedmoney
		card.ability.extra.storedmoney = 0
		if bonus > 0 then return bonus end
	end,
}

Finity.Partner {
	key = "narcissist",
	name = "The Narcissist",
	pos = { x = 4, y = 1 },
	config = { extra = { related_card = "j_finity_lemontrophy", xchips = 2, used = false } },
	loc_vars = function(self, info_queue, card)
		if Finity.partner_linked(card) then
			return { key = "pnr_finity_narcissist_linked", vars = { card.ability.extra.xchips * 1.5 } }
		end
		return { vars = { card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context)
		if context.before then
			card.ability.extra.used = false
		elseif not card.ability.extra.used and mult and hand_chips and to_big(mult) >= to_big(hand_chips) then
			card.ability.extra.used = true
			if Finity.partner_linked(card) then
				return { xmult = card.ability.extra.xchips * 1.5, card = card }
			end
			return { xchips = card.ability.extra.xchips, card = card }
		end
	end,
}
