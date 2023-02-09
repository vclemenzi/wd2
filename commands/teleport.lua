-- teleport <x> <y> <z>
local function command_teleport(x, y, z)
	local lplayer = GetLocalPlayerEntityId()
	if playerid == GetInvalidEntityId() then
		print("Cannot teleport at this time")
		return
	end
	
	ScriptHook.Teleport(x, y, z)
	print("Successfully teleported to "..x..", "..y..", "..z)
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("teleport", command_teleport)
cmd_teleport:AddArgument("x", true, CommandArgumentType.Float)
cmd_teleport:AddArgument("y", true, CommandArgumentType.Float)
cmd_teleport:AddArgument("z", true, CommandArgumentType.Float)
cmd_teleport:SetDescription("Teleport to coordinates (x, y, z)")