require("gameobject/gameobject")
gameobjects.tile = gameobject:new(0, 0, 0, 1, 1, "static")

function gameobjects.tile:init(type, x, y, w, h)
    self.type = type or 0

    self.body = love.physics.newBody(world, x, y, "static")
    self.shape = love.physics.newRectangleShape(0, 0, w, h)
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
end
