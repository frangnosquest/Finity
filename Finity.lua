SMODS.Atlas {key = "modicon", path = "icon.png", px = 32, py = 32}
SMODS.Atlas {key = "tag", path = "tag.png", px = 34, py = 34}
SMODS.Atlas({key = 'bossjokers', path = 'jokers.png', px = 71, py = 95})
SMODS.Atlas({key = 'crybossjokers', path = 'compat/cryptid.png', px = 71, py = 95})
SMODS.Atlas({key = 'akyrsbossjokers', path = 'compat/aikoyorisshenanigans.png', px = 71, py = 95})
SMODS.Atlas({key = 'consumables', path = 'consumables.png', px = 71, py = 95})
SMODS.Atlas({key = 'marks', path = 'marks.png', px = 71, py = 95})
SMODS.Atlas({key = 'backs', path = 'backs.png', px = 71, py = 95})
SMODS.Atlas({key = 'sleeves', path = 'compat/sleeves.png', px = 73, py = 94})
SMODS.Atlas({key = 'blinddeck', path = 'blinddeck.png', px = 71, py = 95})
SMODS.Atlas({key = 'partners', path = 'compat/partners.png', px = 46, py = 58})


SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true }
end

--hello to whoever is reading this, the following comments will
--guide you through how to create your own boss joker for
--cross-mod compatibility

SMODS.Rarity({
	key = "showdown",
	loc_txt = {name = "Showdown"},
	badge_colour = HEX("690a0f"),
})

--this dictionary-structured table is used to check if a boss blind has a
--relative boss Joker, your mod should add to this table:
--["boss blind key"] = {"joker key", "boss blind display name" (used for showdown tag's description and other stuff)}
--while the mod is meant for showdown boss blinds specifically, nothing stops you from using regular boss blinds

FinisherBossBlindStringMap = {
    ["bl_final_acorn"] = {"j_finity_amberacorn","Amber Acorn"},
    ["bl_final_leaf"] = {"j_finity_verdantleaf","Verdant Leaf"},
    ["bl_final_vessel"] = {"j_finity_violetvessel","Violet Vessel"},
	["bl_final_heart"] = {"j_finity_crimsonheart","Crimson Heart"},
	["bl_final_bell"] = {"j_finity_ceruleanbell","Cerulean Bell"},
	["bl_cry_lavender_loop"] = {"j_finity_lavenderloop","Lavender Loop"}, --built-in cross-mod jokers
	["bl_cry_tornado"] = {"j_finity_turquoisetornado","Turquoise Tornado"},
	["bl_cry_vermillion_virus"] = {"j_finity_vermillionvirus","Vermillion Virus"},
	["bl_cry_sapphire_stamp"] = {"j_finity_sapphirestamp","Sapphire Stamp"},
	["bl_cry_obsidian_orb"] = {"j_finity_obsidianorb","Obsidian Orb"},
	["bl_cry_trophy"] = {"j_finity_lemontrophy","Lemon Trophy"},
	["bl_akyrs_final_periwinkle_pinecone"] = {"j_finity_periwinklepinecone","Periwinkle Pinecone"},
	["bl_akyrs_final_razzle_raindrop"] = {"j_finity_razzleraindrop","Razzle Raindrop"},
	["bl_akyrs_final_lilac_lasso"] = {"j_finity_lilaclasso","Lilac Lasso"}
	}

--this table assigns sprites for the Taunting deck and is completely optional	
--["boss blind key"] = {"atlas key", "coordinates"}

FinisherBossBlinddecksprites = {
	placeholder = { "finity_blinddeck", { x = 5, y = 0 } },
	["bl_final_acorn"] = {"finity_blinddeck",{ x = 2, y = 0 } },
	["bl_final_leaf"] = {"finity_blinddeck",{ x = 3, y = 0 } },
	["bl_final_vessel"] = {"finity_blinddeck",{ x = 4, y = 0 } },
	["bl_final_heart"] = {"finity_blinddeck",{ x = 0, y = 0 } },
	["bl_final_bell"] = {"finity_blinddeck",{ x = 1, y = 0 } },
	["bl_cry_lavender_loop"] = {"finity_blinddeck",{ x = 3, y = 1 }}, --built-in cross-mod jokers
	["bl_cry_tornado"] = {"finity_blinddeck",{ x = 5, y = 1 }},
	["bl_cry_vermillion_virus"] = {"finity_blinddeck",{ x = 0, y = 1 }},
	["bl_cry_sapphire_stamp"] = {"finity_blinddeck",{ x = 1, y = 1 }},
	["bl_cry_obsidian_orb"] = {"finity_blinddeck",{ x = 2, y = 1 }},
	["bl_cry_trophy"] = {"finity_blinddeck",{ x = 4, y = 1 }},
	["bl_akyrs_final_periwinkle_pinecone"] = {"finity_blinddeck",{ x = 0, y = 2 }},
	["bl_akyrs_final_razzle_raindrop"] = {"finity_blinddeck",{ x = 1, y = 2 }},
	["bl_akyrs_final_lilac_lasso"] = {"finity_blinddeck",{ x = 2, y = 2 }}
}

--another optional feature is having the boss joker cards appear and say a quip instead of jimbo when losing to their respective blinds.
--["boss blind key"] = {"identifier of your quips in the localization files", number of quips}
--structure your quips this way: lq_identifier_quipnumber

FinisherBossBlindQuips = {
    ["bl_final_acorn"] = {"amber",3},
    ["bl_final_leaf"] = {"verdant",3},
    ["bl_final_vessel"] = {"violet",3},
	["bl_final_heart"] = {"crimson",3},
	["bl_final_bell"] = {"cerulean",3},
	["bl_cry_lavender_loop"] = {"lavender",3}, --built-in cross-mod jokers
	["bl_cry_tornado"] = {"turquoise",3},
	["bl_cry_vermillion_virus"] = {"vermillion",3},
	["bl_cry_sapphire_stamp"] = {"sapphire",3},
	["bl_cry_obsidian_orb"] = {"obsidian",3},
	["bl_cry_trophy"] = {"lemon",3},
	["bl_akyrs_final_periwinkle_pinecone"] = {"periwinkle",3},
	["bl_akyrs_final_razzle_raindrop"] = {"razzle",3},
	["bl_akyrs_final_lilac_lasso"] = {"lilac",3},
	}
	
--and that's all you have to do with stuff here, create your boss joker, make sure to give it the showdown rarity
--and you're good to go, as you can see below the mod handles everything else by itself

SMODS.Tag {
    key = "showdown",
	name = "Showdown Tag",
    atlas = "tag",
    pos = { x = 0, y = 0 },
    in_pool = function(self)
        return false
    end,
    config = { joker = "none", display = "(Beaten blind)" },
	loc_vars = function(self, info_queue, tag)
		local _showdowntoget = ""
		local _willorgain = ""
		local _moneytogain = ""
		local _returnquestion = ""
		local _parenthesistext = ""
		if tag.config.joker == "none" and G.jokers then
			_willorgain = "Earn "
			_moneytogain = "$10"
			_parenthesistext = "(Tag is not authentic)"
		else
			_showdowntoget = tag.config.display
			_willorgain = " will"
			_returnquestion = "return in the next shop..."
		end
		return {
            vars = {_showdowntoget,_willorgain,_returnquestion,_moneytogain,_parenthesistext}
        }
	end,
	loc_txt={
        name = "Showdown Tag",
        text = {
            "{C:attention}#1#{} #2#{C:money}#4#",
			"#3#{C:inactive}#5#",
        }
    }, --the tag creates a joker based on the string provided by the wrapped function below
    apply = function(self, tag, context)
        if context.type == "store_joker_create" then
			if tag.config.joker ~= "none" then
				local card
					card = create_card("Joker", context.area, nil, nil, nil, nil,tag.config.joker)
					create_shop_card_ui(card, "Joker", context.area)
					card.states.visible = false
					tag:yep("+", G.C.RARITY.finity_showdown, function()
						card:start_materialize()
						card:set_cost()
						return true
					end)
				tag.triggered = true
				return card
			else
				local card
				card = create_card("Joker", context.area, nil, nil, nil, nil,nil)
					create_shop_card_ui(card, "Joker", context.area)
					card.states.visible = false
					tag:yep("+", G.C.RARITY.finity_showdown, function()
						card:start_materialize()
						card:set_cost()
						return true
					end)
				ease_dollars(10)
				tag.triggered = true
				return card
			end
        end
    end,
}
local old_end_round = end_round
end_round = function()
    old_end_round()
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
    if FinisherBossBlindStringMap[G.GAME.blind.config.blind.key] then
		local tag = Tag('tag_finity_showdown')
		tag.config.joker = FinisherBossBlindStringMap[G.GAME.blind.config.blind.key][1]
		tag.config.display = FinisherBossBlindStringMap[G.GAME.blind.config.blind.key][2]
        add_tag(tag)
		play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
		G.GAME.blind.savename = G.GAME.blind.config.blind.key
    end  --this function reads the table above to check when to create the tag and what joker it will give
	return true end}))
