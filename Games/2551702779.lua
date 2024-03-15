_G.AGF("Zombie lab") 
local ZN = _G.ATBF("ZN", "Zombie:", "Zombie lab", 6,"Зомби:") 
local aknz = _G.ACBF("aknz", "Kill NPC Zombies(auto)", "Zombie lab", 9,"Убить НПС зомби(авто)")
local hn = _G.ACBF("hn", "Hide notifications", "Zombie lab", 10,"Спрятать уведомления")

local pathIDK = game.Players.LocalPlayer.PlayerGui.PlayerGui
game.Players.LocalPlayer.CharacterAdded:Connect(function () 
wait(0.5) 
pathIDK = game.Players.LocalPlayer.PlayerGui.PlayerGui
pathIDK.ChildAdded:Connect(function(child) 
if child.Name == "MoveUp" then
child.Visible = not hn.Value
end
end)
end) 
pathIDK.ChildAdded:Connect(function(child) 
if child.Name == "MoveUp" then
child.Visible = not hn.Value
end
end) 

_G.ABF("cf", "Change face", "Zombie lab", 11,"Изменить лицо", function() 
pathIDK.ChooseFaceFrame.Visible = true
end) 

_G.ABF("cs", "Change skin", "Zombie lab", 12,"Изменить цвет кожи", function() 
pathIDK.ChooseSkinFrame.Visible = true
end) 

_G.ABF("virus", "Get virus", "Zombie lab", 1,"Получить вирус", function() 
game.ReplicatedStorage.Events.GiveVirus:FireServer()
end) 

_G.ABF("cure", "Get cure", "Zombie lab", 2,"Получить инъекцию", function() 
game.ReplicatedStorage.Events.GiveCure:FireServer()
end) 

_G.ABF("dh", "Delete human only", "Zombie lab", 3,"Удалить только для людей", function() 
game.Workspace.HumanOnlyDoor:Destroy()
end) 

_G.ABF("ds", "Delete safe virus zone", "Zombie lab", 4,"Удалить антивирус", function() 
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

_G.ABF("kaz", "Kill All Zombies", "Zombie lab", 5,"Убить всех зомби", function() 
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

_G.ABF("kz", "Kill Zombie", "Zombie lab", 7,"Убить зомби", function() 
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

 _G.ABF("knz", "Kill NPC Zombies", "Zombie lab", 8,"Убить НПС зомби", function()
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
if aknz.Value then
for k, v in pairs(game.Workspace.Zombies:GetChildren()) do
if v:FindFirstChild("Humanoid") and  v:FindFirstChild("HumanoidRootPart") then
local args = {
    [1] = v.Humanoid,
    [2] = v.HumanoidRootPart,
    [3] = math.huge,
}
pcall(function()
pistol().GunScript_Server.InflictTarget:FireServer(unpack(args))
end)
end 
end
end
end 
