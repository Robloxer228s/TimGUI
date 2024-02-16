_G.AGF("Door") 
local BA = _G.ABF("BA", "Become amogus", "Door", 1) 

BA.Activated:Connect(function() 
game.ReplicatedStorage.Amogus:FireServer() 
end) 
