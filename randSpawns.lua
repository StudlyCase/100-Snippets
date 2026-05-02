local Players = game:GetService("Players")

local RapidForge = require(game.ReplicatedStorage.Library.RapidForge)

local CONFIG = {
	spawnFolder = workspace.SpawnPoints,
	characterTemplate = game.ReplicatedStorage.Templates.Character,
	respawnDelay = 5,
	useRandomSpawn = true,
}

local function getSpawnCFrame()
	if CONFIG.useRandomSpawn then
		local point = RapidForge.getRandomChild(CONFIG.spawnFolder)
		return point and point.CFrame or CFrame.new(0, 5, 0)
	end

	local points = CONFIG.spawnFolder:GetChildren()
	return #points > 0 and points[1].CFrame or CFrame.new(0, 5, 0)
end

local function spawnCharacter(player)
	local cf = getSpawnCFrame()
	local character = RapidForge.cloneAt(CONFIG.characterTemplate, cf)
	character.Name = player.Name
	player.Character = character
end

local function scheduleRespawn(player)
	task.delay(CONFIG.respawnDelay, function()
		if player and player.Parent then
			spawnCharacter(player)
		end
	end)
end

local function onCharacterAdded(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			scheduleRespawn(player)
		end
	end)
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
	spawnCharacter(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	if player.Character then
		player.Character:Destroy()
	end
end)
--[[
Structure:

Workspace
└── SpawnPoints (Folder)
    ├── Spawn1 (Part/BasePart)
    ├── Spawn2
    └── etc...

ReplicatedStorage
└── Templates
    └── Character (Model)
--]]
