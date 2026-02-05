local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local sendPowerupNotificationRE = ReplicatedStorage:FindFirstChild("SendPowerupNotification")
local powerupNotificationTextLabel = script.Parent
local originalSize = powerupNotificationTextLabel.Size
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local sendPowerupNotificationRE = ReplicatedStorage:FindFirstChild("SendPowerupNotification")
local powerupNotificationTextLabel = script.Parent



-- Show notification without animation
local function showNotification(text)
	-- Set the text for the label
	powerupNotificationTextLabel.Text = text

	-- Make the label visible
	powerupNotificationTextLabel.Visible = true

	-- Wait for a while before hiding it again
	wait(3)  -- duration the label stays visible

	-- Hide the label after 1 second
	powerupNotificationTextLabel.Visible = false
end

-- Trigger from server
sendPowerupNotificationRE.OnClientEvent:Connect(function(powerupPlayer, powerupType)
	local message = powerupPlayer.Name.." has bought "..powerupType
	showNotification(message)
end)
