--[[

This file is part of the code example for the SuperClass library.

Code by Leonardo Miliani (2025)

--]]

local SuperClass = {}

-- Shared inheritance constructor
function SuperClass.shared(base)
    return { __shared = true, __base = base }
end

-- Create a new class
function SuperClass.create(...)
    local raw_bases = {...}
    local bases, shared_bases = {}, {}

    for _, b in ipairs(raw_bases) do
        if type(b) == "table" and b.__shared then
            table.insert(shared_bases, b.__base)
        else
            table.insert(bases, b)
        end
    end

    local cls = {}
    cls.__index = cls
    cls.__bases = bases
    cls.__shared_bases = shared_bases
    cls.__classname = "AnonymousClass"

    -- Introspection
    function cls:isInstanceOf(target)
        if self == target then return true end
        local mt = getmetatable(self)
        if mt == target then return true end
        for _, base in ipairs(cls.__bases or {}) do
            if base == target or (base.isInstanceOf and base.isInstanceOf(self, target)) then
                return true
            end
        end
        for _, base in ipairs(cls.__shared_bases or {}) do
            if base == target or (base.isInstanceOf and base.isInstanceOf(self, target)) then
                return true
            end
        end
        return false
    end

    -- Dynamic mixin
    function cls:include(mixin)
        for k, v in pairs(mixin) do
            if k ~= "__init" then
                self[k] = v
            end
        end
    end

    -- Ambiguity resolution
    local function resolve_method(key)
        local found = nil
        for _, base in ipairs(shared_bases) do
            if base[key] then
                if found then return nil end
                found = base[key]
            end
        end
        for _, base in ipairs(bases) do
            if base[key] then
                if found then return nil end
                found = base[key]
            end
        end
        return found
    end

    setmetatable(cls, {
        __index = function(t, key)
            return resolve_method(key)
        end,
        __call = function(class_tbl, ...)
            local obj = setmetatable({}, class_tbl)
            if obj.__init then obj:__init(...) end
            return obj
        end
    })

    return cls
end

return SuperClass
