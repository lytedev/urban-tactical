require("scenes/scene")
require("gui/guiobject")
require("gui/label")
require("gui/button")
require("subclass/fader")
require("utils")
scenes.menu = scene:new()

function scenes.menu:init()
    camera.x = 0
    camera.y = 0
    camera.vx = 0
    camera.vy = 0
    love.graphics.setFont(fonts.medpixel)
    self.keymap = {
        onpress = {
            escape = function() love.event.quit() end,

            lmb = function()
                    if gui.active ~= nil then
                        gui.active:focus()
                    end
                end,

            f11 = function()
                    local f = settings:getBool("window_fullscreen")
                    f = not f
                    settings:set("window_fullscreen", f)
                    settings:set("window_height", 0)
                    settings:set("window_width", 0)
                    reloadModeSettings()
                end,
            f10 = function()
                    for i, j in pairs(settings.data) do print(string.format("%s: %s", i, j)) end
                end,
        },
        onrelease = {

        },
        onupdate = {

        },
    }
    self.keymap["return"] = self.keymap.lmb
    self.keymap[" "] = self.keymap.lmb

    love.keymap = self.keymap

    self.fader = fader:new(1, 1, 0, 0)
    self.menu = guiobject:new()
    self.fadeTitles = true

    self:loadMenu("main", 0)
end

function scenes.menu:update(dt)
    self.menu:update(dt)
    self.fader:update(dt)
end

function scenes.menu:draw()
    self.menu:draw(self.fader.val)
end

function scenes.menu:loadMenu(menuName, speed)
    speed = speed or 0.3
    self.nextMenu = menuName
    self.fader = fader:new(1, 0, speed, 0)
    self.fader.finished = loadMenuCallback
end

function loadMenuCallback()
    currentScene.fader = fader:new(0, 1, 0.3, 0.1)
    print("Loading Menu " .. currentScene.nextMenu)
    require("menus/" .. currentScene.nextMenu)
    currentScene.menu = menus[currentScene.nextMenu]:new()
    currentScene.fadeTitles = false
end
