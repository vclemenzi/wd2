
local function OpenGraphicKitModelMenu(title, tbl)
	local menu = UI.SimpleMenu()
	menu:SetTitle(title)

	local activeGraphicKitTable = tbl
	for k,v in pairsByKeys(tbl) do
		menu:AddButton(k, k, function(menu, text, hint, index) 
			ScriptHook.SetLocalPlayerGraphicKitModel(activeGraphicKitTable[text])
			ScriptHook.ShowNotification("Applied model  " .. text)
		end)
	end

	return menu
end

local GK_Categories = {
	"Generic",
    "Animals",
    "AFI",
    "Auntieshu",
    "Bodyguards",
    "Bratva",
    "CorruptCops",
    "Dedsec",
    "FBI",
    "GhostRidaz",
    "OPD",
    "SFPD",
    "Ragnarok",
    "Umeni",
    "Oakland",
    "SanFrancisco",
    "Ava",
    "Fla",
    "IOP",
    "Mis",
    "NPC",
    "POI",
    "NeiAlcatraz",
    "NeiBlume",
    "NeiCastro",
    "NeiChinatown",
    "NeiDocks",
    "NeiDowntown",
    "NeiDowntownWealthy",
    "NeiGalilei",
    "NeiGhetto",
    "NeiHaightashbury",
    "NeiIndustrial",
    "NeiInvite",
    "NeiMarina",
    "NeiMarin",
    "NeiMission",
    "NeiNatureBeach",
    "NeiNatureRecreational",
    "NeiNudle",
    "NeiSiliconValley",
    "NeiStanford",
    "NeiSwelterSkelter",
    "NeiTidis",
    "NeiWaterFront",
    "NeiWealthyOakland",
    "OCCDriver",
    "Marketing",
    "Debug"
}

local function ChangeGraphicsKitMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Change your model")

	for _,name in pairsByKeys(GK_Categories) do
		menu:AddButton(name, Script():CacheMenu(function()
			return OpenGraphicKitModelMenu(name, GraphicKitModels[name])
		end))
	end

	return menu
end

local function OpenGameClothingMenu()
    OpenMenuPage("UIMenuPageDB.9223372046350598820")
end

local function UnlockAllClothes()
	local Clothings = {
		ItemClothingBundles,
		ItemClothingKiosk,
		ItemClothingReward,
		ItemClothingShopsBiker,
		ItemClothingShopsHighEndSuits,
		ItemClothingShopsHipHop,
		ItemClothingShopsHipster,
		ItemClothingShopsNormcore,
		ItemClothingShopsUrbanSkate,
		ItemClothingDefaultSkin,
		ItemClothingULC,
		ItemClothingVendingMachines,
		ItemClothingCollectibles
	}

	for k,v in pairsByKeys(Clothings) do
		for k2,v2 in pairsByKeys(v) do
			ScriptHook.AddInventoryItem(v2, 1)
		end
	end
	
	ScriptHook.ShowNotification("Unlocked all clothings")
end

local function ClothingMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Clothing")

	menu:AddButton("Unlock all clothing parts", "Unlock all clothing parts for Marcus", UnlockAllClothes)
    menu:AddButton("Change clothing parts", "Open the game menu to change your clothes", OpenGameClothingMenu)
    menu:AddButton("Change player model", "Change your model to Sitarra, Wrench etc.", Script():CacheMenu(ChangeGraphicsKitMenu))
    
	return menu
end

table.insert(SimpleTrainerMenuItems, { "Clothing", "Change your clothes, player model", Script():CacheMenu(ClothingMenu) })