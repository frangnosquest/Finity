local CHIP_SIZE = 0.3
local CHIP_SPEED = 1.2

local function chip(direction)
	local atlas = G.ASSET_ATLAS["finity_modicon"]
	if not atlas then return end
	local sprite = Sprite(0, 0, CHIP_SIZE, CHIP_SIZE, atlas, { x = 0, y = 0 })
	sprite.states.hover.can = false
	sprite.states.click.can = false
	sprite.update = function(self, dt)
		self.T.r = self.T.r + direction * CHIP_SPEED * G.real_dt
	end
	return { n = G.UIT.C, config = { align = "cm", minw = CHIP_SIZE + 0.04 }, nodes = {
		{ n = G.UIT.O, config = { object = sprite } },
	} }
end

local function text_index(badge)
	for i, node in ipairs(badge.nodes or {}) do
		if node.config and node.config.id == "smods_mod_badge_text" then return i end
	end
end

SMODS.current_mod.set_mod_badge = function(mod, obj)
	local set_mod_badge = mod.set_mod_badge
	mod.set_mod_badge = nil
	local built, badge = pcall(SMODS.create_mod_badge, mod, obj)
	mod.set_mod_badge = set_mod_badge
	if not built then error(badge) end
	local index = text_index(badge)
	local left, right = chip(1), chip(-1)
	if not (index and left and right) then return badge end
	badge.nodes = {
		left,
		{ n = G.UIT.C, config = { align = "cm", minw = 1.2 }, nodes = { badge.nodes[index] } },
		right,
	}
	return badge
end
