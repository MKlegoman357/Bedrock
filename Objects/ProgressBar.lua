BackgroundColour = colours.lightGrey
BarColour = colours.blue
TextColour = colours.white
ShowText = false
Value = 0
Maximum = 1
Indeterminate = false
AnimationStep = 0

OnDraw = function(self, x, y)
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)

	-- if self.Indeterminate then
	-- 	for i = 1, self.Width do
	-- 		local s = x + i - 1 + self.AnimationStep
	-- 		if s % 4 == 1 or s % 4 == 2 then
	-- 			Drawing.DrawBlankArea(s, y, 1, self.Height, self.BarColour)
	-- 		end
	-- 	end
	-- 	self.AnimationStep = self.AnimationStep + 1
	-- 	if self.AnimationStep >= 4 then
	-- 		self.AnimationStep = 0
	-- 	end
	-- 	self.Bedrock:StartTimer(function()
	-- 		self:Draw()
	-- 	end, 0.25)
	-- else
		local values = self.Value
		local barColours = self.BarColour
		if type(values) == 'number' then
			values = {values}
		end
		if type(barColours) == 'number' then
			barColours = {barColours}
		end

		local total = 0
		local _x = x
		for i, v in ipairs(values) do
			local width = (v == 0 and 0 or self.Bedrock.Helpers.Round((v / self.Maximum) * self.Width))
			total = total + v
			if width ~= 0 then
				Drawing.DrawBlankArea(_x, y, width, self.Height, barColours[((i-1)%#barColours)+1])
			end
			_x = _x + width
		end

		if self.ShowText then
			local text = self.Bedrock.Helpers.Round((total / self.Maximum) * 100) .. '%'
			Drawing.DrawCharactersCenter(x, y, self.Width, self.Height, text, self.TextColour, colours.transparent)
		end
	-- end
end