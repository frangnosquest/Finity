return {
	descriptions = {
		Back = {
			b_finity_challenger = {
				name = "Challenger's Deck",
				text = {
					"{C:attention}+1{} Joker slot",
					"Start run with {C:attention,T:v_directors_cut}Director's",
					"{C:attention}Cut{} and extra {C:money}$6",
					"All {C:attention}Boss Blinds{} are {C:attention}Showdowns",
				},
			},
			b_finity_taunting = {
				name = "Taunting Deck",
				text = {
					"{C:attention}Boss Blind{} is always {C:attention}#1#{}",
					"{C:inactive}(Click the deck to choose)",
				},
			},
		},
		Sleeve = {
			sleeve_finity_challenger = {
				name = "Challenger's Sleeve",
				text = {
					"{C:attention}+1{} Joker slot",
					"Start run with {C:attention,T:v_directors_cut}Director's",
					"{C:attention}Cut{} and extra {C:money}$6",
					"All {C:attention}Boss Blinds{} are {C:attention}Showdowns",
				},
			},
			sleeve_finity_challenger_alt = {
				name = "Challenger's Sleeve",
				text = {
					"{C:attention}+1{} Joker slot",
					"Start run with {C:attention,T:v_retcon}Retcon",
					"and extra {C:money}$6",
					"All {C:attention}Big Blinds{} are {C:attention}Showdowns",
				},
			},
		},
		Spectral = {
			c_finity_finity = {
				name = "Finity",
				text = {
					"Choose {C:attention}1{} of {C:attention}2",
					"{C:hearts,E:2}Showdown{} Jokers",
					"{C:inactive}(Must have room)",
				},
			},
		},
		Tag = {
			tag_finity_showdown = {
				name = "Showdown Tag",
				text = {
					"{C:attention}#1#{} will",
					"return in the next shop...",
				},
			},
			tag_finity_showdown_fake = {
				name = "Showdown Tag",
				text = {
					"Earn {C:money}$#1#",
					"{C:inactive}(Tag is not authentic)",
				},
			},
		},
		Other = {
			finity_crimsonmark = {
				name = "Mark",
				text = {
					"Marked by",
					"{C:red}Crimson Heart",
				},
			},
			finity_crimsonmark_partner = {
				name = "Mark",
				text = {
					"Marked by",
					"{C:red}The Lovesick",
				},
			},
			finity_ceruleanmark = {
				name = "Mark",
				text = {
					"Marked by",
					"{C:blue}Cerulean Bell",
				},
			},
			finity_ceruleanmark_partner = {
				name = "Mark",
				text = {
					"Marked by",
					"{C:blue}The Controlling",
				},
			},
			finity_razzlemark = {
				name = "Razzle Mark",
				text = {
					"Can be used",
					"as any suit",
				},
			},
			finity_saffronmark = {
				name = "Saffron Mark",
				text = {
					"Cannot be",
					"debuffed or",
					"flipped",
				},
			},
		},
		Joker = {
			j_finity_verdantleaf = {
				name = "Verdant Leaf",
				text = {
					"When you sell a {C:attention}Joker{}, create",
					"one of the next lower {C:attention}rarity{},",
					"selling a {C:chips}common{} {C:attention}Joker{} creates",
					"a {C:attention}consumable",
				},
			},
			j_finity_violetvessel = {
				name = "Violet Vessel",
				text = {
					"All {C:attention}Boss Blinds{} become {C:purple}The Wall{} or",
					"{C:purple}Violet Vessel{}, gains {X:mult,C:white}XMult{} equal to score",
					"surplus ratio after beating a {C:attention}Boss Blind{}",
					"{C:inactive,s:0.8}(Max {X:mult,C:white,s:0.8}X#2#{C:inactive,s:0.8} Mult per round, currently {X:mult,C:white,s:0.8}X#1#{C:inactive,s:0.8} Mult)",
				},
			},
			j_finity_amberacorn = {
				name = "Amber Acorn",
				text = {
					"Gains {X:mult,C:white}X#2#{} Mult for each {C:attention}Joker{}",
					"card when {C:attention}Blind{} is defeated, all other",
					"{C:attention}Jokers{} are {C:attention}pinned to the left",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_finity_crimsonheart = {
				name = "Crimson Heart",
				text = {
					"One random {C:attention}Joker{} is {C:attention}marked",
					"every hand, marked {C:attention}Jokers{}",
					"retrigger {C:attention}#1#{} additional times",
				},
			},
			j_finity_ceruleanbell = {
				name = "Cerulean Bell",
				text = {
					"One random card in hand is {C:attention}marked{},",
					"marked cards permanently gain",
					"{X:mult,C:white}X#1#{} Mult when scored",
				},
			},
			j_finity_lavenderloop = {
				name = "Lavender Loop",
				text = {
					"Beat the blind before {C:attention}Timer",
					"reaches {C:attention}0{} to destroy this and",
					"create a random {C:cry_exotic,E:1}Exotic {C:attention}Joker",
				},
			},
			j_finity_turquoisetornado = {
				name = "Turquoise Tornado",
				text = {
					"All scoring cards have",
					"{C:green}#1# in #3#{} chance to be",
					"destroyed and give their {C:chips}chips",
					"multiplied by {C:attention}#2#{} to this Joker",
					"{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)",
				},
			},
			j_finity_vermillionvirus = {
				name = "Vermillion Virus",
				text = {
					"At end of round, destroy the",
					"{C:attention}Joker{} to the right and create",
					"one of a higher {C:attention}rarity",
				},
			},
			j_finity_sapphirestamp = {
				name = "Sapphire Stamp",
				text = {
					"You can select {C:attention}any",
					"number of cards",
				},
			},
			j_finity_obsidianorb = {
				name = "Obsidian Orb",
				text = {
					"Copies the ability of",
					"every {C:attention}Joker{}",
					"{C:inactive}(Except {C:attention}Obsidian Orb{C:inactive})",
				},
			},
			j_finity_lemontrophy = {
				name = "Lemon Trophy",
				text = {
					"Set {X:chips,C:white}Chips{} to equal {X:mult,C:white}Mult",
				},
			},
			j_finity_periwinklepinecone = {
				name = "Periwinkle Pinecone",
				text = {
					"Add a {C:attention}seal{} to all played cards",
					"that don't have one, cards",
					"with {C:attention}seals{} can't be {C:attention}debuffed",
				},
			},
			j_finity_razzleraindrop = {
				name = "Razzle Raindrop",
				text = {
					"Gains {X:mult,C:white}X#2#{} Mult if a {V:1}#3#{} suit",
					"card is scored and {C:attention}mark{} it, cards",
					"marked this way count as any suit",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_finity_velvetvapour = {
				name = "Velvet Vapour",
				text = {
					"All played {C:attention}#1#s{} and {C:attention}#2#s{} have their rank",
					"changed to {C:attention}V{} after scoring, played {C:attention}Vs{}",
					"make the next card permanently gain {C:chips}Chips{}",
					"equal to double their {C:chips}Chips{} after scoring",
					"{C:inactive}(Ranks change every round)",
				},
			},
			j_finity_chamomilecloud = {
				name = "Chamomile Cloud",
				text = {
					"Add a random {C:attention}enhancement{} to {C:attention,E:2}ALL{} cards",
					"before scoring, gains {X:mult,C:white}X#2#{} Mult when an",
					"unenhanced card is enhanced this way",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_finity_lilaclasso = {
				name = "Lilac Lasso",
				text = {
					"Gains {X:mult,C:white}X#2#{} Mult per empty {C:attention}Joker{}",
					"slot when hand is played",
					"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
				},
			},
			j_finity_salientstream = {
				name = "Salient Stream",
				text = {
					"{C:red}+1{} discard when a",
					"hand is played",
				},
			},
			j_finity_luminouslemonade = {
				name = "Luminous Lemonade",
				text = {
					"{X:mult,C:white}X#1#{} Mult per unused",
					"{C:red}discard{} this run",
					"{X:chips,C:white}X#2#{} Chips per played",
					"{C:blue}hand{} this run",
					"{C:inactive,s:0.8}(Currently {X:mult,C:white,s:0.8}X#3#{C:inactive,s:0.8} Mult and {X:chips,C:white,s:0.8}X#4#{C:inactive,s:0.8} Chips)",
				},
			},
			j_finity_gloriousglaive = {
				name = "Glorious Glaive",
				text = {
					"Played cards give",
					"{X:mult,C:white}X#1#{} Mult when scored",
				},
			},
			j_finity_celadonclubs = {
				name = "Celadon Clubs",
				text = {
					"Played cards of {C:attention}most",
					"{C:attention}common{} rank each give",
					"{X:mult,C:white}X#1#{} Mult when scored",
					"{C:inactive}(Targeting #2#)",
				},
			},
			j_finity_celadonclubs_older = {
				name = "Celadon Clubs",
				text = {
					"Retrigger all {C:attention}even{} cards,",
					"{C:attention}odd{} cards are destroyed after",
					"scoring, {C:attention}face{} cards permanently",
					"gain {X:chips,C:white}X#1#{} Chips when scored",
				},
			},
			j_finity_caramelcoin = {
				name = "Caramel Coin",
				text = {
					"Gains {C:attention}+1{} hand size if played",
					"hand contains a {C:attention}Straight Flush{},",
					"{C:attention}Flush House{} or {C:attention}Flush Five{}",
				},
			},
			j_finity_saffronshield = {
				name = "Saffron Shield",
				text = {
					"{C:dark_edition}+1{} hand size, Joker slot",
					"and consumable slot per",
					"missing base suit in deck",
					"{C:inactive}(Currently {C:attention}+#1#{C:inactive})",
				},
			},
			j_finity_saffronshield_older = {
				name = "Saffron Shield",
				text = {
					"{C:green}#1# in #2#{} cards drawn become",
					"{C:attention}marked{}, cards marked this way",
					"cannot be debuffed or flipped",
				},
			},
			j_finity_rougerose = {
				name = "Rouge Rose",
				text = {
					"If {C:attention}first hand{} of round",
					"has only {C:attention}1 enhanced{} card,",
					"remove the {C:attention}enhancement{}",
					"and make it {C:dark_edition}Negative{}",
				},
			},
			j_finity_rougerose_older = {
				name = "Rouge Rose",
				text = {
					"Sell this card to",
					"set Ante to {C:attention}1{}",
				},
			},
			j_finity_silversword = {
				name = "Silver Sword",
				text = {
					"{X:mult,C:white}X#1#{} Mult per owned {C:attention}Joker{}",
					"Create a {C:dark_edition}Negative{} {C:attention}Silver Sword{}",
					"if not {C:dark_edition}Negative{} when beating a",
					"blind with {C:attention}first hand{} of round",
					"{C:inactive,s:0.8}(Currently {X:mult,C:white,s:0.8}X#2#{C:inactive,s:0.8} Mult)",
				},
			},
			j_finity_mochamike = {
				name = "Mocha Mike",
				text = {
					"Creates {C:attention}#1#{} Negative {C:planet}Planet{}",
					"card for played {C:attention}poker hand{}",
				},
			},
			j_finity_mochamike_plural = {
				name = "Mocha Mike",
				text = {
					"Creates {C:attention}#1#{} Negative {C:planet}Planet{}",
					"cards for played {C:attention}poker hand{}",
				},
			},
			j_finity_feltfortress = {
				name = "Felt Fortress",
				text = {
					"Doubles your {C:attention}current score{}",
				},
			},
			j_finity_cgoosejoker = {
				name = "Chartreuse Chamber",
				text = {
					"Changes type every round, {C:pink}Energize{}",
					"all other Jokers {C:attention}sharing{} its type",
					"when {C:attention}blind{} is defeated",
					"{C:inactive}(Ignores energy limits)",
				},
			},
			j_finity_taupetreble = {
				name = "Taupe Treble",
				text = {
					"Played {C:attention}Enhanced cards{} give {X:red,C:white}X#1#{} Mult",
					"when scored, then increase it by {X:red,C:white}X#2#{}",
					"{C:inactive}(Resets when {C:attention}Boss Blind{} {C:inactive}is defeated)",
				},
			},
			j_finity_chartreusecrown = {
				name = "Chartreuse Crown",
				text = {
					"{C:attention}Retrigger{} all played",
					"{C:attention}nonstandard suit{} cards, they",
					"give {X:mult,C:white}X#1#{} Mult when scored",
				},
			},
		},
		FinityCredit = {
			fcred_finity_freh = {
				name = "_Freh",
				text = { "{C:attention}Developer{}" },
			},
			fcred_finity_missingnumber = {
				name = "Missingnumber",
				text = { "{C:attention}Artist{}" },
			},
			fcred_finity_aikoyori = {
				name = "Aikoyori",
				text = { "{C:attention}Aikoyori's Shenanigans{}" },
			},
			fcred_finity_paya = {
				name = "Paya",
				text = { "{C:attention}Paya's Terrible Additions{}" },
			},
			fcred_finity_notmario = {
				name = "Notmario",
				text = { "{C:attention}More Fluff{}" },
			},
			fcred_finity_jpenguin = {
				name = "JPenguin",
				text = {
					"{C:attention}Chartreuse Chamber{}",
					"{C:attention}concepting{}",
				},
			},
			fcred_finity_ee = {
				name = "Ruby",
				text = { "{C:attention}Entropy{}" },
			},
			fcred_finity_unik = {
				name = "Unik",
				text = { "{C:attention}Unik's Mod{}" },
			},
			fcred_finity_cruel = {
				name = "Mathguy",
				text = { "{C:attention}Cruel Blinds{}" },
			},
			fcred_finity_madcap = {
				name = "RGBeet",
				text = { "{C:attention}Madcap{}" },
			},
		},
		Partner = {
			pnr_finity_scrooge = {
				name = "The Scrooge",
				text = {
					"Earn {C:money}$#1#{} when",
					"you sell a card",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Verdant Leaf{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_glutton = {
				name = "The Glutton",
				text = {
					"Start {C:attention}Blinds{} with",
					"{C:attention}Score{} equal to half the",
					"difference between current",
					"and previous target",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Violet Vessel{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_glutton_linked = {
				name = "The Glutton",
				text = {
					"Start {C:attention}Blinds{} with",
					"{C:attention}Score{} equal to the",
					"difference between current",
					"and previous target",
				},
			},
			pnr_finity_klutz = {
				name = "The Klutz",
				text = {
					"{C:attention}Shuffle{} all Jokers and",
					"gain {C:mult}+#2#{} Mult when {C:attention}Blind{}",
					"is selected, cannot",
					"rearrange Jokers",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Amber Acorn{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_lovesick = {
				name = "The Lovesick",
				text = {
					"One random {C:attention}Joker{} is {C:attention}marked",
					"every hand, gains {C:mult}+#2#{} Mult",
					"when a marked {C:attention}Joker{} triggers",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Crimson Heart{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_controlling = {
				name = "The Controlling",
				text = {
					"One random card in hand is",
					"{C:attention}marked{} every hand, {C:attention}retrigger",
					"marked cards once",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Cerulean Bell{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_controlling_linked = {
				name = "The Controlling",
				text = {
					"One random card in hand is",
					"{C:attention}marked{} every hand, {C:attention}retrigger",
					"marked cards twice",
				},
			},
			pnr_finity_infectee = {
				name = "The Infectee",
				text = {
					"Upgrade {C:attention}leftmost{}",
					"Joker's {C:edition}edition{} when",
					"{C:attention}Boss Blind{} is defeated",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Vermillion Virus{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_infectee_linked = {
				name = "The Infectee",
				text = {
					"Upgrade {C:attention}leftmost and rightmost{}",
					"Joker's {C:edition}edition{} when",
					"{C:attention}Boss Blind{} is defeated",
				},
			},
			pnr_finity_forgetful = {
				name = "The Forgetful",
				text = {
					"{C:attention}+#1#{} card selection limit",
					"this round when {C:attention}Blind{}",
					"is selected",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Sapphire Stamp{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_forgetful_linked = {
				name = "The Forgetful",
				text = {
					"{C:attention}+#1#{} hand size",
					"this round when {C:attention}Blind{}",
					"is selected",
				},
			},
			pnr_finity_snob = {
				name = "The Snob",
				text = {
					"{C:green}#1# in #2#{} chance for every",
					"{C:attention}card{} in played hand to permanently",
					"gain {C:chips}+#3#{} Chips before scoring",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Turquoise Tornado{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_haunt = {
				name = "The Haunt",
				text = {
					"{C:green}#1# in #2#{} chance to",
					"copy any {C:attention}Joker{}",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Obsidian Orb{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_busybody = {
				name = "The Busybody",
				text = {
					"If scoring hand contains",
					"a {C:attention}light{} suit, gain {C:money}$#1#{}",
					"at end of round",
					"{C:inactive}(different effect if it's {C:attention}nighttime{C:inactive})",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Lavender Loop{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_busybody_night = {
				name = "The Busybody",
				text = {
					"If scoring hand contains",
					"a {C:attention}dark{} suit, {C:green}#1# in #2#{} chance to",
					"create a random {C:dark_edition}Spectral{} card",
					"{C:inactive}(different effect if it's {C:attention}daytime{C:inactive})",
				},
			},
			pnr_finity_narcissist = {
				name = "The Narcissist",
				text = {
					"{X:chips,C:white}X#1#{} Chips once per",
					"{C:attention}hand{} if {X:mult,C:white}Mult{} ever",
					"equals or exceeds {X:chips,C:white}Chips{}",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Lemon Trophy{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_narcissist_linked = {
				name = "The Narcissist",
				text = {
					"{X:mult,C:white}X#1#{} Mult once per",
					"{C:attention}hand{} if {X:mult,C:white}Mult{} ever",
					"equals or exceeds {X:chips,C:white}Chips{}",
				},
			},
			pnr_finity_keeper = {
				name = "The Keeper",
				text = {
					"Start with {C:attention}#1#{} random",
					"cards in your deck {C:attention}sealed{}",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Periwinkle Pinecone{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_keeper_linked = {
				name = "The Keeper",
				text = {
					"Start with {C:attention}#1#{} random",
					"cards in your deck {C:attention}sealed{},",
					"{C:attention}+1{} consumable slot when",
					"{C:attention}Periwinkle Pinecone{} is obtained",
				},
			},
			pnr_finity_tearful = {
				name = "The Tearful",
				text = {
					"Scored Hearts give {X:mult,C:white}X#1#{} Mult,",
					"scored Spades give {C:chips}+#2#{} Chips,",
					"scored Diamonds earn {C:money}$#3#{},",
					"scored Clubs give {C:mult}+#4#{} Mult",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Razzle Raindrop{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_smoker = {
				name = "The Smoker",
				text = {
					"All played cards permanently gain",
					"{C:chips}Chips{} when played equal to quantity",
					"of their {C:attention}rank{} in played hand",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Velvet Vapour{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_smoker_linked = {
				name = "The Smoker",
				text = {
					"All played cards permanently gain",
					"{C:chips}Chips{} when played equal to quantity",
					"of their {C:attention}rank{} in played hand doubled",
				},
			},
			pnr_finity_narcoleptic = {
				name = "The Narcoleptic",
				text = {
					"Randomly enhance or unenhance one",
					"{C:attention}held{} card when hand is played,",
					"gains {X:mult,C:white}X#1#{} Mult when unenhancing",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Chamomile Cloud{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_sheperd = {
				name = "The Shepherd",
				text = {
					"{C:dark_edition}#1#{} Joker slots",
					"{C:dark_edition}+#2#{} Joker slot when",
					"{C:attention}Boss Blind{} is defeated",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Lilac Lasso{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_sheperd_linked = {
				name = "The Shepherd",
				text = {
					"{C:dark_edition}#1#{} Joker slots",
					"{C:dark_edition}+#2#{} Joker slots when",
					"{C:attention}Boss Blind{} is defeated",
				},
			},
			pnr_finity_mage = {
				name = "The Mage",
				text = {
					"{C:chips}+1{} hand every",
					"{C:red}#1#{} discards",
					"{C:inactive}({C:attention}#2#{C:inactive} remaining)",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Salient Stream{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_reveler = {
				name = "The Reveler",
				text = {
					"Earn extra {C:money}${} equal to",
					"remaining {C:chips}Hands{} and",
					"{C:red}Discards{} at end of round",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Luminous Lemonade{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
			pnr_finity_reveler_linked = {
				name = "The Reveler",
				text = {
					"Earn extra {C:money}${} equal to",
					"double the remaining {C:chips}Hands{} and",
					"{C:red}Discards{} at end of round",
				},
			},
			pnr_finity_gamer = {
				name = "The Gamer",
				text = {
					"{C:attention}Jokers{} give {X:mult,C:white}X#1#{}",
					"Mult when triggering",
				},
				unlock = {
					"Win a run with",
					"{C:attention}Glorious Glaive{} on",
					"{C:attention}Gold Stake{} difficulty",
				},
			},
		},
	},
	misc = {
		labels = {
			k_finity_showdown = "Showdown",
		},
		dictionary = {
			k_finity_showdown = "Showdown",
			k_finity_beaten_blind = "(Beaten blind)",
			k_finity_taunting_choose = "Choose a Showdown",
			k_finity_choose_one = "Choose one",
			k_finity_secret_button = "???",
			k_finity_per_enhanced = "per Enhanced card",
			k_finity_start = "START!",
			k_finity_success = "Success",
			k_finity_failure = "Failure",
			k_finity_balanced = "Balanced?",
			k_finity_sealed = "Sealed",
			k_finity_bonus = "Bonus!",
			k_finity_v = "V!",
			k_finity_destroyed = "Destroyed!",
			k_finity_purified = "Purified",
			k_finity_doubled = "Doubled",
			k_finity_multiple_ranks = "multiple ranks",
			k_finity_partner_upgrade = "Partner Upgrade!",
			k_finity_credits_title = "This mod is brought to you by:",
			ml_finity_thanks_text = {
				"Finity couldn't be what it is without the huge support from the",
				"balatro modding community as a whole, here's a list of people",
				"that contributed to the mod directly and indirectly",
				"through cross-mod content.",
			},
			b_finity_credits = "Credits",
			b_finity_thanks = "Special Thanks",
			finity_config_spectral = "Enable spectral card (restarts the game)",
			finity_config_olderortalab = "Use beta Ortalab Showdowns (restarts the game)",
		},
		v_dictionary = {
			a_finity_discards = "+#1# Discard",
			a_finity_hands = "+#1# Hand",
			a_finity_selection = "+#1# Selection",
			a_finity_left = "#1# left",
			finity_rank_plural = "#1#s",
			finity_rank_plural_pair = "#1#s and #2#s",
		},
		ranks = {
			finity_V = "V",
		},
		quips = {
			lq_crimson_1 = {
				"We were having",
				"so much fun,",
				"though..!",
			},
			lq_crimson_2 = {
				"Aww, was my",
				"love not",
				"enough?",
			},
			lq_crimson_3 = {
				"Shame we can't",
				"play together",
				"forever...",
			},
			lq_cerulean_1 = {
				"Sorry, but this",
				"game is mine",
				"to win.",
			},
			lq_cerulean_2 = {
				"Did you really",
				"think you were",
				"in control?",
			},
			lq_cerulean_3 = {
				"You ought to",
				"let me play",
				"next time.",
			},
			lq_amber_1 = {
				"Oh dear!",
				"Did I do that?",
			},
			lq_amber_2 = {
				"Keep better",
				"track of your",
				"Jokers next time!",
			},
			lq_amber_3 = {
				"You need to",
				"keep organized!",
			},
			lq_verdant_1 = {
				"Couldn't afford to sell",
				"me even one of your",
				"precious Jokers, huh?",
			},
			lq_verdant_2 = {
				"Stingy today,",
				"are we?",
			},
			lq_verdant_3 = {
				"Hoarding will",
				"get you nowhere.",
			},
			lq_violet_1 = {
				"That amount",
				"won't do at",
				"all!",
			},
			lq_violet_2 = {
				"I'm still",
				"hungry...",
			},
			lq_violet_3 = {
				"This isn't nearly",
				"enough Chips to",
				"satisfy me!",
			},
			lq_lavender_1 = {
				"Too slow! Hurry",
				"up next time!",
			},
			lq_lavender_2 = {
				"Don't waste",
				"my time.",
			},
			lq_lavender_3 = {
				"What were",
				"you, asleep?",
			},
			lq_turquoise_1 = {
				"Such unrefined",
				"cards!",
			},
			lq_turquoise_2 = {
				"Tch!",
			},
			lq_turquoise_3 = {
				"You play just",
				"like that Violet",
				"scoundrel!",
			},
			lq_vermillion_1 = {
				"Eheheh...",
			},
			lq_vermillion_2 = {
				"Ohhh...",
			},
			lq_vermillion_3 = {
				"Ahhh, ahah...",
			},
			lq_sapphire_1 = {
				"Did you miss",
				"an important",
				"card, mayhaps?",
			},
			lq_sapphire_2 = {
				"Ah! I forgot",
				"to count your",
				"cards!",
			},
			lq_sapphire_3 = {
				"...am I forgetting",
				"something?",
			},
			lq_obsidian_1 = {
				"...",
			},
			lq_obsidian_2 = {
				"You must be",
				"cursed too...",
			},
			lq_obsidian_3 = {
				"Too bad...",
			},
			lq_lemon_1 = {
				"Get on my level!",
			},
			lq_lemon_2 = {
				"Sorry kid, you're",
				"just not cool",
				"enough!",
			},
			lq_lemon_3 = {
				"It'll take more",
				"Chips than that",
				"to impress me!",
			},
			lq_periwinkle_1 = {
				"Your Seals are",
				"mine! Hehe!",
			},
			lq_periwinkle_2 = {
				"You shouldn't rely",
				"so much on Seals",
				"for everything!",
			},
			lq_periwinkle_3 = {
				"Even more Seals",
				"for my collection!",
			},
			lq_razzle_1 = {
				"Sniff... I can't",
				"see your suits...",
			},
			lq_razzle_2 = {
				"Boo hoo..!",
			},
			lq_razzle_3 = {
				"I- I'm sorry...",
			},
			lq_lilac_1 = {
				"Don't be so hard",
				"on yourself, sugar!",
			},
			lq_lilac_2 = {
				"Sorry, hun, but",
				"wranglin' your",
				"Jokers is my job!",
			},
			lq_lilac_3 = {
				"Y'all come back",
				"now, y'hear?",
			},
			lq_velvet_1 = {
				"You look like you",
				"could use a smoke...",
			},
			lq_velvet_2 = {
				"Come again?",
				"I couldn't quite",
				"see your ranks...",
			},
			lq_velvet_3 = {
				"Huff... too bad,",
				"sweetheart!",
			},
			lq_chamomile_1 = {
				"Ah, such",
				"pretty cards...",
			},
			lq_chamomile_2 = {
				"Sorry, I was",
				"distracted..!",
			},
			lq_chamomile_3 = {
				"Huh? Were",
				"we playing?",
			},
			lq_salient_1 = {
				"That's just cold...",
			},
			lq_salient_2 = {
				"You can't just",
				"choose one or",
				"the other!",
			},
			lq_salient_3 = {
				"You're washed up...",
			},
			lq_luminous_1 = {
				"Oh, the",
				"party's over?",
			},
			lq_luminous_2 = {
				"Huh? Over",
				"already?",
			},
			lq_luminous_3 = {
				"But we were only",
				"getting started!",
			},
			lq_glorious_1 = {
				"My advice:",
				"git gud!",
			},
			lq_glorious_2 = {
				"Simply a",
				"difference",
				"in skill.",
			},
			lq_glorious_3 = {
				"Total misplay!",
			},
			lq_chartreuse_1 = {
				"The Nest always",
				"wins, honk!",
			},
			lq_chartreuse_2 = {
				"Honk honk! Looks",
				"like Lady Luck",
				"flew south!",
			},
			lq_chartreuse_3 = {
				"I don't need luck,",
				"I've got hustle.",
				"And I EV-trained it!",
			},
			lq_endless_crimson_1 = {
				"Please",
				"don't go...",
			},
			lq_endless_crimson_2 = {
				"Leaving so",
				"soon?",
			},
			lq_endless_crimson_3 = {
				"Come back again",
				"one day..!",
			},
			lq_endless_cerulean_1 = {
				"This ends here!",
			},
			lq_endless_cerulean_2 = {
				"I do believe",
				"it's my turn now.",
			},
			lq_endless_cerulean_3 = {
				"I'm the boss",
				"around here,",
				"not you.",
			},
			lq_endless_amber_1 = {
				"Watch where",
				"you're going!",
			},
			lq_endless_amber_2 = {
				"Hard to play",
				"when you can't",
				"see, huh?",
			},
			lq_endless_amber_3 = {
				"You fumbled it!",
			},
			lq_endless_verdant_1 = {
				"Your Jokers.",
				"Give them to me.",
			},
			lq_endless_verdant_2 = {
				"I'm afraid your",
				"dollar won't be",
				"enough this time.",
			},
			lq_endless_verdant_3 = {
				"I don't take",
				"bribes.",
			},
			lq_endless_violet_1 = {
				"Any more, and",
				"I'll get sick!",
			},
			lq_endless_violet_2 = {
				"Hic..! I think",
				"I've had enough...",
			},
			lq_endless_violet_3 = {
				"Still...",
				"starving...",
			},
			lq_endless_lavender_1 = {
				"This game's run",
				"on far too long!",
			},
			lq_endless_lavender_2 = {
				"Took you long",
				"enough!",
			},
			lq_endless_turquoise_1 = {
				"Tsk! Don't know",
				"when to stop,",
				"do you?",
			},
			lq_endless_turquoise_2 = {
				"You're as",
				"insufferable",
				"as he is...",
			},
			lq_endless_turquoise_3 = {
				"How dare you show",
				"your face in my",
				"presence!",
			},
			lq_endless_vermillion_1 = {
				"Eheheh...",
			},
			lq_endless_vermillion_2 = {
				"Ohhh...",
			},
			lq_endless_vermillion_3 = {
				"Ahhh, ahah...",
			},
			lq_endless_sapphire_1 = {
				"Forget that you",
				"were still playing?",
			},
			lq_endless_sapphire_2 = {
				"I knew I'd",
				"forgotten something!",
			},
			lq_endless_sapphire_3 = {
				"Too many cards",
				"to keep track of!",
			},
			lq_endless_obsidian_1 = {
				"This...",
				"was inevitable.",
			},
			lq_endless_obsidian_2 = {
				"You really are",
				"cursed...",
			},
			lq_endless_obsidian_3 = {
				"...still here?",
			},
			lq_endless_lemon_1 = {
				"You already won,",
				"my guy! Chill out!",
			},
			lq_endless_lemon_2 = {
				"You're too",
				"good at this!",
			},
			lq_endless_lemon_3 = {
				"Did you lose",
				"your Chips at",
				"the finish line?",
			},
			lq_endless_periwinkle_1 = {
				"You could say...",
				"your fate was sealed",
				"from the start!",
			},
			lq_endless_razzle_1 = {
				"Quit raining",
				"on my parade..!",
			},
			lq_endless_razzle_2 = {
				"Boo hoo..!",
			},
			lq_endless_razzle_3 = {
				"I- I'm sorry...",
			},
			lq_endless_lilac_1 = {
				"Woah there,",
				"partner!",
			},
			lq_endless_lilac_2 = {
				"Y'all gotta take",
				"it easy, y'hear?",
			},
			lq_endless_lilac_3 = {
				"Now mosey on",
				"back to where",
				"ya came!",
			},
			lq_endless_chamomile_1 = {
				"Zzz... huhhh?",
			},
			lq_endless_glorious_1 = {
				"GG, well",
				"played...",
			},
			lq_endless_glorious_2 = {
				"C-C-C-Combo",
				"breaker!",
			},
			lq_endless_glorious_3 = {
				"o7",
			},
			pnr_finity_scrooge_1 = {
				"Would you rather",
				"have $1, or $2?",
			},
			pnr_finity_scrooge_2 = {
				"Money is my top",
				"priority.",
			},
			pnr_finity_scrooge_3 = {
				"I'm a secretary.",
				"I know well the",
				"art of the deal.",
			},
			pnr_finity_scrooge_4 = {
				"Sell your Jokers",
				"to me, and I'll make",
				"it worth your while.",
			},
			pnr_finity_scrooge_5 = {
				"A good source of",
				"income is vital",
				"to your success.",
			},
			pnr_finity_glutton_1 = {
				"I'm hungry...",
			},
			pnr_finity_glutton_2 = {
				"I don't like to",
				"keep high standards",
				"of people.",
			},
			pnr_finity_glutton_3 = {
				"Good food and",
				"alcohol is enough",
				"to keep me happy!",
			},
			pnr_finity_glutton_4 = {
				"I'll stick around",
				"so long as you feed",
				"me well...",
			},
			pnr_finity_glutton_5 = {
				"Hic..! Ah, I'm a",
				"bit tipsy...",
			},
			pnr_finity_special_glutton_tornado = {
				"Well, well, well...",
				"If it isn't the",
				"Turquoise Trash...",
			},
			pnr_finity_klutz_1 = {
				"I'm not wall-eyed!",
				"I'm just looking",
				"both ways!",
			},
			pnr_finity_klutz_2 = {
				"I like to think",
				"I'm good at",
				"shuffling a deck.",
			},
			pnr_finity_klutz_3 = {
				"Mind checking that",
				"I haven't lost any",
				"of your cards?",
			},
			pnr_finity_klutz_4 = {
				"My head's spinning",
				"like a merry-go-round...",
			},
			pnr_finity_klutz_5 = {
				"I'll keep those",
				"Jokers of yours",
				"in order!",
			},
			pnr_finity_lovesick_1 = {
				"I love you!",
			},
			pnr_finity_lovesick_2 = {
				"I promise to",
				"stay by your",
				"side!",
			},
			pnr_finity_lovesick_3 = {
				"I won't ever leave",
				"you! I swear!",
			},
			pnr_finity_lovesick_4 = {
				"Play with me,",
				"forever...",
			},
			pnr_finity_lovesick_5 = {
				"I'll keep you",
				"company, I don't",
				"mind...",
			},
			pnr_finity_controlling_1 = {
				"Do what I say and",
				"we'll get through",
				"this together.",
			},
			pnr_finity_controlling_2 = {
				"Let me handle this.",
			},
			pnr_finity_controlling_3 = {
				"I'm well equipped",
				"to deal with this",
				"on my own.",
			},
			pnr_finity_controlling_4 = {
				"You should give",
				"me the controls...",
			},
			pnr_finity_controlling_5 = {
				"I'm a natural",
				"leader.",
			},
			pnr_finity_infectee_1 = {
				"Ahhhh..?",
			},
			pnr_finity_infectee_2 = {
				"Ahahaha..!",
			},
			pnr_finity_infectee_3 = {
				"Nnnn...",
			},
			pnr_finity_forgetful_1 = {
				"Ah, um... what was",
				"your name again?",
			},
			pnr_finity_forgetful_2 = {
				"My memory isn't",
				"the best...",
			},
			pnr_finity_snob_1 = {
				"You dare think",
				"yourself worthy",
				"of my company?",
			},
			pnr_finity_snob_2 = {
				"So long as that",
				"repulsive drunkard",
				"doesn't show himself,",
				"I'll be fine.",
			},
			pnr_finity_snob_3 = {
				"I partake in only",
				"the finest in life.",
			},
			pnr_finity_snob_4 = {
				"You had best play",
				"properly in my presence!",
			},
			pnr_finity_snob_5 = {
				"I won't tolerate",
				"a bad hand.",
			},
			pnr_finity_special_snob_vessel = {
				"How dare you bring",
				"HIM in my sight!",
			},
			pnr_finity_haunt_1 = {
				"...",
			},
			pnr_finity_haunt_2 = {
				"I don't have",
				"much to say...",
			},
			pnr_finity_haunt_3 = {
				"Are you haunted",
				"like me?",
			},
			pnr_finity_haunt_4 = {
				"Spirits of the past...",
				"they speak to me...",
			},
			pnr_finity_haunt_5 = {
				"Don't look",
				"at me...",
			},
			pnr_finity_busybody_1 = {
				"Hurry up!",
			},
			pnr_finity_busybody_2 = {
				"We don't have",
				"all day!",
			},
			pnr_finity_busybody_3 = {
				"I'm keeping a",
				"timer on you,",
				"by the way.",
			},
			pnr_finity_busybody_4 = {
				"I have places to be.",
				"Make it quick.",
			},
			pnr_finity_busybody_5 = {
				"Don't just sit",
				"there and do nothing!",
			},
			pnr_finity_narcissist_1 = {
				"People like me",
				"'cause I'm the",
				"coolest around!",
			},
			pnr_finity_narcissist_2 = {
				"Let's rock and roll!",
			},
			pnr_finity_narcissist_3 = {
				"Chips are the coolness",
				"factor by which Mult",
				"is measured.",
			},
			pnr_finity_keeper_1 = {
				"Do you wanna see",
				"my Seal collection?",
			},
			pnr_finity_keeper_2 = {
				"I like to collect",
				"Seals in my free time.",
			},
			pnr_finity_keeper_3 = {
				"Stickers are pretty",
				"neat too!",
			},
			pnr_finity_tearful_1 = {
				"Sniff...",
			},
			pnr_finity_tearful_2 = {
				"I- I'm fine...",
				"I always cry like this.",
			},
			pnr_finity_tearful_3 = {
				"I- I hope I'm not",
				"in your w- way...",
			},
			pnr_finity_sheperd_1 = {
				"Howdy, partner!",
			},
			pnr_finity_narcoleptic_1 = {
				"Zzz...",
			},
			pnr_finity_mage_1 = {
				"Allow me to show you",
				"some real magic.",
			},
			pnr_finity_reveler_1 = {
				"...",
			},
			pnr_finity_gamer_1 = {
				"Is my mic working?",
			},
		},
	},
}