end
--everything else below is just code for jokers, consumable and decks
SMODS.Joker {
    key = "verdantleaf",
    name = "Verdant Leaf",
    atlas = 'bossjokers',
    loc_txt = {
        name = "Verdant Leaf",
        text = {
            "When you sell a {C:attention}Joker{}, create",
			"one of the next lower {C:attention}rarity{},",
			"selling a {C:chips}common{} {C:attention}Joker{} creates",
			"a {C:attention}consumable"
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 3 },
    cost = 10,
	soul_pos = { x = 1, y = 3 },
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and context.card ~= card then
			local _raritylist = {1,2,{3,"poke_safari"},{4,"finity_showdown","poke_mega"},"cry_exotic"}
			local _rarity = context.card.config.center.rarity
			local _newrarity
			local _raritiesstring = {"Common", "Uncommon", "Rare", "Legendary"}
			if next(SMODS.find_mod('Cryptid')) then
				_raritylist = {1,{2,"cry_candy"},{3,"poke_safari"},"cry_epic",{4,"finity_showdown","poke_mega","entr_reverse_legendary"},"cry_exotic","entr_entropic","entr_zenith"}
				_raritiesstring = {"Common", "Uncommon", "Rare", "cry_epic", "Legendary", "cry_exotic","entr_entropic"}
			end
			for index, value in ipairs(_raritylist) do
				if value == _rarity then
					_newrarity = index - 1
					break
				elseif type(value) == "table" then
					for sub_index, sub_value in ipairs(value) do
						if sub_value == _rarity then
							_newrarity = index - 1
							break
						end
					end
				end
			end
			if _newrarity then
				if _newrarity <= 0 then
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						local randomcons = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil)
						randomcons:add_to_deck()
						G.consumeables:emplace(randomcons)
						G.GAME.consumeable_buffer = 0
						card:juice_up(0.3, 0.5)
					end
				elseif #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit + 1 then
					SMODS.add_card { set = 'Joker', rarity = _raritiesstring[_newrarity]}
					card:juice_up(0.3, 0.5)
				end
			end
		return
		end
	end
}
SMODS.Joker {
    key = "violetvessel",
    name = "Violet Vessel",
    atlas = 'bossjokers',
    loc_txt = {
        name = "Violet Vessel",
        text = {
            "All {C:attention}Boss Blinds{} become {C:purple}The Wall{} or ",
			"{C:purple}Violet Vessel{}, gains {X:mult,C:white}XMult{} equal to {C:attention}score",
			"{C:attention}surplus ratio{} after beating a {C:attention}Boss Blind{}",
			"{C:inactive,s:0.8}(Max {X:mult,C:white,s:0.8}X#2#{C:inactive,s:0.8} Mult per round, currently {X:mult,C:white,s:0.8}X#1#{C:inactive,s:0.8} Mult)",
        }
    },
	config = {
        extra = {xmult = 1},
		max = 2
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.xmult,card.ability.max}
        }
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 4 },
    cost = 10,
	soul_pos = { x = 1, y = 4 },
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
		G.GAME.round_resets.blind_choices.Boss = get_new_boss()
		return true end }))
	end,
	calculate = function(self, card, context)
		if context.joker_main and to_big(card.ability.extra.xmult) > to_big(1) then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
		if context.after and context.cardarea == G.jokers and G.GAME.blind:get_type() == "Boss" and not context.blueprint then
		    if to_big(G.GAME.chips) + to_big(hand_chips) * to_big(mult) > to_big(G.GAME.blind.chips) then
				local surplus = (to_big(G.GAME.chips) + to_big(hand_chips) * to_big(mult))/to_big(G.GAME.blind.chips)
				if to_big(surplus) < to_big(0.01) then
					surplus = 0.01
				end
				if to_big(surplus) >= to_big(card.ability.max) then
					card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(card.ability.max)
				else
					card.ability.extra.xmult = to_big(card.ability.extra.xmult) + to_big(surplus)
				end
				return {
                    message = "X" .. tostring(card.ability.extra.xmult) .. " Mult",
					colour = G.C.RED,
                    card = card
                }
			end
		end
    end
}
SMODS.Joker {
    key = "amberacorn",
    name = "Amber Acorn",
    atlas = 'bossjokers',
    loc_txt = {
        name = "Amber Acorn",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult per owned",
			"{C:attention}Joker{} at end of round, all other",
			"{C:attention}Jokers{} are {C:attention}pinned to the left",
			"until this is sold or destroyed",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
	config = {
        extra = {xmult = 1},
		increase = 0.2
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.xmult,card.ability.increase}
        }
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 2 },
    cost = 10,
	soul_pos = { x = 1, y = 2 },
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult + (card.ability.increase * #G.jokers.cards)
			return {
            message = "X" .. tostring(card.ability.extra.xmult) .. " Mult",
			colour = G.C.RED,
            card = card
			}
		end
		if not context.blueprint then
			for i = 1, #G.jokers.cards do
				if (not G.jokers.cards[i].pinned or G.jokers.cards[i].pinned == false) and G.jokers.cards[i].config.center.key ~= "j_finity_amberacorn" then
					G.jokers.cards[i].pinned = true
				end
			end
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			if (not G.jokers.cards[i].pinned or G.jokers.cards[i].pinned == false) and G.jokers.cards[i].config.center.key ~= "j_finity_amberacorn" then
				G.jokers.cards[i].pinned = true
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			G.jokers.cards[i].pinned = false
			if G.jokers.cards[i].ability.pinned then
				G.jokers.cards[i].ability.pinned = false
			end
		end
	end
}
SMODS.Joker {
    key = "crimsonheart",
    name = "Crimson Heart",
    atlas = 'bossjokers',
    loc_txt = {
        name = "Crimson Heart",
        text = {
            "One random {C:attention}Joker{} is {C:attention}marked",
			"every hand, {C:attention}marked Jokers{}",
			"retrigger {C:attention}#1#{} additional times",
        }
    },
	config = {
		extra = {retriggers = 2},
        hand_played = true,
		identifier = 0
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.retriggers}
        }
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 0 },
    cost = 10,
	soul_pos = { x = 1, y = 0 },
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.identifier == 0 then
			card.ability.identifier = pseudorandom('crimsonheart', 1, 999999999999)
		end
    end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.hand_played = true
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card then
			if context.other_card.ability and context.other_card.ability.finitycrimsonheartmark then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retriggers,
					card = card
				}
			end
		end
		if (context.hand_drawn and card.ability.hand_played == true and not context.blueprint) or context.end_of_round then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.finitycrimsonheartmark and G.jokers.cards[i].ability.finitycrimsonheartmark == card.ability.identifier then
					G.jokers.cards[i].ability.finitycrimsonheartmark = nil
					if G.jokers.cards[i].finity then
						G.jokers.cards[i].finity.floating_sprite_mark = nil
					end
				end
			end
			if context.hand_drawn then
				card.ability.hand_played = false
				local _heartlesstable = {}
				for _, v in ipairs(G.jokers.cards) do
					if v ~= card and v.config.center.key ~= "j_finity_crimsonheart" and not v.ability.finitycrimsonheartmark then
						table.insert(_heartlesstable, v)
					end
				end
				if next(_heartlesstable) ~= nil then
					local _heart_target = pseudorandom_element(_heartlesstable)
					_heart_target.ability.finitycrimsonheartmark = card.ability.identifier
					_heart_target.finity = {}
					_heart_target.finity.floating_sprite_mark = Sprite(
					_heart_target.T.x,
					_heart_target.T.y,
					_heart_target.T.w,
					_heart_target.T.h,
					G.ASSET_ATLAS['finity_marks'],
					{ x = 0, y = 0 }
					)
					_heart_target.finity.floating_sprite_mark.role.draw_major = _heart_target
					_heart_target.finity.floating_sprite_mark.states.hover.can = false
					_heart_target.finity.floating_sprite_mark.states.click.can = false
					_heart_target:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
				end
			end
		end
    end,
	remove_from_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].ability.finitycrimsonheartmark and G.jokers.cards[i].ability.finitycrimsonheartmark == card.ability.identifier then
				G.jokers.cards[i].ability.finitycrimsonheartmark = nil
				if G.jokers.cards[i].finity then
					G.jokers.cards[i].finity.floating_sprite_mark = nil
				end
			end
		end
	end
}
SMODS.Joker {
    key = "ceruleanbell",
    name = "Cerulean Bell",
    atlas = 'bossjokers',
    loc_txt = {
        name = "Cerulean Bell",
        text = {
            "One random card in hand is {C:attention}marked",
			"every hand, {C:attention}marked{} cards permanently",
			"gain {X:mult,C:white}X#1#{} Mult when scored"
        }
    },
	config = {
        hand_played = true,
		identifier = 0,
		xmultbonus = 2
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.xmultbonus}
        }
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 1 },
    cost = 10,
	soul_pos = { x = 1, y = 1 },
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.identifier == 0 then
			card.ability.identifier = pseudorandom('ceruleanbell', 1, 999999999999)
		end
    end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.hand_played = true
		end
		if (context.hand_drawn and card.ability.hand_played == true and not context.blueprint) or context.end_of_round then
			for i = 1, #G.playing_cards do
				if G.playing_cards[i].ability.finityceruleanbellmark and G.playing_cards[i].ability.finityceruleanbellmark == card.ability.identifier then
					G.playing_cards[i].ability.finityceruleanbellmark = nil
					if G.playing_cards[i].finity then
						G.playing_cards[i].finity.floating_sprite_mark = nil
					end
				end
			end
			if context.hand_drawn then
				card.ability.hand_played = false
				local _belllesstable = {}
				for _, v in ipairs(G.hand.cards) do
					if not v.ability.finityceruleanbellmark then
						table.insert(_belllesstable, v)
					end
				end
				if next(_belllesstable) ~= nil then
					local _bell_target = pseudorandom_element(_belllesstable)
					_bell_target.ability.finityceruleanbellmark = card.ability.identifier
					_bell_target.finity = {}
					_bell_target.finity.floating_sprite_mark = Sprite(
					_bell_target.T.x,
					_bell_target.T.y,
					_bell_target.T.w,
					_bell_target.T.h,
					G.ASSET_ATLAS['finity_marks'],
					{ x = 1, y = 0 }
					)
					_bell_target.finity.floating_sprite_mark.role.draw_major = _bell_target
					_bell_target.finity.floating_sprite_mark.states.hover.can = false
					_bell_target.finity.floating_sprite_mark.states.click.can = false
					_bell_target:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
				end
			end
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.finityceruleanbellmark then
				if context.other_card.ability.perma_x_mult ~= 0 then
					context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + 2
				else
					context.other_card.ability.perma_x_mult = 1
				end
				return {
					extra = {message = localize('k_upgrade_ex'), colour = G.C.MULT},
					colour = G.C.MULT,
					card = card
				}
			end
		end
    end,
	remove_from_deck = function(self, card, from_debuff)
		for i = 1, #G.playing_cards do
			if G.playing_cards[i].ability.finityceruleanbellmark and G.playing_cards[i].ability.finityceruleanbellmark == card.ability.identifier then
				G.playing_cards[i].ability.finityceruleanbellmark = nil
				if G.playing_cards[i].finity then
					G.playing_cards[i].finity.floating_sprite_mark = nil
				end
			end
		end
	end
}
SMODS.Consumable {
	key = 'finity',
	name = "Finity",
	set = 'Spectral',
	loc_txt = {
        name = "Finity",
        text = {
            "Creates a",
			"{C:hearts,E:2}Showdown{} Joker",
			"{C:inactive}(Must have room)",
        }
    },
	hidden = true,
	soul_set = 'Spectral',
	soul_rate = 0.006,
	atlas = 'consumables',
	pos = { x = 0, y = 0 },
	cost = 4,
	use = function(self, card, context, copier)
		local new_card = create_card('Joker', G.jokers, nil, "finity_showdown", nil, nil, nil, 'finity')
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        new_card:start_materialize()
        G.GAME.joker_buffer = 0
	end,
	can_use = function(self, card)
		if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			return true
		else
			return false
		end
	end,
}
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
	set_spritesref(self, _center, _front)
	if _center and _center.name == "Finity" then
		self.children.floating_sprite = Sprite(
			self.T.x,
			self.T.y,
			self.T.w,
			self.T.h,
			G.ASSET_ATLAS[_center.atlas or _center.set],
			{ x = 1, y = 0 }
		)
		self.children.floating_sprite.role.draw_major = self
		self.children.floating_sprite.states.hover.can = false
		self.children.floating_sprite.states.click.can = false
	end
