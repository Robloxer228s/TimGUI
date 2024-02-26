_G.AGF("TP to Waypoint","ТП к точке") 
_G.AGF("Teleports", "Телепорты") 
local TPRP = _G.ABF("TPRP", "TP to random player", "Teleports", 3,"ТП к случайному игроку")
local Name = _G.ATBF("NameW", "Name:", "Teleports", 1, "Имя:") 
local Create = _G.ABF("CreateW", "Create and set or set", "Teleports", 2, "Создать или изменить") 
-- local Delete = _G.ABF("DeleteW", "Delete", "Teleports", 0) 
local Waypoints = {}
local Created = {}
local count = 1
Create.Activated:Connect(function() 
if not Created[Name.Text] then
local tmp = _G.ABF(Name.Text, Name.Text, "TP to Waypoint", count) 
count += 1
local Nam = Name.Text
tmp.Activated:Connect(function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Waypoints[Nam]
end) 
Created[Name.Text] = true
end
Waypoints[Name.Text] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)

TPRP.Activated:Connect(function()
local pl = game.Players:GetChildren()[math.random(1,#game.Players:GetChildren())]
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pl.Character.HumanoidRootPart.CFrame
end) 
_G.ABF("TPT", "TPTool", "Teleports", 4,"ТПвтулка").Activated:Connect(function()
local Tele = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
Tele.RequiresHandle = false
Tele.RobloxLocked = true
Tele.Name = "TPTool"
Tele.ToolTip = "Teleport Tool"
if not _G.eng then
Tele.Name = "ТПВтулка"
Tele.ToolTip = "Подотри ей, чтоб тепнутся"
end
Tele.Equipped:connect(function(Mouse)
Mouse.Button1Down:connect(function()
if Mouse.Target then
game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame = (CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z))
end
end)
end)
end)
local Mouse = game.Players.LocalPlayer:GetMouse()
local obj
local nada
local sb
local hl
local function addParentRecursive(object, t)
	if (object and object.Parent) then
		table.insert(t, object.Parent == game and "game" or object.Parent.Name)
		addParentRecursive(object.Parent, t)
	end
end
local function getPath(object, useWaitForChild)
local t = {object.Name}
addParentRecursive(object, t)
local path = t[#t]
if (useWaitForChild) then
for i = #t-1, 1, -1 do
path = path .. ":WaitForChild(\"" .. t[i] .. "\")"
end
else
for i = #t-1, 1, -1 do
local name = t[i]
if (name:match("[^%w_]+") or name:sub(1, 1):match("%d")) then
path = path .. "[\"" .. name .. "\"]"
else
path = path .. "." .. name
end;
end
end
return path
end
Mouse.Button1Down:connect(function()
if not Mouse.Target then return end
if not nada then return end
if sb then sb:Destroy() end
if hl then hl:Destroy() end
obj = Mouse.Target
sb = Instance.new("SelectionBox")
sb.Parent = obj
sb.LineThickness = 0.075
sb.Adornee = obj
print(1) 
hl = Instance.new("Highlight")
hl.Parent = obj
hl.Name = "NotEsp"
hl.Adornee = obj
hl.Archivable = true
hl.Enabled = true
hl.FillColor = Color3.new(0,0,1)
hl.FillTransparency = 0.75
hl.OutlineColor = hl.FillColor
hl.OutlineTransparency = 0
nada = false
end)
_G.AGF("Map", "Карта") 
_G.ABF("SB", "Select", "Map", 1, "Выбрать").Activated:Connect(function() 
nada = true
end) 

_G.ABF("USB", "Unselect", "Map", 2, "Убрать выбор").Activated:Connect(function()
if sb then sb:Destroy() end
if hl then hl:Destroy() end
obj = nil
end) 

_G.ABF("DSB", "delete select", "Map", 3, "Удалить выбронное").Activated:Connect(function()
obj:Destroy()
end) 

_G.ABF("CP", "Copy path", "Map", 4, "Копировать путь").Activated:Connect(function()
setclipboard(tostring(getPath(obj, true)))
end) 

--Spectate
_G.AGF("Player","Игрок")
local lp = game.Players.LocalPlayer
local p = Instance.new("Part")
local actv = _G.ACBF("SFly", "Spectate(visual)", "Player", 11, "Наблюдать(только для тебя)")
local sst = _G.ATBF("SSFly", "Speed for spectate", "Player", 10, "Скорость для наблюдения")
sst.Text = "1"
local jp
local safe = Instance.new("Part") 
safe.Position = Vector3.new(0, 1000000, 0) 

actv.Changed:Connect(function() 
if actv.Value then
local pos = lp.Character.HumanoidRootPart.CFrame
lp.Character.HumanoidRootPart.CFrame = safe.CFrame
wait(0.1) 
lp.Character.HumanoidRootPart.Anchored = true
lp.Character.HumanoidRootPart.CFrame = pos
else
lp.Character.HumanoidRootPart.Anchored = false
end
end) 
--Up/Down
local y = Instance.new("Frame")
y.Parent = game.CoreGui.TimGUI
y.Name = "SpectateY"
y.Size = UDim2.new(0,100,0,50)
local ypos = 0
local down = Instance.new("TextButton")
local up = Instance.new("TextButton")
down.Position = UDim2.new(0,0,0,0)
up.Position = UDim2.new(0.5,0,0,0)
down.Size = UDim2.new(0.5,0,1,0)
up.Size = UDim2.new(0.5,0,1,0)
down.Text = "Down"
up.Text = "Up"
if not _G.eng then
down.Text = "Вниз"
up.Text = "Вверх"
end
down.TextScaled = true
up.TextScaled = true
down.BackgroundColor3 = Color3.new(1,0.5,0.5)
up.BackgroundColor3 = Color3.new(0.5,0.5,1)
down.Parent = y
up.Parent = y

down.MouseButton1Down:Connect(function()
ypos = -0.75
end)
down.MouseButton1Up:Connect(function()
ypos = 0
end)
up.MouseButton1Down:Connect(function()
ypos = 0.75
end)
up.MouseButton1Up:Connect(function()
ypos = 0
end)
local u = game:GetService("UserInputService")
u.InputEnded:Connect(function(input)
if input.KeyCode == Enum.KeyCode.Q then
ypos = 0
elseif input.KeyCode == Enum.KeyCode.E then
ypos = 0
end
end)
u.InputBegan:Connect(function(input)
if input.KeyCode == Enum.KeyCode.Q then
ypos = -0.75
elseif input.KeyCode == Enum.KeyCode.E then
ypos = 0.75
end
end)

--While spectator
game:GetService("RunService").Stepped:Connect(function()
local act = actv.Value
y.Visible = act
if not (lp.Character.Humanoid.JumpPower == 0) and act then
jp = lp.Character.Humanoid.JumpPower
lp.Character.Humanoid.JumpPower = 0
elseif lp.Character.Humanoid.JumpPower == 0 and not act then
lp.Character.Humanoid.JumpPower = jp
end
if act then
p.CFrame = game.Workspace.Camera.CFrame
p.Position = lp.Character.HumanoidRootPart.Position
p.Position += lp.Character.Humanoid.MoveDirection * Vector3.new(sst.Text, sst.Text, sst.Text)
p.Position += Vector3.new(0,ypos,0)
lp.Character.HumanoidRootPart.CFrame = p.CFrame
end
end)


local WST = _G.ATBF("WalkspeedV","WalkSpeed:","Player",1,"Скорость ходьбы:") 
_G.ABF("WalkspeedB", "Set walkSpeed", "Player", 2,"Установить скорость").Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WST.Text
end)
local JT = _G.ATBF("JumpPowerV","JampPower:","Player",3,"Сила прыжка:") 
_G.ABF("JumpPowerB", "Set jampPower", "Player", 4,"Установить силу").Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = JT.Text
end)

local PP = _G.ATBF("SpinV","SpinPower:","Player",5,"Скорость кружения") 
local PB = _G.ACBF("SpinB", "Spining", "Player", 6,"Крутиться") 
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

local IJ = _G.ACBF("IJ", "Infinity Jump", "Player", 7,"Бесконечный прыжок")
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

local Noclip = _G.ACBF("Noclip","Noclip","Player",8,"Проходка сквозь стены")
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

_G.ABF("GM", "GodMode", "Player", 9, "Бесмертие").Activated:Connect(function()
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
