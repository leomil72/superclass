# SuperClass
SuperClass is a Lua library for creating classes with multiple inheritance, automatic override, introspection, and dynamic mixins. Compatible with LÖVE2D.
Works with Lua >= 5.1 and LuaJIT 2.0.

## ✨ Characteristics
- Multiple inheritance (with support for shared inheritance)
- Suppport for `super` & `static`
- Automatic method override: methods in the child class override those in the base class.
- Automatic ambiguity resolution: if two bases have the same method, they are ignored (unresolved ambiguity)
- Shared attributes
- Introspection (`isInstanceOf`)
- Dynamic mixins (`include`)

## 🚀 Installation
Copy the `superclass.lua` file in your project and include it with `require 'path.to.file'`.

You can clone the repo with `git clone https://github.com/leomil72/superclass.git`.


## 📚 API
`Class.create(...)`
Create a new class. It can accept multiple superclasses.

`Class.shared(base)`
Indicates that a superclass is shared (virtual inheritance).

`obj:isInstanceOf(class)`
Checks whether an object is an instance of a class or superclasses.

`obj:include(mixin)`
Dynamically adds methods from a mixin.

## 🧪 Example of use
```lua
local Class = require("superclass")

local Animal = Class.create()
function Animal:__init(name)
    self.name = name
end

local Dog = Class.create(Animal)
function Dog:__init(name)
    Animal.__init(self, name)
end

local myDog = Dog("Fido")
print(myDog:isInstanceOf(Dog))     --> true
print(myDog:isInstanceOf(Animal))  --> true
```
See `main.lua` for a more complete example.

### 🎮 Use with LÖVE2D
```lua
local Class = require("src.superclass")
-- look at examples/love2d-demo/main.lua
```

## 🛠️ License 
MIT license. See the attached file
