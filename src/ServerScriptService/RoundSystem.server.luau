

-- Round System



-- Services
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Constants
local INTERMISSION_TIME = 10
local ROUND_TIME = 15
local RESULT_TIME = 8
local DISPLAY_WINNER_TIME = 5

-- Variables
local displayedImage = ""

-- Object References
local teleportToLobbyPart = game.Workspace:FindFirstChild("TeleportToLobbyPart")
local teleportToGamePart = game.Workspace:FindFirstChild("TeleportToGamePart")
local placedPinsFolder = game.Workspace:FindFirstChild("PlacedPins")
local imageDisplaySystem = game.Workspace:FindFirstChild("ImageDisplaySystem")
local ClaimableCoinsFolder = game.Workspace:FindFirstChild("ClaimableCoins")

-- Replicated Storage
local pinThemplate = replicatedStorage:FindFirstChild("PinThemplate")
local UpdateUITimerValueRE = replicatedStorage:FindFirstChild("UpdateUITimerValue")
local showRoundResultsRE = replicatedStorage:FindFirstChild("ShowRoundResults")
local TogglePinUIRE = replicatedStorage:FindFirstChild("TogglePinUI")
local triggerNewRoundRE = replicatedStorage:FindFirstChild("TriggerNewRound")
local showGameResultsRE = replicatedStorage:FindFirstChild("ShowGameResults")
local endGameRE = replicatedStorage:FindFirstChild("EndGame")
local newRoundStartedRE = replicatedStorage:FindFirstChild("NewRoundStarted")
local SendPinDataRE = replicatedStorage:WaitForChild("SendPinData")
local revealPinsRE = replicatedStorage:WaitForChild("RevealPins")
local autoPlacePinsRE = replicatedStorage:WaitForChild("AutoPlacePins")

local SendDistanceToServerRE = replicatedStorage:FindFirstChild("SendDistanceToServer")

local worldImagesFolder = replicatedStorage:FindFirstChild("WorldImagesFolder")
local worldImages = worldImagesFolder:GetChildren()

local roundIsSingleplayerRound = true

local winningPlayer = nil



local playerPins = {}  -- Table to store pins by player

-- When the server receives a pin position from a client
SendPinDataRE.OnServerEvent:Connect(function(player, position)
	playerPins[player.UserId] = position
end)

-- Function to reveal all pins to all clients
local function revealAllPins()
	-- Send all player pins to all clients
	
	print("NEW FUNCTION CALLED")
	
	local filteredPlayerPins = {}


	
	for playerId, position in pairs(playerPins) do
		
		for _, plr in pairs(game.Players:GetPlayers()) do
			if plr.UserId == playerId then
				print("TRUE")
				print(position)
				
				filteredPlayerPins[playerId] = position
			end
		end
		
	end
	
	revealPinsRE:FireAllClients(filteredPlayerPins)
end

function UpdateTVDisplay(turnTVOn, randomDecal)



	if turnTVOn == true then


		local TweenService = game:GetService("TweenService")

		local decal1 = imageDisplaySystem.TV1.ImageDisplay.Decal
		local decal2 = imageDisplaySystem.TV2.ImageDisplay.Decal
		local decal3 = imageDisplaySystem.TV3.ImageDisplay.Decal


		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out) -- 2-second fade
		local goal = {Transparency = 0} -- Target transparency

		local tween1 = TweenService:Create(decal1, tweenInfo, goal)
		local tween2 = TweenService:Create(decal2, tweenInfo, goal)
		local tween3 = TweenService:Create(decal3, tweenInfo, goal)

		tween1:Play()
		tween2:Play()
		tween3:Play()

	else

		local TweenService = game:GetService("TweenService")

		local decal1 = imageDisplaySystem.TV1.ImageDisplay.Decal
		local decal2 = imageDisplaySystem.TV2.ImageDisplay.Decal
		local decal3 = imageDisplaySystem.TV3.ImageDisplay.Decal


		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out) -- 2-second fade
		local goal = {Transparency = 1} -- Target transparency

		local tween1 = TweenService:Create(decal1, tweenInfo, goal)
		local tween2 = TweenService:Create(decal2, tweenInfo, goal)
		local tween3 = TweenService:Create(decal3, tweenInfo, goal)

		tween1:Play()
		tween2:Play()
		tween3:Play()


	end

