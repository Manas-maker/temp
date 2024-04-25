DirtFull = Entity:extend()

function DirtFull:new(x, y)
	Wall.super.new(self, x, y, 'Platform Tileset/dirtfull.png')
	self.strength = 100
	self.weight = 0
end

function DirtFull.draw(self)
	love.graphics.draw(self.image, self.x, self.y, 0, 4, 4)
end