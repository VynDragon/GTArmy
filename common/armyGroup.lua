ArmyGroup = Class.class(function(self, name)
	self.name = name
	self.members = {}
end)

function ArmyGroup:add(soldier)
	table.insert(self.members, soldier)
end

function ArmyGroup:dump()
	return DataDumper(self)
end


function ArmyGroup:unpack(value)
	for i, v in ipairs(value['members']) do
		local soldier = ArmySoldier(nil, nil, nil)
		soldier:unpack(v) 
		self:add(soldier)
	end
end

