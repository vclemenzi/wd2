local function ToggleFreeCam()
	ScriptHook.SetLocalPlayerFreeCamera(not ScriptHook.HasLocalPlayerFreeCamera())
end

local function ToggleUI()
    if ScriptHook.IsIngameUIEnabled() then
        SendShowOrHideAllUIEvent(0)
    else
        SendShowOrHideAllUIEvent(1)
    end
end

local function CameraMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Camera")

    local freecamIdx = menu:AddCheckbox("Freecam", "Enable/Disable Freecam", ToggleFreeCam)
    local uiToggleIdx = menu:AddCheckbox("Ingame UI", "Show/Hide ingame UI", ToggleUI)

	menu:AddButton("Reset to player", function()
		ScriptHook.CameraReset()
	end)

	for _, v in pairs(CameraSpots) do
		local name, pos = unpack(v)

		menu:AddButton(name, function(menu, text, hint, index)
			ScriptHook.CameraSetCustom(pos[1], pos[2], pos[3], pos[4], pos[5], pos[6])
		end)
	end

	-- Update
	menu:OnUpdate(function()
		menu:SetChecked(freecamIdx, ScriptHook.HasLocalPlayerFreeCamera())
        menu:SetEntryEnabled(freecamIdx, not ScriptHook.HasLocalPlayerNoclip())
        menu:SetChecked(uiToggleIdx, ScriptHook.IsIngameUIEnabled())
	end)

	return menu
end

table.insert(SimpleTrainerMenuItems, { "Camera", "Camera & UI Options", Script():CacheMenu(CameraMenu) })