local TweenService = game:GetService("TweenService")
local part = game.Workspace:WaitForChild("WorldMap"):WaitForChild("Ocean"):WaitForChild("Water") -- Change this to your part

local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true) 
-- 1 second duration, loops forever (-1), auto-reverses (true)

local goal = {Position = part.Position + Vector3.new(0, 0.1, 0)} -- Moves 2 studs up

local tween = TweenService:Create(part, tweenInfo, goal)
tween:Play()