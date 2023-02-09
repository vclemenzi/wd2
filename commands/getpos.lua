-- getpos
local function command_getpos()
    local lplayer = GetLocalPlayerEntityId()
    if lplayer == GetInvalidEntityId() then
		print("Cannot get position at this time")
		return
    end
    
	local pos = {
		GetEntityPosition(lplayer, 0),
		GetEntityPosition(lplayer, 1),
		GetEntityPosition(lplayer, 2)
	}
	
    print("Current position: "..pos[1]..", "..pos[2]..", "..pos[3])
end

-- Register command
ScriptHook.RegisterCommand("getpos", command_getpos)