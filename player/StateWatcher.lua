-- StateWatcher is a watchdog for the local player's entity. Its used to store variables ("states") of the player
-- until the player dies. Example: stores if the player has God mode on / off
--
-- The current implementation of this isn't great. We're checking the entity id each frame to see if it's still
-- valid and alive. Instead, we should be using event callbacks.
local StateWatcher = {
	EventIDs = {},
	State = {}
}
Script().StateWatcher = StateWatcher

-- we need this to make the callbacks work
StateWatcher._type = StateWatcher

-- Init/Shutdown
function StateWatcher:Init()
	local scs = CScriptCallbackSystem_GetInstance()
	--self.EventIDs.OnDie = scs:RegisterMissionEventCallback(GetLocalPlayerEntityId(), self, "OnDie", "Die", -1)
end

function StateWatcher:Shutdown()
	local scs = CScriptCallbackSystem_GetInstance()
	--scs:RemoveCallback(GetLocalPlayerEntityId(), self.EventIDs.OnDie)
end

-- Timer
function StateWatcher:OnUpdate()
	local curPlyId = GetLocalPlayerEntityId()
	if curPlyId == GetInvalidEntityId() or curPlyId ~= self.PlayerId or IsAlive(curPlyId) == 0 then
		self.State = {}
	end

	self.PlayerId = curPlyId

	-- States
	if self:GetState("unlimitedAmmo") then
		self:UnlimitedAmmo()
	end
end

function StateWatcher:OnDie()
	self.State = {}
end

-- State
function StateWatcher:SetState(key, val)
	self.State[key] = val
end
function StateWatcher:GetState(key)
	return self.State[key]
end

-- Unlimited Ammo
function StateWatcher:UnlimitedAmmo()
	for i = 0, 5, 1 do
		ModifyBulletsInClip(GetLocalPlayerEntityId(), i, 999, 9999)
	end
end