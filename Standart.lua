local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local AnticheatGroup = _G.TimGui.Groups.CreateNewGroup("ACGroup")
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
AnticheatGroup.Visible = false
clopGroup.Visible = false
_G.TimGui.Groups.Settings.Create(1,"Clop","Bug","Клоп",function()
     clopGroup.OpenGroup()
end)
_G.TimGui.Groups.Settings.Create(1,"Anticheat","Anticheat","Античит",function()
     AnticheatGroup.OpenGroup()
end)
local enable = clopGroup.Create(2,"Enable","Enable bug","Включить клопа")
enable.Main.Value = true
local all = clopGroup.Create(2,"All","Enable for all(disabled for friends)","Включить для всех(выключенный для друзей)")
all.CFGSave = true
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
local LocalPlayer = game.Players.LocalPlayer

local WayCFrames = {}
local Waypoints = _G.TimGui.Groups.CreateNewGroup("Waypoints 9","Вайпоинты")
local Name = Waypoints.Create(3,1,"Name","Имя")
local pathWay = "TimGui/Waypoints/"
if _G.TimGui.Saves.Enabled then makefolder(pathWay) end
local function CreateWaypoint(wayname,position)
    WayCFrames[wayname] = position
	if Waypoints.Objects[wayname] == nil then
		Waypoints.Create(1,wayname,wayname,wayname,function()
			LocalPlayer.Character.PrimaryPart.CFrame = WayCFrames[wayname]
		end)
	end
end
Waypoints.Create(1,3,"Create/edit","Создать/изменить",function()
	CreateWaypoint(Name.Value,LocalPlayer.Character.PrimaryPart.CFrame)
end)
Waypoints.Create(1,4,"Delete","Удалить",function()
	WayCFrames[Name.Value] = nil
	local Way = Waypoints.Objects[Name.Value]
	if Way ~= nil then
		Way.Destroy()
	end
end)
Waypoints.Create(1,2,"Save for this game","Сохранить для этой игры",function()
	local SaveTab = {}
    local saving = false
    for k,v in pairs(WayCFrames) do
        saving = true
        SaveTab[k] = string.split(tostring(v),", ")
    end
    if saving then
        writefile(pathWay,game.HttpService:JSONEncode(SaveTab))
    else
        delfile(pathWay)
    end
    _G.TimGui.Print("Waypoints","Saved","Вайпоинты","Сохранено")
end).Visible = _G.TimGui.Saves.Enabled
Waypoints.Create(0,5,"Your waypoints","Твои вайпоинты")
if _G.TimGui.Saves.Enabled then
    local checker = pathWay..game.GameId
    local finded = false
    for k,v in pairs(listfiles(pathWay)) do
        if v == checker then
            finded = true
            break
        end
    end
    pathWay = checker
    if finded then
        local loadWaypoints = game.HttpService:JSONDecode(readfile(pathWay)) or {}
        for k,v in pairs(loadWaypoints) do
            CreateWaypoint(k,CFrame.new(table.unpack(v)))
        end
    end
end
-- Map --------------------------------
AnticheatGroup.Create(0,"Map","Map","Карта")
local Map = _G.TimGui.Groups.CreateNewGroup("Map","Карта")
local obj
local Select = {}
Map.Create(0,"SelectTittle","Selected","Выбранное")
local AlightObjectValue
local NoCollide
local NoTouch
local Massless

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
	local AOVV = AlightObjectValue.Value
        local NCV = NoCollide.Value
	local NTV = NoTouch.Value
	local MasslessV = Massless.Value
	AlightObjectValue.Main.Value = false
	NoCollide.Main.Value = false
	NoTouch.Main.Value = false
	Massless.Main.Value = false
	wait()
	AlightObjectValue.Main.Value = AOVV
        NoCollide.Main.Value = NCV
	NoTouch.Main.Value = NTV
	Massless.Main.Value = MasslessV
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
local AlightFolder = Instance.new("Folder")
local AlightPosition = Instance.new("AlignPosition",AlightFolder)
local AlightRotation = Instance.new("AlignOrientation",AlightFolder)
AlightObjectValue = Map.Create(2,"PTM","Pin selected to you","Прикрепить выбранное в тебя")
local ParentAOCam = AnticheatGroup.Create(2,"PTMParentCam","Use parent cam to pin","Использовать камеру для прикрепления")
ParentAOCam.Main.Value = true
ParentAOCam.CFGSave = true

AlightFolder.Name = "VeryImportandFolder"
AlightPosition.MaxForce = math.huge
AlightRotation.MaxTorque = math.huge
AlightRotation.RigidityEnabled = true

