_G.TimGui.Add.G("TP to Waypoint","ТП к точке") 
_G.TimGui.Add.G("Teleports", "Телепорты") 
local Name = _G.TimGui.Add.TB("NameW", "Name:", "Teleports", 1, "Имя:") 
-- local Delete = _G.ABF("DeleteW", "Delete", "Teleports", 0) 
local Waypoints = {}
local Created = {}
local count = 0
_G.TimGui.Add.B("CreateW", "Create and set or set", "Teleports", 2, "Создать или изменить", function(Create) 
if not Created[Name.Text] then
local Nam = Name.Text
count += 1
_G.TimGui.Add.B(Nam, Nam, "TP to Waypoint", count, Nam, function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Waypoints[Nam]
end) 
Created[Nam] = true
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
if _G.TimGui.ru then
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
local Mouse 
while true do
wait(0.1)
local success, response = pcall(function()
Mouse = game.Players.LocalPlayer:GetMouse()
end)
if success then
break
end
end
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
setclipboard(tostring(getPath(obj, false)))
end) 

local timer = _G.TimGui.Add.TB("TIP","Time in part","Map",5,"Время в блоке")
timer.Text = 0.1
_G.TimGui.Add.B("TPP","TP selected part in you","Map",6,"ТП выбранное в тебя",function()
    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    local CF = HRP.CFrame
    HRP.CFrame = obj.CFrame
    local weld = Instance.new("WeldConstraint",game.Workspace)
    weld.Part0 = game.Players.LocalPlayer.Character.HumanoidRootPart
    weld.Part1 = obj
    local timmer = tonumber(timer.Text)
    if timmer == nil then
        timmer = 0.1
    end
    if timmer > 2.5 then
        timmer = 2.5
    elseif timmer > 0.01 then
        timmer = 0.01
    end
    wait(timmer)
    local CCF = HRP.CFrame
    HRP.CFrame = CF
    wait()  
    weld:Destroy()
    wait(0.05)
    HRP.CFrame = CF
    wait()
    CF = HRP.CFrame
    HRP.CFrame = obj.CFrame
    wait(timmer)
    HRP.CFrame = CF
    wait()
    HRP.CFrame = CCF
    wait(0.05)
    HRP.CFrame = CF
end)

_G.TimGui.Add.B("TPPV","TP selected part in you(visual)","Map",7,"ТП выбранное в тебя(только для тебя)",function()
    obj.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)

_G.TimGui.Add.B("TPTP","TP to selected part","Map",8,"ТП в выбранное",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
end)

local Folder
local count
local SB = _G.TimGui.Add.CB("BU", "Blocks underfoot", "Map", 9, "Блоки под ногами") 
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

_G.TimGui.Add.B("DB", "Clear blocks", "Map", 10, "Очистить блоки", function() 
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

local Changer
local WalkSpeed = _G.TimGui.Add.TB("WalkspeedV","WalkSpeed:","Player",1,"Скорость ходьбы:") 
local Chan

local WSpeed = _G.TimGui.Add.CB("WalkspeedB", "Set walkSpeed", "Player", 2,"Установить скорость", function(enabled) 
if Changer then Changer:Disconnect() end
if Chan then Chan:Disconnect() end
Chan = nil
Changer = nil
if not enabled.Value then return end
Chan = game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
    if game.Players.LocalPlayer.Character.Humanoid.MoveDirection == Vector3.new(0,0,0) then
        Changer:Disconnect()
    elseif not Changer then
        Changer = game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(WalkSpeed.Text) 
        end)
        wait()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(WalkSpeed.Text) 
    end
end)
end) 