end
SMODS.DrawStep {
    key = 'finity',
    order = 51,
    func = function(self)
        if self.ability.name == 'Finity' and (self.config.center.discovered or self.bypass_discovery_center) then
            local scale_mod = 0.07 + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod = 0.5 * G.TIMERS.REAL

			self.children.floating_sprite.role.draw_major = self
			self.children.floating_sprite:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				-0.07 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			self.children.floating_sprite:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				-0.2
			)
        end
		if self.config.center and (self.ability.finitycrimsonheartmark or self.ability.finityceruleanbellmark or self.ability.finityrazzleraindropmark) and self.finity and self.finity.floating_sprite_mark then
            local scale_mod = 0.07 + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
			local rotate_mod = 0

			self.finity.floating_sprite_mark.role.draw_major = self
			self.finity.floating_sprite_mark:draw_shader(
				"dissolve",
				0,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				-0.07 + 0.03 * math.sin(1.8 * G.TIMERS.REAL),
				nil,
				0.6
			)
			self.finity.floating_sprite_mark:draw_shader(
				"dissolve",
				nil,
				nil,
				nil,
				self.children.center,
				scale_mod,
				rotate_mod,
				nil,
				-0.07
			)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
to_big = to_big or function(value)
  return value
end

local old_start_run = Game.start_run
function Game:start_run(args)
    old_start_run(self,args)
    for i = 1, #G.jokers.cards do
		if G.jokers.cards[i].ability.finitycrimsonheartmark then
			G.jokers.cards[i].finity = {}
			G.jokers.cards[i].finity.floating_sprite_mark = Sprite(
			G.jokers.cards[i].T.x,
			G.jokers.cards[i].T.y,
			G.jokers.cards[i].T.w,
			G.jokers.cards[i].T.h,
			G.ASSET_ATLAS['finity_marks'],
			{ x = 0, y = 0 }
			)
			G.jokers.cards[i].finity.floating_sprite_mark.role.draw_major = G.jokers.cards[i]
			G.jokers.cards[i].finity.floating_sprite_mark.states.hover.can = false
			G.jokers.cards[i].finity.floating_sprite_mark.states.click.can = false
		end
	end
	for i = 1, #G.hand.cards do
		if G.hand.cards[i].ability.finityceruleanbellmark then
			G.hand.cards[i].finity = {}
			G.hand.cards[i].finity.floating_sprite_mark = Sprite(
			G.hand.cards[i].T.x,
			G.hand.cards[i].T.y,
			G.hand.cards[i].T.w,
			G.hand.cards[i].T.h,
			G.ASSET_ATLAS['finity_marks'],
			{ x = 1, y = 0 }
			)
			G.hand.cards[i].finity.floating_sprite_mark.role.draw_major = G.hand.cards[i]
			G.hand.cards[i].finity.floating_sprite_mark.states.hover.can = false
			G.hand.cards[i].finity.floating_sprite_mark.states.click.can = false
		end
	end
	for i = 1, #G.playing_cards do
		if G.playing_cards[i].ability.finityrazzleraindropmark then
			G.playing_cards[i].finity = {}
			G.playing_cards[i].finity.floating_sprite_mark = Sprite(
			G.playing_cards[i].T.x,
			G.playing_cards[i].T.y,
			G.playing_cards[i].T.w,
			G.playing_cards[i].T.h,
			G.ASSET_ATLAS['finity_marks'],
			{ x = 2, y = 0 }
			)
			G.playing_cards[i].finity.floating_sprite_mark.role.draw_major = G.playing_cards[i]
			G.playing_cards[i].finity.floating_sprite_mark.states.hover.can = false
			G.playing_cards[i].finity.floating_sprite_mark.states.click.can = false
		end
	end
	for i = 1, #G.GAME.tags do
			if G.GAME.tags[i].key == "tag_finity_showdown" and G.GAME.tags[i].config.joker == "none" then
				G.GAME.tags[i].config.joker = FinisherBossBlindStringMap[G.GAME.blind.config.blind.key][1]
				G.GAME.tags[i].config.display = FinisherBossBlindStringMap[G.GAME.blind.config.blind.key][2]
		end
	end
	--G.P_CENTERS.b_finity_taunting.atlas, G.P_CENTERS.b_finity_taunting.pos = G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][6], G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][7]
