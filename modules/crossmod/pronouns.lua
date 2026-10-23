local pronouns = {
	{ key = "he_any", colour = "96D0FF", pronoun_table = { "He", "Any" } },
	{ key = "he_they_it", colour = "96D0FF", pronoun_table = { "He", "They", "It" } },
	{ key = "he_it", colour = "96D0FF", pronoun_table = { "He", "It" } },
	{ key = "they_he", colour = "96D0FF", pronoun_table = { "they", "He" } },
	{ key = "they_any", colour = "FF3EF7", pronoun_table = { "they", "Any" } },
}

for _, v in ipairs(pronouns) do
	CardPronouns.Pronoun {
		key = v.key,
		colour = HEX(v.colour),
		text_colour = G.C.WHITE,
		pronoun_table = v.pronoun_table,
		in_pool = function()
			return false
		end,
	}
end
