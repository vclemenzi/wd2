-- Commands
include("commands/spawn.lua")
include("commands/teleport.lua")
include("commands/skin.lua")
include("commands/time.lua")
include("commands/timescale.lua")
include("commands/cash.lua")
include("commands/felony.lua")
include("commands/weather.lua")
include("commands/god.lua")
include("commands/repairVehicle.lua")
include("commands/progression.lua")
include("commands/getpos.lua")
include("commands/camera.lua")
include("commands/hud.lua")

-- Menu
include("menu/menu.lua")

-- Player
include("player/StateWatcher.lua")

local script = Script()
script.Entities = {}

function script:OnLoad()
	print("Script trainer main loaded!")
end

function script:OnUpdate()
    self.StateWatcher:OnUpdate()
end

function script:OnRender()
	--
end

function script:InitCallbacks()
    self.StateWatcher:Init()
end

function script:OnUnload()
    self.StateWatcher:Shutdown()

    for _,v in pairs(self.Entities) do
        RemoveEntity(v)
    end
end