end

SMODS.Back{
   key = "challenger",
    atlas = "backs",
    pos = {x = 0, y = 0},
    loc_txt = {
        name ="Challenger's Deck",
        text={
			"{C:attention}+1{} Joker slot",
			"Start run with {C:attention,T:v_directors_cut}Director's",
			"{C:attention}Cut{} and extra {C:money}6$",
			"All {C:attention}Boss Blinds{} are {C:attention}Showdowns",
        },
    },
	config = {
        voucher = "v_directors_cut",
		dollars = 6,
		joker_slot = 1
    },
}
G.finityblinddecktype = {"bl_final_bell","Cerulean Bell","notchange","atlas","pos"}
SMODS.Back{
   key = "taunting",
    atlas = "blinddeck",
    pos = {x = 5, y = 0},
    loc_txt = {
        name ="Taunting Deck",
        text={
			"{C:attention}Boss Blind{} is always {C:attention}#1#{}",
			"{C:inactive}(Click to swap)",
        },
    },
	finitychanging = "unknown",
	config = {
        blind = "none"
    },
	loc_vars = function(self, info_queue, center)
		return { vars = {G.finityblinddecktype[2]} }
	end,
	apply = function(self)
		G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][5] = G.finityblinddecktype[1]
		G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][6] = G.finityblinddecktype[4]
		G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][7] = G.finityblinddecktype[5]
		G.GAME.banned_keys["v_directors_cut"] = true
		G.GAME.banned_keys["v_retcon"] = true
    end
}
local oldclick = Card.click
		function Card:click()
			oldclick(self)
			if
				Galdur
					and safely_get(Galdur, "run_setup", "current_page") == 1
					and self.config.center.key == "b_finity_taunting"
					and self.area == safely_get(Galdur, "run_setup", "selected_deck_area")
				or not Galdur
					and (safely_get(G.GAME, "viewed_back", "effect", "center", "finitychanging") and (self.back == "viewed_back" or self.edeck_select))
			then
				local eligible_bosses = {}
				for k, v in pairs(G.P_BLINDS) do
					if v.boss and v.boss.showdown then
						if FinisherBossBlindStringMap[k] then
							eligible_bosses[k] = FinisherBossBlindStringMap[k][2]
						else
							eligible_bosses[k] = v.name
						end
					end
				end
				local _keys = {}
				local _values = {}
				local _atlas
				local _coords
				local _finityisitinthere = 0
				for k, v in pairs(eligible_bosses) do
					if k == G.finityblinddecktype[1] then
						_finityisitinthere = _finityisitinthere + 1
					end
					table.insert(_keys, k)
					table.insert(_values, v)
				end
				if _finityisitinthere == 0 then
					table.insert(_keys, G.finityblinddecktype[1])
				end
				for i, k in ipairs(_keys) do
					if k == G.finityblinddecktype[1] then
						local next_index = (i % #_keys) + 1
						G.finityblinddecktype[1] = _keys[next_index]
						G.finityblinddecktype[2] = _values[next_index]
						if self.children.back then self.children.back:remove() end
						if FinisherBossBlinddecksprites[_keys[next_index]] then
							_atlas = FinisherBossBlinddecksprites[_keys[next_index]][1]
							_coords = FinisherBossBlinddecksprites[_keys[next_index]][2]
						else
							_atlas = FinisherBossBlinddecksprites["placeholder"][1]
							_coords = FinisherBossBlinddecksprites["placeholder"][2]
						end
						G.finityblinddecktype[4] = _atlas
						G.finityblinddecktype[5] = _coords
						self.children.back = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_atlas], _coords)
						self.children.back.states.hover = self.states.hover
						self.children.back.states.click = self.states.click
						self.children.back.states.drag = self.states.drag
						self.children.back.states.collide.can = false
						self.children.back:set_role({ major = self, role_type = 'Glued', draw_major = self })
						G.P_CENTERS.b_finity_taunting.atlas, G.P_CENTERS.b_finity_taunting.pos = _atlas, _coords
						G.finityblinddecktype[3] = "change"
						if not G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"] then
							G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"] = {}
						end
						G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"] = {_atlas,_coords,G.finityblinddecktype[1],G.finityblinddecktype[2],G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][5],G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][6],G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"][7]}
						break
					end
				end
			end
		end

