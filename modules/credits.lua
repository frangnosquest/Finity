Finity.Credit = SMODS.Center:extend {
	set = "FinityCredit",
	class_prefix = "fcred",
	config = {},
	cost = 1,
	omit = true,
	unlocked = true,
	discovered = true,
	required_params = { "key", "atlas", "pos" },
	process_loc_text = function(self) end,
	set_card_type_badge = function(self, card, badges) end,
}

local people = {
	"freh",
	"missingnumber",
	"aikoyori",
	"paya",
	"notmario",
	"jpenguin",
	"ee",
	"unik",
	"cruel",
	"madcap",
}

for index, key in ipairs(people) do
	Finity.Credit {
		key = key,
		atlas = "creditsthanks",
		pos = { x = 0, y = index - 1 },
		soul_pos = { x = 1, y = index - 1 },
	}
end

function Finity.credit_center(key)
	return G.P_CENTERS["fcred_finity_" .. key]
end
