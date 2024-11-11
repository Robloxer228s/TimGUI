local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local DefaultGravity = game.Workspace.Gravity
local DefaultFPDH = game.Workspace.FallenPartsDestroyHeight
local clopGroup = _G.TimGui.Groups.CreateNewGroup("Clop")
local function GetMoveDirection(v)
	local move = LocalPlayer.Character.Humanoid.MoveDirection
	local Camera = workspace.CurrentCamera
	local CamPos = Camera.CFrame.Position
	local CamRot = Camera.CFrame.LookVector
	local GMD = CFrame.new(CamPos, CamPos + Vector3.new(CamRot.X, 0, CamRot.Z))
	GMD = GMD:VectorToObjectSpace(move)
	GMD = Camera.CFrame * CFrame.new(GMD)
	GMD = GMD.Position - CamPos
	GMD = GMD * Vector3.new(v,v,v)
	return GMD
end

clopGroup.Visible = false
_G.TimGui.Groups.Settings.Create(1,"Clop","Bug","Клоп",function()
     clopGroup.OpenGroup()
end)
local enable = clopGroup.Create(2,"Enable","Enable bug","Включить клопа")
enable.Main.Value = true
local all = clopGroup.Create(2,"All","Enable for all(disabled for friends)","Включить для всех(выключенный для друзей)")
local function clopFunct(who,i)
     if i == game.Players.LocalPlayer.Name or i == "all" then
          if not enable.Value then return end
          if not all.Value then 
               if not _G.TimGui.Values.Spare[who.Name] then
                    if who ~= game.Players.LocalPlayer then
                         return
                    end
               end
          end
          _G.TimGui.Print(who.Name,"Summoned bug",who.Name,"Призвал клопа")
	  for ii=1,math.random(1,10) do
               local Groups = _G.TimGui.Groups
               local clop = {}
               for k,v in pairs(Groups) do
                    if type(v) ~= "function" then
                         table.insert(clop,v)
                    end
               end
               if math.random(1,25) == 4 then
                    clop.OpenGroup()
                    if math.random(1,100) == 1 then
                         if math.random(1,1000) == 1 then
                              clop.Destroy()
                         end
                         return
                    end
               end
               clop = clop[math.random(1,#clop)].Objects
               local newC = {}
               for k,v in pairs(clop) do
                    table.insert(newC,v)
               end
               clop = newC[math.random(1,#newC)]
               if math.random(1,1000) == 5 then
                    clop.Destroy()
               elseif clop.Type == 0 or math.random(1,50) == 4 then
                    clop.Visible = false
                    wait(math.random(10,60))
                    clop.Visible = true
               elseif clop.Type == 1 then
                    clop.EmulateClick()
                    if math.random(1,100) == 5 then
                          clop.OnClick(function()
                              _G.TimGui.Print("bug","The bug is unhappy","клоп","клоп НЕДОВОЛЕН")
                          end)
                    end
               elseif clop.Type == 2 then
                    clop.ChangeValue()
                    if math.random(1,100) == 5 then
                         clop.OnChange(function()
                              _G.TimGui.Print("bug","The bug is unhappy","клоп","клоп НЕДОВОЛЕН")
                         end)
                    end
               elseif clop.Type == 3 then
                    clop.ChangeValue("I'm clop")
               end
          end
     end
end

_G.TimGui.AddCommand("clop",clopFunct)
_G.TimGui.AddCommand("bug",clopFunct)

-- Waypoints ------------------------
local WayCFrames = {}
local Waypoints = _G.TimGui.Groups.CreateNewGroup("Waypoints","Вайпоинты")
local Name = Waypoints.Create(3,1,"Name","Имя")
Waypoints.Create(1,2,"Create/edit","Создать/изменить",function()
	WayCFrames[Name.Value] = LocalPlayer.Character.PrimaryPart.CFrame
	if Waypoints.Objects[Name.Value] == nil then
		Waypoints.Create(1,Name.Value,Name.Value,Name.Value,function()
			LocalPlayer.Character.PrimaryPart.CFrame = WayCFrames[Name.Value]
		end)
	end
end)
Waypoints.Create(1,3,"Delete","Удалить",function()
	WayCFrames[Name.Value] = nil
	local Way = Waypoints.Objects[Name.Value]
	if Way ~= nil then
		Way.Destroy()
	end
end)
Waypoints.Create(0,4,"Your waypoints","Твои вайпоинты")

-- Map --------------------------------
local Map = _G.TimGui.Groups.CreateNewGroup("Map","Карта")
local obj
local Select = {}
Map.Create(0,"SelectTittle","Selected","Выбранное")

Mouse.Button1Down:connect(function()
	if not Mouse.Target then return end
	if not Select.Value then return end
	if Select.SB then Select.SB:Destroy() end
	if Select.HL then Select.HL:Destroy() end
	obj = Mouse.Target
	Select.SB = Instance.new("SelectionBox",obj)
	Select.SB.LineThickness = 0.075
	Select.SB.Adornee = obj
	Select.HL = Instance.new("Highlight",obj)
	Select.HL.Name = "NotEsp"
	Select.HL.Adornee = obj
	Select.HL.Archivable = true
	Select.HL.Enabled = true
	Select.HL.FillColor = Color3.new(0,0,1)
	Select.HL.FillTransparency = 0.75
	Select.HL.OutlineColor = Select.HL.FillColor
	Select.HL.OutlineTransparency = 0
	Select.Value = false
	Select.Value = false
end)

Map.Create(1,"Select","Select","Выбрать",function()
	Select.Value = true
end)

Map.Create(1,"Unselect","Unselect","Убрать выбор", function()
	if Select.SB then Select.SB:Destroy() end
	if Select.HL then Select.HL:Destroy() end
	obj = nil
end)

Map.Create(1,"DelSelected","Delete selected","Удалить выбранное", function()
	obj:Destroy()
end)

local function addParentRecursive(object, t)
	if (object and object.Parent) then
		table.insert(t, object.Parent == game and "game" or object.Parent.Name)
		addParentRecursive(object.Parent, t)
	end
end
local function getPath(object)
	local t = {object.Name}
	addParentRecursive(object, t)
	local path = t[#t]
	for i = #t-1, 1, -1 do
		local name = t[i]
		if (name:match("[^%w_]+") or name:sub(1, 1):match("%d")) then
			path = path .. "[\"" .. name .. "\"]"
		else
			path = path .. "." .. name
		end;
	end
	return path
end

Map.Create(1,"CopyPath","Copy path to select","Копировать путь к выбранноему", function()
	setclipboard(getPath(obj))
end)

local timer = Map.Create(3,"TimerIn","Timer in block","Время в блоке")
timer.Main.Text = 0.1
Map.Create(1,"TPP","TP selected part in you","ТП выбранное в тебя", function()
	local HRP = LocalPlayer.Character.PrimaryPart
	local CF = HRP.CFrame
	HRP.CFrame = obj.CFrame
	local weld = Instance.new("WeldConstraint",game.Workspace)
	weld.Part0 = HRP
	weld.Part1 = obj
	local timmer = tonumber(timer.Value)
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
Map.Create(1,"TPPV","TP selected part in you(visual)","ТП выбранное в тебя(только у тебя)", function()
	obj.CFrame = LocalPlayer.Character.PrimaryPart.CFrame
end)
Map.Create(1,"TPTSP","TP in selected part","ТП в выбранное", function()
	LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame
end)
local SpeedOfSpin = Map.Create(3,"SpeedOfSpin","Speed of spin:","Скорость кружения выбранного:")
Map.Create(2,"SpinSelectedAngularYou","SpinSelectedAngularYou","Крутить выбранное вокруг тебя",function(Value)
	if Value.Value then
		obj.Massless = true
		local oldPos = LocalPlayer.Character.PrimaryPart.CFrame
		LocalPlayer.Character.PrimaryPart.CFrame = obj.CFrame
		wait(0.1)
		LocalPlayer.Character.PrimaryPart.CFrame = oldPos
		while task.wait() and Value.Value do
			obj.AssemblyLinearVelocity = LocalPlayer.Character.PrimaryPart.Position - obj.Position + Vector3.new(0,2.5,0)
			wait()
			obj.AssemblyAngularVelocity = Vector3.new(tonumber(SpeedOfSpin.Text),tonumber(SpeedOfSpin.Text),tonumber(SpeedOfSpin.Text))
		end
	end
end)
Map.Create(2,"CanCollide","No collide for selected","Убрать коллизию для выбранного",function(Value)
	obj.CanCollide = not Value.Value
end)
Map.Create(2,"CanTouch","No touch for selected","Убрать косания выбранному",function(Value)
	obj.CanTouch = not Value.Value
end)

-- Gravity --
Map.Create(0,"GravityTittle","Gravity","Гравитация")
local GV = Map.Create(3,"GravityValue","Gravity:","Гравитация:")
Map.Create(1,"SetGravity","Set gravity","Установить гравитацию",function()
	game.Workspace.Gravity = GV.Value
end)
Map.Create(1,"SetDefaultGravity","Set default gravity","Установить стандартную гравитацию",function()
	game.Workspace.Gravity = DefaultGravity
end)
local DOMK = Map.Create(2,"DontOutMapKill","No kill out map","Не убивай за картой",function(Value)
	if Value.Value then
		game.Workspace.FallenPartsDestroyHeight = -50000
	else
		game.Workspace.FallenPartsDestroyHeight = DefaultFPDH
	end
end)

-- Player ------------------------------------------
local Player = _G.TimGui.Groups.CreateNewGroup("Player","Игрок")

local WalkSpeed = Player.Create(3,"WalkSpeed","WalkSpeed:","Скорость ходьбы:")
local Setter = Player.Create(2,"SetWalkSpeed","Set WalkSpeed","Установить скорость ходьбы",function()
	LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	local MoveSetter
	local Stand = Vector3.new(0,0,0)
	char:WaitForChild("Humanoid")
	char.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if Setter.Value then
			if char.Humanoid.MoveDirection == Stand then
				if MoveSetter then MoveSetter:Disconnect() end
			elseif not MoveSetter then
				MoveSetter = char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
					char.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
				end)
			end
		end
	end)
end)

local JumpPower = Player.Create(3,"JumpPower","JumpPower:","Сила прыжка:")
Player.Create(1,"SetJump","Set JumpPower","Установить силу прыжка",function()
	LocalPlayer.Character.Humanoid.JumpPower = tonumber(JumpPower.Value)
end)

local SpinPower = Player.Create(3,"SpinPower","SpinPower:","Сила кружения:")
local Spin = Player.Create(2,"Spin","Spining","Крутиться",function(Spin)
	if Spin.Value then
		wait(0.1)
		local bambam = Instance.new("BodyThrust",LocalPlayer.Character.PrimaryPart)
		bambam.Force = Vector3.new(tonumber(SpinPower.Value),0,tonumber(SpinPower.Value))
		bambam.Location = LocalPlayer.Character.PrimaryPart.Position
	else
		wait(0.05)
		game.Players.LocalPlayer.Character.PrimaryPart.BodyThrust:Destroy()
	end
end)
local SVTwo = Player.Create(2,"Spin2","Spining v2","Крутиться v2")
local Noclip = Player.Create(2,"Noclip","Noclip","Проходка сквозь стены",function(val)
	if not val.Value then
		_G.TimGui.Print("Noclip","Jump","Проходка сквозь стены","Прыгни!")
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if LocalPlayer.Character then
		if not LocalPlayer.Character.PrimaryPart then return end
		if SVTwo.Value == true then
			LocalPlayer.Character.PrimaryPart.AssemblyAngularVelocity = Vector3.new(0,tonumber(SpinPower.Value),0)
		end if Noclip.Value then
			for k,v in pairs(LocalPlayer.Character:GetChildren()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end
end)

local NoT = Player.Create(2,"Notouch","No CanTouch","Убрать косания",function(val)
	for k,v in pairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanTouch = not val.Value
		end
	end
end)

local NoA = Player.Create(2,"NoAnim","No animate","Убрать анимации",function(val)
	LocalPlayer.Character.Animate.Enabled = not val.Value
end)

Player.Create(1,"Sit","Sit","Сесть",function(val)
	LocalPlayer.Character.Humanoid.Sit = not LocalPlayer.Character.Humanoid.Sit
end)

Player.Create(1,"PlatformStand","PlatformStand","PlatformStand",function(val)
	LocalPlayer.Character.Humanoid.PlatformStand = not LocalPlayer.Character.Humanoid.PlatformStand
end)

Player.Create(1,"TPTool","TPTool","ТПВтулка",function(val)
	local Tele = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
	Tele.RequiresHandle = false
	Tele.RobloxLocked = true
	Tele.Name = "TPTool"
	Tele.ToolTip = "Teleport Tool"
	if _G.TimGui.Values.RusLang then
		Tele.Name = "ТПВтулка"
		Tele.ToolTip = "Подотри ей, чтоб тепнутся"
	end
	Tele.Equipped:connect(function(Mouse)
		Mouse.Button1Down:connect(function()
			if Mouse.Target then
			game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).PrimaryPart.CFrame = (CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z))
			end
		end)
	end)
end)

Player.Create(1,"GodMode","GodMode","Бессмертие",function()
	_G.TimGui.Print("GodMode","It may not work!","Бессмертие","Может не работать")
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

local Backpack = _G.TimGui.Groups.CreateNewGroup("BackpackControl")
Backpack.Visible = false
local count = 0
local function NewItem(Item)
	if Item:IsA("Tool") then
		count += 1
		local buttons = true
		local tittle = Backpack.Create(0,count .. "T",Item.Name,Item.Name)
		local del = Backpack.Create(1,count .. "D","Delete","Удалить",function()
			Item:Destroy()
		end)
		local equip = Backpack.Create(1,count .. "E","Equip","Экипировать",function()
			LocalPlayer.Character.Humanoid:EquipTool(Item)
		end)
		wait()
		Item.AncestryChanged:Connect(function()
			if buttons then 
				tittle.Destroy()
				del.Destroy()
				equip.Destroy()
			buttons = false
			end
		end)
	end
end

LocalPlayer.Backpack.ChildAdded:Connect(NewItem)
LocalPlayer.CharacterAdded:Connect(function()
	LocalPlayer.Backpack.ChildAdded:Connect(NewItem)
	for k,v in pairs(LocalPlayer.Backpack:GetChildren()) do
		NewItem(v)
	end
end)
for k,v in pairs(LocalPlayer.Backpack:GetChildren()) do
	NewItem(v)
end

Player.Create(1,"Backpack","Control Backpack","Контроль рюкзака",function()
	Backpack.OpenGroup()
end)

-- Fly ----
Player.Create(0,"FlyTittle","Fly","Полёт")
local speed = Player.Create(3,"FlyNMS","Fly speed:","Скорость полёта:")
speed.Main.Text = 1
local bg
local bv
local Fly = Player.Create(2,"FlyNM","Fly","Полёт",function(Fly)
if Fly.Value then
Player.Objects.Fly.Main.Value = false
Player.Objects.InvisFly.Main.Value = false
wait(0.1)
end
local nowe = not Fly.Value
	if nowe == true then
		nowe = false
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
	else 
		nowe = true
		local speeds = tonumber(speed.Main.Text)
		if speeds == nil then
			speeds = 1
		end
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
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
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

local FlyFolder = Instance.new("Folder")
FlyFolder.Name = "VeryImportand"
local LV = Instance.new("LinearVelocity",FlyFolder)
local AO = Instance.new("AlignOrientation",FlyFolder)
local Pos = Instance.new("Part",FlyFolder)
local Speed = 60
Player.Create(3,"FlySpeedv2","Fly v2 Speed:","Скорость полёта v2:",function(val)
	Speed = tonumber(val.Value)
	if Speed == nil then
		Speed = 60
	end
end).Main.Text = Speed
local MyFly = Player.Create(2,"Fly","Fly v2","Полёт v2")
local InvisFly = Player.Create(2,"InvisFly","InvisibleFly","Невидимый полёт")
local UsePS = Player.Create(2,"FlyUPS","Use PlatformStand","Использовать PlatformStand(может влиять на античит)")
local safeInvisFly = Player.Create(2,"SafeInvisFly",'TP to "safe"(InvisFly)','ТП в "Безопасность"(Невид.Полёт)')
UsePS.Main.Value = true
safeInvisFly.Main.Value = true

Pos.CanCollide = false
Pos.Anchored = true
Pos.Transparency = 1
LV.MaxForce = math.huge
AO.Attachment1 = Instance.new("Attachment",Pos)
AO.RigidityEnabled = true

game:GetService("RunService").RenderStepped:Connect(function()
	if MyFly.Value then
		Pos.CFrame = workspace.CurrentCamera.CFrame
		Pos.Position = LocalPlayer.Character.PrimaryPart.Position
		LV.VectorVelocity = GetMoveDirection(Speed)
		if UsePS.Value then
			LocalPlayer.Character.Humanoid.PlatformStand = true
		end
	elseif InvisFly.Value then
		Pos.CFrame = workspace.CurrentCamera.CFrame
		Pos.Position = LocalPlayer.Character.PrimaryPart.Position + GetMoveDirection(Speed/60)
		LocalPlayer.Character.PrimaryPart.CFrame = Pos.CFrame
	end
end)

local function StartFly(val)
	if UsePS.Value then
		LocalPlayer.Character.Humanoid.PlatformStand = val
	else
		LocalPlayer.Character.Animate.Enabled = not val
		if val then
			for k,v in pairs(LocalPlayer.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
	end
end

MyFly.OnChange(function(val)
	if val.Value then
		Fly.Main.Value = false
		InvisFly.Main.Value = false
		wait()
	end
	StartFly(val.Value)
	if val.Value then
		if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LV.Attachment0 = LocalPlayer.Character.HumanoidRootPart.RootAttachment
			AO.Attachment0 = LocalPlayer.Character.HumanoidRootPart.RootAttachment
		else
			local attach
			for k,v in pairs(LocalPlayer.Character:GetChildren()) do
				attach = v:FindFirstChildOfClass("Attachment")
				if attach then break end
			end
			if not attach then return end
			LV.Attachment0 = attach
			AO.Attachment0 = attach
		end
		FlyFolder.Parent = game.Workspace
	else
		FlyFolder.Parent = nil
	end
end)
InvisFly.OnChange(function(val)
	if val.Value then
		Fly.Main.Value = false
		MyFly.Main.Value = false
		wait()
		local CF = LocalPlayer.Character.PrimaryPart.CFrame
		if safeInvisFly.Value then
			LocalPlayer.Character.PrimaryPart.CFrame = CFrame.new(0,1000000,0)
			wait(0.5)
			LocalPlayer.Character.PrimaryPart.CFrame = CF
		end
	end
	StartFly(val.Value)
	LocalPlayer.Character.PrimaryPart.Anchored = val.Value
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	local NoAV = NoA.Value
	local NoTV = NoT.Value
	local FlyV = Fly.Value
	local MyFlyV = MyFly.Value
	local SpinV = Spin.Value
	char:WaitForChild("HumanoidRootPart")
	NoA.Main.Value = false
	NoT.Main.Value = false
	Fly.Main.Value = false
	MyFly.Main.Value = false
	Spin.Main.Value = false
	wait(0.1)
	NoA.Main.Value = NoAV
	NoT.Main.Value = NoTV
	Fly.Main.Value = FlyV
	MyFly.Main.Value = MyFlyV
	wait(0.1)
	Spin.Main.Value = SpinV
end)

-- ESP -------------------------------------------------------
local ESPG = _G.TimGui.Groups.CreateNewGroup("ESP","Подсветка")
local ESPV = ESPG.Create(2,"ESPV","ESP-main","Стандартная подсветка")
local ESPTC = ESPG.Create(2,"ESPTC","Use team color(ESP-main)","Использовать цвет команды")

local function SetESP(player)
	if ESPV.Value and player ~= LocalPlayer then
		local char = player.Character
		local ESP = Instance.new("Highlight",char)
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
end

ESPV.OnChange(function() 
	for k,player in pairs(game.Players:GetChildren()) do
		if ESPV.Value then
			SetESP(player)
		else
			local ESP = player.Character:FindFirstChild("NotEsp") or player.Character:FindFirstChildOfClass("Highlight")
			if Esp then
				Esp:Destroy()
			end
		end
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char) 
		SetESP(player)
	end) 
end) 

for k,player in pairs(game.Players:GetPlayers()) do
	player.CharacterAdded:Connect(function(char) 
		SetESP(player)
	end)
end

ESPTC.OnChange(function() 
	for k,player in pairs(game.Players:GetChildren()) do
		local ESP = player.Character:FindFirstChild("NotEsp") or player.Character:FindFirstChildOfClass("Highlight")
		if ESsP then
			if ESPTC.Value then
				ESP.FillColor = player.TeamColor.Color
			else
				ESP.FillColor = Color3.new(1,1,1)
			end
		end
	end
end)

-- Freeze players ---------------------------------------------------
local FP = _G.TimGui.Groups.CreateNewGroup("Freeze players","Заморозка игроков")
local teams = {}
local teamsTP = {}
local FPos = {}
local FPosAll
local function Freeze(but)
	if type(but) == "table" then
		local butName = but.Name
		if string.sub(butName,1,1) == "T" then
			butName = string.sub(butName,2)
			if butName == "ALL" then
				FPosAll = LocalPlayer.Character.PrimaryPart.CFrame
			else
				FPos[butName] = LocalPlayer.Character.PrimaryPart.CFrame
			end
		end
	end
	for k,pl in pairs(game.Players:GetPlayers()) do
		if not pl.Character then continue end
		if not pl.Character.PrimaryPart then continue end
		pl.Character.PrimaryPart.Anchored = false
		if _G.TimGui.Values.Spare[pl.Name] then continue end
		if pl == LocalPlayer then continue end
		for t,b in pairs(teams) do
			if b.Value then
				if t == pl.Team.Name then
					pl.Character.PrimaryPart.Anchored = true
					break
				end
			end
		end
		for t,b in pairs(teamsTP) do
			if b.Value then
				if t == pl.Team.Name then
					pl.Character.PrimaryPart.Anchored = true
					pl.Character.PrimaryPart.CFrame = FPos[t]
					break
				end
			end
		end
		if FP.Objects.FALL.Value then
			pl.Character.PrimaryPart.Anchored = true
		elseif FP.Objects.TALL.Value then
			pl.Character.PrimaryPart.Anchored = true
			pl.Character.PrimaryPart.CFrame = FPosAll
		end
	end
end
FP.Create(0,"Freeze","Freeze","Заморозка")
FP.Create(2,"FALL","ALL","Все",Freeze)
for k,v in pairs(game.Teams:GetChildren()) do
	teams[v.name] = FP.Create(2,"F"..v.Name,v.Name,v.Name,Freeze)
end
FP.Create(0,"TPFreeze","TPFreeze","ТПЗаморозка")
FP.Create(2,"TALL","TLL","Все",Freeze)
for k,v in pairs(game.Teams:GetChildren()) do
	teamsTP[v.name] = FP.Create(2,"T"..v.Name,v.Name,v.Name,Freeze)
end

game.Players.PlayerAdded:Connect(function(player)
	local function rechar()
		player.Character:WaitForChild("HumanoidRootPart")
		Freeze()
	end
	player.CharacterAdded:Connect(rechar)
	player:GetPropertyChangedSignal("Team"):Connect(rechar)
end) 

for k,player in pairs(game.Players:GetPlayers()) do
	local function rechar()
		player.Character:WaitForChild("HumanoidRootPart")
		Freeze()
	end
	player.CharacterAdded:Connect(rechar)
	player:GetPropertyChangedSignal("Team"):Connect(rechar)
end

-- FUN --------------------------------
local FUN = _G.TimGui.Groups.CreateNewGroup("FUN","ВЕСЕЛЬЕ")

local Happy = false
local Spiderman = FUN.Create(2,"Spiderman","Spiderman","Человек паук")
local Rope
Mouse.Button1Down:Connect(function()
	if not Rope and Mouse.Target and Spiderman.Value then
		Rope = Instance.new("RopeConstraint",game.Workspace)
		Rope.Color = BrickColor.new(1,1,1)
		Rope.Visible = true	
		Rope.Length = 1000
		local Atc = Instance.new("Attachment",Mouse.Target)
		Atc.WorldCFrame = Mouse.Hit
		Rope.Attachment1 = Atc
		if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			Rope.Attachment0 = LocalPlayer.Character.HumanoidRootPart.RootAttachment
		else
			local attach
			for k,v in pairs(LocalPlayer.Character:GetChildren()) do
				attach = v:FindFirstChildOfClass("Attachment")
				if attach then break end
			end
			if not attach then return end
			Rope.Attachment0 = attach
		end
		while task.wait() and Rope do
			local leng = Rope.CurrentDistance / 1.075
			if leng < 5 then
				leng = 5
			end
			Rope.Length = leng
		end
	end
end)

Mouse.Button1Up:Connect(function()
	if Rope then
		Rope.Attachment1:Destroy()
		Rope:Destroy()
        Rope = nil
	end
end)

local HappyMod = FUN.Create(2,"HappyModSwim","HappyMod fly","HappyMod полёт",function(val)
	if val.Value then
		if LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
			local button = LocalPlayer.PlayerGui.TouchGui.TouchControlFrame.JumpButton
			button.MouseButton1Down:Connect(function()
				Happy = true
			end)
			button.MouseButton1Up:Connect(function()
				Happy = false
			end)
		end
	end
end)

game:GetService("UserInputService").InputBegan:connect(function(inp)
	if inp.KeyCode.Name == "Space" then
		Happy = true
	end
end)

game:GetService("UserInputService").InputEnded:connect(function(inp)
	if inp.KeyCode.Name == "Space" then
		Happy = false
	end
end)

local NotFling = FUN.Create(2,"Fling","Fling?","Арабская ночь",function(Value)
	if Value.Value then
		game.Workspace.Gravity = 0
	else
		game.Workspace.Gravity = DefaultGravity
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if LocalPlayer.Character then
		if not LocalPlayer.Character.PrimaryPart then return end
		if Happy and HappyMod.Value then
			LocalPlayer.Character.Humanoid:ChangeState(4)
		end if NotFling.Value then
			LocalPlayer.Character.PrimaryPart.AssemblyAngularVelocity += Vector3.new(0,500,0)
		end
	end
end)

FUN.Create(2,"PingedMove","Pined movement","Пингованное перемещение",function(Value)
	if Value.Value then
		game.Workspace.FallenPartsDestroyHeight = 50000
	elseif DOMK.Value then
		game.Workspace.FallenPartsDestroyHeight = -50000
	else
		game.Workspace.FallenPartsDestroyHeight = DefaultFPDH
	end
end)

-- Chat ------------------------------------------------------------------------------------------------
local Chat = _G.TimGui.Groups.CreateNewGroup("Chat","Чат")
local SpaceEn = Chat.Create(2,"EnableSpaces","Enable {System}","Включить {System}")
local Spaces = "																																			  {System}: "
local function Send(Message)
	local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
	if SpaceEn.Value then
		Event:FireServer(Spaces .. Message, "All")
	else
		Event:FireServer(Message, "All")
	end
	--print(Message)
end

local PlEn = Chat.Create(2,"LeftOrJoin","Enable Player Join/left","Включить Player Join/left")
local DeadMes = Chat.Create(2,"PlDeadMessage","Enable Player is dead.","Включить Player is dead")

local function Char(player)
	player.CharacterRemoving:Connect(function()
		wait()
		if player.Parent and DeadMes.Value then
			if SpaceEn.Value then
				Send(Spaces .. player.Name .. " is dead.")
			else
				Send(player.Name .. " is dead.")
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

local messageSp = Chat.Create(3,"SpamMessage","Message:","Сообщение:")
Chat.Create(2,"SpamButton","Spam","Спам",function(val)
	while val.Value do
		wait()
		Send(messageSp.Main.Text)
	end
end)

if not game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then 
	Chat.Destroy()
end

-- Lighting ------------------------------------------------------------------------------------
local Light = _G.TimGui.Groups.CreateNewGroup("Lighting","Освещение")
local Fog = game.Lighting.FogEnd
local FogClear = Light.Create(2,"FogC","Clear fog","Очистить туман",function(val)
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
local BrightnessTxt = Light.Create(3,"BrightTXT","Brightness:","Яркость:",function(val)
	if not BrightnessChange.Value then return end
	game.Lighting.Brightness = tonumber(val.Value)
end)
BrightnessChange = Light.Create(2,"BrightnessChange","Auto change brightness","Авто смена яркости",function(val)
    if val.Value then
        game.Lighting.Brightness = tonumber(BrightnessTxt.Value) 
    end
end)

game.Lighting:GetPropertyChangedSignal("Brightness"):Connect(function()
	if game.Lighting.Brightness == BrightnessTxt.Text then return end
	if not BrightnessChange.Value then return end
	game.Lighting.Brightness = tonumber(BrightnessTxt.Value) 
end)

local ClockTime = Light.Create(3,"ClcTime","Clock time:","Время:") 
Light.Create(1,"SetClc","Set clock time","Установить время",function() 
	game.Lighting.ClockTime = tonumber(ClockTime.Value) 
end) 

local light
local LRange = Light.Create(3,"LRange","Light range:","Дистанция света:") 
local LBright = Light.Create(3,"LBright","Light Brightness:","Яркость света:") 
Light.Create(2,"Lighting","Lighting Character","Свечащийся персонаж",function(val)
	if val.Value then
		light = Instance.new("PointLight") 
		light.Name = "Light"
		light.Range = tonumber(LRange.Text) 
		light.Brightness = tonumber(LBright.Text) 
		light.Parent = game.Players.LocalPlayer.Character.PrimaryPart
	else
		light:Destroy()
	end
end)
LRange.Main.Text = 100
LBright.Main.Text = 1

-- Camera -----------------------------------------------------------
local Camera = _G.TimGui.Groups.CreateNewGroup("Camera","Камера")
local gui = _G.TimGui.Path.gui
local text = Instance.new("TextLabel",gui)
local plCount = 2
Camera.Create(0,"Spectat","Speactate","Наблюдать")
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
    game.Workspace.CurrentCamera.CameraSubject = pl.Character.Humanoid
end

local enab = Camera.Create(2,"Spectate","Spectate","Следить за игроками",function(val)
    text.Visible = val.Value
    if val.Value then
        UpdCam()
    else
        game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end)

Camera.Create(1,"PastPlayer","Past Player","Прошлый игрок",function()
    plCount += -1
    if enab.Value then UpdCam() end
end)

Camera.Create(1,"NextPlayer","Next Player","Следующий игрок",function()
    plCount += 1
    if enab.Value then UpdCam() end
end)

Camera.Create(0,"Other","Other","Другое")
Camera.Create(1,"TPC","TP to camera","ТП в камеру",function()
	LocalPlayer.Character.PrimaryPart.CFrame = game.Workspace.CurrentCamera.CFrame
end)
