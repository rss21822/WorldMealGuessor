local mps = game:GetService("MarketplaceService")
local gamepassId = script.GamepassID.Value
local itemName = "Speed Coil" -- Adjust this if your item is named differently

-- Helper to give the Speed Coil safely
local function giveSpeedCoil(plr)
	local backpack = plr:FindFirstChild("Backpack")
	local starterGear = plr:FindFirstChild("StarterGear")

	if backpack and not backpack:FindFirstChild(itemName) then
		script[itemName]:Clone().Parent = backpack
	end

	if starterGear and not starterGear:FindFirstChild(itemName) then
		script[itemName]:Clone().Parent = starterGear
	end
end

-- When gamepass is purchased
mps.PromptGamePassPurchaseFinished:Connect(function(plr, passId, purchased)
	if passId == gamepassId and purchased then
		giveSpeedCoil(plr)
	end
end)

-- On player joining the game
game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		local success, ownsPass = pcall(function()
			return mps:UserOwnsGamePassAsync(plr.UserId, gamepassId)
		end)

		if success and ownsPass then
			-- Wait for Backpack & StarterGear to exist
			plr:WaitForChild("Backpack")
			plr:WaitForChild("StarterGear")

			giveSpeedCoil(plr)
		end
	end)
end)
