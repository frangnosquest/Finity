CardSleeves.Sleeve {
	key = "challenger",
	atlas = "sleeves",
	pos = { x = 0, y = 0 },
	config = {
		voucher = "v_directors_cut",
		dollars = 6,
		joker_slot = 1,
	},
	loc_vars = function(self)
		local key = self.key
		local voucher = "v_directors_cut"
		if self.get_current_deck_key() == "b_finity_challenger" then
			key = self.key .. "_alt"
			voucher = "v_retcon"
		end
		self.config = { voucher = voucher, dollars = 6, joker_slot = 1 }
		return { key = key, vars = { self.config.voucher, self.config.dollars, self.config.joker_slot } }
	end,
}
