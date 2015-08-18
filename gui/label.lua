require("gui/guiobject")
require("subclass/class")
require("utils")
gui.label = guiobject:new()

function gui.label:init(parent)
    guiobject.init(self, parent)

    self.font = love.graphics.getFont()
    self.text = "Label"
    self.color = {255, 255, 255, 255}

    self.mouseActivates = false
end

function gui.label:draw(opacity)
    opacity = opacity or 1
    guiobject.draw(self, opacity)
    local pw = self.font:getWidth(self.text)
    local w = 0
    local h = 0
    w, h = self.font:getWrap(self.text, pw+1)
    h = h * self.font:getHeight()
    local d = self:getDimensions({w, h})
    love.graphics.setFont(self.font)
    local col = self.color
    love.graphics.setColor(col[1], col[2], col[3], col[4] * opacity)
    love.graphics.print(self.text, d[1], d[2])
end