old_RUN_SETUP_check_back = G.FUNCS.RUN_SETUP_check_back
G.FUNCS.RUN_SETUP_check_back = function(e)
	if G.GAME.viewed_back.name ~= e.config.id then
	end
	old_RUN_SETUP_check_back(e)
	if G.GAME.viewed_back.name == "b_finity_taunting" and G.finityblinddecktype[3] == "change" then
		e.config.object:remove() 
		e.config.object = UIBox{
      definition = G.GAME.viewed_back:generate_UI(),
      config = {offset = {x=0,y=0}, align = 'cm', parent = e}
    }
	G.finityblinddecktype[3] = "notchange"
	end
end

local old_init_game_object = Game.init_game_object
function Game:init_game_object()
	local ret =old_init_game_object(self)
	local finityblinddecksave = G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"]
	if finityblinddecksave and finityblinddecksave[1] and finityblinddecksave[2] then
		G.P_CENTERS.b_finity_taunting.atlas, G.P_CENTERS.b_finity_taunting.pos = finityblinddecksave[1], finityblinddecksave[2]
		G.finityblinddecktype[1] = finityblinddecksave[3]
		G.finityblinddecktype[2] = finityblinddecksave[4]
	else
		G.P_CENTERS.b_finity_taunting.atlas, G.P_CENTERS.b_finity_taunting.pos = "finity_blinddeck", { x = 1, y = 0 }
		G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"] = {}
	end
	return ret
end
		
