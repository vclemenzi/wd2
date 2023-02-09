

local function RechargeBattery()
	-- TODO research
end

local function ClearInventory()
	SwitchLocalPlayerInventoryToEmpty()
	SwitchLocalPlayerInventoryToNormal()
end

local function UnlockAllSkills()
	-- TODO, give all skill items
end

local function ConnectToDroneCall()
	SetFlyingDroneAvailable(1)
	SetFlyingDroneCannotDeploy(0)
	MakeRCEntityDisconnectAvailable(1)
	ConnectToFlyingDrone(GetLocalPlayerEntityId())
end

local function DisconnectFromDroneCall()
	DisconnectFromFlyingDrone(GetLocalPlayerEntityId())
	CallBackFlyingDrone(GetLocalPlayerEntityId())
end

local function ConnectToToyCarCall()
	SetToyCarAvailable(1)
	SetToyCarCannotDeploy(0)
	MakeRCEntityDisconnectAvailable(1)
	ConnectToToyCar(GetLocalPlayerEntityId())
end

local function DisconnectFromToyCarCall()
	DisconnectFromToyCar(GetLocalPlayerEntityId())
	CallBackToyCar(GetLocalPlayerEntityId())
end

-- Inventory items
local function OpenItemCatoryMenu(title, tbl)
	local menu = UI.SimpleMenu()
	menu:SetTitle(title)
	
	for k,v in pairsByKeys(tbl) do
		menu:AddButton(k, k, function(menu, text, hint, index) 
			ScriptHook.AddInventoryItem(tbl[text], 1)
			ScriptHook.ShowNotification("Added item " .. text)
		end)
	end

	return menu
end

local Item_Categories = {
	{ "Generic", Items },
	{ "Access Codes", ItemAccessCodes },
	{ "Access Codes Coop", ItemAccessCodesCoop },
	{ "Access Code Rare Car", ItemAccessCodesRareCar },
	{ "Skills", ItemSkills },
	{ "Car Hacking Rewards", ItemCarHackingRewards },
	{ "Cash", ItemCash },
	{ "Clothing Bundles",ItemClothingBundles },
	{ "Clothing Kiosk",ItemClothingKiosk },
	{ "Clothing Reward", ItemClothingReward },
	{ "Clothing Biker",ItemClothingShopsBiker },
	{ "Clothing Highend", ItemClothingShopsHighEndSuits },
	{ "Clothing HipHop", ItemClothingShopsHipHop },
	{ "Clothing Hipster", ItemClothingShopsHipster },
	{ "Clothing Normcore", ItemClothingShopsNormcore },
	{ "Clothing Urban Skate",ItemClothingShopsUrbanSkate },
	{ "Clothing Default", ItemClothingDefaultSkin },
	{ "Clothing ULC", ItemClothingULC },
	{ "Clothing Vending Machines", ItemClothingVendingMachines },
	{ "Clothing Collectibles", ItemClothingCollectibles },
	{ "Components", ItemComponents },
	{ "Emotes", ItemEmotes },
	{ "Followers", ItemFollowers },
	{ "Narrative",ItemsNarrative },
	{ "Progression", ItemsProgression },
	{ "Projectiles", ItemsProjectiles },
	{ "Races", ItemsRaces },
	{ "RCSkins",ItemsRCSkins },
	{ "Survival Guide", ItemsSurvivalGuide },
	{ "Upgrades", ItemUpgrades },
	{ "Valueables", ItemValueables },
	{ "Vehicle Decals", ItemVehicleDecals },
	{ "Weapon Decals", ItemWeaponDecals },
	{ "Yacht", ItemYacht }
}

local function OpenItemCategoriesMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Select Item Category")
	
	for _,v in pairsByKeys(Item_Categories) do
		local name, tbl = unpack(v)
		menu:AddButton(name, Script():CacheMenu(function()
			return OpenItemCatoryMenu(name, tbl)
		end))
	end

	return menu
end

local function UnlockAllEmotes()
	for k,v in pairsByKeys(ItemEmotes) do
		ScriptHook.AddInventoryItem(ItemEmotes[k], 1)
	end

	ScriptHook.ShowNotification("Unlocked all emotes")
end

-- Player Weapons
local function InventoryMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Inventory")

	menu:AddButton("Give item", Script():CacheMenu(OpenItemCategoriesMenu))
	menu:AddButton("Unlock all emotes", "Use all emotes with the F1-F11 keys", UnlockAllEmotes)
	--menu:AddButton("Recharge Battery", RechargeBattery)
	menu:AddButton("Clear inventory", ClearInventory)
	--menu:AddButton("Unlock all skills", UnlockAllSkills)
	menu:AddButton("Connect to drone", ConnectToDroneCall)
	menu:AddButton("Disconnect from drone", DisconnectFromDroneCall)
	menu:AddButton("Connect to toycar", ConnectToToyCarCall)
	menu:AddButton("Disconnect from toycar", DisconnectFromToyCarCall)
	
	return menu
end

table.insert(SimpleTrainerMenuItems, { "Inventory", "Give weapons, recharge battery ..", Script():CacheMenu(InventoryMenu) })