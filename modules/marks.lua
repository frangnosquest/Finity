Finity.mark_sprites = {
	crimson = { x = 0, y = 0 },
	cerulean = { x = 1, y = 0 },
	razzle = { x = 2, y = 0 },
	lovesick = { x = 3, y = 0 },
	controlling = { x = 4, y = 0 },
	saffron = { x = 5, y = 0 },
}

function Finity.attach_mark(card, sprite)
	local mark = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["finity_marks"], Finity.mark_sprites[sprite])
	mark.role.draw_major = card
	mark.states.hover.can = false
	mark.states.click.can = false
	card.finity = { floating_sprite_mark = mark }
end

function Finity.remove_mark(card, field)
	card.ability[field] = nil
	if card.finity then
		card.finity.floating_sprite_mark = nil
	end
end

function Finity.remove_marks(cards, field, owner)
	for _, v in ipairs(cards) do
		if v.ability[field] and v.ability[field] == owner then
			Finity.remove_mark(v, field)
		end
	end
end

function Finity.mark_random(cards, field, owner, sprite, seed, exclude)
	local pool = {}
	for _, v in ipairs(cards) do
		if not v.ability[field] and not (exclude and exclude(v)) then
			pool[#pool + 1] = v
		end
	end
	if not next(pool) then return end
	local target = pseudorandom_element(pool, pseudoseed(seed))
	target.ability[field] = owner
	Finity.attach_mark(target, sprite)
	target:juice_up(0.3, 0.5)
	return target
end

function Finity.mark_sprite_for(ability)
	if not ability then return end
	if ability.finitysaffronshieldmark then return "saffron" end
	if ability.finityrazzleraindropmark then return "razzle" end
	if ability.finityceruleanbellmark then
		return ability.finityceruleanbellmark == "controlling" and "controlling" or "cerulean"
	end
	if ability.finitycrimsonheartmark then
		return ability.finitycrimsonheartmark == "lovesick" and "lovesick" or "crimson"
	end
end

function Finity.restore_marks()
	for _, cards in ipairs({ G.jokers and G.jokers.cards or {}, G.playing_cards or {} }) do
		for _, v in ipairs(cards) do
			local sprite = Finity.mark_sprite_for(v.ability)
			if sprite then
				Finity.attach_mark(v, sprite)
			end
		end
	end
end

Finity.mark_badges = {
	heart_mark = "finity_crimsonmark",
	heart_mark_partner = "finity_crimsonmark_partner",
	bell_mark = "finity_ceruleanmark",
	bell_mark_partner = "finity_ceruleanmark_partner",
	raindrop_mark = "finity_razzlemark",
	shield_mark = "finity_saffronmark",
}

function Finity.add_mark_badges(card, badges)
	local ability = card.ability
	if not ability then return end
	if ability.finitycrimsonheartmark then
		badges[#badges + 1] = ability.finitycrimsonheartmark == "lovesick" and "heart_mark_partner" or "heart_mark"
	end
	if ability.finityceruleanbellmark then
		badges[#badges + 1] = ability.finityceruleanbellmark == "controlling" and "bell_mark_partner" or "bell_mark"
	end
	if ability.finityrazzleraindropmark then
		badges[#badges + 1] = "raindrop_mark"
	end
	if ability.finitysaffronshieldmark then
		badges[#badges + 1] = "shield_mark"
	end
end

function Finity.mark_info(badge, info_queue)
	local key = Finity.mark_badges[badge]
	if key then
		info_queue[#info_queue + 1] = { set = "Other", key = key }
	end
end

function Finity.filter_mark_badges(badges)
	local ret = {}
	if not badges then return ret end
	for k, v in pairs(badges) do
		if type(k) ~= "number" then
			ret[k] = v
		end
	end
	for _, v in ipairs(badges) do
		if not Finity.mark_badges[v] then
			ret[#ret + 1] = v
		end
	end
	return ret
end

function Finity.ignores_debuff(card)
	return card.seal and Finity.has_joker("j_finity_periwinklepinecone")
end

SMODS.DrawStep {
	key = "marks",
	order = 51,
	func = function(self)
		if not (self.finity and self.finity.floating_sprite_mark and Finity.mark_sprite_for(self.ability)) then return end
		local scale_mod = 0.07 + 0.02 * math.cos(1.8 * G.TIMERS.REAL)
		local mark = self.finity.floating_sprite_mark
		mark.role.draw_major = self
		mark:draw_shader("dissolve", 0, nil, nil, self.children.center, scale_mod, 0, nil, -0.07 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
		mark:draw_shader("dissolve", nil, nil, nil, self.children.center, scale_mod, 0, nil, -0.07)
	end,
	conditions = { vortex = false, facing = "front" },
}
