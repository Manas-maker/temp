function love.load()
	gameState = 1
	Object = require 'classic'

	require 'entity'
	require 'player'
	require 'wall'
	require 'box'
	require 'crate'
	require 'rock'
	require 'grasstop'
	require 'dirtfull'

    map = {
    	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
		{1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1},
    	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    map3 = {
    	{1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    	{1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
		{1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4},
    	{1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3},
    	{1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    	{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    	{1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    	{1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1},
    	{1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
    	{1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }
    player = Player(100, #map*50 - 400)
	box = Box(400, #map*50 - 1100)
	box_text = love.graphics.newImage('text1W.png')
	arrow = love.graphics.newImage('arrow.png')
	crateText = love.graphics.newImage('crate_text.png')
	sky = love.graphics.newImage('skyBlock.png')
	thanks1 = love.graphics.newImage('thanks1.png')
	thanks2 = love.graphics.newImage('thanks2.png')
	thanks3 = love.graphics.newImage('thanks3.png')
	thanks4 = love.graphics.newImage('thanks4.png')
	title = love.graphics.newImage('title.png')
	bgm = love.audio.newSource('Defrini - Biogas.mp3', 'stream')

	sky_height = sky:getHeight()
	sky_width = sky:getWidth()
	crate = Crate(400, #map*50 - 1800)
	rock1 = Rock(700, -200)
	rock2 = Rock(700, -150)
	rock3 = Rock(700, -100)
	rock4 = Rock(700, -50)
	rock5 = Rock(700, 0)

	objects = {}
	objects3 = {}
	table.insert(objects, player)
	table.insert(objects, box)
	table.insert(objects, crate)
	player3 = Player(800, 250)
	table.insert(objects3, player3)
	table.insert(objects3, rock1)
	table.insert(objects3, rock2)
	table.insert(objects3, rock3)
	table.insert(objects3, rock4)
	table.insert(objects3, rock5)
	walls = {}
	walls3 = {}

    for i, v in ipairs(map) do
    	for j, w in ipairs(v) do
    		if w == 1 then
    			table.insert(walls, Wall((j-1)*50, (i-1)*50))
    		end
    	end
    end
    for i, v in ipairs(map3) do
    	for j, w in ipairs(v) do
    		if w == 1 then
    			table.insert(walls3, Wall((j-1)*50+200,(i-1)*50 + 100))
    		elseif w == 3 then
    			table.insert(walls3, GrassTop((j-1)*50+200, (i-1)*50 + 100))
    		elseif w == 4 then
    			table.insert(walls3, DirtFull((j-1)*50+200, (i-1)*50 + 80))
    		end
    	end
    end
end

function love.update(dt)
	if gameState == 2 then
		for i, v in ipairs(objects) do
			v:update(dt)
		end

		for i, v in ipairs(walls) do
			v:update(dt)
		end
		local loop = true
		local limit = 0
		while loop do
			loop = false
			limit = limit + 1
			if limit > 100 then
				break
			end
			for i = 1, #objects-1 do
				for j = i+1, #objects do
					local collision = objects[i]:resolveCollision(objects[j])
					if collision then
						loop = true
					end
				end
			end

			for i, wall in ipairs(walls) do
				for j, object in ipairs(objects) do
					local collision = object:resolveCollision(wall)
					if collision then
						loop = true
					end
				end
			end
		end
	elseif gameState == 3 then
		for i, v in ipairs(objects3) do
			v:update(dt)
		end

		for i, v in ipairs(walls3) do
			v:update(dt)
		end
		local loop = true
		local limit = 0
		while loop do
			loop = false
			limit = limit + 1
			if limit > 100 then
				break
			end
			for i = 1, #objects3-1 do
				for j = i+1, #objects3 do
					local collision = objects3[i]:resolveCollision(objects3[j])
					if collision then
						loop = true
					end
				end
			end

			for i, wall in ipairs(walls3) do
				for j, object in ipairs(objects3) do
					local collision = object:resolveCollision(wall)
					if collision then
						loop = true
					end
				end
			end
		end
		print(player3.x)
		print(player3.y)
	end
	if player.x > 600 and player.y == 150 then
		gameState = 3
	end
end
function love.keypressed(key)
	if key == 'space' and gameState == 1 then
		gameState = 2
	end
	if key == 'up' and gameState == 2 then
		player:jump()
	elseif key == 'up' and gameState == 3 then
		player3:jump()
	end
	if key == 'f1' then
		gameState = 3
	end
end

function love.draw()
	if gameState == 1 then
		love.graphics.draw(title, 250, 200)
		love.graphics.print('Press SPACE to start', 300, 450)
		love.graphics.print('By: Manas Pradhan \nNew Delhi, India', 600, 500, 0, 1.2, 1.2)
	elseif gameState == 2 then
		love.audio.play(bgm)
		love.graphics.push()
			love.graphics.translate(0, -player.y + 300)
			angle = math.atan2(crate.y - (#map*50 - 1650), crate.x - 400) - math.pi/2
			love.graphics.draw(box_text, 450, #map*50 - 970, 0, 0.7, 0.7)
			love.graphics.draw(crateText, 330, #map*50 - 1740, 0, 0.8, 0.8)
			love.graphics.draw(arrow, 400, #map*50 - 1650, angle)
			for i, v in ipairs(objects) do
				v:draw()
			end

			for i, v in ipairs(walls) do
				v:draw()
			end
		love.graphics.pop()
	elseif gameState == 3 then
		love.graphics.push()
			love.graphics.translate(-player3.x + 200, -player3.y + 300)
			for i = 1, 100 do
				for j = 1, 100 do
					love.graphics.draw(sky, 500+i*sky_width*2, j*sky_height*2 - 700, 0, 2, 2) 
				end
			end
			for i, v in ipairs(objects3) do
				v:draw()
			end
			for i, v in ipairs(walls3) do
				v:draw()
			end	
			love.graphics.draw(thanks1, 1100, 150)
			love.graphics.draw(thanks2, 1450, 150)
			love.graphics.draw(thanks3, 1850, 50)
			love.graphics.draw(thanks4, 2250, 150)
		love.graphics.pop()
	end
end