require("menus/title")
require("gui/label")
require("gui/button")
menus.main = menus.title:new()

function menus.main:init()
    menus.title.init(self)
    self.align = alignment.topleft

    local originalY = 66

    love.graphics.setFont(fonts.lightserif)
    local font = love.graphics.getFont()
    local xsize = self.title.font:getWidth(self.title.text) + 40
    local offset = love.graphics.getFont():getHeight("|") * 1.5
    local initialChildren = #self.children

    local playButton = gui.button:new(self)
    playButton.textPadding = {40, 0}
    playButton.text = "Play"
    playButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    playButton.size = {xsize, playButton.font:getHeight() + 6}
    playButton.focus = playButton_focus
    playButton.draw = menuButton_draw

    local settingsButton = gui.button:new(self)
    settingsButton.textPadding = {40, 0}
    settingsButton.text = "Settings"
    settingsButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    settingsButton.size = {xsize, settingsButton.font:getHeight() + 6}
    settingsButton.focus = settingsButton_focus
    settingsButton.draw = menuButton_draw

    local quitButton = gui.button:new(self)
    quitButton.textPadding = {40, 0}
    quitButton.text = "Quit"
    quitButton.pos = {0, math.floor(originalY + (offset * (#self.children - initialChildren)))}
    quitButton.size = {xsize, settingsButton.font:getHeight() + 6}
    quitButton.focus = quitButton_focus
    quitButton.draw = menuButton_draw
end

function playButton_focus(self)
    currentScene.fadeTitles = true
    currentScene:loadMenu("settings")
    currentScene.fader = fader:new(1, 0, 0.3, 0)
    currentScene.fader.finished = playButton_fader_callback
end

function playButton_fader_callback()
    loadScene("game")
end

function settingsButton_focus(self)
    currentScene:loadMenu("settings")
end

function quitButton_focus(self)
    currentScene:loadMenu("quit")
end
