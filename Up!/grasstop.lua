GrassTop = Entity:extend()

function GrassTop:new(x, y)
	Wall.super.new(self, x, y, 'Platform Tileset/grasstop.png')
	self.strength = 100
	self.weight = 0
end

function GrassTop.draw(self)
	love.graphics.draw(self.image, self.x, self.y, 0, 4, 4)
end