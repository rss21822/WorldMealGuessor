

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Teams = game:GetService("Teams")



local showRoundResultsRE = ReplicatedStorage:WaitForChild("ShowRoundResults")
local triggerNewRoundRE = ReplicatedStorage:WaitForChild("TriggerNewRound")
local newRoundStartedRE = ReplicatedStorage:WaitForChild("NewRoundStarted")



local localPlayer = Players.LocalPlayer
local GamePassID = 1117351622 -- Replace with the actual GamePass ID




-- Function to make all players except the local player invisible or partially transparent
local function makeOthersInvisible(invisible)
	for _, player in pairs(Teams["In-Game"]:GetPlayers()) do
		
		if player ~= localPlayer and player.Character then
		

			local success, ownsPass = pcall(function()
				return MarketplaceService:UserOwnsGamePassAsync(localPlayer.UserId, GamePassID)
			end)

			if success and ownsPass then
			
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						part.Transparency = 0.7 -- Hide/Show parts
					elseif part:IsA("Accessory") then
						part.Handle.Transparency = 0.7 -- Hide/Show accessories
					end
				end
				
				local head = player.Character:FindFirstChild("Head")
				if head then
					local face = head:FindFirstChild("face") -- Face is a special object inside the head
					if face then
						face.Transparency = 0.7 -- Hide/Show face
					end
					
					local overheadGui = head:FindFirstChild("OverheadGui")

					overheadGui:FindFirstChild("Frame").Visible = false

				end
		
			else
			
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						part.Transparency = 1 -- Hide/Show parts
					elseif part:IsA("Accessory") then
						part.Handle.Transparency = 1 -- Hide/Show accessories
					end
				end
				
				local head = player.Character:FindFirstChild("Head")
				if head then
					local face = head:FindFirstChild("face") -- Face is a special object inside the head
					if face then
						face.Transparency = 1 -- Hide/Show face
					end
					
					local overheadGui = head:FindFirstChild("OverheadGui")

					overheadGui:FindFirstChild("Frame").Visible = false

				end
			end
			
			

		
		end
	end
end

-- Function to make all players visible again
local function makeOthersVisible()
	for _, player in pairs(Teams["In-Game"]:GetPlayers()) do
		if player.Character then
			for _, part in pairs(player.Character:GetChildren()) do
				if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
					part.Transparency = 0 -- Show parts
				elseif part:IsA("Accessory") then
					
					local handle = part:FindFirstChild("Handle")
					if handle then
						handle.Transparency = 0 -- Show accessory
					end
				end
			end
			
			
			local head = player.Character:FindFirstChild("Head")
			if head then
				local face = head:FindFirstChild("face") -- Face is a special object inside the head
				if face then
					face.Transparency = 0 -- Hide/Show face
				end
				
				local overheadGui = head:FindFirstChild("OverheadGui")

				overheadGui:FindFirstChild("Frame").Visible = true
				
			end
		end
	end
end



-- Wait until the character is loaded
local function onCharacterAdded(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()

			
			makeOthersVisible()
			-- Add custom actions here, e.g., show a death UI, play sound, etc.
		end)
	end
end

-- Check if the character already exists
if localPlayer.Character then
	onCharacterAdded(localPlayer.Character)
end

-- Listen for when the character respawns


localPlayer.CharacterAdded:Connect(onCharacterAdded)



showRoundResultsRE.OnClientEvent:Connect(function()
	

	makeOthersVisible()
	
	
end)


newRoundStartedRE.OnClientEvent:Connect(function()
	
	if localPlayer.Team == Teams["In-Game"] then
		makeOthersInvisible()
		
	end
end)
