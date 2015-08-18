require("scenes/scene")
require("gameobject/tile")
require("gameobject/creature")
require("utils")
scenes.game = scene:new()

function scenes.game:init()
    self.keymap = {
        onpress = {
            escape = function()
                    resetWorld()
                    loadScene("menu")
                end,
        },
        onrelease = {

        },
        onupdate = {
            w = function()
                    local xf = math.cos(player.body:getAngle() + (math.pi / 2)) * player.speed
                    local yf = math.sin(player.body:getAngle() + (math.pi / 2)) * player.speed
                    player.xf = player.xf + xf
                    player.yf = player.yf + yf
                end,
            s = function()
                    local xf = math.cos(player.body:getAngle() + (math.pi / 2)) * player.speed
                    local yf = math.sin(player.body:getAngle() + (math.pi / 2)) * player.speed
                    player.xf = player.xf + -xf
                    player.yf = player.yf + -yf
                end,
            a = function()
                    local xf = math.cos(player.body:getAngle()) * player.speed
                    local yf = math.sin(player.body:getAngle()) * player.speed
                    player.xf = player.xf + xf
                    player.yf = player.yf + yf
                end,
            d = function()
                    local xf = math.cos(player.body:getAngle()) * player.speed
                    local yf = math.sin(player.body:getAngle()) * player.speed
                    player.xf = player.xf + -xf
                    player.yf = player.yf + -yf
                end,
        },
    }
    love.keymap = self.keymap

    resetWorld()

    love.graphics.setFont(fonts.biglightserif)

    player = gameobjects.creature:new(0, 200, 200, 16, 16)
    player.rotSpeed = 3
    player.speed = 1000
    player.xf = 0
    player.yf = 0
    player.body:setLinearDamping(3)

    scene.init(self)
end

function scenes.game:update(dt)
    local mx, my = love.mouse.getPosition()
    local desiredAngle = (-math.angle(player.body:getX(), player.body:getY(), mx + camera.x, my + camera.y))
    local angle = player.body:getAngle()
    local da = player.rotSpeed * dt

    local diff = (angle) - (desiredAngle)
    if diff <= da and diff >= -da then
        angle = desiredAngle
    elseif (diff > 0 and diff < math.pi) or diff < -math.pi then
        angle = angle - da
    else
        angle = angle + da
    end

    player.body:setAngle(math.wrap(-math.pi, angle, math.pi))


    player.body:applyForce(player.xf, player.yf)
    player.xf = 0
    player.yf = 0

    local xf = math.cos(player.body:getAngle() + (math.pi / 2)) * 50
    local yf = math.sin(player.body:getAngle() + (math.pi / 2)) * 50
    camera.x = player.body:getX() + xf - (love.graphics.getWidth() / 2)
    camera.y = player.body:getY() + yf - (love.graphics.getHeight() / 2)
end

function scenes.game:draw()
    love.graphics.rectangle("fill", 0, 0, 10, 10)
    love.graphics.rectangle("fill", 50, 200, 10, 10)
    love.graphics.rectangle("fill", 0, 60, 10, 10)
    love.graphics.rectangle("fill", 180, 40, 10, 10)
    love.graphics.rectangle("fill", -20, 30, 10, 10)
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape2:getPoints()))

    camera:undraw()
    love.graphics.setFont(fonts.pixel)
    love.graphics.print("Camera: (" .. tostring(camera.x) .. ", " .. tostring(camera.y) .. ")", 10, 10)
end
