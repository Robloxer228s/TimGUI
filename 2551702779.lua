_G.AGF("Zombie lab") 
local virus = _G.ABF("virus", "Get virus", "Zombie lab", 1,"Получить вирус") 
local cure = _G.ABF("cure", "Get cure", "Zombie lab", 2,"Получить инъекцию") 
local dh = _G.ABF("dh", "Delete human only", "Zombie lab", 3,"Удалить только для людей") 
local ds = _G.ABF("ds", "Delete safe virus zone", "Zombie lab", 4,"Удалить антивирус")
local kaz = _G.ABF("kaz", "Kill All Zombies", "Zombie lab", 5,"Убить всех зомби")
local ZN = _G.ATBF("ZN", "Zombie:", "Zombie lab", 6,"Зомби:") 
local kz = _G.ABF("kz", "Kill Zombie", "Zombie lab", 7,"Убить зомби")
local knz = _G.ABF("knz", "Kill NPC Zombies", "Zombie lab", 8,"Убить НПС зомби")
local aknz = _G.ACBF("aknz", "Kill NPC Zombies(auto)", "Zombie lab", 8,"Убить НПС зомби(авто)")
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

local function pistol() 
local pist
for k,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
local pist = false
pcall(function() 
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Server") then
pist = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
end
end) 
if pist then
return pist
end
if v:FindFirstChild("GunScript_Server") then
return v
end
end
end

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
local pist = pistol()
pist.GunScript_Server.InflictTarget:FireServer(unpack(args))
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
pistol().GunScript_Server.InflictTarget:FireServer(unpack(args))
end)
end) 

knz.Activated:Connect(function()
for k, v in pairs(game.Workspace.Zombies:GetChildren()) do
local args = {
    [1] = v:WaitForChild("Humanoid"),
    [2] = v:WaitForChild("HumanoidRootPart"),
    [3] = math.huge,
}
pcall(function()
pistol().GunScript_Server.InflictTarget:FireServer(unpack(args))
end)
end
end) 

while true do 
wait(1) 
if aknz then
local args = {
    [1] = v:WaitForChild("Humanoid"),
    [2] = v:WaitForChild("HumanoidRootPart"),
    [3] = math.huge,
}
pcall(function()
pistol().GunScript_Server.InflictTarget:FireServer(unpack(args))
end)
end
end
end 
