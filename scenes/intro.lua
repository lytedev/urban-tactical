require("scenes/scene")
require("utils")
scenes.intro = scene:new()

function scenes.intro:init()
	require("subclass/logo")
	love.graphics.setBackgroundColor(11, 11, 11, 255)

	local lytedevLogo = logo:new()
	lytedevLogo.image = love.graphics.newImage("assets/img/lytedev.png")
	local w = lytedevLogo.image:getWidth()
	local h = lytedevLogo.image:getHeight()
	lytedevLogo.quads[1] = love.graphics.newQuad(0, h * 1/5, w, h * 1/5, w, h)
	lytedevLogo.onUpdate = lytedevLogo_onUpdate
	lytedevLogo.onDraw = lytedevLogo_onDraw
	lytedevLogo.totalTime = 2.6
	lytedevLogo.sy = 0

	self.currentlogo = 1
	self.logos = {
		lytedevLogo
	}

	self.fader = fader:new()

    self.fader.color = { love.graphics.getBackgroundColor() }
    self.fader.startTime = 2
    self.fader.fadeTime = 0.3
    self.fader.endTime = 2
    self.fader.time = 0
    self.fader.fadeOut = true
end

function lytedevLogo_onUpdate(self, dt)
	local q = self.quads[self.currentQuad]
	if q then
		local x, y, w, h = q:getViewport()
		local ih = self.image:getHeight()
		local maxy = ih * 2/5
		local pcnt = (self.time - 0.3) / (1)
		pcnt = math.clamp(0, pcnt, 1)
		y = ((math.sin((pcnt * (math.pi / 2) -
			(math.pi / 2))) + 1) * maxy) + ih * 1/5
		-- y = (self.sy + 1) * (1 + dt)
		-- self.sy = y
		q:setViewport(x, y % self.image:getHeight(), w, h)
	end
end

function lytedevLogo_onDraw(self)
	local q = self.quads[self.currentQuad]
	if q then
		local q = self.quads[self.currentQuad];
		local qx, qy, qw, qh = q:getViewport()
		local x = love.graphics.getWidth() / 2 - qw / 2
		local y = love.graphics.getHeight() / 2 - qh / 2
		love.graphics.drawq(self.image, q, x, y)
		love.graphics.setColor(100, 100, 100, 255)
		love.graphics.setFont(fonts.pixel)
		love.graphics.print(".com", x + qw + 2, y + qh - 16)
	end
end

function scenes.intro:update(dt)
	local l = self.logos[self.currentlogo]
	if l then
		self.faderp = 2 * ((l.time - 2) / (l.totalTime - 2))
		self.faderp = math.clamp(0, self.faderp, 1)
		l:update(dt)
		if l.time >= l.totalTime then
			self.currentlogo = self.currentlogo + 1
		end
		if self.currentlogo > #self.logos then
			loadScene("menu")
		end
	end
	self.fader:update(dt)
end

function scenes.intro:draw()
	love.graphics.setColor(255, 255, 255, 255)
	local l = self.logos[self.currentlogo]
	if l then
		l:draw()
	end
	local x = love.graphics.getWidth()
	local y = love.graphics.getHeight()
	local c = self.faderp * 255
	self.fader:draw()
	love.graphics.print(string.format("%f", self.faderp), 5, 5)
end
