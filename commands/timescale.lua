-- timescale <scale>
local function command_settimescale(scale)
	SetTimeScale(scale)
	print("Successfully changed timescale to "..scale)
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("timescale", command_settimescale)
cmd_teleport:AddArgument("scale", false, CommandArgumentType.Float)
cmd_teleport:SetDescription("Change the timescale (default 1.0)")