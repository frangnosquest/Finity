SMODS.Joker {
	key = "chartreusecrown",
	name = "Chartreuse Crown",
	atlas = "buncobossjokers",
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.cardarea ~= G.play or not context.other_card or Finity.has_base_suit(context.other_card) then return end
		if context.individual then
			return { xmult = card.ability.extra.xmult }
		end
		if context.repetition then
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = card,
			}
		end
	end,
}
