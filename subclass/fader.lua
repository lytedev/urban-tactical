require("subclass/class")
fader = class:new()

function fader:init(initial, final, fadeTime, startTime)
    self.initial = initial or 0
    self.final = final or 1
    self.fadeTime = fadeTime or 0.5
    self.startTime = startTime or 0
    self.val = 0
    self.time = 0
    self.finished = function() end
    self.isFinished = false
end

function fader:valMath()
    local p = (self.time - self.startTime) / (self.fadeTime)
    math.clamp(0, p, 1)
    local diff = self.final - self.initial
    local min = math.min(self.initial, self.final)
    local max = math.max(self.initial, self.final)
    self.val = math.clamp(min, self.initial + (p * diff), max)
end

function fader:getTotalTime()
    return self.startTime + self.fadeTime
end

function fader:onFinished()
    self.time = self:getTotalTime()
    self.val = final
    self.isFinished = true
    if self.finished then
        self:finished()
    end
end

function fader:update(dt)
    self.time = math.clamp(0, self.time + dt, self:getTotalTime())
    if self.time >= self:getTotalTime() and not self.isFinished then
        self:onFinished()
    end
    self:valMath()
end
