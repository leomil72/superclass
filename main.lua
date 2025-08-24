--[[

This file is part of the code example for the SuperClass library.

Run 'lua main.lua' from a terminal.

Code by Leonardo Miliani (2025)

--]]

local Class = require("src.superclass")

-- Dynamic mixin
local Logger = {
    log = function(self, msg)
        print("LOG:", msg)
    end
}

-- Base classes
local Animal = Class.create()
function Animal:__init(name)
    self.name = name
end
function Animal:speak()
    print(self.name .. " makes a sound.")
end

local Quadruped = Class.create()
function Quadruped:hasFourLegs()
    print("I'm a quadruped and I have four legs")
end

-- Derived class (multiple inheritance)
local Dog = Class.create(Animal, Quadruped)
function Dog:__init(name)
    Animal.__init(self, name)
end
function Dog:speak()
    print(self.name .. " barks.")
end

-- Instance with mixin
local myDog = Dog("Fido")
myDog:include(Logger)
myDog:log("Ready to play!") --> LOG: Ready to play!
myDog:speak() --> Fido barks.
myDog:hasFourLegs() --> I'm a quadruped and I have four legs

-- Introspection
print('Is myDog an instance of Dog?', myDog:isInstanceOf(Dog))     --> true
print('Is myDog an instance of Animal?', myDog:isInstanceOf(Animal))  --> true
