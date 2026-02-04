## class.lua

To use this class implementation, it's extremely simple.

1. Build your class prototype in a regular lua table (optionally put a constructor in `[prototype]:new`).
2. Call `class` with your prototype as the first argument (and optionally a super class to extend as the second).

The resulting table is your class. You can call the `:new` method on it to create a new instance of it.

Example:

```lua
-- group.lua
local class = require "class"

local prototype = {}

function prototype:add(obj)
	table.insert(self, obj)
end

function prototype:remove(obj)
	for index, child in ipairs(self) do
		if child == obj then
			table.remove(self, index)
			return
		end
	end
end

return class(prototype)
```

```lua
-- main.lua
local Group = require "group"

local entities = Group:new()
```

Additional notes:

* `class` creates a metatable with a prefilled `__index` value under the hood. This means that after turning your prototype into a class, you can assign metamethods to it as you would normally.
* If a super class is specified, it will modify the prototype to assign a property named `super` containing the prototype of the extended class, as well as setting an `__index` metamethod on the prototype.
