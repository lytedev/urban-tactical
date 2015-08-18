require("subclass/class")
require("subclass/camera")
require("utils")
math.randomseed(os.time())
math.random(); math.random(); math.random()

lastMousePosition = {0, 0}
love.textInputMode = false
love.textInput = ""
love.keymap = {
	onpress = {

	},
	onrelease = {

	},
	onupdate = {

	}
}
fonts = {}

function resetWorld()
	if world then
		world:destroy()
	end
    pixelsPerMeter = 16
    gravity = 0
    --gravity = 0
    love.physics.setMeter(pixelsPerMeter)
    world = love.physics.newWorld(0, gravity * pixelsPerMeter, true)
end

function love.load()
	resetWorld()

	love.graphics.setBackgroundColor(11, 11, 11, 255)
	love.graphics.setDefaultImageFilter("nearest", "nearest")
	fonts.bigserif = love.graphics.newFont("assets/ttf/friz_quadrata_tt.ttf", 32)
	fonts.serif = love.graphics.newFont("assets/ttf/friz_quadrata_tt.ttf", 16)
	fonts.pixel = love.graphics.newFont("assets/ttf/pf_tempesta_seven_condensed.ttf", 8)
	fonts.medpixel = love.graphics.newFont("assets/ttf/pf_tempesta_seven_condensed.ttf", 16)
	fonts.bigpixel = love.graphics.newFont("assets/ttf/pf_tempesta_seven_condensed.ttf", 32)
	fonts.lightserif = love.graphics.newFont("assets/ttf/opensans_light.ttf", 20)
	fonts.biglightserif = love.graphics.newFont("assets/ttf/opensans_light.ttf", 40)
	--fonts.pixel = love.graphics.newFont("assets/ttf/pf_westa_seven_condensed.ttf", 8)
	--fonts.medpixel = love.graphics.newFont("assets/ttf/pf_westa_seven_condensed.ttf", 16)
	--fonts.bigpixel = love.graphics.newFont("assets/ttf/pf_westa_seven_condensed.ttf", 32)
	love.graphics.setFont(fonts.medpixel)
	if not skipintro then
		loadScene("intro")
	else
		-- loadScene("menu")
		loadScene("game")
	end
end

function love.update(dt)
	camera:update(dt)
	world:update(dt)
	for _, fixture in ipairs(love.destroyedFixtures) do
	    fixture:destroy()
	end
	love.destroyedFixtures = {}
	for key, action in pairs(love.keymap.onupdate) do
		if key == "lmb" or key == "mmb" or key == "rmb" or key == "wdmb" or key == "wumb" or key == "x1mb" or key == "x2mb" then
			if love.mouse.isDown(key) then action(love.mouse.getPosition()) end
		else
	    	if love.keyboard.isDown(key) then action() end
	    end
	end
	currentScene:update(dt)
	lastMouseX, lastMouseY = love.mouse.getPosition()
	lastMousePosition = { x = lastMouseX, y = lastMouseY }
	love.textInput = ""
end

function love.draw()
	camera:draw(dt)
	currentScene:draw()
	-- love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
end

function love.keypressed(key, unicode)
	local action = love.keymap.onpress[key]
	if type(action) == "function" then action() end
	if love.textInputMode then
		if unicode >= 32 and unicode <= 128 then
			love.textInput = love.textInput .. string.char(unicode)
		end
	end
end

function love.keyreleased(key, unicode)
	local action = love.keymap.onrelease[key]
	if type(action) == "function" then action() end
end

function love.mousepressed(x, y, b)
	local key = tostring(b).."mb"
	local action = love.keymap.onpress[key]
	if type(action) == "function" then action() end
end

function love.mousereleased(x, y, b)
	local key = tostring(b).."mb"
	local action = love.keymap.onrelease[key]
	if type(action) == "function" then action() end
end

function loadScene(sceneName)
	require("scenes/" .. sceneName)
	currentScene = scenes[sceneName]:new()
end

function love.quit()
	settings:save()
end

function reloadModeSettings()
    love.graphics.setMode(
    	settings:getInt("window_width"),
    	settings:getInt("window_height"),
    	settings:getBool("window_fullscreen"),
    	settings:getBool("window_vsync"),
    	settings:getInt("window_antialias"))
end

love.destroyedFixtures = {}
function love.physics.destroyFixture(fixture)
	fixture:setMask(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
	table.insert(love.destroyedFixtures, fixture)
end
