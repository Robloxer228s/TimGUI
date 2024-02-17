_G.AGF("Zombie lab") 
local virus = _G.ABF("virus", "Get virus", "Zombie lab", 1,"Получить вирус") 
local cure = _G.ABF("cure", "Get cure", "Zombie lab", 2,"Получить инъекцию") 
local dh = _G.ABF("dh", "Delete human only", "Zombie lab", 3,"Удалить только для людей") 
local ds = _G.ABF("ds", "Delete safe virus zone", "Zombie lab", 4,"Удалить антивирус")
local kaz = _G.ABF("kaz", "Kill All Zombies", "Zombie lab", 5,"Убить всех зомби(обычный пистолет нужен)")
local ZN = _G.ATBF("ZN", "Zombie:", "Zombie lab", 6,"Зомби:") 
local kz = _G.ABF("kz", "Kill Zombie", "Zombie lab", 7,"Убить зомби(обычный пистолет нужен)")
virus.Activated:Connect(function() 
game.ReplicatedStorage.Events.GiveVirus:FireServer()
end) 

cure.Activated:Connect(function() 
game.ReplicatedStorage.Events.GiveCure:FireServer()
end) 

dh.Activated:Connect(function() 
game.Workspace.HumanOnlyDoor:Destroy()
end) 

ds.Activated:Connect(function() 
game.Workspace.AntiWeaponZone:Destroy()
end) 

kaz.Activated:Connect(function() 
for i=2,#game.Players:GetPlayers() do
v=game.Players:GetPlayers()[i]
if v.Character:FindFirstChild("Humanoid") then
local args = {
    [1] = v.Character.Humanoid,
    [2] = v.Character.HumanoidRootPart,
    [3] = math.huge,
}
pcall(function()
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Pistol") then
game:GetService("Players").LocalPlayer.Character.Pistol.GunScript_Server.InflictTarget:FireServer(unpack(args))
else
game:GetService("Players").LocalPlayer.Backpack.Pistol.GunScript_Server.InflictTarget:FireServer(unpack(args))
end
end)
end
end
end) 

kz.Activated:Connect(function() 
v=game.Players:FindFirstChild(ZN.Text) 
local args = {
    [1] = v.Character:WaitForChild("Humanoid"),
    [2] = v.Character:WaitForChild("HumanoidRootPart"),
    [3] = math.huge,
}
pcall(function()
if not game.Players.LocalPlayer.Backpack:FindFirstChild("Pistol") then
game:GetService("Players").LocalPlayer.Character.Pistol.GunScript_Server.InflictTarget:FireServer(unpack(args))
else
game:GetService("Players").LocalPlayer.Backpack.Pistol.GunScript_Server.InflictTarget:FireServer(unpack(args))
end
end)
end) 
