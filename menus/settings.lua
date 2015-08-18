require("menus/title")
require("gui/label")
require("gui/button")
menus.settings = menus.title:new()

function menus.settings:init()
    menus.title.init(self)
    self.align = alignment.topleft

    local originalY = 66
    local xsize = self.children[1].font:getWidth(self.children[1].text) + 40

    love.graphics.setFont(fonts.lightserif)
    local offset = love.graphics.getFont():getHeight("|") * 1.5
    local initialChildren = #self.children

    local backButton = gui.button:new(self)
    backButton.textPadding = {40, 0}
    backButton.text = "Back"
    backButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    backButton.size = {xsize, backButton.font:getHeight() + 6}
    backButton.focus = backButton_focus
    backButton.draw = menuButton_draw
end

function backButton_focus(self)
    currentScene:loadMenu("main")
end