if CardSleeves then
    CardSleeves.Sleeve {
		key = "challenger",
		atlas = "sleeves",
		pos = { x = 0, y = 0 },
		loc_txt = {
			name = "Challenger's Sleeve",
			text={
				"{C:attention}+1{} Joker slot",
				"Start run with {C:attention,T:v_directors_cut}Director's",
				"{C:attention}Cut{} and extra {C:money}6$",
				"All {C:attention}Boss Blinds{} are {C:attention}Showdowns",
			},
		},
		config = {
			voucher = "v_directors_cut",
			dollars = 6,
			joker_slot = 1
		},
		loc_vars = function(self)
			local key, vars
			if self.get_current_deck_key() == "b_finity_challenger" then
				key = self.key .. "_alt"
				self.config = { voucher = "v_retcon", dollars = 6, joker_slot = 1 }
				vars = { self.config.voucher, self.config.dollars, self.config.joker_slot, }
			else
				key = self.key
				self.config = { voucher = "v_directors_cut", dollars = 6, joker_slot = 1 }
				vars = { self.config.voucher, self.config.dollars, self.config.joker_slot, }
			end
			return { key = key, vars = vars }
		end,
	}
end

local old_get_new_boss = get_new_boss
function get_new_boss()
	if G.GAME.selected_back.name == "b_finity_taunting" then
		local _savetable = G.PROFILES[G.SETTINGS.profile]["finityblinddeckdata"]
		return _savetable[5]
	end
	for k, v in pairs(G.P_BLINDS) do
		if not G.GAME.bosses_used[k] then
			G.GAME.bosses_used[k] = 0
		end
	end
    local boss = old_get_new_boss()
	if string.sub(boss, 1, 15) ~= "bl_akyrs_master" and vvcheck ~= "vv" then
		if next(SMODS.find_card('j_finity_violetvessel')) and not G.finityvvcheck then
			if string.sub(boss, 1, 15) == "bl_akyrs_expert" then
				boss = "bl_akyrs_expert_inflation"
			elseif (G.GAME.round_resets.ante % G.GAME.win_ante == 0 or G.GAME.selected_back.name == "b_finity_challenger" or G.GAME.selected_sleeve =="sleeve_finity_challenger") then
				boss = "bl_final_vessel"
			else
				boss = "bl_wall"
			end
		elseif G.GAME.selected_back.name == "b_finity_challenger" or G.GAME.selected_sleeve == "sleeve_finity_challenger" then
			local eligible_bosses = {}
			for k, v in pairs(G.P_BLINDS) do
				if v.boss and v.boss.showdown then
					eligible_bosses[k] = true
				end
			end
			for k, v in pairs(G.GAME.banned_keys) do
				eligible_bosses[k] = nil
			end

			local min_use = 100
			for k, v in pairs(G.GAME.bosses_used) do
				if eligible_bosses[k] then
					eligible_bosses[k] = v
					min_use = math.min(min_use, eligible_bosses[k])
				end
			end
	
			for k, v in pairs(eligible_bosses) do
				if v and v > min_use then
					eligible_bosses[k] = nil
				end
			end
	
			local _, new_boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))
			G.GAME.bosses_used[new_boss] = G.GAME.bosses_used[new_boss] + 1
			boss = new_boss
		end
	end
	G.finityvvcheck = nil
    return boss
end

