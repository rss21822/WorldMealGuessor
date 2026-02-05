local StartGui = game:GetService("StarterGui")


repeat
	
	local disabled = pcall(function()
		
		StartGui:SetCore("ResetButtonCallback", false)
		
	end)
	
	task.wait(1)
	
until disabled