_G.TimGui.Add.G("TP to Waypoint","ТП к точке") 
_G.TimGui.Add.G("Teleports", "Телепорты") 
local Name = _G.TimGui.Add.TB("NameW", "Name:", "Teleports", 1, "Имя:") 
-- local Delete = _G.ABF("DeleteW", "Delete", "Teleports", 0) 
local Waypoints = {}
local Created = {}
local count = 1
_G.TimGui.Add.B("CreateW", "Create and set or set", "Teleports", 2, "Создать или изменить", function(Create) 
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

_G.TimGui.Add.B("TPRP", "TP to random player", "Teleports", 3,"ТП к случайному игроку", function(TPRP)
local pl = game.Players:GetChildren()[math.random(1,#game.Players:GetChildren())]
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pl.Character.HumanoidRootPart.CFrame
end) 
_G.TimGui.Add.B("TPT", "TPTool", "Teleports", 4,"ТПвтулка", function()
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
_G.TimGui.Add.G("Map", "Карта") 
_G.TimGui.Add.B("SB", "Select", "Map", 1, "Выбрать", function() 
nada = true
end) 

_G.TimGui.Add.B("USB", "Unselect", "Map", 2, "Убрать выбор", function()
if sb then sb:Destroy() end
if hl then hl:Destroy() end
obj = nil
end) 

_G.TimGui.Add.B("DSB", "delete select", "Map", 3, "Удалить выбронное", function()
obj:Destroy()
end) 

_G.TimGui.Add.B("CP", "Copy path", "Map", 4, "Копировать путь", function()
setclipboard(tostring(getPath(obj, true)))
end) 

local Folder
local count
local SB = _G.TimGui.Add.CB("BU", "Blocks underfoot", "Map", 5, "Блоки под ногами") 
game:GetService("RunService").Stepped:Connect(function()
if SB.Value then
if Folder == nil then
Folder = Instance.new("Folder") 
Folder.Name = "TimGui"
Folder.Parent = game.Workspace
end
local char = game.Players.LocalPlayer.Character
local tmp = Instance.new("Part") 
tmp.CFrame = char.HumanoidRootPart.CFrame
if char.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
wait(0.1)
count = char.HumanoidRootPart.CFrame.Y - char.LeftFoot.CFrame.Y
local vtc = char.LeftFoot.Size * Vector3.new(0, 1, 0) 
count += vtc.Y
local countt = char.HumanoidRootPart.CFrame.Y - char.RightFoot.CFrame.Y
local vtc = char.RightFoot.Size * Vector3.new(0, 1, 0) 
countt += vtc.Y
if countt > count then
count = countt
end
end
tmp.Position += Vector3.new(0, -count * 1.10675, 0) 
tmp.Anchored = true
tmp.Parent = Folder
end
end) 

_G.TimGui.Add.B("DB", "Clear blocks", "Map", 6, "Очистить блоки", function() 
if Folder == nil then return end
Folder:Destroy()
Folder = nil
end)

_G.TimGui.Add.G("Player","Игрок")
--Fly/Spactate   end in 414
local speed = _G.TimGui.Add.TB("FS","FlySpeed:","Player",10,"СкоростьПолёта:")
speed.Text = "1"
local Fly = _G.TimGui.Add.CB("Fly","Fly","Player",11,"Полёт")
local lp = game.Players.LocalPlayer
local safe = Instance.new("Part") 
safe.Position = Vector3.new(0, 1000000, 0) 
local speeds = 1
local speaker = game:GetService("Players").LocalPlayer
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
speed.Changed:Connect(function() 
speeds = speed.Text
end) 
local actv = _G.TimGui.Add.CB("Invisible", "Invisible fly", "Player", 12, "Невидимый полëт") 
actv.Changed:Connect(function() 
if actv.Value and Fly.Value then
local pos = lp.Character.HumanoidRootPart.CFrame
lp.Character.HumanoidRootPart.CFrame = safe.CFrame
wait(0.1) 
lp.Character.HumanoidRootPart.Anchored = true
lp.Character.HumanoidRootPart.CFrame = pos
else
lp.Character.HumanoidRootPart.Anchored = false
end
end) 
local bv
local bg
game:GetService("RunService").Stepped:Connect(function()
if actv.Value and Fly.Value then
local p = Instance.new("Part") 
p.CFrame = game.Workspace.Camera.CFrame
p.Position = lp.Character.HumanoidRootPart.Position
p.Position += lp.Character.Humanoid.MoveDirection * Vector3.new(0.01, 0.01, 0.01)
lp.Character.HumanoidRootPart.CFrame = p.CFrame
end
end)

Fly.Changed:connect(function()
wait(0.1)
local nowe = not Fly.Value
if actv.Value then
local pos = lp.Character.HumanoidRootPart.CFrame
lp.Character.HumanoidRootPart.CFrame = safe.CFrame
wait(0.1) 
lp.Character.HumanoidRootPart.Anchored = true
lp.Character.HumanoidRootPart.CFrame = pos
end
	if nowe == true then
		nowe = false
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		lp.Character.HumanoidRootPart.Anchored = false
	else 
		nowe = true
		for i = 1, speeds do
			spawn(function()
				local hb = game:GetService("RunService").Heartbeat
				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end
			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end

	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0
		bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()
			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false
	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0
		bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false
	end
end)

local WST = _G.TimGui.Add.TB("WalkspeedV","WalkSpeed:","Player",1,"Скорость ходьбы:") 
_G.TimGui.Add.G("WalkspeedB", "Set walkSpeed", "Player", 2,"Установить скорость", function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WST.Text
end)
local JT = _G.TimGui.Add.TB("JumpPowerV","JampPower:","Player",3,"Сила прыжка:") 
_G.ABF("JumpPowerB", "Set jampPower", "Player", 4,"Установить силу", function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = JT.Text
end)

local PP = _G.TimGui.Add.TB("SpinV","SpinPower:","Player",5,"Скорость кружения") 
local PB = _G.TimGui.Add.CB("SpinB", "Spining", "Player", 6,"Крутиться") 
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

game.Players.LocalPlayer.ChildAdded:Connect(function()
local Flyy = Fly.Value
local Speeen = PB.Value
Fly.Value = false
PB.Value = false 
wait(0.5) 
Fly.Value = Flyy
wait(0.5) 
PB.Value = Speeen
end) 

local IJ = _G.TimGui.Add.CB("IJ", "Infinity Jump", "Player", 7,"Бесконечный прыжок")
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

local Noclip = _G.TimGui.Add.CB("Noclip","Noclip","Player",8,"Проходка сквозь стены")
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

_G.TimGui.Add.B("GM", "GodMode", "Player", 9, "Бесмертие", function()
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

_G.TimGui.Add.G("ESP","Подсветка(esp)")
local espLoad = false
local ESPV = _G.TimGui.Add.CB("Esp","ESP-Main","ESP",1,"Обычный esp(для любой игры)") 
local ESPTC = _G.TimGui.Add.CB("Esptc", "Use Team Color(esp-main)", "ESP", 2,"Использовать цвет команды (для обычной esp) ") 

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