--cryptid crossmod jokers
if next(SMODS.find_mod('Cryptid')) then
SMODS.Joker {
    key = "lavenderloop",
    name = "Lavender Loop",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Lavender Loop",
        text = {
            "Beat the blind before {C:attention}Timer",
			"reaches {C:attention}0{} to destroy this and",
			"create a random {C:cry_exotic,E:1}Exotic {C:attention}Joker",
        }
    },
	config = {
		start = 0,
		inblind = 0,
		time = 30
	},
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = "finity_showdown",
    pos = { x = 0, y = 3 },
    cost = 10,
	soul_pos = { x = 1, y = 3 },
	loc_vars = function(self, info_queue, card)
    return {
        main_end = {
				{
				n = G.UIT.C,
				config = { align = "bm", minh = 0.3 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							ref_table = card.ability,
							ref_value = "time",
							scale = 0.32,
							colour = G.C.BLACK
						}
					}
				}
			}
        }
    }
	end,
	update = function(self, card)
		card.ability.time = string.gsub(string.format("%.2f",30-(G.TIMERS.REAL - card.ability.start)*card.ability.inblind), "%.", ":")
	end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.setting_blind then
			card.ability.start = G.TIMERS.REAL
			card.ability.inblind = 1
			return {
                message = "START!",
            }
		end
		if context.end_of_round and context.main_eval and not context.repetition then
			card.ability.inblind = 0
			if G.TIMERS.REAL - card.ability.start <= 30 then
				card:start_dissolve()
				SMODS.add_card { set = 'Joker', rarity = "cry_exotic" }
				return {
                message = "Success",
				}
			else
				return {
                message = "Failure",
				}
			end
		end
	end
}
SMODS.Joker {
    key = "turquoisetornado",
    name = "Turquoise Tornado",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Turquoise Tornado",
        text = {
            "All scoring cards have",
			"{C:green}#1# in #3#{} chance to be",
			"destroyed and give their {C:chips}chips",
			"multiplied by {C:attention}#2#{} to this Joker",
			"{C:inactive}(currently {C:chips}+#4#{C:inactive} Chips)"
        }
    },
	config = {
		extra = { chips = 0 },
		multiplier = 15,
		odds = 3
	},
	loc_vars = function(self, info_queue, card)
        return{ vars = {G.GAME.probabilities.normal*2,card.ability.multiplier,card.ability.odds,card.ability.extra.chips}}
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 5 },
    cost = 10,
	soul_pos = { x = 1, y = 5 },
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}},
				colour = G.C.CHIPS,
				card = card
            }
        end
		if context.destroying_card and not context.blueprint then
			if pseudorandom('turquoisetornado') < G.GAME.probabilities.normal / (card.ability.odds*2) then
				context.destroying_card.ability.perma_bonus = context.destroying_card.ability.perma_bonus or 0
				card.ability.extra.chips = card.ability.extra.chips + ((context.destroying_card.base.nominal + context.destroying_card.ability.perma_bonus) * card.ability.multiplier)
				return {
						message = localize('k_upgrade_ex'), colour = G.C.CHIPS,
						colour = G.C.CHIPS,
						remove = true,
						card = card
					}
			end
		end
	end
}
SMODS.Joker {
    key = "vermillionvirus",
    name = "Vermillion Virus",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Vermillion Virus",
        text = {
            "At end of round, destroy the",
			"{C:attention}Joker{} to the right and create",
			"one of a higher {C:attention}rarity",
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 0 },
    cost = 10,
	soul_pos = { x = 1, y = 0 },
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.repetition then
			local virus_pos
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					virus_pos = i
					break
				end
			end
			if G.jokers.cards[virus_pos+1] then
				local _raritylist = {1,{2,"cry_candy"},{3,"poke_safari"},"cry_epic",{4,"finity_showdown","poke_mega"},"cry_exotic"}
				local _rarity = G.jokers.cards[virus_pos+1].config.center.rarity
				local _newrarity
				local _raritiesstring = {"Common", "Uncommon", "Rare", "cry_epic", "Legendary", "cry_exotic"}
				if next(SMODS.find_mod('entr')) then
					table.insert(_raritiesstring, "entr_entropic")
					table.insert(_raritylist[5], "entr_reverse_legendary")	
				end
				for index, value in ipairs(_raritylist) do
					if value == _rarity then
						_newrarity = index + 1
						_rarity = index
						break
					elseif type(value) == "table" then
						for sub_index, sub_value in ipairs(value) do
							if sub_value == _rarity then
								_newrarity = index + 1
								_rarity = index
								break
							end
						end
					end
				end
				if _newrarity and _newrarity <= #_raritiesstring and not G.jokers.cards[virus_pos+1].ability.eternal then
					card:juice_up()
					G.jokers.cards[virus_pos+1]:start_dissolve()
					SMODS.add_card { set = 'Joker', rarity = _raritiesstring[_newrarity]}
					card:juice_up(0.3, 0.5)
				end
			end
		end
	end
}
SMODS.Joker {
    key = "sapphirestamp",
    name = "Sapphire Stamp",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Sapphire Stamp",
        text = {
            "You can select {C:attention}any",
			"number of cards",
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = "finity_showdown",
    pos = { x = 0, y = 1 },
    cost = 10,
	soul_pos = { x = 1, y = 1 },
	add_to_deck = function(self, card, from_debuff)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1e20
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1e20
		if G.hand.config.highlighted_limit < 5 then
			G.hand.config.highlighted_limit = 5
		end
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end,
}
SMODS.Joker {
    key = "obsidianorb",
    name = "Obsidian Orb",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Obsidian Orb",
        text = {
            "Copies the ability of",
			"every {C:attention}Joker{}",
			"{C:inactive}(Except {C:attention}Obsidian Orb{C:inactive})",
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = "finity_showdown",
    pos = { x = 0, y = 2 },
    cost = 10,
	soul_pos = { x = 1, y = 2 },
	calculate = function(self, card, context) --huge thanks to Somethingcom515 for helping me with this multi-blueprint effect
	if context.blueprint then return end      --anyone reading this should definitely check out his awesome mod "seals on everything" :)
	local effects_table = {}
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center.key ~= "j_finity_obsidianorb" then
				local effect = SMODS.blueprint_effect(card, G.jokers.cards[i], context)
				if effect then
					effect.colour = G.C.BLACK
				end
				effects_table[#effects_table+1] = effect
			end
		end
		return finity_obsidian_recursive(effects_table, 1)
	end,
}
function finity_obsidian_recursive(table_return_table, index)
    local ret = table_return_table[index]
    if index <= #table_return_table then
        local function getDeepest(tbl)
            tbl = tbl or {}
            while tbl.extra do
                tbl = tbl.extra
            end
            return tbl
        end
        local prev = getDeepest(ret)
        prev.extra = finity_obsidian_recursive(table_return_table, index + 1)
    end
    return ret
end

SMODS.Joker {
    key = "lemontrophy",
    name = "Lemon Trophy",
    atlas = 'crybossjokers',
    loc_txt = {
        name = "Lemon Trophy",
        text = {
            "Set {X:chips,C:white}Chips{} to equal {X:mult,C:white}Mult",
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 4 },
    cost = 10,
	soul_pos = { x = 1, y = 4 },
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = "Balanced?",
				chip_mod = mult - hand_chips,
				colour = G.C.CHIPS,
			}
		end
	end
}
end
--aikoyori's shenanigans crossmod jokers
if next(SMODS.find_mod('aikoyorisshenanigans')) then
SMODS.Joker {
    key = "periwinklepinecone",
    name = "Periwinkle Pinecone",
    atlas = 'akyrsbossjokers',
    loc_txt = {
        name = "Periwinkle Pinecone",
        text = {
            "Add a {C:attention}seal{} to all played cards",
			"that don't have one, cards",
			"with {C:attention}seals{} can't be {C:attention}debuffed",
        }
    },
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = "finity_showdown",
    pos = { x = 0, y = 0 },
    cost = 10,
	soul_pos = { x = 1, y = 0 },
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.before and context.cardarea == G.jokers and not (context.individual or context.repetition) then
			local goodseals = {}
			local _givenseal
			local given____
			for i = 1, #context.scoring_hand do
				if not context.scoring_hand[i].seal then
					given____ = true
					_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					while _givenseal == nil or _givenseal == "akyrs_debuff" do
						_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					end
					context.scoring_hand[i]:set_seal(_givenseal)
				end
			end
			if given____ == true then
				return {
				message = "Sealed",
			}
			end
		end
	end
}
SMODS.Joker {
    key = "razzleraindrop",
    name = "Razzle Raindrop",
    atlas = 'akyrsbossjokers',
    loc_txt = {
        name = "Razzle Raindrop",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult if a {C:hearts}#3#{C:spades}#4#{C:diamonds}#5#{C:clubs}#6#{} suit",
			"card is scored and {C:attention}mark{} it, cards",
			"{C:attention}marked{} this way count as any suit",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
	config = {
		extra = { xmult = 1 },
		increase = 0.2,
		suit = "none"
	},
	loc_vars = function(self, info_queue, card)
		local _hearts = ""
		local _spades = ""
		local _diamonds = ""
		local _clubs = ""
		if card.ability.suit == "Hearts" then
			_hearts = "Heart"
		elseif card.ability.suit == "Spades" then
			_spades = "Spade"
		elseif card.ability.suit == "Diamonds" then
			_diamonds = "Diamond"
		elseif card.ability.suit == "Clubs" then
			_clubs = "Club"
		end
        return{ vars = {card.ability.extra.xmult,card.ability.increase,_hearts,_spades,_diamonds,_clubs}}
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 1 },
    cost = 10,
	soul_pos = { x = 1, y = 1 },
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.suit == "none" then
			card.ability.suit = pseudorandom_element({ "Spades", "Hearts", "Clubs", "Diamonds" })
		end
    end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			card.ability.suit = pseudorandom_element({ "Spades", "Hearts", "Clubs", "Diamonds" })
		end
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card:is_suit(card.ability.suit) then
				local __card__ = context.other_card
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				card:juice_up()
				__card__:juice_up()
				__card__.ability.finityrazzleraindropmark = true
				__card__.finity = {}
				__card__.finity.floating_sprite_mark = Sprite(
				__card__.T.x,
				__card__.T.y,
				__card__.T.w,
				__card__.T.h,
				G.ASSET_ATLAS['finity_marks'],
				{ x = 2, y = 0 }
				)
				__card__.finity.floating_sprite_mark.role.draw_major = __card__
				__card__.finity.floating_sprite_mark.states.hover.can = false
				__card__.finity.floating_sprite_mark.states.click.can = false
				return true end}))
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase
				SMODS.calculate_effect({
                    message = "X" .. tostring(card.ability.extra.xmult) .. " Mult",
					colour = G.C.RED,
				},card)
			end
		end
	end
}
SMODS.Joker {
    key = "lilaclasso",
    name = "Lilac Lasso",
    atlas = 'akyrsbossjokers',
    loc_txt = {
        name = "Lilac Lasso",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult per empty {C:attention}Joker{}",
			"slot when hand is played ",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
	config = {
		extra = { xmult = 1 },
		increase = 1,
	},
	loc_vars = function(self, info_queue, card)
        return{ vars = {card.ability.extra.xmult,card.ability.increase}}
    end,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 0, y = 2 },
    cost = 10,
	soul_pos = { x = 1, y = 2 },
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
		if context.before and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.increase*(G.jokers.config.card_limit - #G.jokers.cards)
			SMODS.calculate_effect({
                    message = "X" .. tostring(card.ability.extra.xmult) .. " Mult",
					colour = G.C.RED,
				},card)
		end
	end
}
local old_card_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if flush_calc then
		if self.ability and self.ability.finityrazzleraindropmark and not self.debuff then
			return true
		end
		return old_card_is_suit(self, suit, bypass_debuff, flush_calc)
	else
		if self.debuff and not bypass_debuff then return end
		if self.ability and self.ability.finityrazzleraindropmark and not self.debuff then
			return true
		end
		return old_card_is_suit(self, suit, bypass_debuff, flush_calc)
	end
end
end

if next(SMODS.find_mod('partner')) then
--[[Partner_API.Partner{
	key = "lovesick",
    name = "The Lovesick",
    unlocked = true,
    discovered = true,
	individual_quips = true,
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "The Lovesick",
        text = {
            "One random {C:attention}Joker{} is {C:attention}marked",
			"every hand, gains {C:mult}+#2#{} Mult",
			"when a marked {C:attention}Joker{} triggers",
			"{C:inactive}(currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    atlas = "partners",
    config = {extra = {related_card = "j_finity_crimsonheart", mult = 0, mult_mod = 0.5}, hand_played = true},
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 2 end
        return { vars = {card.ability.extra.mult,card.ability.extra.mult_mod*benefits} }
    end,
    calculate = function(self, card, context)
        if (context.partner_hand_drawn and card.ability.hand_played == true) or context.partner_end_of_round then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.finitycrimsonheartmark and G.jokers.cards[i].ability.finitycrimsonheartmark == "lovesick" then
					G.jokers.cards[i].ability.finitycrimsonheartmark = nil
					if G.jokers.cards[i].finity then
						G.jokers.cards[i].finity.floating_sprite_mark = nil
					end
				end
			end
			if context.partner_hand_drawn then
				card.ability.hand_played = false
				local _heartlesstable = {}
				for _, v in ipairs(G.jokers.cards) do
					if v ~= card and v.config.center.key ~= "j_finity_crimsonheart" and not v.ability.finitycrimsonheartmark then
						table.insert(_heartlesstable, v)
					end
				end
				if next(_heartlesstable) ~= nil then
					local _heart_target = pseudorandom_element(_heartlesstable)
					_heart_target.ability.finitycrimsonheartmark = "lovesick"
					_heart_target.finity = {}
					_heart_target.finity.floating_sprite_mark = Sprite(
					_heart_target.T.x,
					_heart_target.T.y,
					_heart_target.T.w,
					_heart_target.T.h,
					G.ASSET_ATLAS['finity_marks'],
					{ x = 0, y = 0 }
					)
					_heart_target.finity.floating_sprite_mark.role.draw_major = _heart_target
					_heart_target.finity.floating_sprite_mark.states.hover.can = false
					_heart_target.finity.floating_sprite_mark.states.click.can = false
					_heart_target:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
				end
			end
		end
    end,
}]]
Partner_API.Partner{
    key = "scrooge",
    name = "The Scrooge",
    unlocked = true,
    discovered = true,
	individual_quips = true,
    pos = {x = 3, y = 0},
    loc_txt = {
        name = "The Scrooge",
        text = {
            "Earn {C:money}#1#${} when",
			"you sell a card",
        }
    },
    atlas = "partners",
    config = {extra = {related_card = "j_finity_verdantleaf", money = 1}},
    loc_vars = function(self, info_queue, card)
        local benefits = 1
        if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 2 end
        return { vars = {card.ability.extra.money*benefits} }
    end,
    calculate = function(self, card, context)
        if context.partner_selling_card then
            local benefits = 1
            if next(SMODS.find_card(card.ability.extra.related_card)) then benefits = 2 end
			return {
				dollars = card.ability.extra.money*benefits,
				card = card
			}
        end
    end,
}
end

function safely_get(t, ...)
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

G.localization.descriptions.Other['crimsonmark'] =  {
        name = 'Crimson Mark',
        text = {"Retriggers {C:attention}2",
				"extra times"
			},
    }
G.localization.descriptions.Other['ceruleanmark'] =  {
        name = 'Cerulean Mark',
        text = {"gains {X:mult,C:white}X2{}",
				"Mult when scored"
			},
    }
G.localization.descriptions.Other['razzlemark'] =  {
        name = 'Razzle Mark',
        text = {"Can be used",
				"as any suit"
			},
    }