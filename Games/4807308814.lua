_G.AGF("Items", "Предметы") 
_G.AGF("Game", "Игра") 
_G.AGF("Lobby", "лобби") 
_G.ABF("FHR", "Free hacker role", "Lobby", 1, "Бесплатная роль: хакер").Activated:Connect(function() 
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("Phone", false, false)
end) 

_G.ABF("FNR", "Free nerd role", "Lobby", 2, "Бесплатная роль: нерд").Activated:Connect(function() 
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer("Book", false, false)
end) 

local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
local Items = {
		"Armor",
		"Med Kit",
		"Key",
		"Gold Key",
		"Louise",
		"Lollipop",
		"Chips",
		"Golden Apple",
		"Pizza",
		"Gold Pizza",
		"Rainbow Pizza",
		"Rainbow Pizza Box",
		"Book",
		"Phone",
		"Cookie",
		"Apple",
		"Bloxy Cola",
		"Expired Bloxy Cola",
		"Bottle",
		"Ladder",
		"Battery"
}

for k, v in Items do
_G.ABF(k, v, "Items", k).Activated:Connect(function() 
if v == "Armor" then
Events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(LocalPlayer), 1)
else
Events:WaitForChild("GiveTool"):FireServer(tostring(v:gsub(" ", "")))
end
end) 
end

_G.ABF("KE", "Kill enemies", "Game", 1, "Убить врагов").Activated:Connect(function() 
pcall(function()
for i, v in pairs(game:GetService("Workspace").BadGuys:GetChildren()) do
Events:WaitForChild("HitBadguy"):FireServer(v, 64.8, 4)
end
for i, v in pairs(game:GetService("Workspace").BadGuysBoss:GetChildren()) do
Events:WaitForChild("HitBadguy"):FireServer(v, 64.8, 4)
end
for i, v in pairs(game:GetService("Workspace").BadGuysFront:GetChildren()) do
Events:WaitForChild("HitBadguy"):FireServer(v, 64.8, 4)
end
if game:GetService("Workspace"):FindFirstChild("BadGuyPizza", true) then
Events:WaitForChild("HitBadguy"):FireServer(game:GetService("Workspace"):FindFirstChild("BadGuyPizza", true), 64.8, 4)
end
if game:GetService("Workspace"):FindFirstChild("BadGuyBrute") then
Events:WaitForChild("HitBadguy"):FireServer(game:GetService("Workspace").BadGuyBrute, 64.8, 4)
end
end)
end) 

_G.ABF("TSp", "Train speed", "Game", 2, "Прокачать скорость").Activated:Connect(function() 
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RainbowWhatStat"):FireServer("Speed")
end) 

_G.ABF("TSt", "Train strength", "Game", 3, "Прокачать силу").Activated:Connect(function() 
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RainbowWhatStat"):FireServer("Strength")
end) 