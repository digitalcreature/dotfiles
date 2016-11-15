$name = {} do

	local base = $name
	base.__index = base
	setmetatable(base, base)

	function base:init()
	end

	function base:__call(cls, ...)
		local obj = setmetatable({}, cls)
		if obj.init then obj:init(...) end
		return obj
	end

end
