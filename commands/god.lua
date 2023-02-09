-- god [on/off]
local function command_god(val)
	local playerid = GetLocalPlayerEntityId()
	if playerid == GetInvalidEntityId() then
		print("Cannot god at this time")
		return
	end

	local stateWatcher = Script().StateWatcher

	if val == nil or val == "on" or val == "true" then
		ActivateInvincibility(playerid)
		SetPawnImmuneToDeath(playerid, 1)
		stateWatcher:SetState("god", true)
		print("God mode enabled")
	else
		RemoveInvincibility(playerid)
		SetPawnImmuneToDeath(playerid, 0)
		stateWatcher:SetState("god", false)
		print("God mode disabled")
	end
end

-- Register command
local cmd_god = ScriptHook.RegisterCommand("god", command_god)
cmd_god:AddArgument("on/off", true)
cmd_god:SetDescription("Enable/Disable god mode")