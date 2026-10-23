function Finity.challenger_sleeve_active()
	return CardSleeves and G.GAME.selected_sleeve == "sleeve_finity_challenger" and G.GAME.selected_back.name == "b_finity_challenger"
end

function Finity.reset_big_blind(keep_current)
	local choices = G.GAME.round_resets.blind_choices
	if Finity.challenger_sleeve_active() then
		G.finityvvcheck = true
		choices.Big = get_new_boss()
	elseif G.GAME.modifiers.cry_rush_hour_ii then
		choices.Small = get_new_boss()
		choices.Big = get_new_boss()
	elseif not keep_current then
		choices.Big = "bl_big"
	end
end

local function is_challenger_run()
	local back = G.GAME.selected_back
	return (back and back.name == "b_finity_challenger") or G.GAME.selected_sleeve == "sleeve_finity_challenger"
end

local function boss_uses()
	return G.GAME.bosses_used.boss or G.GAME.bosses_used
end

local function count_boss_use(boss)
	if SMODS.add_boss_to_used_table and pcall(SMODS.add_boss_to_used_table, boss, "boss") then return end
	local uses = boss_uses()
	uses[boss] = (tonumber(uses[boss]) or 0) + 1
end

local function random_showdown(fallback)
	local uses = boss_uses()
	local eligible, min_use = {}, math.huge
	for k, v in pairs(G.P_BLINDS) do
		if v.boss and v.boss.showdown and not G.GAME.banned_keys[k]
			and not (string.sub(k, 1, 11) == "bl_jen_epic" and G.GAME.round_resets.ante <= 14)
			and not (string.sub(k, 1, 12) == "bl_unik_epic" and G.GAME.round <= 40)
			and not (string.sub(k, 1, 17) == "bl_unik_legendary" and G.GAME.round <= 90) then
			local used = tonumber(uses[k]) or 0
			eligible[k] = used
			min_use = math.min(min_use, used)
		end
	end
	for k, used in pairs(eligible) do
		if used > min_use then
			eligible[k] = nil
		end
	end
	if not next(eligible) then return fallback end
	local _, boss = pseudorandom_element(eligible, pseudoseed("boss"))
	count_boss_use(boss)
	return boss
end

function Finity.pick_boss(roll, skip_vessel)
	local back = G.GAME.selected_back
	if back and back.name == "b_finity_taunting" then
		return G.GAME.finity_taunting_blind or Finity.taunting.blind
	end
	local boss = roll()
	if string.sub(boss, 1, 15) == "bl_akyrs_master" then return boss end
	if Finity.has_joker("j_finity_violetvessel") and not skip_vessel then
		if string.sub(boss, 1, 15) == "bl_akyrs_expert" then
			return "bl_akyrs_expert_inflation"
		elseif G.GAME.round_resets.ante % G.GAME.win_ante == 0 or is_challenger_run() then
			return "bl_final_vessel"
		end
		return "bl_wall"
	elseif is_challenger_run() then
		return random_showdown(boss)
	end
	return boss
end

if SMODS.get_new_blind then
	local get_new_blind_ref = SMODS.get_new_blind
	function SMODS.get_new_blind(blind_type)
		local kind = blind_type or "boss"
		local function roll(roll_type)
			return function()
				return get_new_blind_ref(roll_type)
			end
		end
		if kind == "boss" then
			return Finity.pick_boss(roll(blind_type))
		elseif kind == "big" and Finity.challenger_sleeve_active() then
			return Finity.pick_boss(roll("boss"), true)
		elseif (kind == "big" or kind == "small") and G.GAME.modifiers and G.GAME.modifiers.cry_rush_hour_ii then
			return Finity.pick_boss(roll("boss"))
		end
		return get_new_blind_ref(blind_type)
	end
else
	local get_new_boss_ref = get_new_boss
	function get_new_boss()
		for k in pairs(G.P_BLINDS) do
			G.GAME.bosses_used[k] = G.GAME.bosses_used[k] or 0
		end
		local skip_vessel = G.finityvvcheck
		G.finityvvcheck = nil
		return Finity.pick_boss(get_new_boss_ref, skip_vessel)
	end
end

function Finity.refresh_boss_choice()
	local round = G.GAME and G.GAME.round_resets
	local state = round and round.blind_states and round.blind_states.Boss
	if state ~= "Upcoming" and state ~= "Select" then return end
	round.blind_choices.Boss = get_new_boss()
	if G.STATE == G.STATES.BLIND_SELECT and G.blind_select then
		G.blind_select:remove()
		if G.blind_prompt_box then G.blind_prompt_box:remove() end
		G.blind_select, G.blind_prompt_box = nil, nil
		G.STATE_COMPLETE = false
	end
end

function Finity.hook_superboss()
	if Finity.superboss_hooked or not G.get_new_superboss then return end
	Finity.superboss_hooked = true
	local get_new_superboss_ref = G.get_new_superboss
	G.get_new_superboss = function(...)
		if Finity.has_joker("j_finity_violetvessel") then
			return "bl_mf_violet_vessel_dx"
		end
		return get_new_superboss_ref(...)
	end
end
