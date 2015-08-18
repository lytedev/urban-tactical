require("subclass/class")
gameobject = class:new()
gameobjects = {}

function gameobject:init(type, x, y, w, h, bodyType)
    bodyType = bodyType or "dynamic"
    self.type = type or 0

    self.body = love.physics.newBody(world, x, y, bodyType)
    self.shape = love.physics.newRectangleShape(0, 0, w, h)
    -- self.shape = love.physics.newCircleShape(w / 4)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
end
