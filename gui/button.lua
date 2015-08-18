require("gui/guiobject")
require("subclass/class")
require("utils")
gui.button = guiobject:new()

function gui.button:init(parent)
    guiobject.init(self, parent)

    self.font = love.graphics.getFont()
    self.text = "Button"
    self.textPadding = {0, 0}
    self.color = {255, 200, 0, 255}
    self.activeColor = {255, 255, 255, 255}
    self.size = {100, 20}
end

function gui.button:draw(opacity)
    opacity = opacity or 1
    guiobject.draw(self, opacity)
    local bd = self:getDimensions()
    local pw = self.font:getWidth(self.text)
    local w = 0
    local h = 0
    w, h = self.font:getWrap(self.text, pw)
    h = h * self.font:getHeight()
    local d = self:getDimensions({w, h})
    local col = self.color
    if self.isActive then
        col = self.activeColor
    end
    love.graphics.setFont(self.font)
    love.graphics.setColor(col[1], col[2], col[3], col[4] * opacity)
    love.graphics.print(self.text, d[1] + self.textPadding[1], d[2] + self.textPadding[2])
end
