
local SoundService = game:GetService("SoundService")

local sound = SoundService:WaitForChild("ClickSound")


local function playClickSound()
	if sound.IsLoaded then
		sound:Play()
	end
end

local function connectButtons()
	local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	for _, button in ipairs(playerGui:GetDescendants()) do
		if button:IsA("TextButton") or button:IsA("ImageButton") then
			button.MouseButton1Click:Connect(playClickSound)
		end
	end
end

-- Run when the game starts
connectButtons()

-- Also connect buttons when new UI elements are added
game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function()
	connectButtons()
end)