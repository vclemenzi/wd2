-- hud
local function command_toggle_hud(val)
	if val == nil or val == "on" or val == "true" then
		SendShowOrHideAllUIEvent(1)
		print("Successfully enabled HUD")
	else
		SendShowOrHideAllUIEvent(0)
		print("Successfully disabled HUD")
	end
end

-- Register command toggle hud
local cmd_hud = ScriptHook.RegisterCommand("hud", command_toggle_hud)
cmd_hud:AddArgument("on/off", true)
cmd_hud:SetDescription("Enable/Disable HUD")