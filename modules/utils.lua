to_big = to_big or function(value)
	return value
end

to_number = to_number or function(value)
	return value
end

function Finity.safely_get(t, ...)
	local current = t
	for _, k in ipairs({ ... }) do
		if not current or current[k] == nil then
			return false
		end
		current = current[k]
	end
	return current
end

function FinityRemoveMatchingKeys(t1, t2)
	if not t1 or not t2 then return {} end
	local result = {}
	for key, value in pairs(t1) do
		if not t2[key] then
			result[key] = value
		end
	end
	return result
end

function Finity.has_mod(id)
	return next(SMODS.find_mod(id)) ~= nil
end

function Finity.has_joker(key)
	return next(SMODS.find_card(key)) ~= nil
end

function Finity.xmult_message(value)
	return localize { type = 'variable', key = 'a_xmult', vars = { value } }
end

Finity.base_suits = { "Spades", "Hearts", "Clubs", "Diamonds" }

function Finity.has_base_suit(card)
	for _, suit in ipairs(Finity.base_suits) do
		if card:is_suit(suit) then return true end
	end
	return false
end

function Finity.missing_base_suits()
	local missing = 0
	for _, suit in ipairs(Finity.base_suits) do
		local found = false
		for _, playing_card in ipairs(G.playing_cards or {}) do
			if playing_card:is_suit(suit) then
				found = true
				break
			end
		end
		if not found then missing = missing + 1 end
	end
	return missing
end

Finity.enhancement_blacklist = {
	m_akyrs_scoreless = true,
	m_entr_disavowed = true,
	m_unstb_poison = true,
	m_unstb_radioactive = true,
	m_unstb_biohazard = true,
}

function Finity.poll_enhancement()
	local enhancement
	repeat
		enhancement = SMODS.poll_enhancement({ guaranteed = true })
	until enhancement and not Finity.enhancement_blacklist[enhancement]
	return enhancement
end

function Finity.poll_seal()
	local seal
	repeat
		seal = SMODS.poll_seal({ guaranteed = true })
	until seal and seal ~= "akyrs_debuff"
	return seal
end

function Finity.merge_effects(effects, index)
	index = index or 1
	local ret = effects[index]
	if index <= #effects then
		local deepest = ret or {}
		while deepest.extra do
			deepest = deepest.extra
		end
		deepest.extra = Finity.merge_effects(effects, index + 1)
	end
	return ret
end

Finity.rarity_ladder = {
	{ create = { "Common" }, also = { 1, "akyrs_supercommon", "playbook_the", "crp_trash", "crp_:3", "crp_common_2" } },
	{ create = { "crp_2common4me" } },
	{ create = { "Uncommon" }, also = { 2, "cry_candy", "akyrs_emerald", "crp_uncommon_2" } },
	{ create = { "crp_unrare" } },
	{ create = { "Rare" }, also = { 3, "poke_safari", "payasaka_ahead", "crp_rare_2" } },
	{ create = { "cry_epic" }, also = { "mf_bossblind", "crp_cipe" } },
	{ create = { "Legendary" }, also = { 4, "finity_showdown", "poke_mega", "entr_reverse_legendary", "payasaka_daeha" } },
	{ create = { "cry_exotic" }, also = { "crp_exotic_2", "unik_unik_legendary_blind_finity" } },
	{ create = { "crp_mythic", "jen_wondrous", "entr_entropic", "playbook_playful" }, also = { "jen_ritualistic" }, virus_cap = true },
	{ create = { "crp_exomythic", "jen_extraordinary", "entr_zenith" }, also = { "jen_transcendent" } },
	{ create = { "crp_2exomythic4me" } },
	{ create = { "crp_22exomythic4mecipe" } },
	{ create = { "crp_exomythicepicawesomeuncommon2mexotic22exomythic4mecipe" } },
	{ create = { "crp_all", "jen_omnipotent" }, also = { "jen_omegatranscendent" } },
}

local vanilla_rarity_index = { Common = 1, Uncommon = 2, Rare = 3, Legendary = 4 }

local function tier_has(tier, rarity)
	for _, list in ipairs({ tier.create, tier.also or {} }) do
		for _, key in ipairs(list) do
			if key == rarity then return true end
		end
	end
	return false
end

function Finity.rarity_tier(rarity)
	for index, tier in ipairs(Finity.rarity_ladder) do
		if tier_has(tier, rarity) then return index end
	end
end

function Finity.register_rarity(rarity, alongside, can_create)
	local index = Finity.rarity_tier(alongside)
	if not index or Finity.rarity_tier(rarity) then return end
	local tier = Finity.rarity_ladder[index]
	if can_create then
		table.insert(tier.create, rarity)
	else
		tier.also = tier.also or {}
		table.insert(tier.also, rarity)
	end
end

local function rarity_available(rarity)
	local pool = G.P_JOKER_RARITY_POOLS[vanilla_rarity_index[rarity] or rarity]
	return pool ~= nil and next(pool) ~= nil
end

function Finity.creatable_rarity(index)
	local tier = Finity.rarity_ladder[index]
	if not tier then return end
	for _, rarity in ipairs(tier.create) do
		if rarity_available(rarity) then return rarity end
	end
end

function Finity.shift_rarity(rarity, step, max_tier)
	local index = Finity.rarity_tier(rarity)
	if not index then return end
	local target = index + step
	while Finity.rarity_ladder[target] and not (max_tier and target > max_tier) do
		local created = Finity.creatable_rarity(target)
		if created then return created end
		target = target + step
	end
end

function Finity.virus_max_tier()
	for index, tier in ipairs(Finity.rarity_ladder) do
		if tier.virus_cap then return index end
	end
end

function Finity.joker_position(target)
	for i, joker in ipairs(G.jokers.cards) do
		if joker == target then return i end
	end
	for i, joker in ipairs(G.jokers.cards) do
		if joker.config.center.key == "j_payasaka_cast" then
			local area = G["payasaka_cast_jokers_" .. tostring(joker.sort_id)]
			if area then
				for _, other in ipairs(area.cards) do
					if other == target then return i end
				end
			end
		end
	end
end
