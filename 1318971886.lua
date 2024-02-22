_G.AGF("Items", "Предметы") 
_G.AGF("Game/Lobby", "Игра/лобби") 

local Events = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")
local Items = {
		"Med kit",
		"Cure",
		"Apple",
		"Cookie",
		"Bloxy Cola",
		"Chips",
		"Lollipop",
		"Epic Pizza",
		"Pizza 3",
		"Expired Bloxy Cola",
		"Teddy Bloxpin",
		"Bat",
		"Linked Sword",
		"Hammer",
		"Plank", 
		"Key"
}

for k, v in Items do
_G.ABF(k, v, "Items", k).Activated:Connect(function() 
Events:WaitForChild("GiveTool"):FireServer(tostring(v:gsub(" ", "")))
end) 
end

_G.ABF("KE", "Kill bad guys", "Game/Lobby", 1, "Убить плохих челов").Activated:Connect(function() 
pcall(function()
for i, v in pairs(game:GetService("Workspace").BadGuys:GetChildren()) do
for i = 1, 50 do
Events:WaitForChild("HitBadguy"):FireServer(v, 10) 
Events:WaitForChild("HitBadguy"):FireServer(v, 996)
Events:WaitForChild("HitBadguy"):FireServer(v, 9) 
Events:WaitForChild("HitBadguy"):FireServer(v, 8) 
Events:WaitForChild("HitBadguy"):FireServer(v, 996)  
end
end
end)
end) 

_G.ABF(2, "The Swat(Lobby) ", "Game/Lobby", 2).Activated:Connect(function() 
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("SwatGun", false)
end) 

_G.ABF(3, "The Officer(Lobby) ", "Game/Lobby", 3).Activated:Connect(function() 
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("SwatGun", false)
end) 

_G.ABF(4, "The Fighter(Lobby) ", "Game/Lobby", 4).Activated:Connect(function() 
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("SwatGun", false)
end) 
