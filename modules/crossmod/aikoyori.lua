SMODS.Joker {
	key = "periwinklepinecone",
	name = "Periwinkle Pinecone",
	atlas = "akyrsbossjokers",
	pronouns = "they_them",
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.before and context.cardarea == G.jokers then
			local sealed = false
			for _, v in ipairs(context.scoring_hand) do
				if not v.seal then
					v:juice_up()
					v:set_seal(Finity.poll_seal())
					sealed = true
				end
			end
			if sealed then
				return { message = localize("k_finity_sealed") }
			end
		end
	end,
}

SMODS.Joker {
	key = "razzleraindrop",
	name = "Razzle Raindrop",
	atlas = "akyrsbossjokers",
	pronouns = "they_he",
	config = {
		extra = { xmult = 1 },
		increase = 0.2,
		suit = "none",
	},
	loc_vars = function(self, info_queue, card)
		local suit = card.ability.suit
		local known = suit ~= "none"
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.increase,
				known and localize(suit, "suits_singular") or "",
				colours = { known and G.C.SUITS[suit] or G.C.UI.TEXT_INACTIVE },
			},
		}
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
		if card.ability.suit == "none" then
			card.ability.suit = pseudorandom_element(Finity.base_suits, pseudoseed("finity_razzleraindrop"))
		end
	end,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and card.ability.extra.xmult > 1 then
			return { xmult = card.ability.extra.xmult }
		end
		if context.blueprint then return end
		if context.end_of_round and context.main_eval and context.game_over == false then
			card.ability.suit = pseudorandom_element(Finity.base_suits, pseudoseed("finity_razzleraindrop"))
		end
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.suit) then
			local target = context.other_card
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.1,
				func = function()
					card:juice_up()
					target:juice_up()
					target.ability.finityrazzleraindropmark = true
					Finity.attach_mark(target, "razzle")
					return true
				end,
			}))
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase
			SMODS.calculate_effect({ message = Finity.xmult_message(card.ability.extra.xmult), colour = G.C.RED }, card)
		end
	end,
}

local velvet_ranks = { "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King" }

local function roll_velvet_ranks(card)
	local choices = {}
	for i, rank in ipairs(velvet_ranks) do
		choices[i] = rank
	end
	local first, index = pseudorandom_element(choices, pseudoseed("finity_velvetvapour"))
	table.remove(choices, index)
	card.ability.ranks.first = first
	card.ability.ranks.second = pseudorandom_element(choices, pseudoseed("finity_velvetvapour"))
end

local function rank_name(rank)
	if rank == "none" then return "-" end
	return localize(tostring(rank), "ranks")
end

local function flip_to_v(card, target)
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
			SMODS.change_base(target, target.config.card.suit, "finity_V")
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
end

SMODS.Joker {
	key = "velvetvapour",
	name = "Velvet Vapour",
	atlas = "akyrsbossjokers",
	config = {
		ranks = { first = "none", second = "none" },
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { rank_name(card.ability.ranks.first), rank_name(card.ability.ranks.second) } }
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
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.ranks.first == "none" or card.ability.ranks.second == "none" then
			roll_velvet_ranks(card)
		end
	end,
	calculate = function(self, card, context)
		if context.after and context.scoring_hand then
			local hand = context.scoring_hand
			for i, scored in ipairs(hand) do
				local next_card = hand[i + 1]
				if next_card and tostring(scored.config.card.value) == "finity_V" then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.1,
						func = function()
							next_card.ability.perma_bonus = (next_card.ability.perma_bonus or 0) + 2 * (2 + (scored.ability.perma_bonus or 0))
							next_card:juice_up(0.3, 0.3)
							return true
						end,
					}))
					SMODS.calculate_effect({ message = localize("k_finity_bonus"), colour = G.C.CHIPS }, scored)
				end
			end
			if context.blueprint then return end
			local first, second = tostring(card.ability.ranks.first), tostring(card.ability.ranks.second)
			local converted = 0
			for _, scored in ipairs(hand) do
				local value = tostring(scored.config.card.value)
				if value == first or value == second then
					flip_to_v(card, scored)
					converted = converted + 1
				end
			end
			if converted > 0 then
				G.E_MANAGER:add_event(Event({ trigger = "after", delay = 2, func = function() return true end }))
				return { message = localize("k_finity_v") }
			end
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			roll_velvet_ranks(card)
		end
	end,
}

