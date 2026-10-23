local LAVENDER_TIME = 30

SMODS.Joker {
	key = "lavenderloop",
	name = "Lavender Loop",
	atlas = "crybossjokers",
	pronouns = "she_her",
	poke_custom_prefix = "finity_cryboss",
	config = {
		elapsed = 0,
		inblind = 0,
		time = LAVENDER_TIME,
	},
	unlocked = true,
	discovered = true,
	eternal_compat = false,
	perishable_compat = true,
	blueprint_compat = false,
	rarity = "finity_showdown",
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
		return {
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.3 },
					nodes = {
						{ n = G.UIT.T, config = { ref_table = card.ability, ref_value = "time", scale = 0.32, colour = G.C.BLACK } },
					},
				},
			},
		}
	end,
	update = function(self, card, dt)
		local running = card.ability.inblind == 1
		if running and not G.SETTINGS.paused then
			card.ability.elapsed = (card.ability.elapsed or 0) + (dt or 0)
		end
		local remaining = LAVENDER_TIME - (running and card.ability.elapsed or 0)
		card.ability.time = (string.format("%.2f", remaining):gsub("%.", ":"))
	end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.setting_blind then
			card.ability.elapsed = 0
			card.ability.inblind = 1
			return { message = localize("k_finity_start") }
		end
		if (context.end_of_round and context.main_eval) or context.forcetrigger then
			card.ability.inblind = 0
			if context.forcetrigger or (card.ability.elapsed or 0) <= LAVENDER_TIME then
				card:start_dissolve()
				SMODS.add_card { set = "Joker", rarity = "cry_exotic" }
				return { message = localize("k_finity_success") }
			end
			return { message = localize("k_finity_failure") }
		end
	end,
}

SMODS.Joker {
	key = "turquoisetornado",
	name = "Turquoise Tornado",
	atlas = "crybossjokers",
	pronouns = "she_her",
	poke_custom_prefix = "finity_cryboss",
	config = {
		extra = { chips = 0 },
		multiplier = 15,
		odds = 3,
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 2, card.ability.odds, "finity_turquoisetornado")
		return { vars = { numerator, card.ability.multiplier, denominator, card.ability.extra.chips } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
	cost = 10,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and card.ability.extra.chips > 0 then
			return { chips = card.ability.extra.chips }
		end
		if context.destroying_card and not context.blueprint
			and SMODS.pseudorandom_probability(card, "turquoisetornado", 2, card.ability.odds, "finity_turquoisetornado") then
			local destroyed = context.destroying_card
			card.ability.extra.chips = card.ability.extra.chips + (destroyed.base.nominal + (destroyed.ability.perma_bonus or 0)) * card.ability.multiplier
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.CHIPS,
				remove = true,
				card = card,
			}
		end
	end,
}

SMODS.Joker {
	key = "vermillionvirus",
	name = "Vermillion Virus",
	atlas = "crybossjokers",
	pronouns = "he_they_it",
	poke_custom_prefix = "finity_cryboss",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.repetition or not ((context.end_of_round and context.main_eval) or context.forcetrigger) then return end
		local position = Finity.joker_position(context.blueprint_card or card)
		if not position then return end
		local target = G.jokers.cards[position + 1]
		if not target or target.ability.eternal then return end
		local higher = Finity.shift_rarity(target.config.center.rarity, 1, Finity.virus_max_tier())
		if higher then
			target:start_dissolve()
			SMODS.add_card { set = "Joker", rarity = higher }
			card:juice_up(0.3, 0.5)
		end
	end,
}

SMODS.Joker {
	key = "sapphirestamp",
	name = "Sapphire Stamp",
	atlas = "crybossjokers",
	pronouns = "he_they",
	poke_custom_prefix = "finity_cryboss",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	rarity = "finity_showdown",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	cost = 10,
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(1e6)
		SMODS.change_discard_limit(1e6)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1e6)
		SMODS.change_discard_limit(-1e6)
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end,
}

SMODS.Joker {
	key = "obsidianorb",
	name = "Obsidian Orb",
	atlas = "crybossjokers",
	pronouns = "he_it",
	poke_custom_prefix = "finity_cryboss",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	rarity = "finity_showdown",
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 },
	cost = 10,
	--huge thanks to Somethingcom515 for helping me with this multi-blueprint effect
	--anyone reading this should definitely check out his awesome mod "seals on everything" :)
	calculate = function(self, card, context)
		if context.blueprint then return end
		local holder = Finity.joker_position(card)
		local effects = {}
		for i, other in ipairs(G.jokers.cards) do
			if i ~= holder and other ~= card and other.config.center.key ~= "j_finity_obsidianorb" then
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

SMODS.Joker {
	key = "lemontrophy",
	name = "Lemon Trophy",
	atlas = "crybossjokers",
	pronouns = "he_him",
	poke_custom_prefix = "finity_cryboss",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				message = localize("k_finity_balanced"),
				chip_mod = mult - hand_chips,
				colour = G.C.CHIPS,
			}
		end
	end,
}
