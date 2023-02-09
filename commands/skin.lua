-- skin <model>
local function command_changeskin(model)
	local playerid = GetLocalPlayerEntityId()
	if playerid == GetInvalidEntityId() then
		print("Cannot change your skin at this time")
		return
	end
	ChangeGraphicKitModel(playerid, model)
	print("Skin successfully changed!")
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("skin", command_changeskin)
cmd_teleport:AddArgument("model", false)
cmd_teleport:SetDescription("Change your skin (graphckitmodel name)")