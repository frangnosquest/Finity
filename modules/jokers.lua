SMODS.Joker {
	key = "verdantleaf",
	name = "Verdant Leaf",
	atlas = "bossjokers",
	poke_custom_prefix = "finity_boss",
	pronouns = "she_they",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	cost = 10,
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and context.card ~= card then
			local rarity = context.card.config.center.rarity
			if not Finity.rarity_tier(rarity) then return end
			local lower = Finity.shift_rarity(rarity, -1)
			if not lower then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					SMODS.add_card { set = "Consumeables", area = G.consumeables }
					card:juice_up(0.3, 0.5)
				end
			elseif #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit + 1 then
				SMODS.add_card { set = "Joker", rarity = lower }
				card:juice_up(0.3, 0.5)
			end
		end
	end,
}

SMODS.Joker {
	key = "violetvessel",
	name = "Violet Vessel",
	atlas = "bossjokers",
	poke_custom_prefix = "finity_boss",
	pronouns = "he_him",
	config = {
		extra = { xmult = 1 },
		max = 2,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.max } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 10,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				Finity.refresh_boss_choice()
				return true
			end,
		}))
	end,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and to_big(card.ability.extra.xmult) > to_big(1) then
			return { xmult = card.ability.extra.xmult }
		end
		if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
			if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
				local surplus = to_number(to_big(G.GAME.chips) / to_big(G.GAME.blind.chips))
				local gain = math.floor(math.min(surplus, card.ability.max) * 100 + 0.5) / 100
				card.ability.extra.xmult = to_number(card.ability.extra.xmult) + gain
				return {
					message = Finity.xmult_message(card.ability.extra.xmult),
					colour = G.C.RED,
				}
			end
		end
	end,
}

local function pin_jokers()
	for _, v in ipairs(G.jokers.cards) do
		if v.config.center.key ~= "j_finity_amberacorn" then
			v.pinned = true
		end
	end
end

SMODS.Joker {
	key = "amberacorn",
	name = "Amber Acorn",
	atlas = "bossjokers",
	poke_custom_prefix = "finity_boss",
	pronouns = "he_any",
	config = {
		extra = { xmult = 1 },
		increase = 0.2,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.increase } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 2 },
	soul_pos = { x = 1, y = 2 },
	cost = 10,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult > 1 then
			return { xmult = card.ability.extra.xmult }
		end
		if context.blueprint then return end
		if context.card_added then
			G.E_MANAGER:add_event(Event({
				func = function()
					pin_jokers()
					return true
				end,
			}))
		elseif context.setting_blind or context.before or context.end_of_round then
			pin_jokers()
		end
		if context.end_of_round and context.main_eval and context.game_over == false then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase * #G.jokers.cards
			return {
				message = Finity.xmult_message(card.ability.extra.xmult),
				colour = G.C.RED,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		pin_jokers()
	end,
	remove_from_deck = function(self, card, from_debuff)
		for _, v in ipairs(G.jokers.cards) do
			v.pinned = false
			if v.ability.pinned then
				v.ability.pinned = false
			end
		end
	end,
}

local function not_crimson_target(card)
	return function(v)
		return v == card or v.config.center.key == "j_finity_crimsonheart"
	end
end

SMODS.Joker {
	key = "crimsonheart",
	name = "Crimson Heart",
	atlas = "bossjokers",
	poke_custom_prefix = "finity_boss",
	pronouns = "she_they",
	config = {
		extra = { retriggers = 2 },
		hand_played = true,
		identifier = "0",
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 10,
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.identifier == "0" then
			card.ability.identifier = tostring(pseudorandom("crimsonheart", 1, 999999999999))
		end
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.hand_played = true
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card
			and context.other_card.ability and context.other_card.ability.finitycrimsonheartmark then
			return {
				message = localize("k_again_ex"),
				repetitions = math.min(card.ability.extra.retriggers, 40),
				card = card,
			}
		end
		if (context.hand_drawn and card.ability.hand_played and not context.blueprint) or (context.end_of_round and context.main_eval) then
			Finity.remove_marks(G.jokers.cards, "finitycrimsonheartmark", card.ability.identifier)
			if context.hand_drawn then
				card.ability.hand_played = false
				if Finity.mark_random(G.jokers.cards, "finitycrimsonheartmark", card.ability.identifier, "crimson", "finity_crimsonheart", not_crimson_target(card)) then
					card:juice_up(0.3, 0.5)
				end
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		Finity.remove_marks(G.jokers.cards, "finitycrimsonheartmark", card.ability.identifier)
	end,
}

SMODS.Joker {
	key = "ceruleanbell",
	name = "Cerulean Bell",
	atlas = "bossjokers",
	poke_custom_prefix = "finity_boss",
	pronouns = "she_her",
	config = {
		identifier = "0",
		xmultbonus = 2,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.xmultbonus } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	cost = 10,
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.identifier == "0" then
			card.ability.identifier = tostring(pseudorandom("ceruleanbell", 1, 999999999999))
		end
	end,
	calculate = function(self, card, context)
		if (context.hand_drawn and not context.blueprint) or (context.end_of_round and context.main_eval) then
			Finity.remove_marks(G.playing_cards, "finityceruleanbellmark", card.ability.identifier)
			if context.hand_drawn and Finity.mark_random(G.hand.cards, "finityceruleanbellmark", card.ability.identifier, "cerulean", "finity_ceruleanbell") then
				card:juice_up(0.3, 0.5)
			end
		end
		if context.individual and context.cardarea == G.play and context.other_card.ability.finityceruleanbellmark then
			local ability = context.other_card.ability
			if (ability.perma_x_mult or 0) ~= 0 then
				ability.perma_x_mult = ability.perma_x_mult + card.ability.xmultbonus
			else
				ability.perma_x_mult = card.ability.xmultbonus - 1
			end
			return {
				extra = { message = localize("k_upgrade_ex"), colour = G.C.MULT },
				colour = G.C.MULT,
				card = card,
			}
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		Finity.remove_marks(G.playing_cards, "finityceruleanbellmark", card.ability.identifier)
	end,
}
