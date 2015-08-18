require("subclass/gamesettings")
settings = gamesettings:new()

skipintro = true
defaultsettings = true

function love.conf(t)
    -- love.graphics.setBackgroundColor(0, 0, 0, 255)
    if not defaultsettings then
        settings:load("settings.lua")
    end
    config = t

    t.title = "Infantry Clone"
    t.author = "Daniel Flanagan"
    t.url = "http://lytedev.com"
    t.identity = "moduletest"
    t.version = "0.8.0"
    -- Versioning System:
    -- Alpha X.X.X
        -- Non-Functioning Game
    -- Beta X.X.X
        -- Functioning Game, Many Bugs
    -- Release X.X>X
        -- Full Game, Minimal Bugs
    t.identityVersion = "Alpha 1.0"

    t.console = false
    t.release = false -- Are you crazy or something?

    t.screen.scaleHeight = 180
    t.screen.width = settings:getInt("window_width")
    t.screen.height = settings:getInt("window_height")
    t.screen.fullscreen = settings:getBool("window_fullscreen")
    t.screen.vsync = settings:getBool("window_vsync")
    t.screen.fsaa = settings:getInt("window_antialias")

    t.modules.joystick = true
    t.modules.audio = true
    t.modules.keyboard = true
    t.modules.event = true
    t.modules.image = true
    t.modules.graphics = true
    t.modules.timer = true
    t.modules.mouse = true
    t.modules.sound = true
    t.modules.physics = true
end
