local function AbortMissionCall()
	AbortMission_v2(1) -- mission id
	MissionEnded()
end

local function GameOverCall()
	GameOver(1)
end

local function ClearRewardsCall()
	ClearRewards(1)
end

local function GameMenu()
	local menu = UI.SimpleMenu()
	menu:SetTitle("Game")

	-- Items
	menu:AddButton("Abort mission", AbortMissionCall)
	menu:AddButton("Game over", GameOverCall)
	menu:AddButton("Clear rewards", ClearRewardsCall)

	return menu
end

table.insert(SimpleTrainerMenuItems, { "Game", "Abort mission, game over..", Script():CacheMenu(GameMenu) })