-- Menu Utility
local script = Script()

function script:CacheMenu(menu_callback)
	local menu_cached = nil
	return function()
		menu_cached = menu_cached or menu_callback()
		return menu_cached
	end
end

-- Menu
local menu = UI.SimpleMenu()
SimpleTrainerMenu = menu

menu:SetTitle("ScriptHook")

-- Items
SimpleTrainerMenuItems = {}
include("Player.lua")
include("Clothing.lua")
include("Inventory.lua")
include("Camera.lua")
include("Teleport.lua")
include("Vehicle.lua")
include("Environment.lua")
include("Game.lua")

for _,data in ipairs(SimpleTrainerMenuItems) do
	menu:AddButton(unpack(data))
end

-- Key Bind
ScriptHook.RegisterKeyHandler("menu", function()
	menu:Toggle()
end)

-- DEBUG
if __isdebugbuild() then
	menu:Activate()
end