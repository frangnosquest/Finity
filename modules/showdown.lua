SMODS.Rarity {
	key = "showdown",
	badge_colour = HEX("690a0f"),
}

local function showdown_joker(tag)
	local joker = tag.ability and tag.ability.finity_joker
	if not joker and tag.config.joker and tag.config.joker ~= "none" then
		joker = tag.config.joker
	end
	if joker and G.P_CENTERS[joker] then
		return joker
	end
end

local function active_tag(tag)
	for _, v in ipairs(G.GAME and G.GAME.tags or {}) do
		if v == tag then return true end
	end
	return false
end

SMODS.Tag {
	key = "showdown",
	name = "Showdown Tag",
	atlas = "tag",
	pos = { x = 0, y = 0 },
	config = { dollars = 10 },
	in_pool = function(self)
		return false
	end,
	loc_vars = function(self, info_queue, tag)
		local blind = tag.ability and tag.ability.finity_blind
		if blind then
			return { vars = { Finity.showdown_name(blind) } }
		end
		if not tag.fake_tag and active_tag(tag) then
			return { key = "tag_finity_showdown_fake", vars = { self.config.dollars } }
		end
		return { vars = { localize("k_finity_beaten_blind") } }
	end,
	apply = function(self, tag, context)
		if context.type ~= "store_joker_create" then return end
		local joker = showdown_joker(tag)
		tag.triggered = true
		if not joker then
			tag:yep("+", G.C.MONEY, function()
				ease_dollars(self.config.dollars)
				return true
			end)
			return
		end
		local card = create_card("Joker", context.area, nil, nil, nil, nil, joker)
		create_shop_card_ui(card, "Joker", context.area)
		card.states.visible = false
		tag:yep("+", G.C.RARITY.finity_showdown, function()
			card:start_materialize()
			card:set_cost()
			return true
		end)
		return card
	end,
}

local tag_apply_to_run_ref = Tag.apply_to_run
function Tag:apply_to_run(_context)
	if _context and _context.type == "tag_add" and _context.tag and _context.tag.key == "tag_finity_showdown" then
		return
	end
	return tag_apply_to_run_ref(self, _context)
end

function Finity.add_showdown_tag(blind_key)
	local showdown = Finity.get_showdown(blind_key)
	if not (showdown and showdown.joker) then return end
	local tag = Tag("tag_finity_showdown")
	tag.ability.finity_joker = showdown.joker
	tag.ability.finity_blind = blind_key
	add_tag(tag)
	play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
	play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
end

function Finity.fix_loaded_showdown_tags()
	local blind_key = G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key
	local showdown = Finity.get_showdown(blind_key)
	if not (showdown and showdown.joker) then return end
	for _, tag in ipairs(G.GAME.tags or {}) do
		if tag.key == "tag_finity_showdown" and tag.ability and not tag.ability.finity_blind then
			tag.ability.finity_joker = showdown.joker
			tag.ability.finity_blind = blind_key
		end
	end
end

local end_round_ref = end_round
function end_round()
	end_round_ref()
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			Finity.add_showdown_tag(G.GAME.blind.config.blind.key)
			return true
		end,
	}))
end

local function current_quips()
	local blind_key = G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.key
	local showdown = Finity.get_showdown(blind_key)
	return showdown and showdown.quips, blind_key
end

function Finity.has_showdown_quips()
	return current_quips() ~= nil
end

function Finity.has_endless_quips()
	local quips = current_quips()
	return quips and quips.endless and true or false
end

function Finity.showdown_character_center()
	local _, blind_key = current_quips()
	local showdown = Finity.get_showdown(blind_key)
	return showdown and showdown.joker and G.P_CENTERS[showdown.joker]
end

local function pick_quip(quips)
	if G.GAME.round_resets.ante > G.GAME.win_ante and quips.endless then
		return "lq_endless_" .. quips.key .. "_" .. math.random(1, quips.endless)
	end
	return "lq_" .. quips.key .. "_" .. math.random(1, quips.count)
end

local function delayed_quip(character, delay, key, duration)
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = delay,
		blocking = false,
		func = function()
			if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID("jimbo_spot") then
				character.ui_object_updated = true
				character:add_speech_bubble(key, nil, { quip = true })
				character:say_stuff(duration)
			end
			return true
		end,
	}))
end

function Finity.showdown_game_over(spot)
	local quips = current_quips()
	if not (quips and spot and Finity.showdown_character_center()) then return false end
	G.GAME.finityshowdownloss = true
	local character = Card_Character({ x = 0, y = 5 })
	G.GAME.finityshowdownloss = nil
	spot.config.object:remove()
	spot.config.object = character
	character.ui_object_updated = true
	character:add_speech_bubble(pick_quip(quips), nil, { quip = true })
	character:say_stuff(5)
	if Finity.has_mod("SealsOnEverything") then
		delayed_quip(character, 1, "again", 2)
		delayed_quip(character, 1.5, pick_quip(quips), 5)
	end
	return true
end
