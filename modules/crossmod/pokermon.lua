local poke_types = { "Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth" }

local function is_poke_type(ptype)
	for _, v in ipairs(poke_types) do
		if v == ptype then return true end
	end
	return false
end

local function joker_type(joker)
	local extra = joker.ability and joker.ability.extra
	return type(extra) == "table" and extra.ptype or nil
end

local function roll_type(card)
	local shared = {}
	for _, v in ipairs(G.jokers.cards) do
		local ptype = joker_type(v)
		if v ~= card and ptype and is_poke_type(ptype) then
			shared[#shared + 1] = ptype
		end
	end
	return pseudorandom_element(next(shared) and shared or poke_types, pseudoseed("finity_cgoose"))
end

SMODS.Joker {
	key = "cgoosejoker",
	name = "Chartreuse Chamber",
	atlas = "pokermonbossjokers",
	poke_custom_prefix = "finity_pokermonboss",
	config = { extra = { first = true, ptype = "Bird" } },
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.ptype == "Bird" then
			info_queue[#info_queue + 1] = { set = "Other", key = "Bird" }
		end
	end,
	unlocked = true,
	discovered = true,
	eternal_compat = false,
	blueprint_compat = false,
	rarity = "finity_showdown",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	cost = 10,
	add_to_deck = function(self, card, from_debuff)
		apply_type_sticker(card, roll_type(card))
	end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.setting_blind then
			if card.ability.extra.first then
				card.ability.extra.first = false
			else
				local ptype = roll_type(card)
				apply_type_sticker(card, ptype)
				return {
					message = ptype,
					colour = G.ARGS.LOC_COLOURS.pink,
				}
			end
		end
		if context.end_of_round and context.main_eval then
			card.ability.extra.first = false
			for _, v in ipairs(G.jokers.cards) do
				if v ~= card and v.config.center.key ~= "j_finity_cgoosejoker" and joker_type(v) == card.ability.extra.ptype then
					increment_energy(v, card.ability.extra.ptype)
				end
			end
		end
	end,
}
