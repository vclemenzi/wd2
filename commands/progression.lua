-- progression <id> <value>
local function command_setprogression(id, val)
    ScriptHook.SetProgression(tonumber(id), tonumber(val))
    print("Successfully set progression $"..id.." to value $"..val)
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("progression", command_setprogression)
cmd_teleport:AddArgument("id", false, CommandArgumentType.UInt32)
cmd_teleport:AddArgument("value", false, CommandArgumentType.UInt32)
cmd_teleport:SetDescription("Sets the player progression to a specific value")