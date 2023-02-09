-- cash <value>
local function command_setcash(val)
    local gave_amount = ScriptHook.SetProgression(0, tonumber(val))
    print("Successfully gave $"..gave_amount)
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("cash", command_setcash)
cmd_teleport:AddArgument("value", false, CommandArgumentType.UInt32)
cmd_teleport:SetDescription("Adds the cash in your pocket")