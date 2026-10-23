local older = Finity.config.olderortalab

local function most_common_ranks()
	local tally, max_count = {}, 0
	for _, playing_card in ipairs(G.playing_cards or {}) do
		local value = playing_card.base.value
		if value then
			tally[value] = (tally[value] or 0) + 1
			max_count = math.max(max_count, tally[value])
		end
	end
	local ranks = {}
	for value, count in pairs(tally) do
		if count == max_count then
			ranks[#ranks + 1] = value
		end
	end
	table.sort(ranks)
	return ranks
end

local function most_common_ids()
	local tally, max_count = {}, 0
	for _, playing_card in ipairs(G.playing_cards or {}) do
		local id = playing_card:get_id()
		if id then
			tally[id] = (tally[id] or 0) + 1
			max_count = math.max(max_count, tally[id])
		end
	end
	local ids = {}
	for id, count in pairs(tally) do
		if count == max_count then
			ids[id] = true
		end
	end
	return ids
end

local function rank_name(value)
	local name = localize(value, "ranks")
	if name == "ERROR" then
		name = value:match("^[^_]+_(.+)") or value
	end
	return name
end

local function celadon_target_text()
	if not G.playing_cards then return localize("k_none") end
	local ranks = most_common_ranks()
	if #ranks == 1 then
		return localize { type = "variable", key = "finity_rank_plural", vars = { rank_name(ranks[1]) } }
	elseif #ranks == 2 then
		return localize { type = "variable", key = "finity_rank_plural_pair", vars = { rank_name(ranks[1]), rank_name(ranks[2]) } }
	elseif #ranks > 2 then
		return localize("k_finity_multiple_ranks")
	end
	return localize("k_none")
end

if older then
	SMODS.Joker {
		key = "celadonclubs",
		name = "Celadon Clubs",
		atlas = "ortalabbossjokers",
		config = {
			extra = { exchips = 0.2 },
		},
		loc_vars = function(self, info_queue, card)
			return { key = "j_finity_celadonclubs_older", vars = { card.ability.extra.exchips } }
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
			if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) then
				local id = context.other_card:get_id()
				if id % 2 == 0 and id ~= 14 and not context.other_card:is_face() then
					return {
						repetitions = 1,
						message = localize("k_again_ex"),
					}
				end
			end
			if context.individual and context.cardarea == G.play and not context.blueprint then
				local other = context.other_card
				local id = other:get_id()
				if (id % 2 == 1 and not other:is_face()) or id == 14 then
					other.finity_celadon_destroy = true
				elseif other:is_face() then
					other.ability.perma_x_chips = (other.ability.perma_x_chips or 0) + card.ability.extra.exchips
					return {
						extra = { message = localize("k_upgrade_ex"), colour = G.C.CHIPS },
						colour = G.C.CHIPS,
						card = card,
					}
				end
			end
			if context.destroying_card and context.destroying_card.finity_celadon_destroy and not context.blueprint then
				return {
					remove = true,
					message = localize("k_finity_destroyed"),
				}
			end
		end,
	}
else
	SMODS.Joker {
		key = "celadonclubs",
		name = "Celadon Clubs",
		atlas = "ortalabbossjokers",
		config = {
			extra = { xmult = 1.75 },
		},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.xmult, celadon_target_text() } }
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
			if context.before then
				card.finity_celadon_ids = most_common_ids()
			end
			if context.individual and context.cardarea == G.play and (card.finity_celadon_ids or most_common_ids())[context.other_card:get_id()] then
				return { xmult = card.ability.extra.xmult }
			end
		end,
	}
end

SMODS.Joker {
	key = "caramelcoin",
	name = "Caramel Coin",
	atlas = "ortalabbossjokers",
	config = {
		extra = { bonushands = 0 },
	},
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 1 },
	soul_pos = { x = 1, y = 1 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main then
			local hands = context.poker_hands
			if next(hands["Straight Flush"]) or next(hands["Flush House"]) or next(hands["Flush Five"]) then
				card.ability.extra.bonushands = card.ability.extra.bonushands + 1
				G.hand:change_size(1)
				return { message = localize { type = "variable", key = "a_handsize", vars = { 1 } } }
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.bonushands > 0 then
			G.hand:change_size(-card.ability.extra.bonushands)
		end
	end,
}

local function only_enhanced(cards)
	local found
	for _, v in ipairs(cards) do
		if v.ability.set == "Enhanced" then
			if found then return end
			found = v
		end
	end
	return found
end

local function resize_saffron(amount)
	if amount == 0 then return end
	G.jokers:change_size(amount)
	G.hand:change_size(amount)
	G.consumeables:change_size(amount)
end

