--[[

This file is part of the Love2D code example for the SuperClass library.

Copy the 'superclass.lua' file inside this folder and
run 'love .' from a terminal.

Code by Leonardo Miliani (2025)

--]]

local Class = require("superclass")

local Entity = Class.create()
function Entity:__init(name)
    self.name = name
    self.x, self.y = 100, 100
end
function Entity:draw()
    love.graphics.print("Entity: " .. self.name, self.x, self.y)
end

local Player = Class.create(Entity)
function Player:__init(name)
    Entity.__init(self, name)
    self.x, self.y = 200, 200
end
function Player:draw()
    love.graphics.print("Player: " .. self.name, self.x, self.y)
end

local player

function love.load()
    player = Player("Buddy")
end

function love.draw()
    player:draw()
end
