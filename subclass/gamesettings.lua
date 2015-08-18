require("subclass/class")
require("utils")
gamesettings = class:new()

function gamesettings:init()
    self.file = "settings.lua"

    self.data = {}
    self.data.window_width = "640"
    self.data.window_height = "360"
    self.data.window_fullscreen = "false"
    self.data.window_vsync = "true"
    self.data.window_antialias = "4"
end

function gamesettings:save(file)
    file = file or self.file
    fileHandle = love.filesystem.newFile(file)
    fileHandle:open("w")
    local fileData = "# Auto-Generated Settings for " .. config.identity
    fileData = fileData .. "\n" .. "# Generated on " .. os.date("%Y %m %d") .. "\n\n"
    local pairs = pairs
    for i, j in pairs(self.data) do
        local line = i .. "=" .. j .. "\n"
        fileData = fileData .. line
    end
    fileHandle:write(fileData)
end

function gamesettings:load(file)
    file = file or self.file
    if love.filesystem.exists(file) then
        fileHandle = love.filesystem.newFile(file)
        fileHandle:open("r")
        i = love.filesystem.lines(file)
        for line in i do
            if line:sub(1, 1) ~= "#" and line:len() >= 1 then
                -- local var, val = line:match("^[%s][%w_]+[ \t]*=[ \t]*[%w_]+[%s]$")
                local var = line:match("^[%s]*[%w_]+")
                local val = line:match("=[%s]*[%w_]+[%s]*$")
                if var == nil or var == "" or val == nil or val == "" then
                    print(string.format("var: %s\nval: %s", tostring(var), tostring(val)))
                    print(string.format("Line\n  \"%s\"\n  failed to parse.", line))
                    love.event.quit()
                else
                    val = val:sub(2):gsub("^%s*", ""):gsub("%s*$", "")
                    self.data[var] = val
                end
            end
        end
        return true
    else
        print(string.format("Settings:Load() - File \"%s\" doesn't exist.", file))
        return false
    end
end

function gamesettings:get(key)
    return self.data[key]
end

function gamesettings:getInt(key)
    return tonumber(self.data[key])
end

function gamesettings:getBool(key)
    return self.data[key]:lower() == "true"
end

function gamesettings:set(key, val)
    self.data[key] = tostring(val)
end
