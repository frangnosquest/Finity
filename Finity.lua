Finity = Finity or {}
Finity.config = SMODS.current_mod.config

SMODS.current_mod.optional_features = function()
	return { retrigger_joker = true, post_trigger = true }
end

local function load_module(path)
	assert(SMODS.load_file(path))()
end

local function has_mod(id)
	return next(SMODS.find_mod(id)) ~= nil
end

load_module("modules/atlases.lua")
load_module("modules/utils.lua")
load_module("modules/api.lua")
load_module("modules/marks.lua")
load_module("modules/showdown.lua")
load_module("modules/jokers.lua")

if Finity.config.spectral then
	load_module("modules/spectral.lua")
end

load_module("modules/decks.lua")
load_module("modules/taunting.lua")
load_module("modules/bosses.lua")

if CardSleeves then
	load_module("modules/crossmod/sleeves.lua")
end

if has_mod("Cryptid") then
	load_module("modules/crossmod/cryptid.lua")
end
if has_mod("aikoyorisshenanigans") then
	load_module("modules/crossmod/aikoyori.lua")
end
if has_mod("ortalab") then
	load_module("modules/crossmod/ortalab.lua")
end
if has_mod("Cardsauce") then
	load_module("modules/crossmod/cardsauce.lua")
end
if has_mod("Pokermon") then
	load_module("modules/crossmod/pokermon.lua")
end
if has_mod("paperback") then
	load_module("modules/crossmod/paperback.lua")
end
if has_mod("Bunco") then
	load_module("modules/crossmod/bunco.lua")
end

if has_mod("partner") then
	load_module("modules/partners/partners.lua")
	if has_mod("Cryptid") then
		load_module("modules/partners/cryptid.lua")
	end
	if has_mod("aikoyorisshenanigans") then
		load_module("modules/partners/aikoyori.lua")
	end
end

load_module("modules/hooks.lua")
load_module("modules/credits.lua")
load_module("modules/secret.lua")
load_module("modules/ui.lua")
load_module("modules/badge.lua")

if JokerDisplay and JokerDisplay.Definitions then
	load_module("modules/crossmod/jokerdisplay.lua")
end

if has_mod("cardpronouns") then
	load_module("modules/crossmod/pronouns.lua")
end
