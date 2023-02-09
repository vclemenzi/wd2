-- setCamera <pX> <pY> <pZ> <rX> <rY> <rZ>
local function command_set_camera(pX, pY, pZ, rX, rY, rZ)
	ScriptHook.CameraSetCustom(pX, pY, pZ, rX, rY, rZ)
	print("Successfully set camera to "..pX..", "..pY..", "..pZ.."("..rX..", "..rY..", "..rZ)
end

-- resetCamera
local function command_reset_camera()
	ScriptHook.CameraReset()
	print("Successfully reset camera")
end

-- Register command set camera
local cmd_set_camera = ScriptHook.RegisterCommand("setCamera", command_set_camera)
cmd_set_camera:AddArgument("pX", true, CommandArgumentType.Float)
cmd_set_camera:AddArgument("pY", true, CommandArgumentType.Float)
cmd_set_camera:AddArgument("pZ", true, CommandArgumentType.Float)
cmd_set_camera:AddArgument("rX", true, CommandArgumentType.Float)
cmd_set_camera:AddArgument("rY", true, CommandArgumentType.Float)
cmd_set_camera:AddArgument("rZ", true, CommandArgumentType.Float)
cmd_set_camera:SetDescription("Set custom camera on position and rotation (pX, pY, pZ, rX, rY, rZ)")

-- Register command reset camera
local cmd_reset_camera = ScriptHook.RegisterCommand("resetCamera", command_reset_camera)
cmd_reset_camera:SetDescription("Reset the camera behind the player")