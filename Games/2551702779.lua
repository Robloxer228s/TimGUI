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

--old
--[[
local pist = false
pcall(function() 
if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript_Server") then
pist = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
end
end) 
if pist then
return pist
end
--]]

local function kill(player, character) 
player = game.Players:GetPlayerFromCharacter(char)
local char -- Get Character
if player == false then
char = character
else
char = player.Character
end
-- Check Humanoid
if not char:FindFirstChild("Humanoid") then return false end
-- Spare
if _G.TimGui.SpareFriends and player then
if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then return true end
end
-- Find gun and kill char
for k,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
if v:FindFirstChild("GunScript_Server") then
local args = {
    [1] = player.Character:WaitForChild("Humanoid"),
    [2] = player.Character:WaitForChild("HumanoidRootPart"),
    [3] = math.huge,
}
pcall(function()
v.GunScript_Server.InflictTarget:FireServer(unpack(args))
return true
end)
end
end
print("You aren't have gun")
return false
end

_G.TimGui.Add.B("kaz", "Kill All Zombies", "Zombie lab", 5,"Убить всех зомби", function() 
for i=2,#game.Players:GetPlayers() do
v=game.Players:GetPlayers()[i]
killZombie(v)
end
end) 

_G.TimGui.Add.B("kz", "Kill Zombie", "Zombie lab", 7,"Убить зомби", function() 
v = game.Players:FindFirstChild(ZN.Text) 
killZombie(v)
end) 

_G.TimGui.Add.B("knz", "Kill NPC Zombies", "Zombie lab", 8,"Убить НПС зомби", function()
for k, v in pairs(game.Workspace.Zombies:GetChildren()) do
killZombie(false,v)
end
end) 

local round = 5
local enabled = false

_G.TimGui.Add.CB("KAM","Kill those zombies who are moving","Zombie lab",13,"убивать, тех зомби кто двигается",function(val) 
enabled = val.Value
end) 

local PlayersPos = {}

local function Check(Char) 
local iiii = Instance.new("BoolValue") 
iiii.Changed:Connect(function()
while task.wait(0.25) do
local pos = Char.HumanoidRootPart.Position
pos = Vector3.new(math.floor(pos.X / round),math.floor(pos.Y / round), math.floor(pos.Z / round))
if not (PlayersPos[Char.Name] == pos) then
if enabled then
killZombie(false,Char)
end
end
PlayersPos[Char.Name] = pos
end
end) 
iiii.Value = true
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
if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
killZombie(false,v)
end 
end
end
end 
