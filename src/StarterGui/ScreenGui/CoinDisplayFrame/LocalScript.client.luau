
local coinDisplayFrame = script.Parent

local coinAmountText = coinDisplayFrame:FindFirstChild("CoinAmountText")

local localPlayer = game.Players.LocalPlayer
local HiddenStats = localPlayer:WaitForChild("HiddenStats")
local coins = HiddenStats:WaitForChild("Coins")



local tweenService = game:GetService("TweenService")

-- Create tween settings
local growInfo = TweenInfo.new(
	0.08, -- Time to grow
	Enum.EasingStyle.Back, -- Easing makes it bouncy
	Enum.EasingDirection.Out
)

local shrinkInfo = TweenInfo.new(
	0.08, -- Time to shrink back
	Enum.EasingStyle.Back,
	Enum.EasingDirection.In
)

local growTween = tweenService:Create(coinAmountText, growInfo, {Size = UDim2.new(0.6, 0,0.828, 0)}) -- slightly bigger
local shrinkTween = tweenService:Create(coinAmountText, shrinkInfo, {Size = UDim2.new(0.498, 0,0.691, 0)}) -- normal size


coinAmountText.Text = localPlayer:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value

coins.Changed:Connect(function(newValue)
	print("Your Coins changed! New amount:", newValue)


	coinAmountText.Text = newValue
	
	growTween:Play()
	
	growTween.Completed:Wait()
	
	shrinkTween:Play()
	
end)
