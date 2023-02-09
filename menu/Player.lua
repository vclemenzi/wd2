local selectedFraction = "Police"

-- 
local function SetAffiliationRelationshipMenu(name, id)
	local menu = UI.SimpleMenu()
	menu:SetTitle("Set realtionship to " .. name)

	for k,v in pairsByKeys(RelationShips) do
		menu:AddButton(k, function(menu, text, hint, index) 
			SetSquadRelationship(id, RelationShips[k], GetLocalPlayerEntityId())
			ScriptHook.ShowNotification("Your relationship to " .. name .. " is now " .. k)
		end)
	end

	return menu
end

local function OpenRelationshipMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Select a fraction")

	for k,v in pairsByKeys(Affiliation) do
		menu:AddButton(k, Script():CacheMenu(function()
			return SetAffiliationRelationshipMenu(k, Affiliation[k])
		end))
	end

	return menu
end

-- 
local function GetFelonyTypeID(felonyTypeName)
	return Fractions[felonyTypeName]
end

local function StartFelonySearch(level, fraction)
	local felonyLevel = level
	local felonyType = GetFelonyTypeID(fraction)

	ScriptHook.SetHeatLevel(level, felonyType)
end

local function StartFelonyChase(level, fraction, behaviour)
	local target = GetLocalPlayerEntityId()
	local felonyType = GetFelonyTypeID(fraction)
	local felonyLevel = level
	local startAction = 2

	if behaviour == "search" then
		startAction = 3
	end

	FelonyStartChase(target, felonyType, felonyLevel, startAction)
end

-- Player Wanted
local function FractionWantedMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Select a fraction")

	for k,v in pairsByKeys(Fractions) do
		menu:AddButton(k, function(menu, text, hint, index) 
			selectedFraction = text
			ScriptHook.ShowNotification("Changed wanted system to fraction " .. selectedFraction)
		end)
	end

	return menu
end

local function IsPoliceFractionSelected()
	return GetFelonyTypeID(selectedFraction) == 0
end

local function OpenWantedMenuCall()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Wanteds - " .. selectedFraction)

	menu:AddButton("Change fraction", "Select a fraction to chase you", Script():CacheMenu(FractionWantedMenu))

	menu:AddButton("Toggle", function()
		ScriptHook.ToggleFelonySystem()
		ScriptHook.ShowNotification("Toggled felony system")
	end)
	
	local searchButton = menu:AddButton("Start scan", function()
		StartFelonySearch(2, selectedFraction)
		ScriptHook.ShowNotification(selectedFraction .. " is looking for you")
	end)
	
	menu:AddButton("Start chase", function()
		StartFelonyChase(2, selectedFraction, "chase")
		ScriptHook.ShowNotification(selectedFraction .. " is chasing you")
	end)

	menu:AddButton("Start escape", function()
		StartFelonyChase(2, selectedFraction, "search")
		ScriptHook.ShowNotification(selectedFraction .. " is searching for you")
	end)
	
	menu:AddButton("Clear", function()
		FelonyEndChaseOrSearch(GetLocalPlayerEntityId(), GetFelonyTypeID(selectedFraction), 1)
		ScriptHook.ClearHeatLevel(GetFelonyTypeID(selectedFraction))
		ScriptHook.ShowNotification(selectedFraction .. " have lost interest you")
	end)

	menu:OnUpdate(function()
		menu:SetEntryEnabled(searchButton, IsPoliceFractionSelected())
	end)
	
	return menu
end

-- Player Give Weapons
local function GiveWeapon(menu, text, name)
	--SimpleTrainerMenu:Toggle()

	local item = WeaponIDs[name]
	AddItem(item, 1)
	EquipItem(item)

	ScriptHook.ShowNotification("Equipped " .. name)
end

local function GiveWeaponsMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Give Weapon")
	menu:AddSearch("Search", "Start typing to filter")

	for k,v in pairsByKeys(WeaponIDs) do
		menu:AddButton(k:sub(12), k, GiveWeapon)
	end

	return menu
end

-- God
local function PlayerHasGod()
	return Script().StateWatcher:GetState("god") == true
end
local function PlayerSetGod(on)
	local playerid = GetLocalPlayerEntityId()
	Script().StateWatcher:SetState("god", on)

	if on then
		ActivateInvincibility(playerid)
		SetPawnImmuneToDeath(playerid, 1)
	else
		RemoveInvincibility(playerid)
		SetPawnImmuneToDeath(playerid, 0)
	end
end

-- Unlimited Ammo
local function PlayerHasUnlimitedAmmo()
	return Script().StateWatcher:GetState("unlimitedAmmo") == true
end
local function PlayerSetUnlimitedAmmo(on)
	Script().StateWatcher:SetState("unlimitedAmmo", on)
	Script().StateWatcher:UnlimitedAmmo()
end

local function GiveCash()
	UI.SimpleTextInput("Quantity", function(success, text)
		if success then
			ScriptHook.SetProgression(0, tonumber(text))
		end
	end)
end

local function Add10000Followers()
	ScriptHook.SetProgression(3, 10000)

	ScriptHook.ShowNotification("Added 10.000 followers")
end

-- Noclip
local function ToggleNoclip()
	ScriptHook.SetLocalPlayerNoclip(not ScriptHook.HasLocalPlayerNoclip())
end

-- Player
local function PlayerMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Player")

	-- Items
	local godIdx = menu:AddCheckbox("God Mode", "Toggle invincibility", function()
		PlayerSetGod(not PlayerHasGod())
	end)

	local unlAmmoIdx = menu:AddCheckbox("Unlimited Ammo", "No reload, always full clips", function()
		PlayerSetUnlimitedAmmo(not PlayerHasUnlimitedAmmo())
	end)

	local noclipIdx = menu:AddCheckbox("Noclip / Fly", "Enable/Disable flying", ToggleNoclip)
	
	menu:AddButton("Weapons", GiveWeaponsMenu)
	menu:AddButton("Felony", "Clear heat, toggle felony", OpenWantedMenuCall)
	menu:AddButton("Relationship", "Set your relationship to fractions", OpenRelationshipMenu)
	menu:AddButton("Add cash", "Adds $10.000 to your pocket", GiveCash)
	menu:AddButton("Add 10.000 followers", "Boost your level up by adding 10.000 followers", Add10000Followers)

	-- Update
	menu:OnUpdate(function()
		menu:SetChecked(godIdx, PlayerHasGod())
		menu:SetChecked(unlAmmoIdx, PlayerHasUnlimitedAmmo())

		menu:SetChecked(noclipIdx, ScriptHook.HasLocalPlayerNoclip())
		menu:SetEntryEnabled(noclipIdx, not ScriptHook.HasLocalPlayerFreeCamera())
	end)

	return menu
end

table.insert(SimpleTrainerMenuItems, { "Player", "Change clothes, remove wanteds ..", Script():CacheMenu(PlayerMenu) })