local JT = _G.TimGui.Add.TB("JumpPowerV","JampPower:","Player",3,"Сила прыжка:") 
_G.TimGui.Add.B("JumpPowerB", "Set jampPower", "Player", 4,"Установить силу", function()
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

local anim = _G.TimGui.Add.CB("Noanim","No animation","Player",13,"Без анимации", function(val)
        if Fly.Value then return end
	game.Players.LocalPlayer.Character.Animate.Disabled = val.Value
end) 

local NOTouch = _G.TimGui.Add.CB("NoTouch","Not CanTouch","Player",15,"Убрать касания",function(val)
    for k,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
        if v:IsA("BasePart") then
            v.CanTouch = not val.Value
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
local Flyy = Fly.Value
local Speeen = PB.Value
local animat = anim.Value
local Speed = WSpeed.Value
local NoTouchVal = NOTouch.Value
Fly.Value = false
PB.Value = false 
anim.Value = false 
WSpeed.Value = false
NOTouch.Value = false
wait(0.5) 
NOTouch.Value = NoTouchVal
WSpeed.Value = Speed
anim.Value = animat
Fly.Value = Flyy
wait(0.25) 
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
_G.TimGui.Print("Noclip","Jump!","Проходка сквозь стены","Прыгни!")
end
end)

_G.TimGui.Add.B("GM", "GodMode", "Player", 9, "Бесмертие", function()
_G.TimGui.Print("GodMod","It may not work!","Бессмертие","Может не работать")
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

_G.TimGui.Add.G("Lighting","Освещение")

local Fog = game.Lighting.FogEnd
local FogClear = _G.TimGui.Add.CB("FogC","Clear fog","Lighting",1,"Очистить туман",function(val)
    if val.Value then
        Fog = game.Lighting.FogEnd
        game.Lighting.FogEnd = 1000000
    else
        game.Lighting.FogEnd = Fog
    end
end)

game.Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
if game.Lighting.FogEnd == 1000000 then return end
Fog = game.Lighting.FogEnd
if not FogClear.Value then return end
game.Lighting.FogEnd = 1000000
end)

local BrightnessChange
local BrightnessTxt = _G.TimGui.Add.TB("BrightTXT","Brightness:","Lighting",2,"Яркость:")
BrightnessTxt:GetPropertyChangedSignal("Text"):Connect(function()
if not BrightnessChange.Value then return end
game.Lighting.Brightness = tonumber(BrightnessTxt.Text)
end)
BrightnessChange = _G.TimGui.Add.CB("BrightnessChange","Auto change brightness","Lighting",3,"Авто смена яркости",function(val)
    if val.Value then
        game.Lighting.Brightness = tonumber(BrightnessTxt.Text) 
    end
end)

game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
if game.Lighting.Brightness == BrightnessTxt.Text then return end
if not BrightnessChange.Value then return end
game.Lighting.Brightness = tonumber(BrightnessTxt.Text) 
end)

local ClockTime = _G.TimGui.Add.TB("ClcTime", "Clock time:", "Lighting", 4, "Время:") 
_G.TimGui.Add.B("SetClc", "Set clock time", "Lighting", 5, "Установить время", function() 
game.Lighting.ClockTime = tonumber(ClockTime.Text) 
end) 

local light
local LRange = _G.TimGui.Add.TB("LRange", "Light range:", "Lighting", 6, "Дистанция света:") 
local LBright = _G.TimGui.Add.TB("LBright", "Light Brightness:", "Lighting", 7, "Яркость света:") 
_G.TimGui.Add.CB("Lighting","Lighting Character","Lighting",8,"Свечащийся персонаж",function(val)
if val.Value then
light = Instance.new("PointLight") 
light.Name = "Light"
light.Range = tonumber(LRange.Text) 
light.Brightness = tonumber(LBright.Text) 
light.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
else
light:Destroy()
end
end)

LRange.Text = 100
LBright.Text = 1

_G.TimGui.Add.B("Sit","Sit","Player",14,"Сесть",function(val)
game.Players.LocalPlayer.Character.Humanoid.Sit = not game.Players.LocalPlayer.Character.Humanoid.Sit
end)


_G.TimGui.Add.G("Camera","Камера")
local gui = _G.TimGui.Path.Main.Parent
local text = Instance.new("TextLabel",gui)
local plCount = 2
text.Position = UDim2.new(1,-300,0,-25)
text.Size = UDim2.new(0,300,0,25)
text.BackgroundColor3 = Color3.fromRGB(66,66,114)
text.TextColor3 = Color3.new(1,1,1)
text.TextScaled = true
text.TextXAlignment = Enum.TextXAlignment.Left
text.Visible = false

local function UpdCam()
    local co = plCount
    local pl = game.Players:GetPlayers()[plCount]
    if game.Players:GetPlayers()[plCount] and plCount ~= 1 then
        if not pl.Character then
            pl.CharacterAdded:Wait()
            wait()
        end
    elseif plCount == 1 then
        plCount = #game.Players:GetPlayers()
        pl = game.Players:GetPlayers()[plCount]
        co = plCount
    else
        plCount = 2
        pl = game.Players:GetPlayers()[plCount]
        co = plCount
    end
    if co ~= plCount then return end
    local all = #game.Players:GetPlayers()
    text.Text = "["..tostring(plCount -1).."/"..tostring(all -1).."]".." "..pl.Name
    game.Workspace.Camera.CameraSubject = pl.Character.Humanoid
end

local enab = _G.TimGui.Add.CB("Spectate","Spectate","Camera",1,"Следить за игроками",function(val)
    text.Visible = val.Value
    if val.Value then
        UpdCam()
    else
        game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end
end)

_G.TimGui.Add.B("PastPlayer","Past Player","Camera",2,"Прошлый игрок",function()
    plCount += -1
    if not enab.Value then return end
    UpdCam()
end)

_G.TimGui.Add.B("NextPlayer","Next Player","Camera",3,"Следующий игрок",function()
    plCount += 1
    if not enab.Value then return end
    UpdCam()
end)

