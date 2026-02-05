local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDataStore")
local Players = game:GetService("Players")

-- Function to save player data
local function savePlayerData(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local hiddenStats = player:FindFirstChild("HiddenStats")
	if leaderstats and hiddenStats then
		local data = {

			Wins = leaderstats:FindFirstChild("Wins") and leaderstats.Wins.Value or 0,
			Coins = hiddenStats:FindFirstChild("Coins") and hiddenStats.Coins.Value or 0,


		}

		local success, errorMessage = pcall(function()
			PlayerDataStore:SetAsync(player.UserId, data)
		end)

		if not success then
			warn("Failed to save data for " .. player.Name .. ": " .. errorMessage)
		end
	end
end

-- Function to load player data
local function loadPlayerData(player)
	local success, result = pcall(function()
		return PlayerDataStore:GetAsync(player.UserId)
	end)

	if success then
		if result then
			local leaderstats = player:FindFirstChild("leaderstats")
			local hiddenStats = player:FindFirstChild("HiddenStats")
			if leaderstats and hiddenStats then
				leaderstats.Wins.Value = result.Wins or 0
				hiddenStats.Coins.Value = result.Coins or 0
			end
		else
			print(player.Name .. " has no previous data. Starting fresh.")
		end
	else
		warn("Failed to load data for " .. player.Name)
	end
end



-- Handle player join
Players.PlayerAdded:Connect(function(player)
	-- Create leaderstats folder
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player



	-- Create Wins
	local Wins = Instance.new("IntValue")
	Wins.Name = "Wins"
	Wins.Value = 0
	Wins.Parent = leaderstats

	-- Create HiddenStats folder
	local hiddenStats = Instance.new("Folder")
	hiddenStats.Name = "HiddenStats"
	hiddenStats.Parent = player	

	-- Create Coins
	local Coins = Instance.new("IntValue")
	Coins.Name = "Coins"
	Coins.Value = 0
	Coins.Parent = hiddenStats


	-- Load saved data
	loadPlayerData(player)


end)

-- Handle player leaving
game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		savePlayerData(player)
	end
end)