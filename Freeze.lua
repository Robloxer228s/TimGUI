_G.TimGui.Add.G("Freeze players", "Заморозка игроков")
local pos  = {} --CFrame

local function SFreeze(v,Tp)
if not v.Character:FindFirstChild("HumanoidRootPart") then return end
if _G.TimGui.SpareFriends and v:IsFriendsWith(game.Players.LocalPlayer.UserId) then return end
v.Character.HumanoidRootPart.Anchored = true
if Tp then
print(v.Name,TP)
v.Character.HumanoidRootPart.CFrame = Tp
end
end

local function FreezeBS(FTPP, TP, Team)
if FTPP.Value then
--set pos
if TP then
pos[FTPP.Parent.Name] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
--freeze
for k,v in pairs(game.Players:GetPlayers()) do
if v == game.Players.LocalPlayer then continue end
if Team then
if not (Team == v.Team) then continue end
end
SFreeze(v,pos[FTPP.Parent.Name])
end
else
--unfreeze
for k,v in pairs(game.Players:GetPlayers()) do
if v == game.Players.LocalPlayer then continue end
if not v.Character then continue end
if not v.Character:FindFirstChild("HumanoidRootPart") then continue end
if _G.TimGui.SpareFriends and v:IsFriendsWith(game.Players.LocalPlayer.UserId) then return end
if Team then
if not (Team == v.Team) then continue end
end
v.Character.HumanoidRootPart.Anchored = false
end
end
end

local FTP = _G.TimGui.Add.CB("FTPAll","FreezeTP all","Freeze players",1,"ТПЗаморозка всех", function(val) 
FreezeBS(val, true, nil) 
end)
local Friz = _G.TimGui.Add.CB("FAll","Freeze all","Freeze players",2,"Заморозка всех", function(val) 
FreezeBS(val, false, nil) 
end)

local teamsFB = {}
local teamsFTPB = {}

local function freeze(Char) 
wait(0.25)
if not Char.Character then return end
if not Char.Character:FindFirstChild("HumanoidRootPart") then return end
Char.Character.HumanoidRootPart.Anchored = false
if FTP.Value then SFreeze(Char,pos[FTP.Parent.Name]) end
if Friz.Value then SFreeze(Char,nil) end
if not Char.Team then return end
if not teamsFTPB[Char.Team.Name] then return end
if teamsFTPB[Char.Team.Name].Value == true then
SFreeze(Char,pos[teamsFTPB[Char.Team.Name].Parent.Name])
elseif teamsFB[Char.Team.Name].Value == true then
SFreeze(Char,nil)
end
end

local function NewPlayer(Player) 
wait(1)
if _G.TimGui.SpareFriends and Player:IsFriendsWith(game.Players.LocalPlayer.UserId) then return end 
Player.CharacterAdded:Connect(function()
freeze(Player) 
end)
Player:GetPropertyChangedSignal("Team"):Connect(function()
freeze(Player) 
end)
freeze(Player) 
end

local iiiii = Instance.new("BoolValue")
for k,v in pairs(game.Players:GetPlayers()) do
if v == game.Players.LocalPlayer then continue end
iiiii.Changed:Connect(function()
NewPlayer(v) 
end)
end
iiiii.Value = true

for k,v in pairs(game.Teams:GetChildren()) do
teamsFTPB[v.Name] = _G.TimGui.Add.CB("TPFreeze " .. v.Name,'TPFreeze "' .. v.Name .. '" team',"Freeze players",1 + (k * 2),"ТПЗаморозить команду " .. v.Name , function(val) 
FreezeBS(val, true, v) 
end)
teamsFB[v.Name] = _G.TimGui.Add.CB("Freeze " .. v.Name,'Freeze "' .. v.Name .. '" team',"Freeze players",2 + (k * 2),"Заморозить команду " .. v.Name , function(val) 
FreezeBS(val, false, v) 
end)
end 

game.Players.PlayerAdded:Connect(NewPlayer)