Map.Create(1,"PTMF","Pin selected to you(forever)","Прикрепить выбранное в тебя(навсегда)",function()
	local Alight = AlightFolder:Clone()
	local attach
	if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		attach = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("RootAttachment")
		attach = attach or LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("Attachment")
	else
		for k,v in pairs(LocalPlayer.Character:GetChildren()) do
			attach = v:FindFirstChildOfClass("Attachment")
			if attach then break end
		end
		if not attach then attach = Instance.new("Attachment",LocalPlayer.Character.PrimaryPart) end
		if not attach then return end
	end
	local objAttach = Instance.new("Attachment",obj)
	Alight.AlignPosition.Attachment0 = objAttach
	Alight.AlignOrientation.Attachment0 = objAttach
	Alight.AlignPosition.Attachment1 = attach
	Alight.AlignOrientation.Attachment1 = attach
	Alight.Parent = game.Workspace.CurrentCamera
	obj.Destroying:Connect(function()
		Alight:Destroy()
	end)
end)

AlightObjectValue.OnChange(function(val)
	if val.Value then
		local attach
		if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			attach = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("RootAttachment")
			attach = attach or LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("Attachment")
		else
			for k,v in pairs(LocalPlayer.Character:GetChildren()) do
				attach = v:FindFirstChildOfClass("Attachment")
				if attach then break end
			end
			if not attach then attach = Instance.new("Attachment",LocalPlayer.Character.PrimaryPart) end
			if not attach then return end
		end
		local objAttach = Instance.new("Attachment",obj)
		AlightPosition.Attachment0 = objAttach
		AlightRotation.Attachment0 = objAttach
		AlightPosition.Attachment1 = attach
		AlightRotation.Attachment1 = attach
		AlightFolder.Parent = game.Workspace.CurrentCamera
	else
		AlightPosition.Attachment1 = nil
		AlightRotation.Attachment1 = nil
		AlightFolder.Parent = nil
		AlightPosition.Attachment1:Destroy()
	end
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
Massless = Map.Create(2,"Massles","Massless for selected","Убрать вес выбранному",function(Value)
	obj.Massless = Value.Value
end)
NoCollide = Map.Create(2,"CanCollide","No collide for selected","Убрать коллизию для выбранного",function(Value)
	obj.CanCollide = not Value.Value
end)
NoTouch = Map.Create(2,"CanTouch","No touch for selected","Убрать косания выбранному",function(Value)
	obj.CanTouch = not Value.Value
end)

game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	if AlightObjectValue.Value and ParentAOCam.Value then
		AlightFolder.Parent = game.Workspace.CurrentCamera
	end
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
DOMK.CFGSave = true
-- Other --
Map.Create(0,"TittleOther","Other","Другие")
Map.Create(1,"NCFA","No collide for all","Убрать косания каждому",function()
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end)
local ypos
local PartWTA = Instance.new("Part")
local ParentWTACam = AnticheatGroup.Create(2,"WTAarentCam","Use parent cam for walk to air","Использовать камеру для ходьбы по воздуху")
ParentWTACam.Main.Value = true
ParentWTACam.CFGSave = true

PartWTA.Anchored = true
PartWTA.Size = Vector3.new(20,1,20)
PartWTA.Transparency = 1
PartWTA.CanCollide = false
local WTA = Map.Create(2,"Floor","Walk to air","Ходить по воздуху",function(val)
    PartWTA.CanCollide = val.Value
    if val.Value then
	if ParentWTACam.Value then
		PartWTA.Parent = game.Workspace.CurrentCamera
	else
		PartWTA.Parent = game.Workspace
	end
        if not LocalPlayer.Character then
            LocalPlayer.CharacterAdded:Wait()
        end
        local HRPP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        ypos = HRPP.Position.Y-3.5
    else
	PartWTA.Parent = nil
    end
end)
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and WTA.Value then
	PartWTA.CanCollide = true
        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            PartWTA.Position = Vector3.new(HRP.Position.X,ypos,HRP.Position.Z)
        end
    end
end)
-- Player ------------------------------------------
local Player = _G.TimGui.Groups.CreateNewGroup("Player","Игрок")

local WalkSpeed = Player.Create(3,"WalkSpeed","WalkSpeed:","Скорость ходьбы:")
local Setter = Player.Create(2,"SetWalkSpeed","Set WalkSpeed","Установить скорость ходьбы",function()
	LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
end)
local function SetWSNewChar(char)
	local MoveSetter
	local Stand = Vector3.new(0,0,0)
	char:WaitForChild("Humanoid")
	char.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if char.Humanoid.MoveDirection == Stand then
			if MoveSetter then MoveSetter:Disconnect() end
            		MoveSetter = nil
		elseif not MoveSetter and Setter.Value then
			MoveSetter = char.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				if Setter.Value then
                    			char.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
                		end
			end)
			wait()
			char.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
		end
	end)
	while task.wait(0.5) do
		if Setter.Value then
			char.Humanoid.WalkSpeed = tonumber(WalkSpeed.Value)
		end
	end
