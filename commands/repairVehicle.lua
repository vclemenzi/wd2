-- repairVehicle
local function command_repairlocalplayervehicle()
	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId) 

	ScriptHook.RepairVehicle(vehId)
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("repairVehicle", command_repairlocalplayervehicle)
cmd_teleport:SetDescription("Repairs the vehicle you are sitting in")