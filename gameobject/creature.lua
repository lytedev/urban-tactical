require("gameobject/gameobject")
gameobjects.creature = gameobject:new(0, 0, 0, 1, 1, "static")

function gameobjects.creature:init(type, x, y, w, h)
    bodyType = bodyType or "dynamic"
    self.type = type or 0

    self.body = love.physics.newBody(world, x, y, bodyType)
    self.shape = love.physics.newRectangleShape(0, 0, w, h)
    self.shape2 = love.physics.newRectangleShape(0, h * 2, w / 2, h * 2)
    -- self.shape = love.physics.newCircleShape(w / 4)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture = love.physics.newFixture(self.body, self.shape2, 1)
end
