-- Utility
local function IsPlayerInVehicle()
	local plyId = GetLocalPlayerEntityId()
	return GetCurrentVehicleEntityId(plyId) ~= GetInvalidEntityId() 
end

-- Spawn Vehicle
Script().WarpIntoSpawnedVehicles = true
Script().EngineOn = true
Script().SirenOn = false

local function SpawnVehicleInternal(archetype)
	local pos = GetReticleHitLocation()
	if pos[1] == 0 or pos[2] == 0 or pos[3] == 0 then
		ScriptHook.ShowNotification("Cannot spawn here")
		return nil
	end

	local veh = SpawnEntityFromArchetype(archetype, pos[1], pos[2], pos[3], 0, 0, 0)
	if veh == GetInvalidEntityId() then
		ScriptHook.ShowNotification("Failed to spawn vehicle")
		return nil
	end

	return veh
end

local function SpawnVehicle(menu, text, archetype, id)
	local veh = SpawnVehicleInternal(archetype)
	if veh == nil then
		return
	end
	
	SetVehicleLockState(veh, 1)

	if Script().WarpIntoSpawnedVehicles then
		ScriptHook.PutPlayerInVehicleDelayed(veh, 200)
	end
	
	ScriptHook.ShowNotification("Spawned " .. text)
end

local function SpawnVehicleMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Spawn Vehicle")
	menu:AddSearch("Search", "Start typing to filter")

	for k,v in pairsByKeys(VehicleArchetype) do
		menu:AddButton(k, v, SpawnVehicle)
	end

	return menu
end

local function InternalModifyLight(lightname, toggle)
	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId) 

	if lightname == "highbeam" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 2, 127, toggle, 0)
	elseif lightname == "lowbeam" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 4, 127, toggle, 0)
	elseif lightname == "reverse" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 16, 127, toggle, 0)
	elseif lightname == "break" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 32, 127, toggle, 0)
	elseif lightname == "interiorexterior" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 64, 127, toggle, 0)
	elseif lightname == "marker" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 128, 127, toggle, 0)
	elseif lightname == "emergencylight" then
		ScriptHook.EnableVehicleEmergencyLight(vehId, toggle)
	elseif lightname == "leftspotlight" then
		ScriptHook.EnableVehicleSpotLight(vehId, 0, toggle)
	elseif lightname == "rightspotlight" then
		ScriptHook.EnableVehicleSpotLight(vehId, 1, toggle)
	elseif lightname == "leftindicator" then
		ScriptHook.EnableVehicleIndicator(vehId, 1, toggle)
	elseif lightname == "rightindicator" then
		ScriptHook.EnableVehicleIndicator(vehId, 0, toggle)
	elseif lightname == "conveniencelight" then
		ScriptHook.SetVehicleLightBehaviorFlag(vehId, 256, 127, toggle, 0)
	end
end

local function ModifyLight(text, lightname)
	local menu = UI.SimpleMenu()
	menu:SetTitle("Modify " .. text)

	local textVal = text
	menu:AddButton("Enable", Script():CacheMenu(function()
		ScriptHook.ShowNotification("Enabled Vehicle " .. textVal)

		return InternalModifyLight(lightname, true)
	end))

	menu:AddButton("Disable",Script():CacheMenu(function()
		ScriptHook.ShowNotification("Disabled Vehicle " .. textVal)

		return InternalModifyLight(lightname, false)
	end))

	return menu
end

VehicleLights = {
	["HighBeam Lights"] = "highbeam",
	["LowBeam Lights"] = "lowbeam",
	["Reverse Lights"] = "reverse",
	["Break Lights"] = "break",
	["Interior And Extra Exterior Lights"] = "interiorexterior",
	["Marker Lights"] = "marker",
	["Emergency Light"] = "emergencylight",
	["SpotLight Left"] = "leftspotlight",
	["SpotLight Right"] = "rightspotlight",
	["Indicator Left "] = "leftindicator",
	["Indicator Right"] = "rightindicator",
	["Convenience Light"] = "conveniencelight"
}

local function VehicleLightsMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Modify Lights")

	for k,v in pairsByKeys(VehicleLights) do
		menu:AddButton(k, v, Script():CacheMenu(function()
			return ModifyLight(k, v)
		end))
	end

	return menu
end

