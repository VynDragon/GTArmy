Inventory = Class.class(function(self, init)
	self.contents = {}
	if init then
		self.contents = init
	end 
end)

function Inventory:add(what, howmuch)
	if self.contents[what] ~= nil then
		self.contents[what] = self.contents[what] + howmuch
	else
		self.contents[what] = howmuch
	end
	return howmuch
end

function Inventory:remove(what, howmuch)
	if self.contents[what] ~= nil then
		if self.contents[what] >= howmuch then
			self.contents[what] = self.contents[what] - howmuch
			return howmuch
		end
	end
	return 0
end

function Inventory:serialize()
	value = json.encode(self)
	return value
end

function Inventory:unpack(value)
	for k, v in pairs(value['contents']) do
		self:add(k, v)
	end
end