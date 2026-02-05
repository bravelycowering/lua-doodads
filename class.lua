-- extremely lightweight 'class' implementation

local function new(self, ...)
	local init = self.__index.new
	local inst = setmetatable({}, self)
	if type(init) == "function" then
		init(inst, ...)
	end
	return inst
end

---@generic C: table
---@param proto C
---@param super? table
---@return { __index: C, new: fun(self: { __index: C }, ...: any): C}
local function class(proto, super)
	assert(type(proto) == "table", "bad argument #1 to 'class' (table expected, got "..type(proto)..")")
	local c = { __index = proto, new = new }
	if super ~= nil then
		assert(type(super) == "table" and (type(super.__index) == "table" or type(super.__index) == "function"), "bad argument #2 to 'class' (metatable with __index field expected, got "..type(super)..")")
---@diagnostic disable-next-line: inject-field
		proto.super = super
		setmetatable(proto, super)
	end
	return c
end

return class
