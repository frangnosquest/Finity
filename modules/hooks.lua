local start_run_ref = Game.start_run
function Game:start_run(args)
	Finity.showdown_choice = nil
	start_run_ref(self, args)
	Finity.restore_marks()
	Finity.fix_loaded_showdown_tags()
end

local init_game_object_ref = Game.init_game_object
function Game:init_game_object()
	if Cryptid and Cryptid.mod_whitelist then
		Cryptid.mod_whitelist["Finity"] = true
	end
	local ret = init_game_object_ref(self)
	Finity.load_taunting()
	return ret
end

local title_jokers = {
	"j_finity_amberacorn",
	"j_finity_verdantleaf",
	"j_finity_violetvessel",
	"j_finity_crimsonheart",
	"j_finity_ceruleanbell",
}

local main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
	local ret = main_menu_ref(self, change_context)
	Finity.hook_superboss()
	if not self.title_top then return ret end
	local center = Finity.config.spectral and G.P_CENTERS.c_finity_finity or G.P_CENTERS[pseudorandom_element(title_jokers)]
	local card = Card(self.title_top.T.x, self.title_top.T.y, G.CARD_W, G.CARD_H, nil, center)
	card.bypass_discovery_center = true
	card.T.w = card.T.w * 1.1 * 1.2
	card.T.h = card.T.h * 1.1 * 1.2
	G.title_top.T.w = G.title_top.T.w * 1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	card:set_sprites(card.config.center)
	card.no_ui = true
	card.states.visible = false
	self.title_top:emplace(card)
	self.title_top:align_cards()
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0,
		blockable = false,
		blocking = false,
		func = function()
			card.states.visible = true
			if change_context == "splash" then
				card:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
			else
				card:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
			end
			return true
		end,
	}))
	return ret
end
