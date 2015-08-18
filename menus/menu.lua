require("subclass/class")
require("gui/guiobject")
menu = guiobject:new()
menus = {}

function menu:init()
    guiobject.init(self)
    gui.active = nil
    gui.focus = nil
end
