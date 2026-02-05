
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local purchasePowerupRE = ReplicatedStorage:FindFirstChild("PurchasePowerup")
local sendPowerupNotificationRE = ReplicatedStorage:FindFirstChild("SendPowerupNotification")

local plusHealthCost = 30
local plusSpeedCost = 10
local shieldCost = 20

local minusSpeedCost = 30
local setFireCost = 50


purchasePowerupRE.OnServerEvent:Connect(function(player, powerupType)
	
	
	
	if powerupType == "plusHealth" then
		if player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value >= plusHealthCost then
			
			player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value -= plusHealthCost
			
			
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.Health += 20
					
					sendPowerupNotificationRE:FireAllClients(player, powerupType)
				end
			end
		end
	elseif powerupType == "plusSpeed" then
		if player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value >= plusSpeedCost then

			player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value -= plusSpeedCost

			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					
					sendPowerupNotificationRE:FireAllClients(player, powerupType)
					task.spawn(function()
						
						humanoid.WalkSpeed = 40
						
						wait(15)
						
						humanoid.WalkSpeed = 20
						
					end)


				end
			end
		end
	elseif powerupType == "shield" then
		
		if player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value >= minusSpeedCost then

			player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value -= minusSpeedCost
		
		
			sendPowerupNotificationRE:FireAllClients(player, powerupType)
		
			task.spawn(function()
			
			player:SetAttribute("isShielded", true)
			
			wait(30)
			
			player:SetAttribute("isShielded", false)
				
			end)
		end

	elseif powerupType == "minusSpeed" then

		if player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value >= minusSpeedCost then

			player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value -= minusSpeedCost

			for i,targetPlayer in pairs(Players:GetPlayers()) do

				if targetPlayer:GetAttribute("isShielded") == false and targetPlayer ~= player and targetPlayer.Team == Teams["In-Game"] then
					task.spawn(function()

						if targetPlayer.Character then
							local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
							if humanoid then
								
								sendPowerupNotificationRE:FireAllClients(player, powerupType)

								task.spawn(function()

									humanoid.WalkSpeed = 5

									wait(15)

									humanoid.WalkSpeed = 20

								end)
							end
						end
					end)
				end
			end
		end
		
	elseif powerupType == "setFire" then
		
		print("HEHEH")
		
		if player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value >= setFireCost then
			
			print("HEHEH")

			player:FindFirstChild("HiddenStats"):FindFirstChild("Coins").Value -= setFireCost


			print("HEHEH")
			for i,targetPlayer in pairs(Players:GetPlayers()) do
				print("HEHEH")
				if targetPlayer:GetAttribute("isShielded") == false and targetPlayer ~= player and targetPlayer.Team == Teams["In-Game"] then -- check so that also isnt the local player
					print("HEHEH")
					task.spawn(function()

						if targetPlayer.Character then
							local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
							if humanoid then
								
								
								sendPowerupNotificationRE:FireAllClients(player, powerupType)
								
								task.spawn(function()
									
									local torso = targetPlayer.character:WaitForChild("UpperTorso", 2) or targetPlayer.Character:WaitForChild("Torso", 2)
									if not torso then return end

									local particleEmitter = game.Workspace:FindFirstChild("ParticlesLibrary"):FindFirstChild("FireParticleEmitter"):Clone()
									particleEmitter.Parent = torso
									
									for i = 1, 3 do
									
										humanoid.Health -= 5
										
										wait(1)
									end
									
									particleEmitter:Destroy()
									
								end)
								

								
								
							end
						end
					end)
				end
			end
		end
		
	else
		
		-- powerup is oof all so its handled elsewhere
		
	end
	
	

end)

