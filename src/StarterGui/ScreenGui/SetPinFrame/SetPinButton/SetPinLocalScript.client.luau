local button = script.Parent

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Teams = game:GetService("Teams")

local PinPlaceSound = SoundService:WaitForChild("PinPlaceSound")


local existingPin = nil  -- To store the reference to the existing pin

local localPlayer = game.Players.LocalPlayer
local fixedHeight = 4824.42 -- Set the height level where you want the pin to be placed

local togglePinUIRE = ReplicatedStorage:WaitForChild("TogglePinUI")
local triggerNewRoundRE = ReplicatedStorage:FindFirstChild("TriggerNewRound")
local sendPinDataRE = ReplicatedStorage:WaitForChild("SendPinData")
local revealPinsRE = ReplicatedStorage:WaitForChild("RevealPins")
local getPlayerByIdRF = ReplicatedStorage:WaitForChild("GetPlayerById")
local autoPlacePinsRE = ReplicatedStorage:WaitForChild("AutoPlacePins")
--local prepareForNewRoundRE = ReplicatedStorage:WaitForChild("PrepareForNewRound")

--button.MouseButton1Click:Connect(function()



function placePin()


	local model = ReplicatedStorage:FindFirstChild("PinThemplate")


	-- Check if there's already a pin placed for this player
	for _, item in pairs(game.Workspace.PlacedPins:GetChildren()) do
		if item.Name == localPlayer.Name then




			existingPin = item -- Store the reference to the existing pin


		end
	end

	-- Proceed if the model exists
	if model then
		-- If no pin is placed, create a new one


		if not game.Workspace.PlacedPins:FindFirstChild(localPlayer.Name) then


			local clonedModel = model:Clone() -- Clone the model
			clonedModel.Parent = game.Workspace:WaitForChild("PlacedPins") -- Move it to the workspace
			clonedModel.Name = localPlayer.Name



			-- Set PrimaryPart dynamically if it's not already set
			local primaryPart = clonedModel:FindFirstChild("Base") -- Change "Base" to the name of the part you want to use
			if primaryPart then
				clonedModel.PrimaryPart = primaryPart
			else
				warn("No part named 'Base' found in the model!")
				return
			end

			-- Check if PrimaryPart exists before setting the position
			if clonedModel.PrimaryPart then

				-- Get the player's feet position using HumanoidRootPart
				local feetPosition
				if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then

					local humanoidRootPart = localPlayer.Character.HumanoidRootPart
					feetPosition = humanoidRootPart.Position -- This gets the position near the feet
				end

				-- Ensure feetPosition is defined before setting it
				if feetPosition then

					-- Modify the Y-axis to your fixed height while keeping X and Z as is
					local newPosition = Vector3.new(feetPosition.X, fixedHeight, feetPosition.Z)
					clonedModel:SetPrimaryPartCFrame(CFrame.new(newPosition)) -- Set position using CFrame
					clonedModel:FindFirstChild("BillboardGuiHolderPart"):FindFirstChild("BillboardGui"):FindFirstChild("PinOwnerTextLabel").Text = "📍"..localPlayer.Name
					sendPinDataRE:FireServer(newPosition)

					for _, particle in pairs(clonedModel.Base:GetChildren()) do
						if particle:IsA("ParticleEmitter") then


							PinPlaceSound:Play()

							particle:Emit(1) -- Emit particles



						end
					end

				else
					warn("Could not find HumanoidRootPart for the player!")
				end
			else
				warn("No PrimaryPart defined for the model!")
			end
		else

			-- If a pin is already placed, move the existing pin to the new location
			if existingPin and existingPin.PrimaryPart then
				-- Get the player's feet position using HumanoidRootPart
				local feetPosition
				if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local humanoidRootPart = localPlayer.Character.HumanoidRootPart
					feetPosition = humanoidRootPart.Position -- This gets the position near the feet
				end

				-- Ensure feetPosition is defined before setting it
				if feetPosition then
					-- Modify the Y-axis to your fixed height while keeping X and Z as is
					local newPosition = Vector3.new(feetPosition.X, fixedHeight, feetPosition.Z)
					existingPin:SetPrimaryPartCFrame(CFrame.new(newPosition)) -- Move existing pin to new position

					sendPinDataRE:FireServer(newPosition)

					for _, particle in pairs(existingPin.Base:GetChildren()) do
						if particle:IsA("ParticleEmitter") then

							PinPlaceSound:Play()
							particle:Emit(1) -- Emit particles

						end
					end
				else
					warn("Could not find HumanoidRootPart for the player!")
				end
			end
		end
	else
		warn("Model not found in ReplicatedStorage!")
	end
end

button.Activated:Connect(function()
	placePin()	
end)

autoPlacePinsRE.OnClientEvent:Connect(function()

	if localPlayer.Team == Teams["In-Game"] and not game.Workspace.PlacedPins:FindFirstChild(localPlayer.Name) then

		placePin()

	end


end)


togglePinUIRE.OnClientEvent:Connect(function(visibilityBool)
	
	if localPlayer.Team == Teams:FindFirstChild("In-Game") then
		script.Parent.Parent.Visible = visibilityBool 
	else	
		script.Parent.Parent.Visible = false
	end


end)

triggerNewRoundRE.OnClientEvent:Connect(function()



	if game.Workspace.PlacedPins:FindFirstChild(localPlayer.Name) then
		game.Workspace.PlacedPins:FindFirstChild(localPlayer.Name):Destroy()
	end

end)


local imageLabel = script.Parent.Parent:FindFirstChild("SetPinButton")

local originalSize = imageLabel.Size -- Store the original size
local hoverSize = UDim2.new(originalSize.X.Scale * 1.1, 0, originalSize.Y.Scale * 1.1, 0) -- Slightly bigger size

imageLabel.MouseEnter:Connect(function()
	imageLabel:TweenSize(hoverSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
end)

imageLabel.MouseLeave:Connect(function()
	imageLabel:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
end)







local pinObjectTemplate = ReplicatedStorage:WaitForChild("PinThemplate")

revealPinsRE.OnClientEvent:Connect(function(playerPins)





	-- Create all pins from the received data
	for playerId, position in pairs(playerPins) do




		-- Clone the pin model
		local pin = pinObjectTemplate:Clone()

		local playerFromId = getPlayerByIdRF:InvokeServer(playerId)

		if playerFromId then
			pin:FindFirstChild("BillboardGuiHolderPart"):FindFirstChild("BillboardGui"):FindFirstChild("PinOwnerTextLabel").Text = "📍"..playerFromId.Name
		end	

		local primaryPart = pin:FindFirstChild("Base")

		pin.PrimaryPart = primaryPart



		-- Position the model at the specified position
		pin:SetPrimaryPartCFrame(CFrame.new(position))  -- Assuming the model has a PrimaryPart set



		-- Parent the pin to the map
		pin.Parent = workspace.Map

		-- Optionally, tag the pin so it can be removed later
		pin.Name = "Pin"
	end

end)

triggerNewRoundRE.OnClientEvent:Connect(function()



	-- Destroying all pins
	for _, pin in pairs(workspace.Map:GetChildren()) do
		if pin.Name == "Pin" then
			pin:Destroy()
		end
	end


end)