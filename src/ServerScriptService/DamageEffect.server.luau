local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DamageFolder = ReplicatedStorage:WaitForChild("DamageFolder")
local Highlight = DamageFolder:WaitForChild("Highlight") -- Make sure it's a valid object

local TWEEN_TIME = 0.2
local Info = TweenInfo.new(TWEEN_TIME)

-- Function to handle health change
local function OnHealthChanged(humanoid)
	local lastHealth = humanoid.Health
	local debounce = false

	humanoid.HealthChanged:Connect(function(newHealth)
		if newHealth < lastHealth and not debounce then
			debounce = true

			-- Clone the highlight effect and parent it to the character
			local highlightClone = Highlight:Clone()
			highlightClone.Parent = humanoid.Parent

			-- Create and play the first tween (fade in)
			local Tween1 = TweenService:Create(highlightClone, Info, {FillTransparency = 0.5})
			Tween1:Play()

			task.wait(TWEEN_TIME)

			-- Create and play the second tween (fade out)
			local Tween2 = TweenService:Create(highlightClone, Info, {FillTransparency = 1})
			Tween2:Play()

			-- Destroy highlight after tween finishes
			Tween2.Completed:Wait()
			highlightClone:Destroy()

			debounce = false
		end

		lastHealth = newHealth -- Update health for next damage detection
	end)
end

-- Connect function to each player
local function OnPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			OnHealthChanged(humanoid)
		end
	end)
end

-- Connect to all current and future players
Players.PlayerAdded:Connect(OnPlayerAdded)

for _, player in pairs(Players:GetPlayers()) do
	OnPlayerAdded(player) -- Ensure already connected players are handled
end