SMODS.Joker {
	key = "chamomilecloud",
	name = "Chamomile Cloud",
	atlas = "akyrsbossjokers",
	config = {
		extra = { xmult = 1 },
		increase = 0.15,
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
	pos = { x = 0, y = 3 },
	soul_pos = { x = 1, y = 3 },
	cost = 10,
	calculate = function(self, card, context)
		if (context.joker_main or context.forcetrigger) and to_big(card.ability.extra.xmult) > to_big(1) then
			return { xmult = card.ability.extra.xmult }
		end
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			local upgraded = false
			for _, cards in ipairs({ context.full_hand, G.hand.cards }) do
				for _, v in ipairs(cards) do
					if v.ability.set ~= "Enhanced" then
						upgraded = true
						card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase
					end
					v:set_ability(G.P_CENTERS[Finity.poll_enhancement()])
					v:juice_up()
				end
			end
			if upgraded then
				return {
					message = Finity.xmult_message(card.ability.extra.xmult),
					colour = G.C.RED,
				}
			end
		end
	end,
}

SMODS.Joker {
	key = "lilaclasso",
	name = "Lilac Lasso",
	atlas = "akyrsbossjokers",
	pronouns = "they_any",
	config = {
		extra = { xmult = 1 },
		increase = 1,
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
		if context.before and not context.blueprint and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase * (G.jokers.config.card_limit - #G.jokers.cards)
			return {
				message = Finity.xmult_message(card.ability.extra.xmult),
				colour = G.C.RED,
			}
		end
	end,
}

SMODS.Joker {
	key = "salientstream",
	name = "Salient Stream",
	atlas = "akyrsbossjokers",
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
		if context.joker_main or context.forcetrigger then
			ease_discard(1)
			return {
				message = localize { type = "variable", key = "a_finity_discards", vars = { 1 } },
				colour = G.C.RED,
			}
		end
	end,
}

SMODS.Joker {
	key = "luminouslemonade",
	name = "Luminous Lemonade",
	atlas = "akyrsbossjokers",
	config = {
		extra = { exmult = 0.1, exchips = 0.1 },
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.exmult,
				card.ability.extra.exchips,
				card.ability.extra.exmult * (G.GAME.unused_discards or 0) + 1,
				card.ability.extra.exchips * (G.GAME.hands_played or 0) + 1,
			},
		}
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	rarity = "finity_showdown",
	pos = { x = 0, y = 6 },
	soul_pos = { x = 1, y = 6 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			local discards = G.GAME.unused_discards or 0
			local hands = G.GAME.hands_played or 0
			local ret = {}
			if discards > 0 then
				ret.xmult = card.ability.extra.exmult * discards + 1
			end
			if hands > 0 then
				ret.xchips = card.ability.extra.exchips * hands + 1
			end
			if next(ret) then return ret end
		end
	end,
}

SMODS.Joker {
	key = "gloriousglaive",
	name = "Glorious Glaive",
	atlas = "akyrsbossjokers",
	pronouns = "she_her",
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
	pos = { x = 0, y = 7 },
	soul_pos = { x = 1, y = 7 },
	cost = 10,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			return { xmult = card.ability.extra.xmult }
		end
	end,
}

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if self.ability and self.ability.finityrazzleraindropmark and not self.debuff then
		return true
	end
	return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end

SMODS.Rank {
	key = "V",
	card_key = "V",
	hc_atlas = "vrankhc",
	lc_atlas = "vranklc",
	hidden = true,
	pos = { x = 0 },
	nominal = 2,
	shorthand = "V",
	in_pool = function(self, args)
		return false
	end,
}

local v_compat_cards = {
	{ mod = "paperback", code = "paperback_STARS", name = "V of Stars", suit = "paperback_Stars", pos = { x = 1, y = 0 } },
	{ mod = "paperback", code = "paperback_CROWNS", name = "V of Crowns", suit = "paperback_Crowns", pos = { x = 1, y = 1 } },
	{ mod = "entr", code = "entr_nilsuit", name = "V of Nil", suit = "entr_nilsuit", pos = { x = 2, y = 0 } },
}

local function add_v_compat_cards()
	for _, v in ipairs(v_compat_cards) do
		if Finity.has_mod(v.mod) then
			G.P_CARDS[v.code .. "_finity_V"] = {
				name = v.name,
				value = "finity_V",
				suit = v.suit,
				pos = v.pos,
				lc_atlas = "finity_vranklccompat",
				hc_atlas = "finity_vrankhccompat",
			}
		end
	end
end

local PURE_V = { x = 2, y = 1 }
local fallback_signature

local function fallback_suits()
	local covered = { Hearts = true, Clubs = true, Diamonds = true, Spades = true }
	for _, v in ipairs(v_compat_cards) do
		if Finity.has_mod(v.mod) then covered[v.suit] = true end
	end
	local suits = {}
	for key, suit in pairs(SMODS.Suits) do
		if not covered[key] then suits[#suits + 1] = suit end
	end
	table.sort(suits, function(a, b) return a.key < b.key end)
	return suits
end

local function tinted_atlas(key, source, suits, colour)
	if not (source and source.image_data) then return end
	local data = source.image_data
	local cell_w, cell_h = data:getWidth() / source.columns, data:getHeight() / source.rows
	local x0, y0 = PURE_V.x * cell_w, PURE_V.y * cell_h
	local pixels, brightest = {}, 0.01
	for y = 0, cell_h - 1 do
		for x = 0, cell_w - 1 do
			local r, g, b, a = data:getPixel(x0 + x, y0 + y)
			if a > 0 then
				local shade = (r + g + b) / 3
				pixels[#pixels + 1] = { x, y, shade, a }
				brightest = math.max(brightest, shade)
			end
		end
	end
	local out = love.image.newImageData(cell_w * #suits, cell_h)
	for i, suit in ipairs(suits) do
		local tint = suit[colour] or { 0, 0, 0 }
		for _, pixel in ipairs(pixels) do
			local factor = math.min(1, pixel[3] / brightest)
			out:setPixel((i - 1) * cell_w + pixel[1], pixel[2], tint[1] * factor, tint[2] * factor, tint[3] * factor, pixel[4])
		end
	end
	local image = love.graphics.newImage(out, { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
	local atlas = {
		key = key,
		name = key,
		image = image,
		image_data = out,
		px = source.px,
		py = source.py,
		atlas_table = "ASSET_ATLAS",
		columns = image:getWidth() / source.px,
		rows = image:getHeight() / source.py,
	}
	G.ASSET_ATLAS[key] = atlas
	return atlas
end

local function add_fallback_v_cards()
	local rank = SMODS.Ranks["finity_V"]
	local suits = fallback_suits()
	if not (rank and next(suits)) then return end
	local names = {}
	for i, suit in ipairs(suits) do names[i] = suit.key end
	local signature = G.SETTINGS.GRAPHICS.texture_scaling .. ":" .. table.concat(names, ",")
	if signature ~= fallback_signature or not (G.ASSET_ATLAS.finity_vfallbacklc and G.ASSET_ATLAS.finity_vfallbackhc) then
		local lc = tinted_atlas("finity_vfallbacklc", G.ASSET_ATLAS.finity_vranklccompat, suits, "lc_colour")
		local hc = tinted_atlas("finity_vfallbackhc", G.ASSET_ATLAS.finity_vrankhccompat, suits, "hc_colour")
		if not (lc and hc) then return end
		fallback_signature = signature
	end
	for i, suit in ipairs(suits) do
		G.P_CARDS[suit.card_key .. "_" .. rank.card_key] = {
			name = rank.key .. " of " .. suit.key,
			value = rank.key,
			suit = suit.key,
			pos = { x = i - 1, y = 0 },
			lc_atlas = "finity_vfallbacklc",
			hc_atlas = "finity_vfallbackhc",
		}
	end
end

local function hook_akyrs_rank_atlas()
	if Finity.akyrs_rank_hooked or not (AKYRS and AKYRS.rank_to_atlas) then return end
	Finity.akyrs_rank_hooked = true
	local rank_to_atlas_ref = AKYRS.rank_to_atlas
	AKYRS.rank_to_atlas = function(rank_key, ...)
		if rank_key == "finity_V" then
			return G.ASSET_ATLAS["finity_vranklccompat"], { x = 2, y = 1 }
		end
		return rank_to_atlas_ref(rank_key, ...)
	end
end

local init_game_object_ref = Game.init_game_object
function Game:init_game_object()
	local ret = init_game_object_ref(self)
	hook_akyrs_rank_atlas()
	add_v_compat_cards()
	add_fallback_v_cards()
	return ret
end
