--hello to whoever is reading this, this is all you need to give your boss blinds
--their own boss joker for cross-mod compatibility

--call Finity.register_showdown for every blind, every field except blind and joker is optional:
--
--if Finity and Finity.register_showdown then
--	Finity.register_showdown({
--		blind = "bl_mymod_scarlet_spoon",       --key of your boss blind
--		joker = "j_mymod_scarletspoon",         --key of the joker the showdown tag gives (give it the "finity_showdown" rarity)
--		name = "Scarlet Spoon",                 --fallback display name, only used when the blind has no localized name
--		deck = {                                --Taunting deck art for this blind, uses the placeholder if left out
--			atlas = "mymod_blinddeck",          --full atlas key, mod prefix included
--			pos = { x = 0, y = 0 },
--		},
--		quips = {                               --the boss joker replaces jimbo on the game over screen
--			key = "scarlet",                    --quips are read from misc.quips as lq_scarlet_1, lq_scarlet_2...
--			count = 3,                          --how many lq_scarlet_N quips you have
--			endless = 2,                        --optional, quips for losing in endless, lq_endless_scarlet_1...
--		},
--	})
--end
--
--Finity loads with priority -5, so any mod with the default priority (0) or higher can just call it
--straight from its main file, the check above skips it when Finity isn't installed
--if your mod has to load before Finity, call it from a Game:main_menu hook instead, that works just as well
--while the mod is meant for showdown boss blinds specifically, nothing stops you from using regular boss blinds

--if your mod adds a joker rarity, you can also tell Finity where it sits so Verdant Leaf and
--Vermillion Virus know how to move it up or down, by naming an existing rarity of the same tier:
--
--if Finity and Finity.register_rarity then
--	Finity.register_rarity("mymod_shiny", "Rare")          --treated as Rare, never created by the effects of the Jokers above
--	Finity.register_rarity("mymod_mythic", "cry_exotic", true) --same tier as Exotic and can be created
--end

--mods made before register_showdown existed filled these tables directly, this method
--is outdated and i do not rcommend it but it still works to avoid breaking compatibility:
--FinisherBossBlindStringMap["bl_key"] = {"joker key", "display name"}
--FinisherBossBlinddecksprites["bl_key"] = {"atlas key", { x = 0, y = 0 }}
--FinisherBossBlindQuips["bl_key"] = {"quip key", quip count, endless quip count}

Finity.showdowns = Finity.showdowns or {}

FinisherBossBlindStringMap = FinisherBossBlindStringMap or {}
FinisherBossBlinddecksprites = FinisherBossBlinddecksprites or {}
FinisherBossBlindQuips = FinisherBossBlindQuips or {}

Finity.placeholder_deck = { atlas = "finity_blinddeck", pos = { x = 5, y = 0 } }

local function warn(message)
	if sendWarnMessage then
		sendWarnMessage(message, "Finity")
	end
end

function Finity.register_showdown(def)
	if type(def) ~= "table" or type(def.blind) ~= "string" or type(def.joker) ~= "string" then
		warn("register_showdown needs at least a blind key and a joker key")
		return
	end
	local deck = def.deck
	if deck and not (type(deck.atlas) == "string" and type(deck.pos) == "table") then
		warn(("register_showdown: ignoring invalid deck art for %s"):format(def.blind))
		deck = nil
	end
	local quips = def.quips
	if quips and not (type(quips.key) == "string" and type(quips.count) == "number") then
		warn(("register_showdown: ignoring invalid quips for %s"):format(def.blind))
		quips = nil
	end
	local entry = {
		blind = def.blind,
		joker = def.joker,
		name = def.name,
		deck = deck,
		quips = quips,
	}
	Finity.showdowns[def.blind] = entry
	return entry
end

local function legacy_showdown(blind)
	local map = FinisherBossBlindStringMap[blind]
	local sprite = FinisherBossBlinddecksprites[blind]
	local quips = FinisherBossBlindQuips[blind]
	if not (map or sprite or quips) then return end
	return {
		joker = map and map[1],
		name = map and map[2],
		deck = sprite and { atlas = sprite[1], pos = sprite[2] },
		quips = quips and type(quips[1]) == "string" and tonumber(quips[2])
			and { key = quips[1], count = tonumber(quips[2]), endless = tonumber(quips[3]) } or nil,
	}
end

function Finity.get_showdown(blind)
	if not blind then return end
	local registered = Finity.showdowns[blind]
	local legacy = legacy_showdown(blind)
	if not (registered or legacy) then return end
	local first, second = registered or {}, legacy or {}
	if registered and registered.builtin then
		first, second = second, first
	end
	return {
		blind = blind,
		joker = first.joker or second.joker,
		name = first.name or second.name,
		deck = first.deck or second.deck,
		quips = first.quips or second.quips,
	}
end

function Finity.showdown_name(blind)
	if blind and G.P_BLINDS[blind] then
		local name = localize { type = "name_text", set = "Blind", key = blind }
		if name and name ~= "ERROR" then return name end
	end
	local showdown = Finity.get_showdown(blind)
	return showdown and showdown.name or blind
end

local function deck(x, y)
	return { atlas = "finity_blinddeck", pos = { x = x, y = y } }
end

local function quips(key, count, endless)
	return { key = key, count = count, endless = endless }
end