if older then
	SMODS.Joker {
		key = "saffronshield",
		name = "Saffron Shield",
		atlas = "ortalabbossjokers",
		config = {
			extra = { odds = 2 },
		},
		loc_vars = function(self, info_queue, card)
			local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "finity_saffronshield")
			return { key = "j_finity_saffronshield_older", vars = { numerator, denominator } }
		end,
		unlocked = true,
		discovered = true,
		eternal_compat = true,
		blueprint_compat = true,
		rarity = "finity_showdown",
		pos = { x = 0, y = 2 },
		soul_pos = { x = 1, y = 2 },
		cost = 10,
		calculate = function(self, card, context)
			if context.hand_drawn and not context.blueprint then
				for _, v in ipairs(G.hand.cards) do
					if not v.ability.finitysaffronchecked and not v.ability.finitysaffronshieldmark then
						v.ability.finitysaffronchecked = true
						if SMODS.pseudorandom_probability(card, "saffronshield", 1, card.ability.extra.odds, "finity_saffronshield") then
							card:juice_up()
							v:juice_up()
							v.ability.finitysaffronshieldmark = true
							Finity.attach_mark(v, "saffron")
						end
					end
				end
			end
			if context.end_of_round and context.main_eval then
				for _, v in ipairs(G.playing_cards) do
					v.ability.finitysaffronchecked = nil
				end
			end
		end,
	}

	SMODS.Joker {
		key = "rougerose",
		name = "Rouge Rose",
		atlas = "ortalabbossjokers",
		loc_vars = function(self, info_queue, card)
			return { key = "j_finity_rougerose_older" }
		end,
		unlocked = true,
		discovered = true,
		eternal_compat = false,
		blueprint_compat = false,
		rarity = "finity_showdown",
		pos = { x = 0, y = 3 },
		soul_pos = { x = 1, y = 3 },
		cost = 10,
		calculate = function(self, card, context)
			if context.selling_self and not context.blueprint then
				ease_ante(-G.GAME.round_resets.ante + 1)
			end
		end,
	}
else
	SMODS.Joker {
		key = "saffronshield",
		name = "Saffron Shield",
		atlas = "ortalabbossjokers",
		config = {
			extra = { modifier = 0 },
		},
		loc_vars = function(self, info_queue, card)
			return { vars = { Finity.missing_base_suits() } }
		end,
		unlocked = true,
		discovered = true,
		eternal_compat = true,
		blueprint_compat = false,
		rarity = "finity_showdown",
		pos = { x = 0, y = 2 },
		soul_pos = { x = 1, y = 2 },
		cost = 10,
		set_ability = function(self, card, initial, delay_sprites)
			if G.playing_cards then
				card.ability.extra.modifier = Finity.missing_base_suits()
			end
		end,
		add_to_deck = function(self, card, from_debuff)
			card.ability.extra.modifier = Finity.missing_base_suits()
			resize_saffron(card.ability.extra.modifier)
		end,
		remove_from_deck = function(self, card, from_debuff)
			resize_saffron(-card.ability.extra.modifier)
		end,
		calculate = function(self, card, context)
			if (context.end_of_round or context.other_card) and not context.blueprint then
				local missing = Finity.missing_base_suits()
				if card.ability.extra.modifier ~= missing then
					resize_saffron(missing - card.ability.extra.modifier)
					card.ability.extra.modifier = missing
				end
			end
		end,
	}

	SMODS.Joker {
		key = "rougerose",
		name = "Rouge Rose",
		atlas = "ortalabbossjokers",
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue + 1] = { key = "e_negative_playing_card", set = "Edition", config = { extra = 1 } }
		end,
		unlocked = true,
		discovered = true,
		eternal_compat = false,
		blueprint_compat = false,
		rarity = "finity_showdown",
		pos = { x = 0, y = 3 },
		soul_pos = { x = 1, y = 3 },
		cost = 10,
		calculate = function(self, card, context)
			if context.blueprint then return end
			if context.first_hand_drawn then
				juice_card_until(card, function()
					return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES
				end, true)
			end
			local target = context.after and G.GAME.current_round.hands_played == 0 and only_enhanced(context.full_hand)
			if target then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.1,
					func = function()
						target:flip()
						play_sound("card1", 1)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.05,
					func = function()
						target:set_ability(G.P_CENTERS.c_base)
						target:set_edition({ negative = true })
						return true
					end,
				}))
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 1,
					func = function()
						target:flip()
						play_sound("tarot2", 1, 0.6)
						card:juice_up(0.3, 0.3)
						target:juice_up(0.3, 0.3)
						return true
					end,
				}))
				return { message = localize("k_finity_purified") }
			end
		end,
	}

	local function saffron_fits(center_key)
		return center_key == "j_finity_saffronshield" and #G.jokers.cards < G.jokers.config.card_limit + Finity.missing_base_suits()
	end

	local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
	G.FUNCS.check_for_buy_space = function(card)
		if saffron_fits(card.config.center_key) then
			return true
		end
		return check_for_buy_space_ref(card)
	end

	local can_select_card_ref = G.FUNCS.can_select_card
	G.FUNCS.can_select_card = function(e)
		if saffron_fits(e.config.ref_table.config.center_key) then
			e.config.colour = G.C.GREEN
			e.config.button = "use_card"
			return
		end
		can_select_card_ref(e)
	end
end

SMODS.Joker {
	key = "silversword",
	name = "Silver Sword",
	atlas = "ortalabbossjokers",
	pronouns = "he_him",
	config = {
		extra = { xmult = 0.2 },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, 1 + card.ability.extra.xmult * (G.jokers and #G.jokers.cards or 1) } }
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 1, y = 4 },
	cost = 10,
	calculate = function(self, card, context)
		if context.after and context.main_eval and not context.blueprint and (card.edition or {}).key ~= "e_negative"
			and G.GAME.current_round.hands_played == 0
			and to_big(G.GAME.chips) + to_big(hand_chips) * to_big(mult) > to_big(G.GAME.blind.chips) then
			G.E_MANAGER:add_event(Event({
				func = function()
					local copy = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_finity_silversword")
					copy:set_edition("e_negative", true)
					copy:add_to_deck()
					G.jokers:emplace(copy)
					return true
				end,
			}))
			return { message = localize("k_plus_joker"), colour = G.C.BLUE }
		end
		if context.joker_main or context.forcetrigger then
			return { xmult = 1 + card.ability.extra.xmult * #G.jokers.cards }
		end
	end,
}