VehiclePartTranslation = {}
VehiclePartTranslation["C7C61A80"] = "Vehicle"
VehiclePartTranslation["FA744A40"] = "Chassis"
VehiclePartTranslation["78577600"] = "Front Left Tyre"
VehiclePartTranslation["5DD44980"] = "Back Left Tyre"
VehiclePartTranslation["A7DB7500"] = "Back Right Tyre"
VehiclePartTranslation["82584880"] = "Front Right Tyre"
VehiclePartTranslation["7B83D300"] = "Front Right Door Window"
VehiclePartTranslation["3C81CFC0"] = "Front Right Door Mirror"
VehiclePartTranslation["C59F9D80"] = "Back Right Door Window"
VehiclePartTranslation["F04E5C70"] = "Front Left Door"
VehiclePartTranslation["A416110"] = "Front Right Door"
VehiclePartTranslation["4CA73780"] = "Back Left Door"
VehiclePartTranslation["B6A80A00"] = "Back Right Door"
VehiclePartTranslation["E200E780"] = "Back Left Door Window"
VehiclePartTranslation["818CEE80"] = "Front Left Door Window"
VehiclePartTranslation["55B0ED00"] = "Front Left Door Mirror"
VehiclePartTranslation["782F7700"] = "Back Right Light"
VehiclePartTranslation["82204B80"] = "Back Left Light"
VehiclePartTranslation["B9A3A280"] = "Trunk Door"
VehiclePartTranslation["ACF22880"] = "Rear Window"
VehiclePartTranslation["94D5F200"] = "Hood"
VehiclePartTranslation["53E4C080"] = "Rear Bumper"
VehiclePartTranslation["92C3DD00"] = "Front Bumper"
VehiclePartTranslation["4EFC7C80"] = "Windshield Swiper Right"
VehiclePartTranslation["B4F34100"] = "Windshield Swiper Left"
VehiclePartTranslation["EF041FC0"] = "Engine"
VehiclePartTranslation["4D7E1580"] = "Transmission"
VehiclePartTranslation["ED134840"] = "Rear Right Sidewindow"
VehiclePartTranslation["AA7A3D80"] = "Exhaust Left"
VehiclePartTranslation["33736C40"] = "Exhaust Right"
VehiclePartTranslation["EED902A0"] = "Front Right Fender"
VehiclePartTranslation["14D63FC0"] = "Front Left Fender"
VehiclePartTranslation["D5368500"] = "Lowbeam Light Left"
VehiclePartTranslation["2F39B880"] = "Lowbeam Light Right"
VehiclePartTranslation["2D7F0640"] = "Highbeam Light Right"
VehiclePartTranslation["95821B80"] = "Suspension"
VehiclePartTranslation["36B52E00"] = "Cabriolet Roof"
VehiclePartTranslation["5D4B6B80"] = "Windshield"
VehiclePartTranslation["F5277B20"] = "Middle Breaklight"
VehiclePartTranslation["BD153900"] = "Light Combo Left"
VehiclePartTranslation["471A0480"] = "Light Combo Right"
VehiclePartTranslation["8D931180"] = "Driver Seat"

VehiclePartTranslation["3F4C3EC0"] = "Big Ad Wall Container"
VehiclePartTranslation["2B8BA640"] = "Big Ad Wall Right Screen"
VehiclePartTranslation["B282F800"] = "Big Ad Wall Left Screen"
VehiclePartTranslation["19E7EE00"] = "Big Ad Wall Right Screen Background"
VehiclePartTranslation["F113CB00"] = "Big Ad Wall Left Screen Background"
-- TODO add more translations..

local function VehiclePartMenu(partId)
	local menu = UI.SimpleMenu()

	--

	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId) 

	local partId = partId
	local vehPartHash = ScriptHook.GetVehiclePartHash(vehId, partId)
	local translation = VehiclePartTranslation[string.format("%X", vehPartHash)]
	
	if translation ~= nil then
		menu:SetTitle("Modify Part (" .. translation  .. ")" )
	else
		menu:SetTitle("Modify Part (ID " .. partId  .. ")" )
	end

	menu:AddButton("Pos", "lel", function()
		ScriptHook.SetVehiclePartPosition(vehId, partId, 1.0, 1.0, 1.0)
	end)

	menu:AddButton("Reset", "lel", function()
		ScriptHook.SetVehiclePartPosition(vehId, partId, 0.0, 0.0, 0.0)
	end)

	return menu
end

local function VehiclePartsMenu()
	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId) 

	local vehPartCount = ScriptHook.GetVehiclePartCount(vehId)

	local menu = UI.SimpleMenu()
	menu:SetTitle("Modify Parts (" .. vehPartCount .. ")" )

	for i=0,vehPartCount - 1 do 
		local vehPartHash = ScriptHook.GetVehiclePartHash(vehId, i)
		local translation = VehiclePartTranslation[string.format("%X", vehPartHash)]

		if translation ~= nil then
			menu:AddButton(translation, "Modify the vehicle part", Script():CacheMenu(function()
				return VehiclePartMenu(i)
			end))
		else
			
			print(i .. "  " .. string.format("%X", vehPartHash))

			menu:AddButton(i .. " 0x" .. string.format("%X", vehPartHash), "lel", Script():CacheMenu(function()
				return VehiclePartMenu(i)
			end))
		end
	end

	return menu
end

-- Spider Tank
local spawned_spidertank = nil
local function IsInSpiderTank()
	return spawned_spidertank ~= nil
end

local function SpawnSpiderTank()
	local spider = SpawnVehicleInternal("{a0b8ae08-00fc-4458-9fcd-f70dc6ba6b7e}")
	if spider == nil then 
		return
	end

	table.insert(Script().Entities, spider)

	ForceHackIngredient(spider, GetLocalPlayerEntityId())
	spawned_spidertank = spider
end

local function LeaveSpiderTank()
	RemoveEntity(spawned_spidertank)
	spawned_spidertank = nil
end

