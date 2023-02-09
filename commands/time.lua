-- time <hour> <minute>
local function command_changetimeofday(hour, minute)
	if hour and minute then
		SetTimeOfDayHourAndMinute(tonumber(hour), tonumber(minute))
		print("Successfully changed time of day to "..hour..":"..minute)
	end
end

-- Register command
local cmd_teleport = ScriptHook.RegisterCommand("time", command_changetimeofday)
cmd_teleport:AddArgument("hour", false)
cmd_teleport:AddArgument("minute", false)
cmd_teleport:SetDescription("Change the time of day")