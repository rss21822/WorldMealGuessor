
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")

local BellSound = SoundService:WaitForChild("BellSound")


local showRoundResultsRE = ReplicatedStorage:FindFirstChild("ShowRoundResults")
local triggerNewRoundRE = ReplicatedStorage:FindFirstChild("TriggerNewRound")
local prepareForNewRoundRE = ReplicatedStorage:FindFirstChild("PrepareForNewRound")
local sendDistanceToServerRE = ReplicatedStorage:FindFirstChild("SendDistanceToServer")

local dottedLine = {}


showRoundResultsRE.OnClientEvent:Connect(function(chosenLocationPositionMarker)
	
	BellSound:Play()
	

	
	if game.Workspace.PlacedPins:FindFirstChild(Players.LocalPlayer.Name) then

		-- Wait for the parts to exist
		local CorrectDestinationPin = chosenLocationPositionMarker
		local PlayerPlacedPin = game.Workspace.PlacedPins:WaitForChild(Players.LocalPlayer.Name)

		local dotSize = 0.2     -- Size of each dot
		local gapSize = 1     -- Space between dots

		local distance = (CorrectDestinationPin.Position - PlayerPlacedPin:WaitForChild("Base").Position).Magnitude -- Calculate distance
		local numSegments = math.floor(distance / (dotSize + gapSize)) -- Adjust segment count dynamically

		-- Get the direction vector
		local direction = (CorrectDestinationPin.Position - PlayerPlacedPin:WaitForChild("Base").Position).Unit

		-- Create dotted line segments
		
	
	
		for i = 0, numSegments do
			local dot = Instance.new("Part")
			dot.Size = Vector3.new(dotSize, dotSize, dotSize) -- Small dots
			dot.Shape = Enum.PartType.Block
			dot.Material = Enum.Material.Neon -- Glowing effect
			dot.Color = Color3.fromRGB(255, 107, 107) -- Red color
			dot.Anchored = true
			dot.CanCollide = false
			dot.Parent = game.Workspace:FindFirstChild("Dots") -- Only visible for the local player

			-- Position the dot along the line
			dot.Position = PlayerPlacedPin:WaitForChild("Base").Position + direction * (i * (dotSize + gapSize))
			
			table.insert(dottedLine, dot)
		end
	

		sendDistanceToServerRE:FireServer(distance)
	
		print("Dotted line created with", numSegments, "segments!")
	else
		
		local distance = 9999 -- oof player completely when no pin is set
		
		sendDistanceToServerRE:FireServer(distance)
		
	end
	
	
end)


triggerNewRoundRE.OnClientEvent:Connect(function()

	-- Delete the dots when the event is fired
	for _, dot in pairs(game.Workspace:WaitForChild("Dots"):GetChildren()) do
		dot:Destroy()
	end

end)


prepareForNewRoundRE.OnClientEvent:Connect(function()
	
	
	
end)