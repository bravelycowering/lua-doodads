-- extremely lightweight 'class' implementation

local function new(self, ...)
	local init = self.__index.new
	local inst = setmetatable({}, self)
	if init then
		init(inst, ...)
	end
	return inst
end

---@generic C
---@param proto C
---@param super? table
---@return { __index: C, new: fun(self: { __index: C }, ...: any): C}
return function(proto, super)
	local class = { __index = proto, new = new }
	if super then
---@diagnostic disable-next-line: inject-field
		proto.super = super
		setmetatable(proto, super)
	end
	return class
end