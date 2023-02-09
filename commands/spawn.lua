-- spawn <name OR archetype>
local function command_spawn(query)
	if query == nil or string.len(query) <= 1 then
		print("Syntax: spawn <name OR archetype>")
		print("For a list of names and archetypes, check out data/scripts/trainer/Vehicles.txt")
		
		return
	end
	
	local archetype = nil
	if string.sub(query, 1, 1) == '{' then
		if string.len(query) ~= 38 then
			print("Invalid archetype")
			return
		end
	else
		archetype = VehicleArchetype[query]
		if archetype == nil then
			-- Lowercase compare
			query = string.lower(query)

			for k,v in pairs(VehicleArchetype) do
				if string.lower(k) == query then
					archetype = v
					break
				end
			end
		end
	end
	
	if archetype == nil then
		print("Invalid vehicle " .. query)
		print("For a list of names and archetypes, check out data/scripts/trainer/Vehicles.txt")
	
		return
	end
	
	local pos = GetReticleHitLocation()
	local veh = SpawnEntityFromArchetype(archetype, pos[1], pos[2], pos[3], 0, 0, 0)
	if veh == GetInvalidEntityId() then
		print("Failed to spawn vehicle!")
		return
	end
	
	SetVehicleLockState(veh, 1)
	print("Spawned " .. query .. " (Id: " .. veh .. ")")
end

-- Register command
local cmd_spawn = ScriptHook.RegisterCommand("spawn", command_spawn)
cmd_spawn:AddArgument("name OR archetype", false)
cmd_spawn:SetDescription("Spawn a vehicle (by name or archetype)")