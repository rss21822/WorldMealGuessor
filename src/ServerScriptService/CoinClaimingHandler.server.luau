

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local SoundService = game:GetService("SoundService")

local GemCollectSound = SoundService:WaitForChild("GemCollectSound")

local proGamepassId = 1115996940





function onTouch(specificGemPart, otherPart)
	
	print("TOUCHED")
	
	local specificCoinModel = specificGemPart.Parent
	
	if specificCoinModel:GetAttribute("isClaimed") == false then
	
		local player = game.Players:GetPlayerFromCharacter(otherPart.Parent)
		
		if player then
			
			local HiddenStats = player:FindFirstChild("HiddenStats")

			if not HiddenStats then
				return
			end
			
			local coins = HiddenStats:FindFirstChild("Coins")

			if coins and specificCoinModel:GetAttribute("isClaimed") == false then

				GemCollectSound:Play()

				if MarketplaceService:UserOwnsGamePassAsync(player.UserId, proGamepassId) then

					coins.Value = coins.Value + 2 

				else 

					coins.Value = coins.Value + 1
				end
			end

			for _, particle in pairs(game.Workspace.ParticlesLibrary.GemClaimParticles:GetChildren()) do
				if particle:IsA("ParticleEmitter") then


					local clonedParticle = particle:Clone()
					clonedParticle.Parent = specificGemPart
					clonedParticle:Emit(10) -- Emit particles

					-- Destroy cloned particle after 1 second (adjust if needed)
					task.delay(1, function()
						clonedParticle:Destroy()
					end)
				end
			end
		
		
		
			for i, coinPart in pairs(specificCoinModel:GetChildren()) do
			

				coinPart.Transparency = 1
				coinPart.CanCollide = false
			
				if coinPart.Name == "Frame" then
				
					for _, child in pairs(coinPart:GetChildren()) do

						if child:IsA("ParticleEmitter") then
							child.Enabled = false
						end
					end				
				end
			end
		
			specificCoinModel:SetAttribute("isClaimed", true)
	
		end
	end
end


local claimableCoinsFolder = game.Workspace:WaitForChild("ClaimableCoins") -- Change this to your folder name


-- Connect the Touched event to all parts in the folder
local function connectTouchedEvents()
	for _, coinModel in pairs(claimableCoinsFolder:GetChildren()) do

		for i, coinPart in pairs(coinModel:GetChildren()) do
			
			if coinPart.Name == "Frame" then
				
				coinPart.Touched:Connect(function(otherPart)
					onTouch(coinPart, otherPart)
					
				end)																																												
			end
		end
	end
end

connectTouchedEvents()