end






local function Countdown(duration)

	for i = duration, 1, -1 do
		print(tostring(i))
		task.wait(1)

	end
end


local function Intermission()

	TogglePinUIRE:FireAllClients(false)

	for _, player in pairs(Players:GetPlayers()) do

		if player.Team and player.Team.Name == "In-Game" then

			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = teleportToLobbyPart.CFrame
			end
			

			player.Team = game.Teams:FindFirstChild("Lobby")
		end
	end

	
	for i = INTERMISSION_TIME, 1, -1 do
		
		UpdateUITimerValueRE:FireAllClients("Intermission: "..tostring(i))
		
		task.wait(1)

	end
	
end


local function RunGame()
	
	local gameIsActive = true
	
	local PlayerCountAtStart = 0
	
	for _, player in pairs(Players:GetPlayers()) do
		if player.Team and player.Team.Name == "Lobby" then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = teleportToGamePart.CFrame
			end

			player.Team = game.Teams:FindFirstChild("In-Game")
			
			PlayerCountAtStart += 1
		end
	end
	
	if PlayerCountAtStart == 0 then
		return
	end
	
	if PlayerCountAtStart > 1 then
		roundIsSingleplayerRound = false
	else
		roundIsSingleplayerRound = true
	end

	while gameIsActive do
		
		newRoundStartedRE:FireAllClients()
		
		
		
		for i, coinModel in pairs(ClaimableCoinsFolder:GetChildren()) do
			
			

			
			
			for i, coinPart in pairs(coinModel:GetChildren()) do
				
				

				
				if coinPart.Name == "Frame" then

					for _, child in pairs(coinPart:GetChildren()) do
						
						if child:IsA("ParticleEmitter") then
							child.Enabled = true
						end
						


					end				


				end
				

				
				coinPart.Transparency = 0
				
				coinPart.CanCollide = true
		

				
			end
			
	
			local xPosition = math.random(-170 , 65)
			local yPosition = 4826.376
			local zPosition = math.random(-1205, -1083)
			
 -- Change to your model's name

			if coinModel and coinModel.PrimaryPart then
				coinModel:SetPrimaryPartCFrame(CFrame.new(xPosition, yPosition, zPosition)) -- Move the model to (0,10,0)
				
				for i,coinPart in pairs(coinModel:GetChildren()) do
					coinPart.Orientation = Vector3.new(90,0,0)
				end
			end



			coinModel:SetAttribute("isClaimed", false)
		

			
		end
		
		

		TogglePinUIRE:FireAllClients(true)
		
		
		local randomDecal = worldImages[math.random(1, #worldImages)]

		
		imageDisplaySystem.TV1.ImageDisplay.Decal.Texture = randomDecal.Texture
		imageDisplaySystem.TV2.ImageDisplay.Decal.Texture = randomDecal.Texture
		imageDisplaySystem.TV3.ImageDisplay.Decal.Texture = randomDecal.Texture
		
		
		
		UpdateTVDisplay(true, randomDecal)
		
		
		
		
		for i = ROUND_TIME, 1, -1 do

			
			UpdateUITimerValueRE:FireAllClients("Place your pin: "..tostring(i))
			
			task.wait(1)

		end
		
		TogglePinUIRE:FireAllClients(false)


		local randomDecalPositionMarker = randomDecal:WaitForChild("LocationPositionMarker")
		
		autoPlacePinsRE:FireAllClients()
		

		showRoundResultsRE:FireAllClients(randomDecalPositionMarker)

		UpdateUITimerValueRE:FireAllClients("Displaying Result")
		
		--local flag = randomDecalPositionMarker:WaitForChild("Flag")
		
		task.wait(0.3)


		--revealPinsRE:FireAllClients(playerPins)
		revealAllPins()
		
		
		local flag = replicatedStorage:WaitForChild("Flag")
		
		local clonedFlag = flag:Clone()
		
		clonedFlag:FindFirstChild("BillboardGui"):WaitForChild("TextLabel").Text = "🏁"..randomDecal.Name

		clonedFlag.Parent = game.Workspace

		
		-- Ensure the cloned model has a PrimaryPart before positioning
		if clonedFlag.PrimaryPart then
			clonedFlag:SetPrimaryPartCFrame(randomDecalPositionMarker.CFrame)
			

			local newY = 4824.42  



			-- Get the current position of the PrimaryPart
			local currentPosition = clonedFlag.PrimaryPart.Position

			-- Update the model's position while keeping X and Z unchanged
			clonedFlag:SetPrimaryPartCFrame(CFrame.new(currentPosition.X, newY, currentPosition.Z))
			
		else
			warn("flag has no primary part")
		end

		task.spawn(function()
			for i = RESULT_TIME, 1, -1 do

				UpdateUITimerValueRE:FireAllClients("Showing Results: "..tostring(i))

				task.wait(1)

			end
		end)
		
		imageDisplaySystem.TV1.ImageDisplay.ScreenSurfaceGUI.MainFrame.AnswerTextLabel.Text = randomDecal.Name
		imageDisplaySystem.TV2.ImageDisplay.ScreenSurfaceGUI.MainFrame.AnswerTextLabel.Text = randomDecal.Name
		imageDisplaySystem.TV3.ImageDisplay.ScreenSurfaceGUI.MainFrame.AnswerTextLabel.Text = randomDecal.Name
		
		
		imageDisplaySystem.TV1.ImageDisplay.ScreenSurfaceGUI.Enabled = true
		imageDisplaySystem.TV2.ImageDisplay.ScreenSurfaceGUI.Enabled = true
		imageDisplaySystem.TV3.ImageDisplay.ScreenSurfaceGUI.Enabled = true

		task.wait(RESULT_TIME - 0.5)

		UpdateTVDisplay(false, randomDecal)
		

		
		
		
		task.wait(0.5)
		
		imageDisplaySystem.TV1.ImageDisplay.ScreenSurfaceGUI.Enabled = false
		imageDisplaySystem.TV2.ImageDisplay.ScreenSurfaceGUI.Enabled = false
		imageDisplaySystem.TV3.ImageDisplay.ScreenSurfaceGUI.Enabled = false

		clonedFlag:Destroy()
		
		triggerNewRoundRE:FireAllClients()
		
		playerPins = {}

		
		if roundIsSingleplayerRound == false then
			if #Teams:FindFirstChild("In-Game"):GetPlayers() < 2 then
				gameIsActive = false
			end
			
		else
			if #Teams:FindFirstChild("In-Game"):GetPlayers() < 1 then
				gameIsActive = false
			end
		end
	end
	
	
	
	-- GAME IS OVER, DISPLAY RESULTS:

	for i, remainingPlayer in pairs(Teams["In-Game"]:GetPlayers()) do
		
		winningPlayer = remainingPlayer

		local leaderstats = remainingPlayer:FindFirstChild("leaderstats")
		
		if not leaderstats then
			return
		end
		
		local wins = leaderstats:FindFirstChild("Wins")
	
		if wins then
			wins.Value += 1
		end
		

		
	end

	if winningPlayer and roundIsSingleplayerRound == false then
		
		local winningTextToDisplay = winningPlayer.Name.." has won the game!"
		showGameResultsRE:FireAllClients(winningTextToDisplay)
		
	elseif roundIsSingleplayerRound == true then
		local winningTextToDisplay = "No wins rewarded (Game is in singleplayer mode)"
		showGameResultsRE:FireAllClients(winningTextToDisplay)
	else
		
		local winningTextToDisplay = "No winner (Tie)"
		showGameResultsRE:FireAllClients(winningTextToDisplay)
		
	end
	
	task.spawn(function()
		for i = DISPLAY_WINNER_TIME, 1, -1 do

			UpdateUITimerValueRE:FireAllClients("Displaying Winner: "..tostring(i))

			task.wait(1)

		end
	end)
	
	task.wait(DISPLAY_WINNER_TIME)
	
	if winningPlayer and winningPlayer.Character then
		local humanoid = winningPlayer.Character:FindFirstChildOfClass("Humanoid") -- Finds the Humanoid
		
		if humanoid then
			humanoid.Health = humanoid.MaxHealth
			
		end
	end
	

	
	endGameRE:FireAllClients()
	
	
end


while true do

	Intermission()
	RunGame()
end


