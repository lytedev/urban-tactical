require("subclass/class")
require("utils")

cameraClass = class:new()

function cameraClass:init()
    self.x = 0
    self.y = 0
    self.vx = 0
    self.vy = 0
end

function cameraClass:update(dt)
    self.x = self.x + (self.vx * dt)
    self.y = self.y + (self.vy * dt)
end

function cameraClass:draw()
    love.graphics.translate(-self.x, -self.y)
end

function cameraClass:undraw()
    love.graphics.translate(self.x, self.y)
end

camera = cameraClass:new()