local builtin = {
	{ blind = "bl_final_acorn", joker = "j_finity_amberacorn", name = "Amber Acorn", deck = deck(2, 0), quips = quips("amber", 3, 3) },
	{ blind = "bl_final_leaf", joker = "j_finity_verdantleaf", name = "Verdant Leaf", deck = deck(3, 0), quips = quips("verdant", 3, 3) },
	{ blind = "bl_final_vessel", joker = "j_finity_violetvessel", name = "Violet Vessel", deck = deck(4, 0), quips = quips("violet", 3, 3) },
	{ blind = "bl_final_heart", joker = "j_finity_crimsonheart", name = "Crimson Heart", deck = deck(0, 0), quips = quips("crimson", 3, 3) },
	{ blind = "bl_final_bell", joker = "j_finity_ceruleanbell", name = "Cerulean Bell", deck = deck(1, 0), quips = quips("cerulean", 3, 3) },
	{ blind = "bl_cry_lavender_loop", joker = "j_finity_lavenderloop", name = "Lavender Loop", deck = deck(3, 1), quips = quips("lavender", 3, 2) },
	{ blind = "bl_cry_tornado", joker = "j_finity_turquoisetornado", name = "Turquoise Tornado", deck = deck(5, 1), quips = quips("turquoise", 3, 3) },
	{ blind = "bl_cry_vermillion_virus", joker = "j_finity_vermillionvirus", name = "Vermillion Virus", deck = deck(0, 1), quips = quips("vermillion", 3, 3) },
	{ blind = "bl_cry_sapphire_stamp", joker = "j_finity_sapphirestamp", name = "Sapphire Stamp", deck = deck(1, 1), quips = quips("sapphire", 3, 3) },
	{ blind = "bl_cry_obsidian_orb", joker = "j_finity_obsidianorb", name = "Obsidian Orb", deck = deck(2, 1), quips = quips("obsidian", 3, 3) },
	{ blind = "bl_cry_trophy", joker = "j_finity_lemontrophy", name = "Lemon Trophy", deck = deck(4, 1), quips = quips("lemon", 3, 3) },
	{ blind = "bl_akyrs_final_periwinkle_pinecone", joker = "j_finity_periwinklepinecone", name = "Periwinkle Pinecone", deck = deck(0, 2), quips = quips("periwinkle", 3, 1) },
	{ blind = "bl_akyrs_final_razzle_raindrop", joker = "j_finity_razzleraindrop", name = "Razzle Raindrop", deck = deck(1, 2), quips = quips("razzle", 3, 1) },
	{ blind = "bl_akyrs_final_lilac_lasso", joker = "j_finity_lilaclasso", name = "Lilac Lasso", deck = deck(2, 2), quips = quips("lilac", 3, 3) },
	{ blind = "bl_akyrs_final_velvet_vapour", joker = "j_finity_velvetvapour", name = "Velvet Vapour", deck = deck(4, 2), quips = quips("velvet", 3) },
	{ blind = "bl_akyrs_final_chamomile_cloud", joker = "j_finity_chamomilecloud", name = "Chamomile Cloud", deck = deck(3, 2), quips = quips("chamomile", 3, 1) },
	{ blind = "bl_akyrs_final_salient_stream", joker = "j_finity_salientstream", name = "Salient Stream", deck = deck(5, 2), quips = quips("salient", 3) },
	{ blind = "bl_akyrs_final_luminous_lemonade", joker = "j_finity_luminouslemonade", name = "Luminous Lemonade", deck = deck(6, 2), quips = quips("luminous", 3) },
	{ blind = "bl_akyrs_final_glorious_glaive", joker = "j_finity_gloriousglaive", name = "Glorious Glaive", deck = deck(7, 2), quips = quips("glorious", 3, 3) },
	{ blind = "bl_ortalab_celadon_clubs", joker = "j_finity_celadonclubs", name = "Celadon Clubs", deck = deck(0, 3) },
	{ blind = "bl_ortalab_caramel_coin", joker = "j_finity_caramelcoin", name = "Caramel Coin", deck = deck(1, 3) },
	{ blind = "bl_ortalab_saffron_shield", joker = "j_finity_saffronshield", name = "Saffron Shield", deck = deck(2, 3) },
	{ blind = "bl_ortalab_rouge_rose", joker = "j_finity_rougerose", name = "Rouge Rose", deck = deck(3, 3) },
	{ blind = "bl_ortalab_silver_sword", joker = "j_finity_silversword", name = "Silver Sword", deck = deck(4, 3) },
	{ blind = "bl_csau_mochamike", joker = "j_finity_mochamike", name = "Mocha Mike", deck = deck(0, 4) },
	{ blind = "bl_csau_feltfortress", joker = "j_finity_feltfortress", name = "Felt Fortress", deck = deck(1, 4) },
	{ blind = "bl_poke_cgoose", joker = "j_finity_cgoosejoker", name = "Chartreuse Chamber", deck = deck(2, 4), quips = quips("chartreuse", 3) },
	{ blind = "bl_paperback_taupe_treble", joker = "j_finity_taupetreble", name = "Taupe Treble" },
	{ blind = "bl_bunc_final_crown", joker = "j_finity_chartreusecrown", name = "Chartreuse Crown" },
}

for _, def in ipairs(builtin) do
	if not Finity.showdowns[def.blind] then
		local entry = Finity.register_showdown(def)
		entry.builtin = true
	end
end