local DefaultGravity = game.Workspace.Gravity
local Gravity = _G.TimGui.Add.TB("Gravity","Gravity:","Map",12,"Гравитация:")
_G.TimGui.Add.B("SetGravity","Set Gravity","Map",13,"Установить гравитацию",function()
    game.Workspace.Gravity = Gravity.Text
end)

_G.TimGui.Add.B("SetDefaultGravity","Set default gravity","Map",14,"Установить гравитацию по умолчанию",function()
    game.Workspace.Gravity = DefaultGravity
end)

local FPDH = game.Workspace.FallenPartsDestroyHeight
_G.TimGui.Add.CB("NoDownDestroying","No kill out map","Map",15,"Не убивать под картой",function(val)
    if val.Value then
        game.Workspace.FallenPartsDestroyHeight = -50000
    else
        game.Workspace.FallenPartsDestroyHeight = FPDH
    end
end)

local SpeedOfSpin = _G.TimGui.Add.TB("SpeedOfSpin","Speed of spin:","Map",16,"Скорость кружения выбранного:")
_G.TimGui.Add.CB("SpinSelectedAngularYou","SpinSelectedAngularYou","Map",17,"Крутить выбранное вокруг тебя",function(val)
    if val.Value then
        obj.Massless = true
        local oldPos = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame
        wait(0.1)
        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = oldPos
        while task.wait() and val.Value do
            obj.AssemblyLinearVelocity = game.Players.LocalPlayer.Character.PrimaryPart.Position - obj.Position + Vector3.new(0,2.5,0)
            wait()
            obj.AssemblyAngularVelocity = Vector3.new(tonumber(SpeedOfSpin.Text),tonumber(SpeedOfSpin.Text),tonumber(SpeedOfSpin.Text))
        end
    end
end)

_G.TimGui.Add.CB("NoCollideForSelected","No Collide For Selected","Map",18,"Убрать коллизию выбранному",function(val)
    obj.CanCollide = not val.Value
end)

_G.TimGui.Add.CB("NoTouchForSelected","No Touch For Selected","Map",19,"Убрать косания выбранному",function(val)
    obj.CanTouch = not val.Value
end)

_G.TimGui.Add.G("FUN","ВЕСЕЛЬЕ")

_G.TimGui.Add.CB("CreatePing","Pinged Movement","FUN",1,"Пингованное перемещение",function(val)
    if val.Value then
        game.Workspace.FallenPartsDestroyHeight = 50000
    else
        game.Workspace.FallenPartsDestroyHeight = FPDH
    end
end)

_G.TimGui.Add.CB("Fling","Funny fling","FUN",2,"Арабская ночь",function(val)
    if val.Value then
        game.Workspace.Gravity = 0
        while task.wait() and val.Value do
            if not game.Players.LocalPlayer.Character then continue end
            game.Players.LocalPlayer.Character.PrimaryPart.AssemblyAngularVelocity = Vector3.new(0,500,0)
        end
    else
        game.Workspace.Gravity = DefaultGravity
    end
end)

if not game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then return end
_G.TimGui.Add.G("Chat","Чат")
local function Send(Message)
    local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
    Event:FireServer(Message, "All")
    --print(Message)
end

local Spaces = "                                                                                                                                              {System}: "

local SpaceEn = _G.TimGui.Add.CB("EnableSpaces","Enable {System}","Chat",1,"Включить {System}")
local PlEn = _G.TimGui.Add.CB("LeftOrJoin","Enable Player Join/left","Chat",2,"Включить Player Join/left")
local DeadMes = _G.TimGui.Add.CB("PlDeadMessage","Enable Player is dead.","Chat",3,"Включить Player is dead")

local function Char(player)
    player.CharacterRemoving:Connect(function()
        wait()
        if player.Parent and DeadMes.Value then
            if SpaceEn.Value then
                Send(Spaces .. player.Name .. " is dead.")
            else
                Send(child.Name .. " is dead.")
            end
        end
    end)
end

game.Players.PlayerAdded:Connect(function(child)
    if PlEn.Value then
        if SpaceEn.Value then
            Send(Spaces .. child.Name .. " joined in the game.")
        else
            Send(child.Name .. " joined in the game.")
        end
    end
    Char(child)
end)

for k,v in pairs(game.Players:GetPlayers()) do
    Char(v)
end

game.Players.PlayerRemoving:Connect(function(child)
    if PlEn.Value then
        if SpaceEn.Value then
            Send(Spaces .. child.Name .. " out the game.")
        else
            Send(child.Name .. " out the game.")
        end
    end
end)

local messageSp = _G.TimGui.Add.TB("SpamMessage","Message:","Chat",4,"Сообщение:")
_G.TimGui.Add.CB("SpamButton","Spam","Chat",5,"Спам",function(val)
    while val.Value do
        wait()
        Send(messageSp.Text)
    end
end)
