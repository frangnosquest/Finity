SMODS.Joker {
	key = "taupetreble",
	name = "Taupe Treble",
	atlas = "paperbackbossjokers",
	config = {
		extra = { xMult = 1.1, ExMult = 0.1, base = 1.1 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xMult, card.ability.extra.ExMult } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
			local xmult = card.ability.extra.xMult
			if not context.blueprint then
				card.ability.extra.xMult = xmult + card.ability.extra.ExMult
			end
			return { xmult = xmult }
		end
		if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
			card.ability.extra.xMult = card.ability.extra.base or 1.1
		end
	end,
}
