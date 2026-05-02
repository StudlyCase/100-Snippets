local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local RapidForge = require(game.ReplicatedStorage.Library.RapidForge)

local STAT_NAME = "Coins"
local UPDATE_INTERVAL = 5

local leaderboardFrame = RapidForge.waitFor(
	RapidForge.getGui("HUD"),
	"LeaderboardFrame"
)
local listContainer = RapidForge.waitFor(leaderboardFrame, "List")
local rowTemplate = RapidForge.waitFor(leaderboardFrame, "RowTemplate")

local function getLeaderboardData()
	local entries = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local stats = RapidForge.getLeaderstats(player)
		local stat = stats and stats:FindFirstChild(STAT_NAME)
		if stat then
			table.insert(entries, { player = player, value = stat.Value })
		end
	end
	table.sort(entries, function(a, b) return a.value > b.value end)
	return entries
end

local function updateLeaderboard()
	RapidForge.clearChildren(listContainer)

	local data = getLeaderboardData()
	for rank, entry in ipairs(data) do
		local row = RapidForge.cloneInto(rowTemplate, listContainer)
		row.Visible = true

		RapidForge.waitFor(row, "RankLabel").Text = "#" .. rank
		RapidForge.waitFor(row, "NameLabel").Text = entry.player.DisplayName
		RapidForge.waitFor(row, "ValueLabel").Text = RapidForge.formatNumber(entry.value)
	end
end

local elapsed = 0
RunService.Heartbeat:Connect(function(dt)
	elapsed += dt
	if elapsed >= UPDATE_INTERVAL then
		elapsed = 0
		updateLeaderboard()
	end
end)

updateLeaderboard()

--[[
requires RapidForge
change STAT_NAME accordingly

Structure:

PlayerGui
└── HUD (ScreenGui)
    └── LeaderboardFrame (Frame)
        ├── List (Frame / ScrollingFrame)
        └── RowTemplate (Frame, Visible = false)
            ├── RankLabel (TextLabel)
            ├── NameLabel (TextLabel)
            └── ValueLabel (TextLabel)
--]]
