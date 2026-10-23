SMODS.Joker {
	key = "mochamike",
	name = "Mocha Mike",
	atlas = "cardsaucebossjokers",
	config = {
		extra = { times = 1 },
	},
	loc_vars = function(self, info_queue, card)
		return {
			key = card.ability.extra.times > 1 and "j_finity_mochamike_plural" or nil,
			vars = { card.ability.extra.times },
		}
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
		if context.joker_main then
			local hand = context.scoring_name
			for _, planet in pairs(G.P_CENTER_POOLS.Planet) do
				if planet.config.hand_type == hand then
					for _ = 1, card.ability.extra.times do
						G.E_MANAGER:add_event(Event({
							func = function()
								local planet_card = create_card("Planet", G.consumeables, nil, nil, nil, true, planet.key)
								planet_card:set_edition("e_negative", true)
								planet_card:add_to_deck()
								G.consumeables:emplace(planet_card)
								return true
							end,
						}))
					end
				end
			end
			return { message = localize("k_plus_planet") }
		end
	end,
}

SMODS.Joker {
	key = "feltfortress",
	name = "Felt Fortress",
	atlas = "cardsaucebossjokers",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	cost = 10,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and to_big(G.GAME.chips) > to_big(0) then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					G.GAME.chips = G.GAME.chips * 2
					return true
				end,
			}))
			return { message = localize("k_finity_doubled") }
		end
	end,
}
