Rock = Entity:extend()

function Rock:new(x, y)
	Rock.super.new(self, x, y, 'rock1.png')
	self.strength = 100
	self.weight = 1000
end