local function SpiderTankMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Spider Tank")
	
	local spawnIdx = menu:AddButton("Spawn", SpawnSpiderTank)
	local leaveIdx = menu:AddButton("Leave / Destroy", LeaveSpiderTank)

	menu:OnUpdate(function()
		menu:SetEntryEnabled(spawnIdx, not IsInSpiderTank())
		menu:SetEntryEnabled(leaveIdx, IsInSpiderTank())
	end)

	return menu
end

-- Repair
local function RepairVehicle()
	if not IsPlayerInVehicle() then
		ScriptHook.ShowNotification("Not in a vehicle")
		return
	end

	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId) 

	ScriptHook.RepairVehicle(vehId)
	ScriptHook.ShowNotification("Vehicle repaired")
end

-- God
local function VehicleSetGod(on)
	if not IsPlayerInVehicle() then
		return
	end

	local plyId = GetLocalPlayerEntityId()
	local vehId = GetCurrentVehicleEntityId(plyId)

	if on then
		CDominoManager_GetInstance():SendRegisteredEventToEntity(vehId, "CVehicle", "SetAsIndestructable")
		ScriptHook.ShowNotification("Vehicle indestructable")
	else
		CDominoManager_GetInstance():SendRegisteredEventToEntity(vehId, "CVehicle", "SetAsDestructable")
		ScriptHook.ShowNotification("Vehicle destructable")
	end
end

local function LocalVehicleMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Vehicle")

	local engineIdx = menu:AddCheckbox("Engine", function(menu, text, hint, idx, enabled)
		Script().EngineOn = enabled

		if IsPlayerInVehicle() then
			local plyId = GetLocalPlayerEntityId()
			local vehId = GetCurrentVehicleEntityId(plyId) 

			ScriptHook.EnableVehicleEngine(vehId, Script().EngineOn)
		end
	end)


	local sirenIdx = menu:AddCheckbox("Siren", function(menu, text, hint, idx, enabled)
		Script().SirenOn = enabled

		if IsPlayerInVehicle() then
			local plyId = GetLocalPlayerEntityId()
			local vehId = GetCurrentVehicleEntityId(plyId) 

			ScriptHook.EnableVehicleSiren(vehId, Script().SirenOn)
		end
	end)


	local repairIdx = menu:AddButton("Repair", RepairVehicle)
	local licenseIdx = menu:AddButton("License Plate", function()
		UI.SimpleTextInput("License Plate", function(success, text)
			if success then
				local plyId = GetLocalPlayerEntityId()
				local vehId = GetCurrentVehicleEntityId(plyId) 

				ScriptHook.SetVehicleLicensePlateText(vehId, text)
			end
		end, "Maximum 6 Characters", 6)
	end)

	local lightIdx = menu:AddButton("Lights", Script():CacheMenu(VehicleLightsMenu))

	local partsIdx = menu:AddButton("Parts", Script():CacheMenu(VehiclePartsMenu))

	menu:OnUpdate(function()
		if not IsPlayerInVehicle() then
			Script().EngineOn = false
			Script().SirenOn = false
		else
			local plyId = GetLocalPlayerEntityId()
			local vehId = GetCurrentVehicleEntityId(plyId) 
			local isEnabled = ScriptHook.IsVehicleEngineEnabled(vehId)
			Script().EngineOn = isEnabled
			local isEnabled = ScriptHook.IsVehicleSirenEnabled(vehId)
			Script().SirenOn = isEnabled
		end

		menu:SetChecked(engineIdx, Script().EngineOn)
		menu:SetChecked(sirenIdx, Script().SirenOn)
		
		menu:SetEntryEnabled(engineIdx, IsPlayerInVehicle())
		menu:SetEntryEnabled(sirenIdx, IsPlayerInVehicle())
		menu:SetEntryEnabled(repairIdx, IsPlayerInVehicle())
		menu:SetEntryEnabled(licenseIdx, IsPlayerInVehicle())
		menu:SetEntryEnabled(lightIdx, IsPlayerInVehicle())
		menu:SetEntryEnabled(partsIdx, IsPlayerInVehicle())
	end)

	return menu
end

-- Vehicle
local function VehicleMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Vehicle")

	-- Items
	local warpIdx = menu:AddCheckbox("Warp into Spawned Vehicles", function(menu, text, hint, idx, enabled)
		Script().WarpIntoSpawnedVehicles = enabled
	end)
	
	menu:AddButton("Spawn", "Spawn vehicle", Script():CacheMenu(SpawnVehicleMenu))
	menu:AddButton("Spider Tank", "Spawn Spider Tank", Script():CacheMenu(SpiderTankMenu))
	
	local localVehicleIdx = menu:AddButton("Local Vehicle", "Control the vehicle youre in",  Script():CacheMenu(LocalVehicleMenu))

	menu:OnUpdate(function()
		menu:SetChecked(warpIdx, Script().WarpIntoSpawnedVehicles)
		menu:SetEntryEnabled(localVehicleIdx, IsPlayerInVehicle())
	end)

	return menu
end

table.insert(SimpleTrainerMenuItems, { "Vehicle", "Spawn vehicles, modify them ..", Script():CacheMenu(VehicleMenu) })