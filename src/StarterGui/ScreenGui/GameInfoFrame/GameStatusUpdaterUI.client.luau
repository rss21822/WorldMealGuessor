


local replicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local BellSound = SoundService:WaitForChild("BellSound")

local updateUITimerValueRE = replicatedStorage:FindFirstChild("UpdateUITimerValue")
local showGameResultsRE = replicatedStorage:FindFirstChild("ShowGameResults")
local endGameRE = replicatedStorage:FindFirstChild("EndGame")


local gameStatusTextLabel = script.Parent:FindFirstChild("GameStatusTextLabel")
local gameWinnerTextLabel = script.Parent:FindFirstChild("GameWinnerTextLabel")

updateUITimerValueRE.OnClientEvent:Connect(function(data)
	gameStatusTextLabel.Text = tostring(data)
end)

showGameResultsRE.OnClientEvent:Connect(function(winningTextToDisplay)
	
	gameWinnerTextLabel.Text = winningTextToDisplay
	gameWinnerTextLabel.Visible = true
	
	
end)


endGameRE.OnClientEvent:Connect(function()
	
	gameWinnerTextLabel.Visible = false
	gameWinnerTextLabel.Text = "placeholder"
	
end)


