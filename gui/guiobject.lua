require("subclass/class")
require("utils")
guiobject = class:new()
gui = {}

gui.focus = nil
gui.active = nil

alignment = {
    topleft = 1,
    top = 2,
    topright = 3,
    left = 4,
    center = 5,
    right = 6,
    bottomleft = 7,
    bottom = 8,
    bottomright = 9,
}

function guiobject:init(parent)
    parent = parent or nil

    self.parent = parent
    if self.parent ~= nil then
        table.insert(self.parent.children, 1, self)
    end
    self.children = {}

    if self.parent == nil then
        self.align = alignment.topleft
    else
        self.align = self.parent.align
    end

    self.pos = {0, 0}
    self.size = {0, 0}

    self.mouseActivates = true
    self.isActive = false
    self.hasFocus = false
end

function guiobject:update(dt)
    for i = 1, #self.children, 1 do
        self.children[i]:update(dt)
    end
    local x, y = love.mouse.getPosition()
    local d = self:getDimensions()
    if x ~= lastMousePosition.x or y ~= lastMousePosition.y then
        if pointInRect(x, y, d[1], d[2], d[3], d[4]) and self.mouseActivates then
            self:activate()
        else
            self:deactivate()
        end
    end
end

function guiobject:draw(opacity)
    opacity = opacity or 1
    for i = 1, #self.children, 1 do
        self.children[i]:draw(opacity)
    end
end

function guiobject:getBounds()
    local bounds = {0, 0, 0, 0}
    if self.parent ~= nil then
        bounds = self.parent:getBounds()
    else
        bounds = {self.pos[1], self.pos[2], self.size[1], self.size[2]}
    end
    if bounds[3] == 0 then bounds[3] = love.graphics.getWidth() end
    if bounds[4] == 0 then bounds[4] = love.graphics.getHeight() end
    return bounds
end

function guiobject:getDimensions(pretendSize)
    pretendSize = pretendSize or self.size
    if pretendSize[1] == 0 then pretendSize[1] = self.size[1] end
    if pretendSize[2] == 0 then pretendSize[2] = self.size[2] end
    local bounds = self:getBounds()
    -- TODO Make a getAlignedPosition/Size function in utils or something
    local pos = self.pos
    local dimension = {0, 0, 0, 0}
    if self.align <= 3 then
        dimension[4] = pretendSize[2]
        dimension[2] = bounds[2] + pos[2]
    elseif self.align <= 6 then
        dimension[4] = pretendSize[2]
        dimension[2] = bounds[2] + (bounds[4] / 2) - (dimension[4] / 2) + pos[2]
    else
        dimension[4] = pretendSize[2]
        dimension[2] = bounds[2] + bounds[4] - dimension[4] - pos[2]
    end
    if self.align % 3 == 1 then
        dimension[3] = pretendSize[1]
        dimension[1] = bounds[1] + pos[1]
    elseif self.align % 3 == 2 then
        dimension[3] = pretendSize[1]
        dimension[1] = bounds[1] + (bounds[3] / 2) - (dimension[3] / 2) + pos[1]
    elseif self.align % 3 == 0 then
        dimension[3] = pretendSize[1]
        dimension[1] = bounds[1] + bounds[3] - dimension[3] - pos[1]
    end
    return dimension
end

function guiobject:focus()
    if gui.focus ~= nil then
        if gui.focus ~= self then
            gui.focus:unfocus()
        end
    end
    if parent ~= nil then
        parent:focus()
    end
    self.hasFocus = true
    gui.focus = self
end

function guiobject:unfocus()
    if gui.focus == self then
        gui.focus = nil
    end
    if self.hasFocus then
        self.hasFocus = false
    end
    if parent ~= nil then
        parent:unfocus()
    end
end

function guiobject:activate()
    if gui.active ~= nil then
        if gui.active ~= self then
            gui.active:deactivate()
        end
    end
    if parent ~= nil then
        parent:activate()
    end
    self.isActive = true
    gui.active = self
end

function guiobject:deactivate()
    if gui.active == self then
        gui.active = nil
    end
    if self.isActive then
        self.isActive = false
    end
    if parent ~= nil then
        parent:deactivate()
    end
end
