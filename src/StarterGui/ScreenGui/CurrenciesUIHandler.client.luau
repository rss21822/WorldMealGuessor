
local Players = game:GetService("Players")



local GemTextLabel = script.Parent:FindFirstChild("GemDisplay"):FindFirstChild("TextLabel")


local player = Players.LocalPlayer


-- Wait for HiddenStats to be created
local HiddenStats = player:WaitForChild("HiddenStats")
local coins = HiddenStats:WaitForChild("Coins")




GemTextLabel.Text = coins.Value


-- Detect when the value changes


coins.Changed:Connect(function(newValue)
	GemTextLabel.Text = tostring(newValue)
end)



