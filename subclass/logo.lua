logo = class:new()

function logo:init()
	self.image = nil
	self.currentQuad = 1
	self.quads = {}
	self.time = 0
	self.totalTime = 5
	self.onUpdate = nil
	self.onDraw = nil
end

function logo:update(dt)
	if self.currentQuad <= #self.quads then
		self.time = self.time + dt
		if self.time >= self.totalTime then
			self.currentQuad = self.currentQuad + 1
		end
		if type(self.onUpdate) == "function" then
			self.onUpdate(self, dt)
		end
	end
end

function logo:draw()
	if self.currentQuad <= #self.quads then
		local q = self.quads[self.currentQuad];
		local qx, qy, qw, qh = q:getViewport()
		local x = love.graphics.getWidth() / 2 - qw / 2
		local y = love.graphics.getHeight() / 2 - qh / 2
		love.graphics.drawq(self.image, q, x, y)
	end
	if type(self.onDraw) == "function" then
		self.onDraw(self)
	end
end