end
LocalPlayer.CharacterAdded:Connect(SetWSNewChar)
task.spawn(function()
    SetWSNewChar(LocalPlayer.Character)
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

local MultyJump = Player.Create(2,"MultyJump","MultyJump","Прыжок от воздуха")

game:GetService("UserInputService").JumpRequest:Connect(function()
	if MultyJump.Value then
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.None)
		wait()
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local NoCollideForOther = Player.Create(2,"NoCollide","No collide for other players","Проходка сквозь других игроков")
RunService.RenderStepped:connect(function()
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
	end if NoCollideForOther.Value then
        for k,v in pairs(game.Players:GetPlayers()) do
            if v ~= LocalPlayer then
		if v.Character then
	                for _,i in pairs(v.Character:GetChildren()) do
	                    if i:IsA("BasePart") then
	                        i.CanCollide = false
	                    end
	                end
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
local AnimSpeed = Player.Create(3,"AnimSpeed1","Speed for animation:","Скорость анимации:")
local AnimSpeedEnabled = Player.Create(2,"AnimSpeedEnabled1","Enable speed for animation","Включить скорость анимации")
RunService.RenderStepped:Connect(function()
    if AnimSpeedEnabled.Value then
        local char = LocalPlayer.Character
        local animator = char:FindFirstChildOfClass("Humanoid")
        if animator then
            animator = animator:FindFirstChildOfClass("Animator")
            if animator then
                local speed = tonumber(AnimSpeed.Value)
                if speed ~= nil then
                    for _,v in pairs(animator:GetPlayingAnimationTracks()) do
                        v:AdjustSpeed(speed)
                    end
                end
            end
        end
    end
end)
local NoA = Player.Create(2,"NoAnim","No animate","Убрать анимации",function(val)
	LocalPlayer.Character.Animate.Enabled = not val.Value
end)
local countingDash = Instance.new("Part")
Player.Create(1,"Dash","Dash","Рывок",function()
    local HRP = LocalPlayer.Character.HumanoidRootPart
    countingDash.CFrame = HRP.CFrame
    countingDash.Position = Vector3.new(1,1,1)
    HRP.Velocity = (countingDash.CFrame * Vector3.new(0,50,-200))
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
-- WalkFling----
local WFSettings = _G.TimGui.Groups.CreateNewGroup("WFSettings")
local WFChanges = {}
WFSettings.Visible = false
Player.Create(1,"SettingsWF","Settings for walkfling","Настройки для отпуливателя",function() WFSettings.OpenGroup() end)
WFSettings.Create(0,"PowersTittle","Powers for walkfling","Силы для отпуливателя")
local Power = 100000
local function ChangerPWF(val)
    local trues = false
    for _,v in pairs(WFChanges) do
        if val.Value then
            if v ~= val then
                v.Main.Value = false
            end
        end
        if v.Value then
            trues = true
        end
    end
    if not trues then
        WFChanges[1].Main.Value = true
    end
end
WFChanges[1] = WFSettings.Create(2,"DefPower","Default Power","Стандартная сила",function(val)
    if val.Value then
        Power = 100000
    end
    ChangerPWF(val)
end)
WFChanges[2] = WFSettings.Create(2,"MegaWalkFling","Set Mega Power","Поставить супер силу",function(val)
    if val.Value then
        Power = 10000000000000000000000
    end
    ChangerPWF(val)
end)
local PowerValue = WFSettings.Create(3,"PVCustom","Custom(example:100000):","Своя(например:100000):")
WFChanges[3] = WFSettings.Create(2,"CustomSet","Set Custom Power","Поставить Свою силу",function(val)
    if val.Value then
        local CustomPower = tonumber(PowerValue.Value)
        if CustomPower then
            Power = CustomPower
            ChangerPWF(val)
        else
            _G.TimGui.Print("WalkFling","Custom power not a number","ОтпуливателЬ","Твоя сила не число")
            val.Main.Value = false
        end
    else
        ChangerPWF(val)
    end
end)
WFSettings.Create(0,"PositionTittle","Custom position","Своя позиция")
local XWFP = WFSettings.Create(3,"X","X:","X:")
local YWFP = WFSettings.Create(3,"Y","Y:","Y:")
local ZWFP = WFSettings.Create(3,"Z","Z:","Z:")
WFChanges[4] = WFSettings.Create(2,"SetCP","Set Custom Pos","Установить свою позицию",function(val) ChangerPWF(val) end)
WFChanges[1].Main.Value = true
for _,v in pairs(WFChanges) do
	v.CFGSave = true
end
local walkfling = Player.Create(2,"WalkFling","Walkfling","Отпуливатель o_o")
RunService.PostSimulation:Connect(function()
    if walkfling.Value then
        local char = LocalPlayer.Character
        if char then
            local HRP = char.PrimaryPart
            if HRP then
                local velocity = HRP.Velocity
                if not WFChanges[4].Value then
                    HRP.Velocity = (velocity + Vector3.new(0,5,0)) *Power
                else
                    HRP.Velocity = Vector3.new(XWFP.Value,YWFP.Value,ZWFP.Value)
                end
                RunService.RenderStepped:Wait()
                HRP.Velocity = velocity
            end
        end
    end
end)
local InvisiblePlayer = Player.Create(2,"InvisiblePlayer2","Invisible","Невидимость",function(val)
	local char = LocalPlayer.Character
	if char:FindFirstChildOfClass("Humanoid").RigType.Name == "R15" then
        	if val.Value then
	            _G.TimGui.Print("R15","Touch don't work","R15","Косания не работают")
	            char.Archivable = true
	            local newchar = char:Clone()
	            char.PrimaryPart.CFrame = CFrame.new(0,1000000,0)
	            wait(LocalPlayer:GetNetworkPing()+0.25)
	            LocalPlayer.Character = newchar
	            newchar.Parent = char.Parent
	            char.Parent = script
	            newchar:FindFirstChildOfClass("Humanoid").Died:Connect(function()
	                local value = val.Value
	                val.Main.Value = false
	                wait(0.5)
	                val.Main.Value = value
	            end)
        	else
	            local oldChar = script:FindFirstChild(LocalPlayer.Name) or script:FindFirstChildOfClass("Model")
	            if oldChar then
	                local pos = char.PrimaryPart.CFrame
	                oldChar.Parent = char.Parent
	                LocalPlayer.Character = oldChar
	                oldChar.PrimaryPart.CFrame = pos
	                char:Destroy()
	                game.Workspace.CurrentCamera.CameraSubject = oldChar:FindFirstChild("Humanoid")
	                local anim = oldChar:FindFirstChild("Animate")
	                if anim then
	                    anim.Enabled = false
	                    wait()
	                    anim.Enabled = true
	                end
            		else
                		_G.TimGui.Print("visible","Your character not found","Видимость","Твой персонаж не найден")
            end
        end
	else
		if val.Value then
            _G.TimGui.Print("R6","Touch work","R6","Косания работают")
			local oldHRP = char.HumanoidRootPart
			local pos = oldHRP.CFrame
			local newHRP = oldHRP:Clone()
			oldHRP.CFrame = CFrame.new(0,1000000,0)
			wait(LocalPlayer:GetNetworkPing()+0.25)
			oldHRP.Name = "HRP"
			newHRP.Parent = char
		else
			local HRP = char:FindFirstChild("HRP")
			local HumRP = char:FindFirstChild("HumanoidRootPart")
			if HRP and HumRP then
				HRP.Name = "HumanoidRootPart"
				HumRP:Destroy()
			end
		end
	end
    for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Name ~= "HRP" then
            if val.Value then
                v.Transparency = 0.5
            else
                v.Transparency = 0
            end
        end
    end
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
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,nowe)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
	LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
	if Fly.Value then
		nowe = true
		local speeds = tonumber(speed.Main.Text)
		if speeds == nil then
			speeds = 1
		end
		for i = 1, speeds do
			spawn(function()
				local hb = RunService.Heartbeat
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
		while Fly.Value or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			RunService.RenderStepped:Wait()
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
		while Fly.Value or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
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

local Speed = 60
Player.Create(3,"FlySpeedv2","Fly v2 Speed:","Скорость полёта v2:",function(val)
	Speed = tonumber(val.Value)
	if Speed == nil then
		Speed = 60
	end
end).Main.Text = Speed
local MyFly = Player.Create(2,"Fly","Fly v2","Полёт v2")
local Fling = Player.Create(2,"FlingWithFly",'Fling with fly v2','Отпуливатель с полётом v2')
local InvisFly = Player.Create(2,"InvisFly","InvisibleFly","Невидимый полёт")
local SeatOnFly = Player.Create(2,"Allow Sit on fly v2","Allow Sit on fly v2","Разрешить сидеть при полёте2")
local safeInvisFly = Player.Create(2,"SafeInvisFly",'TP to "safe"(InvisFly)','ТП в "Безопасность"(Невид.Полёт)')
AnticheatGroup.Create(0,"FlyTittle","Fly v2","Полёт v2")
local UsePS = AnticheatGroup.Create(2,"FlyUPS","Use PlatformStand","Использовать PlatformStand")
local ParentCamera = AnticheatGroup.Create(2,"FlyUParentCamera","Use camera for fly","Использовать камеру для полёта")
ParentCamera.Main.Value = true
UsePS.Main.Value = true
safeInvisFly.Main.Value = true
safeInvisFly.CFGSave = true
UsePS.CFGSave = true
ParentCamera.CFGSave = true
SeatOnFly.CFGSave = true
local LV, AV, AO, Pos, FlyFolder
local function reloadMyFly()
	MyFly.Main.Value = false
	FlyFolder = Instance.new("Folder")
	FlyFolder.Name = "VeryImportand"
	
	LV = Instance.new("LinearVelocity",FlyFolder)
	AV = Instance.new("AngularVelocity",FlyFolder)
	AO = Instance.new("AlignOrientation",FlyFolder)
	Pos = Instance.new("Part",FlyFolder)

	Pos.CanCollide = false
	Pos.Anchored = true
	Pos.Transparency = 1
	LV.MaxForce = math.huge
	AO.Attachment1 = Instance.new("Attachment",Pos)
	AO.RigidityEnabled = true
	AV.AngularVelocity = Vector3.new(1000,1000,1000)
	AV.MaxTorque = math.huge
end reloadMyFly()
Player.Create(1,"reloadFly","Reload fly v2","Перезапустить полёт",reloadMyFly)

RunService.RenderStepped:Connect(function()
	if LocalPlayer.Character then
		if MyFly.Value then
			Pos.CFrame = workspace.CurrentCamera.CFrame
			Pos.Position = LocalPlayer.Character.PrimaryPart.Position
			if LocalPlayer.Character.Humanoid.Sit then
	                        local camera = game.Workspace.CurrentCamera
	                        if camera.CameraSubject:IsA("Seat") or camera.CameraSubject:IsA("VehicleSeat") then
	                                camera.CameraSubject = LocalPlayer.Character.Humanoid
				end
			end
			if UsePS.Value and not LocalPlayer.Character.Humanoid.Sit then
				LocalPlayer.Character.Humanoid.PlatformStand = true
			end
		elseif InvisFly.Value then
			Pos.CFrame = workspace.CurrentCamera.CFrame
			Pos.Position = LocalPlayer.Character.PrimaryPart.Position + GetMoveDirection(Speed/60)
			LocalPlayer.Character.PrimaryPart.CFrame = Pos.CFrame
		end
	end
end)

local function StartFly(val)
	LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,(not val) or SeatOnFly.Value)
	Fly.Main.Value = false 
	if UsePS.Value then
		LocalPlayer.Character.Humanoid.PlatformStand = not (not val or (SeatOnFly.Value and LocalPlayer.Character.Humanoid.Sit))
	else
		LocalPlayer.Character.Animate.Enabled = not val
		if not val then
			for k,v in pairs(LocalPlayer.Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
				v:Stop()
			end
		end
	end
end

local function getattachment()
	local attach
	if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		attach = LocalPlayer.Character.HumanoidRootPart:FindFirstChild("RootAttachment")
		attach = attach or LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("Attachment")
	else
		for k,v in pairs(LocalPlayer.Character:GetChildren()) do
			attach = v:FindFirstChildOfClass("Attachment")
			if attach then break end
		end
		if not attach then attach = Instance.new("Attachment",LocalPlayer.Character.PrimaryPart) end
	end
	return attach
end

MyFly.OnChange(function(val)
	if val.Value then
		--Fly.Main.Value = false
		InvisFly.Main.Value = false
		wait()
	end
	StartFly(val.Value)
	if val.Value then
		local attach = getattachment()
		LV.Attachment0 = attach
		AO.Attachment0 = attach
		AO.Enabled = not Fling.Value
		AV.Attachment0 = attach
		AV.Enabled = Fling.Value
		LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
			LV.VectorVelocity = GetMoveDirection(Speed)
		end)
		if ParentCamera.Value then
			FlyFolder.Parent = game.Workspace.CurrentCamera
		else
			FlyFolder.Parent = game.Workspace
		end
	else
		FlyFolder.Parent = nil
	end
end)
SeatOnFly.OnChange(function()
	if MyFly.Value then
		_G.TimGui.Print("Fly","Restart fly","Полёт","Перезапусти полёт")
	end
end)
Fling.OnChange(function()
	AO.Enabled = not Fling.Value
	AV.Enabled = Fling.Value
	AV.Attachment0 = getattachment()
end)
game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	if MyFly.Value and ParentCamera.Value then
		AlightFolder.Parent = game.Workspace.CurrentCamera
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
	local invis = InvisiblePlayer.Value
	char:WaitForChild("HumanoidRootPart")
	NoA.Main.Value = false
	NoT.Main.Value = false
	Fly.Main.Value = false
	MyFly.Main.Value = false
	Spin.Main.Value = false
	if not script:FindFirstChild(LocalPlayer.Name) then	
		InvisiblePlayer.Main.Value = false
	end
	wait(0.1)
	NoA.Main.Value = NoAV
	NoT.Main.Value = NoTV
	Fly.Main.Value = FlyV
	MyFly.Main.Value = MyFlyV
	if not script:FindFirstChild(LocalPlayer.Name) then	
		InvisiblePlayer.Main.Value = invis
	end
	wait(0.1)
	Spin.Main.Value = SpinV
end)

-- ESP -------------------------------------------------------
local ESP = Instance.new("Folder",_G.TimGui.Path.gui)
local ESPB = {}
local ESPG = _G.TimGui.Groups.CreateNewGroup("ESP v2","Подсветка")
local sizeTexts = ESPG.Create(3,"SizeTxt","Size of text:","Размер текста")
local enableTexts = ESPG.Create(2,"Txt","Enable text","Включить текст")
local oldSizeText = 7
enableTexts.CFGSave = true
enableTexts.Main.Value = true
sizeTexts.Main.Text = oldSizeText
local MercyESP = ESPG.Create(2,"colorMercy","Change color for mercy","Заменять цвет для пощады")
local allESP = ESPG.Create(2,"All","ESP to all","Подсветить всех")
ESPB["NoTeam"] = ESPG.Create(2,"NoTeam","ESP to neutral","Подсветить без команды")
ESP.Name = "NOOOOTesp"
MercyESP.CFGSave = true
MercyESP.Main.Value = true
local function updESPpl(v)
    local highlight = ESP:FindFirstChild(v.Name)
    if highlight then
        highlight.Enabled = ESPB[v.Team or "NoTeam"].Value or allESP.Value
        highlight.FillColor = v.TeamColor.Color
        if MercyESP.Value then
            if _G.TimGui.Values.Spare[v.Name] then
                highlight.FillColor = Color3.new(0.25,1,0.25)
            end
        end
	    highlight.OutlineColor = highlight.FillColor
        highlight.Adornee = v.Character
	    local board = highlight:FindFirstChild("board")
	    if board then
	        highlight.board.Adornee = v.Character
	        highlight.board.nick.TextColor3 = v.TeamColor.Color
	    end
    end
end
local function updESP()
    for k,v in pairs(game.Players:GetPlayers()) do
        updESPpl(v)
    end
end
local NoTeamEnabled
for k,v in pairs(game.Teams:GetChildren()) do
    ESPB[v] = ESPG.Create(2,v.Name,"Esp to "..v.Name,"Подсветить "..v.Name,updESP)
    NoTeamEnabled = true
end
if not NoTeamEnabled then
    ESPB["NoTeam"].Visible = false
end
allESP.OnChange(updESP)
local function createHighlight(v)
    local highlight = Instance.new("Highlight",ESP)
    highlight.Name = v.Name
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = false
    if enableTexts.Value then
	    local board = Instance.new("BillboardGui",highlight)
	    local size = tonumber(sizeTexts.Value)
	    if not size then size = oldSizeText end
	    board.Size = UDim2.new(size,0,size/3.3,0)
	    board.Name = "board"
	    board.AlwaysOnTop = true
	    board.Enabled = false
	    local name = Instance.new("TextLabel",board)
	    name.Size = UDim2.new(1,0,0.6,0)
	    name.BackgroundTransparency = 1
	    name.TextStrokeTransparency = 0
	    name.TextColor3 = v.TeamColor.Color
	    name.TextScaled = true
	    name.Text = v.Name
	    name.Name = "nick"
	    local dist = Instance.new("TextLabel",board)
	    dist.Size = UDim2.new(0.6,0,0.4,0)
	    dist.Position = UDim2.new(0,0,0.6,0)
	    dist.BackgroundTransparency = 1
	    dist.TextStrokeTransparency = 0
	    dist.TextStrokeColor3 = Color3.new(1,1,1)
	    dist.TextColor3 = Color3.new(0,0,0)
	    dist.TextScaled = true
	    dist.Text = 0
	    local health = Instance.new("TextLabel",board)
	    health.Size = UDim2.new(0.4,0,0.4,0)
	    health.Position = UDim2.new(0.6,0,0.6,0)
	    health.BackgroundTransparency = 1
	    health.TextStrokeTransparency = 0
	    health.TextColor3 = Color3.new(1,1,0)
	    health.TextScaled = true
	    health.Text = ".../..."
	    highlight:GetPropertyChangedSignal("Enabled"):Connect(function()
	        board.Enabled = highlight.Enabled
	    end)
	    task.spawn(function()
	        while highlight.Parent do
	            wait(0.2)
	            if board.Enabled then
	                if LocalPlayer.Character and v.Character then
	                    local LHRP = LocalPlayer.Character.PrimaryPart
	                    local HRP = v.Character.PrimaryPart
	                    if LHRP and HRP then
	                        local count = LHRP.Position - HRP.Position
	                        local adding = math.abs(count.X) + math.abs(count.Y) + math.abs(count.Z)
	                        dist.Text = math.floor(adding)
	                    end
	                    if v.Character:FindFirstChild("Humanoid") then
	                        local HP = v.Character.Humanoid.Health
	                        local MHP = v.Character.Humanoid.MaxHealth
	                        local res = HP/MHP
	                        health.Text = math.floor(HP).."/"..MHP
	                        health.TextColor3 = Color3.new(res,1-res,0)
	                    end
	                end
	            end
	        end
    	  end)
    end
    updESPpl(v)
    return highlight,board
end
local function NewPlayer(v)
    if not v.Character then
        v.CharacterAdded:Wait()
    end
    createHighlight(v)
    v.CharacterAdded:Connect(function()
        wait()
        updESPpl(v)
    end)
    v:GetPropertyChangedSignal("Team"):Connect(function()
        wait()
        updESPpl(v)
    end)
end
for _,v in pairs(game.Players:GetPlayers()) do
    if v ~= LocalPlayer then
	task.spawn(function()
        	NewPlayer(v)
	end)
    end
end
game.Players.PlayerAdded:Connect(NewPlayer)

game.Players.PlayerRemoving:Connect(function(v)
    local highlight = ESP:FindFirstChild(v.Name)
    if highlight then highlight:Destroy() end
end)
local function reloadESP()
    ESP:ClearAllChildren()
    for k,v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer then
            createHighlight(v)
        end
    end
end
ESPG.Create(1,"reload","Reload ESP","Перезагрузить",reloadESP)
enableTexts.OnChange(function()
    reloadESP()
end)
sizeTexts.OnChange(function(v)
    local size = tonumber(v.Value)
    if size ~= oldSizeText then
        if size then
            oldSizeText = size
            reloadESP()
        end
    end
end)
MercyESP.OnChange(updESP)
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
		if pl == LocalPlayer then continue end
	        if not pl.Character then continue end
		if not pl.Character.PrimaryPart then continue end
		pl.Character.PrimaryPart.Anchored = false
		if _G.TimGui.Values.Spare[pl.Name] then continue end
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

RunService.RenderStepped:connect(function()
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

local REvent = {}
local function FindEvent(parent)
    local event = parent:FindFirstChildOfClass("RemoteEvent")
    if event then
        table.insert(REvent,event)
    else
        for k,v in pairs(parent:GetChildren()) do
		FindEvent(v)
        end
    end
end
FindEvent(game.ReplicatedStorage)
if #REvent ~= 0 then
    local bytes = 102400
    local val = string.rep("򃿿",bytes/4)
    local getping = FUN.Create(2,"GetPing","Get Ping","Увеличить пинг")
    RunService.RenderStepped:Connect(function()
	if getping.Value then
		for _,v in pairs(REvent) do
        		v:FireServer(val)
		end
	end
    end)
end

-- Chat ------------------------------------------------------------------------------------------------
local Chat = _G.TimGui.Groups.CreateNewGroup("Chat","Чат")
local SpaceEn = Chat.Create(2,"EnableSpaces","Enable {System}","Включить {System}")
local Spaces = "																																			  {System}: "
SpaceEn.CFGSave = true
SpaceEn.Visible = false
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
text.BackgroundColor3 = _G.TimGui.Colors.MainBackground
text.TextColor3 = _G.TimGui.Colors.Text
text.TextScaled = true
text.TextXAlignment = Enum.TextXAlignment.Left
text.Visible = false

_G.TimGui.Colors.OnChange(function()
	text.BackgroundColor3 = _G.TimGui.Colors.MainBackground
	text.TextColor3 = _G.TimGui.Colors.Text
end)

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
Camera.Create(1,"MaxDistance","Max Zoom of camera","Максимальный зум камеры",function()
	LocalPlayer.CameraMaxZoomDistance = math.huge
end)

-- Other ------------------------------------------------------------------------------------
local group = _G.TimGui.Groups.CreateNewGroup("Other","Другое")
local LocalPlayer = game.Players.LocalPlayer

if game:GetService("UserInputService").TouchEnabled then
	local Sgui = Instance.new("ScreenGui",LocalPlayer.PlayerGui)
	local SCenter = Instance.new("ImageLabel",Sgui)
	local SButton = Instance.new("ImageButton",Sgui)
	local Enabled = Instance.new("BoolValue",Sgui)
	local LSize = 32 
	local LBSizeD = 1.25
	local OldHumanoid

	Sgui.IgnoreGuiInset = true
	Sgui.Name = "MouseLock(ShiftLock)"
    	Sgui.Enabled = false
	Sgui.ResetOnSpawn = false
	Sgui.DisplayOrder = 1

	SCenter.Image = "rbxasset://textures/MouseLockedCursor.png"
	SCenter.Size = UDim2.new(0,LSize,0,LSize)
	SCenter.Position = UDim2.new(0.5,-LSize/2,0.5,-LSize/2)
	SCenter.BackgroundTransparency = 1
	SCenter.Visible = false

	SButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
	SButton.Size = UDim2.new(0,62/LBSizeD,0,62/LBSizeD)
	SButton.Position = UDim2.new(0.875,-62/LBSizeD,0.775,-62/LBSizeD)
	SButton.BackgroundTransparency = 1
	SButton.Activated:Connect(function() Enabled.Value = not Enabled.Value end)

	Enabled.Name = "Enabled"
	Enabled.Changed:Connect(function()
		local char = workspace.CurrentCamera.CameraSubject.Parent
		LocalPlayer.Character.Humanoid.AutoRotate = not Enabled.Value
		SCenter.Visible = Enabled.Value
		if Enabled.Value then
			SButton.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
			if char:FindFirstChild("Humanoid") then
				oldHumanoid = char.Humanoid
				char.Humanoid.CameraOffset += Vector3.new(2.5,0,0)
			end
		else
			SButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
			if char:FindFirstChild("Humanoid") then
				if oldHumanoid then
					oldHumanoid.CameraOffset += Vector3.new(-2.5,0,0)
				end
			end
		end
	end)

	local function upd()
		if Enabled.Value then
			local camera = workspace.CurrentCamera
			local Char = camera.CameraSubject.Parent
			if Char:IsA("Model") then
				local HRP = Char.PrimaryPart
				if HRP then
					local Length = 900000
					local CamR = Vector3.new(camera.CFrame.LookVector.X *Length, HRP.Position.Y, camera.CFrame.LookVector.Z*Length)
					HRP.CFrame = CFrame.new(HRP.Position, CamR)
				end
			end
		end
	end

	LocalPlayer:GetMouse().Move:Connect(upd)
	RunService.RenderStepped:Connect(upd)
    	workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function(char)
		local char = workspace.CurrentCamera.CameraSubject.Parent
		if char:IsA("Model") then
			local en = Enabled.Value
		        Enabled.Value = false
		        char:WaitForChild("HumanoidRootPart",math.huge)
		        wait()
		        Enabled.Value = en
		end
    	end)
	    group.Create(2,"SL(ML)","Shift Lock/Mouse Lock(for mobile)","Шифт лок/блокировка мыши (для телефонов)",function(val)
	        Sgui.Enabled = val.Value
	    end)
else
    if mouse1click ~= nil then
        group.Create(2,"Clicker","AutoClicker","Автокликер",function(val)
            wait(1)
            while task.wait() and val.Value do
                mouse1click()
            end
        end)
    end
    group.Create(1,"SL","Enable shift Lock","Включить shiftlock switch",function()
        LocalPlayer.DevEnableMouseLock = true
    end)
end

group.Create(0,"Try hack game","Try hack game","Попытки взлома игры")
local function checkPass(obj,ParentName)
    if (string.find(obj.Name,"pass") ~= nil) or (string.find(obj.Name,"Pass") ~= nil) then
        return true
    end
    if ParentName then
        return (string.find(obj.Parent.Name,"pass") ~= nil) or (string.find(obj.Parent.Name,"Pass") ~= nil)
    end
end

group.Create(1,"Attempt Get Passes","Attempt Get All Passes","Попытаться получить все геймпассы",function()
    local Attempt = 0
    local function up(val)
        for _,v in pairs(val:GetChildren()) do
            if v:IsA("BoolValue") then
                if checkPass(v,true) then
                    v.Value = not v.Value
                    Attempt += 1
                end
            end
            up(v)
        end
    end
    up(LocalPlayer)
    if Attempt == 0 then
        _G.TimGui.Print("Gamepasses","Not found","Gamepasses","Не найдено")
    else
        _G.TimGui.Print("Gamepasses",Attempt.." has been activated","Gamepasses","Активировано: "..Attempt)
    end
end)

group.Create(1,"Attempt Get PassesGUI","Attempt Make Visible All Gui(for pass)","Попытаться открыть все окна (с пассами)",function()
    local Attempt = 0
    local function up(val)
        for _,v in pairs(val:GetChildren()) do
            if checkPass(v,false) then
                if v:IsA("LayerCollector") then
                    v.Enabled = not v.Enabled
                    Attempt += 1
                elseif v:IsA("GuiObject") then
                    v.Visible = not v.Visible
                    Attempt += 1
                end
            end
            up(v)
        end
    end
    up(LocalPlayer)
    if Attempt == 0 then
        _G.TimGui.Print("Gamepasses","Not found","Gamepasses","Не найдено")
    else
        _G.TimGui.Print("Gamepasses",Attempt.." has been activated","Gamepasses","Активировано: "..Attempt)
    end
end)

group.Create(1,"Attempt activate all privilegies","Attempt activate all privilegies?","Попытаться получить все привилегии?",function()
    local Attempt = 0
    local function up(val)
        for _,v in pairs(val:GetChildren()) do
            if v:IsA("BoolValue") then
                if not v.Value then
                    Attempt += 1
                end
                v.Value = true
            end
            up(v)
        end
    end
    up(LocalPlayer)
    if Attempt == 0 then
        _G.TimGui.Print("Privilegies?","Not found","Privilegies?","Не найдено")
    else
        _G.TimGui.Print("Privilegies?",Attempt.." has been activated","Привилегии?","Активировано: "..Attempt)
    end
end)

local HideGui = group.Create(2,"Hide All Guis","Hide All Guis","Спрятать весь интерфейс")
local Hided = {}
local function UpdHideGui(obj,hide)
    if hide then
        Hided[obj] = obj.Enabled
        obj.Enabled = false
    elseif Hided[obj] then
        obj.Enabled = Hided[obj]
    end
end
local function NewGui(gui)
    if gui:IsA("LayerCollector") then
        gui:GetPropertyChangedSignal("Enabled"):Connect(function()
            if gui.Enabled then
                UpdHideGui(gui,HideGui.Value)
            end
        end)
        UpdHideGui(gui,HideGui.Value)
    end
end
LocalPlayer.PlayerGui.ChildAdded:Connect(NewGui)
for k,v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
    NewGui(v)
end
HideGui.OnChange(function(val)
    for k,v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("LayerCollector") then
            UpdHideGui(v,val.Value)
        end
    end
end)
