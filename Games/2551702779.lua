_G.TimGui.Add.G("Zombie lab") 
local ZN = _G.TimGui.Add.TB("ZN", "Zombie:", "Zombie lab", 6,"Зомби:") 
local aknz = _G.TimGui.Add.CB("aknz", "Kill NPC Zombies(auto)", "Zombie lab", 9,"Убить НПС зомби(авто)")
local hn = _G.TimGui.Add.CB("hn", "Hide notifications", "Zombie lab", 10,"Спрятать уведомления")

local pathIDK = game.Players.LocalPlayer.PlayerGui.Main
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

_G.TimGui.Add.B("cf", "Change face", "Zombie lab", 11,"Изменить лицо", function() 
pathIDK.ChooseFaceFrame.Visible = true
end) 

_G.TimGui.Add.B("cs", "Change skin", "Zombie lab", 12,"Изменить цвет кожи", function() 
pathIDK.ChooseColorFrame.Visible = true
end) 

_G.TimGui.Add.B("virus", "Get virus", "Zombie lab", 1,"Получить вирус", function() 
game.ReplicatedStorage.Events.GiveVirus:FireServer()
end) 

_G.TimGui.Add.B("cure", "Get cure", "Zombie lab", 2,"Получить инъекцию", function() 
game.ReplicatedStorage.Events.GiveCure:FireServer()
end) 

_G.TimGui.Add.B("dh", "Delete human only", "Zombie lab", 3,"Удалить только для людей", function() 
game.Workspace.HumanOnlyDoor:Destroy()
end) 

_G.TimGui.Add.B("ds", "Delete safe virus zone", "Zombie lab", 4,"Удалить антивирус", function() 
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

_G.TimGui.Add.B("kaz", "Kill All Zombies", "Zombie lab", 5,"Убить всех зомби", function() 
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

_G.TimGui.Add.B("kz", "Kill Zombie", "Zombie lab", 7,"Убить зомби", function() 
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

_G.TimGui.Add.B("knz", "Kill NPC Zombies", "Zombie lab", 8,"Убить НПС зомби", function()
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

local round = 10 
local enabled = false

_G.TimGui.Add.CB("KAM","Kill those zombies who are moving","Zombie lab",13,"убивать, тех зомби кто двигается",function(val) 
enabled = val.Value
end) 

local PlayersPos = {}

local function Check(Char) 
Char:WaitForChild("HitBox"):GetPropertyChangedSignal("Position"):Connect(function()
print(Char.Name, Char.ClassName) 
if not enabled then return end
local pos = Char.Position
pos = Vector3.new(math.floor(pos.X / round),math.floor(pos.Y / round), math.floor(pos.Z / round))
if not (PlayersPos[Char.Name] == pos) then
if Char.Character:FindFirstChild("Humanoid") then
local args = {
    [1] = Char.Character.Humanoid,
    [2] = Char.Character.HumanoidRootPart,
    [3] = math.huge,
}
pcall(function()
local pist = pistol()
pist.GunScript_Server.InflictTarget:FireServer(unpack(args))
end)
end
end
PlayersPos[Char.Name] = pos
end) 
end

local function NewPlayer(Player) 
if not (Player.ClassName == "Player") then return end
Player.CharacterAdded:Connect(Check)
Check(Player.Character) 
end

for k, v in pairs(game.Players:GetChildren()) do
NewPlayer(v) 
end

game.Players.PlayerAdded:Connect(NewPlayer)

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
