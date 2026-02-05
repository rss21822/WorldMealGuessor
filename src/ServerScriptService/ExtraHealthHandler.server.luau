local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local GAMEPASS_ID = 1115996940  -- Replace with your actual Gamepass ID
local HEALTH_MULTIPLIER = 1.2 -- 1.2x Health

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			-- Check if the player owns the gamepass
			local success, hasPass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(player.UserId, GAMEPASS_ID)
			end)

			if success and hasPass then
				humanoid.MaxHealth = humanoid.MaxHealth * HEALTH_MULTIPLIER
				humanoid.Health = humanoid.MaxHealth -- Set current health to new max
			end
		end
	end)
end)
