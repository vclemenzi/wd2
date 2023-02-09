-- felony <toggle>
local function command_setfelonyenabled(toggle)

    if toggle == "off" then
        FelonySystemEnable(false)
        print("Felony system disabled")
    else
        FelonySystemEnable(true)
        print("Feloy system enabled")
    end
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("felony", command_setfelonyenabled)
cmd_teleport:AddArgument("state", false)
cmd_teleport:SetDescription("Turn the felony system on or off (true/false)")