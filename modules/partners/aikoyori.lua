Finity.Partner {
	key = "keeper",
	name = "The Keeper",
	pos = { x = 0, y = 2 },
	config = { extra = { related_card = "j_finity_periwinklepinecone", benefits = false, cards = 5 } },
	loc_vars = function(self, info_queue, card)
		local cards = card.ability.extra.cards or 5
		if card.ability.extra.benefits then
			return { key = "pnr_finity_keeper_linked", vars = { cards } }
		end
		return { vars = { cards } }
	end,
	calculate = function(self, card, context)
		if context.card_added and context.card.config.center.key == card.ability.extra.related_card then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
			card.ability.extra.benefits = true
			return { message = localize("k_finity_bonus") }
		end
	end,
	calculate_begin = function(self, card)
		local pool = {}
		for i, v in ipairs(G.playing_cards) do
			pool[i] = v
		end
		pseudoshuffle(pool, pseudoseed("finity_keeper"))
		for i = 1, math.min(card.ability.extra.cards or 5, #pool) do
			pool[i]:set_seal(Finity.poll_seal())
		end
	end,
}

Finity.Partner {
	key = "tearful",
	name = "The Tearful",
	pos = { x = 1, y = 2 },
	config = { extra = { related_card = "j_finity_razzleraindrop", xmult = 1.1, chips = 10, money = 0.25, mult = 2 } },
	loc_vars = function(self, info_queue, card)
		local extra, bonus = card.ability.extra, Finity.partner_bonus(card, 2)
		return { vars = { extra.xmult * bonus, extra.chips * bonus, extra.money * bonus, extra.mult * bonus } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local extra, bonus, other = card.ability.extra, Finity.partner_bonus(card, 2), context.other_card
			local ret = {}
			if other:is_suit("Spades") then ret.chips = extra.chips * bonus end
			if other:is_suit("Clubs") then ret.mult = extra.mult * bonus end
			if other:is_suit("Hearts") then ret.xmult = extra.xmult * bonus end
			if other:is_suit("Diamonds") then ret.dollars = extra.money * bonus end
			if next(ret) then
				ret.card = card
				return ret
			end
		end
	end,
}

Finity.Partner {
	key = "smoker",
	name = "The Smoker",
	pos = { x = 4, y = 2 },
	config = { extra = { related_card = "j_finity_velvetvapour" } },
	loc_vars = function(self, info_queue, card)
		return { key = Finity.partner_linked(card) and "pnr_finity_smoker_linked" or nil }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local other = context.other_card
			local rank = other.config.card.value
			local amount = 0
			for _, v in ipairs(context.scoring_hand) do
				if v.config.card.value == rank then
					amount = amount + 1
				end
			end
			other.ability.perma_bonus = (other.ability.perma_bonus or 0) + amount * Finity.partner_bonus(card, 2)
			return {
				extra = { message = localize("k_upgrade_ex"), colour = G.C.CHIPS },
				colour = G.C.CHIPS,
				card = card,
			}
		end
	end,
}

Finity.Partner {
	key = "narcoleptic",
	name = "The Narcoleptic",
	pos = { x = 3, y = 2 },
	config = { extra = { related_card = "j_finity_chamomilecloud", xmult = 1, exmult = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.exmult * Finity.partner_bonus(card, 2), card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult ~= 1 then
			return {
				Xmult_mod = card.ability.extra.xmult,
				message = Finity.xmult_message(card.ability.extra.xmult),
			}
		end
		if context.before and next(G.hand.cards) then
			local target = pseudorandom_element(G.hand.cards, pseudoseed("finity_narcoleptic"))
			target:juice_up()
			if target.ability.set ~= "Enhanced" then
				target:set_ability(G.P_CENTERS[Finity.poll_enhancement()])
				return
			end
			target:set_ability(G.P_CENTERS.c_base)
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.exmult * Finity.partner_bonus(card, 2)
			return {
				message = Finity.xmult_message(card.ability.extra.xmult),
				colour = G.C.RED,
				card = card,
			}
		end
	end,
}

Finity.Partner {
	key = "sheperd",
	name = "The Sheperd",
	pos = { x = 2, y = 2 },
	config = { extra = { related_card = "j_finity_lilaclasso", slots = -4, add = 1 } },
	loc_vars = function(self, info_queue, card)
		local slots = card.ability.extra.slots
		return {
			key = Finity.partner_linked(card) and "pnr_finity_sheperd_linked" or nil,
			vars = { (slots >= 0 and "+" or "") .. slots, card.ability.extra.add * Finity.partner_bonus(card, 2) },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss then
			local add = card.ability.extra.add * Finity.partner_bonus(card, 2)
			card.ability.extra.slots = card.ability.extra.slots + add
			G.jokers.config.card_limit = G.jokers.config.card_limit + add
			return { message = localize("k_upgrade_ex") }
		end
	end,
	calculate_begin = function(self, card)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
}

Finity.Partner {
	key = "mage",
	name = "The Mage",
	pos = { x = 5, y = 2 },
	config = { extra = { related_card = "j_finity_salientstream", discards = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { Finity.partner_bonus(card, 2, 3), card.ability.extra.discards } }
	end,
	calculate = function(self, card, context)
		if context.discard then
			local required = Finity.partner_bonus(card, 2, 3)
			local extra = card.ability.extra
			extra.discards = extra.discards - 1
			if required == 2 and extra.discards == 2 then
				extra.discards = extra.discards - 1
			end
			if extra.discards <= 0 then
				ease_hands_played(1)
				extra.discards = required
				return {
					message = localize { type = "variable", key = "a_finity_hands", vars = { 1 } },
					colour = G.C.CHIPS,
					card = card,
				}
			end
			return {
				message = localize { type = "variable", key = "a_finity_left", vars = { extra.discards } },
				card = card,
			}
		end
	end,
}

Finity.Partner {
	key = "reveler",
	name = "The Reveler",
	pos = { x = 6, y = 2 },
	config = { extra = { related_card = "j_finity_luminouslemonade" } },
	loc_vars = function(self, info_queue, card)
		return { key = Finity.partner_linked(card) and "pnr_finity_reveler_linked" or nil }
	end,
	calculate_cash = function(self, card)
		local bonus = (G.GAME.current_round.hands_left + G.GAME.current_round.discards_left) * Finity.partner_bonus(card, 2)
		if bonus > 0 then return bonus end
	end,
}

Finity.Partner {
	key = "gamer",
	name = "The Gamer",
	pos = { x = 7, y = 2 },
	config = { extra = { related_card = "j_finity_gloriousglaive", xmult = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult + Finity.partner_bonus(card, 0.25, 0) } }
	end,
	calculate = function(self, card, context)
		if context.post_trigger and context.other_card then
			local xmult = card.ability.extra.xmult + Finity.partner_bonus(card, 0.25, 0)
			return {
				Xmult_mod = xmult,
				message = Finity.xmult_message(xmult),
				card = card,
			}
		end
	end,
}
