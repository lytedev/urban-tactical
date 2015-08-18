require("menus/title")
require("gui/label")
require("gui/button")
menus.quit = menus.title:new()

function menus.quit:init()
    menus.title.init(self)
    self.align = alignment.topleft

    local originalY = 66
    local xsize = self.children[1].font:getWidth(self.children[1].text) + 40

    love.graphics.setFont(fonts.lightserif)
    local offset = love.graphics.getFont():getHeight("|") * 1.5
    local initialChildren = #self.children

    local query = gui.label:new(self)
    query.text = "Are you sure you want to quit?"
    query.pos = {40, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    query.size = {xsize, query.font:getHeight() + 6}

    local yesButton = gui.button:new(self)
    yesButton.textPadding = {40, 0}
    yesButton.text = "Yes"
    yesButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    yesButton.size = {xsize, yesButton.font:getHeight() + 6}
    yesButton.focus = yesButton_focus
    yesButton.draw = menuButton_draw

    local backButton = gui.button:new(self)
    backButton.textPadding = {40, 0}
    backButton.text = "No"
    backButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    backButton.size = {xsize, backButton.font:getHeight() + 6}
    backButton.focus = backButton_focus
    backButton.draw = menuButton_draw
end

function yesButton_focus(self)
    love.event.quit()
end

function backButton_focus(self)
    currentScene:loadMenu("main")
end
