_G.AGF("Main","Стандартные")
_G.ABF("GM", "GodMode", "Main", 10, "Бесмертие").Activated:Connect(function()
local speaker = game.Players.LocalPlayer
local Cam = workspace.CurrentCamera
local Pos, Char = Cam.CFrame, speaker.Character
local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
local nHuman = Human.Clone(Human)
nHuman.Parent, speaker.Character = Char, nil
nHuman.SetStateEnabled(nHuman, 15, false)
nHuman.SetStateEnabled(nHuman, 1, false)
nHuman.SetStateEnabled(nHuman, 0, false)
nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
speaker.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
local Script = Char.FindFirstChild(Char, "Animate")
if Script then
Script.Disabled = true
wait()
Script.Disabled = false
end
nHuman.Health = nHuman.MaxHealth
end)
local WST = _G.ATBF("WalkspeedV","WalkSpeed:","Main",1,"Скорость ходьбы:") 
local WSB = _G.ABF("WalkspeedB", "Set walkSpeed", "Main", 2,"Установить скорость")
WSB.Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WST.Text
end)
local JT = _G.ATBF("JumpPowerV","JampPower:","Main",3,"Сила прыжка:") 
local JB = _G.ABF("JumpPowerB", "Set jampPower", "Main", 4,"Установить силу")
JB.Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = JT.Text
end)

_G.ABF("GM", "GodMode", "Main", 10, "Бесмертие").Activated:Connect(function()
local speaker = game.Players.LocalPlayer
local Cam = workspace.CurrentCamera
local Pos, Char = Cam.CFrame, speaker.Character
local Human = Char and Char.FindFirstChildWhichIsA(Char, "Humanoid")
local nHuman = Human.Clone(Human)
nHuman.Parent, speaker.Character = Char, nil
nHuman.SetStateEnabled(nHuman, 15, false)
nHuman.SetStateEnabled(nHuman, 1, false)
nHuman.SetStateEnabled(nHuman, 0, false)
nHuman.BreakJointsOnDeath, Human = true, Human.Destroy(Human)
speaker.Character, Cam.CameraSubject, Cam.CFrame = Char, nHuman, wait() and Pos
nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
local Script = Char.FindFirstChild(Char, "Animate")
if Script then
Script.Disabled = true
wait()
Script.Disabled = false
end
nHuman.Health = nHuman.MaxHealth
end)

local PP = _G.ATBF("SpinV","SpinPower:","Main",5,"Скорость кружения") 
local PB = _G.ACBF("SpinB", "Spining", "Main", 6,"Крутиться") 
PB.Changed:Connect(function()
if PB.Value then
wait(.1)
local bambam = Instance.new("BodyThrust")
bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bambam.Force = Vector3.new(PP.Text,0,PP.Text)
bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
else
wait(0.05)
game.Players.LocalPlayer.Character.HumanoidRootPart.BodyThrust:Destroy()
end
end)

local IJ = _G.ACBF("IJ", "Infinity Jump", "Main", 7,"Бесконечный прыжок")
local plr = game.Players.LocalPlayer  -- Переменная для игрока
IJ.Changed:Connect(function()
 local UserInputService = game:GetService("UserInputService")
 if (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) then
  local button = plr.PlayerGui.TouchGui.TouchControlFrame.JumpButton
  local function onButtonActivated()
   if IJ.Value then
    local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    Humanoid:ChangeState("Jumping")
    wait(0.1)
    Humanoid:ChangeState("Seated")
   end
  end
  button.Activated:Connect(onButtonActivated)
 else
  local Player = game:GetService("Players").LocalPlayer
  local Mouse = Player:GetMouse()
  
  Mouse.KeyDown:Connect(function(k)
   if IJ.Value then
    if k.KeyCode == Enum.KeyCode.Space then  -- Использование Enum.KeyCode для клавиши Space
     local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
     Humanoid:ChangeState("Jumping")
     wait(0.1)
     Humanoid:ChangeState("Seated")
    end
   end
  end)
 end
end)

local Noclip = _G.ACBF("Noclip","Noclip","Main",8,"Проходка сквозь стены")
local Stepped
Noclip.Changed:Connect(function()
if Noclip.Value then
Stepped = game:GetService("RunService").Stepped:Connect(function()
if Noclip.Value then
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end
else
Stepped:Disconnect()
end
end)
else
Clipon = false
Status.TextColor3 = Color3.new(170,0,0)
end
end)

local TPRP = _G.ABF("TPRP", "TP to random player", "Main", 9,"ТП к случайному игроку")
TPRP.Activated:Connect(function()
local pl = game.Players:GetChildren()[math.random(1,#game.Players:GetChildren())]
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pl.Character.HumanoidRootPart.CFrame
end)

_G.AGF("ESP","Подсветка(esp)")
local espLoad = false
local ESPV = _G.ACBF("Esp","ESP-Main","ESP",1,"Обычный esp(для любой игры)") 
local ESPTC = _G.ACBF("Esptc", "Use Team Color(esp-main)", "ESP", 2,"Использовать цвет команды (для обычной esp) ") 

ESPV.Changed:Connect(function() 
if not espLoad then
for k,player in pairs(game.Players:GetChildren()) do
if not (player == game.Players.LocalPlayer) then
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end)
end
end
game.Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end) 
end) 
end
espLoad = true
for k,player in pairs(game.Players:GetChildren()) do
if ESPV.Value and not (player == game.Players.LocalPlayer) then
local ESP = Instance.new("Highlight")
ESP.Parent = player.Character
ESP.Name = "NotEsp"
ESP.Adornee = player.Character
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
else
local Esp = player.Character:FindFirstChildOfClass("Highlight") 
if Esp then
Esp:Destroy()
end
end
end
end)

ESPTC.Changed:Connect(function() 
if ESPV.Value then
for k,player in pairs(game.Players:GetChildren()) do
if ESPV.Value then
local ESP = player.Character:FindFirstChild("NotEsp")
if ESP then
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
else
ESP.FillColor = Color3.new(1,1,1)
end
end
end
end
end
end) 
