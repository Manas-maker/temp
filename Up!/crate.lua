Crate = Entity:extend()

function Crate:new(x, y)
	Crate.super.new(self, x, y, 'crate.png')
end