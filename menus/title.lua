require("menus/menu")
require("gui/label")
require("gui/button")
menus.title = menu:new()

function menus.title:init()
    menu.init(self)
    self.align = alignment.topleft

    self.version = gui.label:new(self)
    self.version.color = {255, 255, 255, 128}
    self.version.pos = {40, 40}
    self.version.align = alignment.bottomleft
    self.version.font = fonts.pixel
    self.version.text = config.identityVersion

    self.title = gui.label:new(self)
    self.title.font = fonts.bigpixel
    self.title.color = {255, 255, 255, 255}
    self.title.pos = {40, 40}
    self.title.font = fonts.biglightserif
    self.title.text = config.title

    self.color = {255, 255, 255, 16}
    self.activeColor = {255, 50, 0, 64}
end

function menus.title:draw(opacity)
    menu.draw(self, opacity)
    if not currentScene.fadeTitles then opacity = 1 end
    self.version:draw(opacity)
    self.title:draw(opacity)
end

function menus.title.nofade(self)
    gui.label.draw(self, 1)
end

function menuButton_draw(self, opacity)
    local col = self.parent.color
    if self.isActive then
        col = self.parent.activeColor
    end
    love.graphics.setColor(col[1], col[2], col[3], col[4] * opacity)
    local d = self:getDimensions()
    love.graphics.rectangle("fill", -10, d[2], d[1] + d[3] + 10, d[4])
    gui.button.draw(self, opacity)
end
