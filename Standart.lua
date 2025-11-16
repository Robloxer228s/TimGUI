local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local AnticheatGroup = _G.TimGui.Groups.CreateNewGroup("ACGroup")
local Mouse = LocalPlayer:GetMouse()
local DefaultGravity = game.Workspace.Gravity
local DefaultFPDH = game.Workspace.FallenPartsDestroyHeight
local clopGroup = _G.TimGui.Groups.CreateNewGroup("Clop")
local Settings = _G.TimGui.Groups.Settings
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
Settings.Create(1,"Clop","Bug","Клоп",function()
     clopGroup.OpenGroup()
end)
Settings.Create(1,"Anticheat","Anticheat","Античит",function()
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
local Waypoints = _G.TimGui.Groups.CreateNewGroup("Waypoints","Вайпоинты")
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
Map.Create(2,"MaxSimulateRadius","Set max simulate radius","Поставить максимальную прогрузку физики",function()
    setsimulationradius(math.huge)
end).CFGSave = true
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
local UseCamParentSpeed = AnticheatGroup.Create(2,"WSCamParent","Use parent camera for walkspeed v2","Использовать камеру для скорости v2")
local SpeedVelocity = Instance.new("LinearVelocity")
local twoWS = Player.Create(2,"WalkspeedV2","Set walkspeed v2","Установить скорость V2",function(val)
    if val.Value then
        if UseCamParentSpeed then
            SpeedVelocity.Parent = game.Workspace.CurrentCamera
        else
            SpeedVelocity.Parent = game.Workspace
        end
        local HRP = LocalPlayer.Character.PrimaryPart
        if HRP then
            SpeedVelocity.Attachment0 = HRP:FindFirstChildOfClass("Attachment") or Instance.new("Attachment")
        end
    else
        SpeedVelocity.Parent = nil
        SpeedVelocity.Attachment0 = nil
    end
end)
SpeedVelocity.ForceLimitMode = 1
local function SetWSNewChar(char)
	local MoveSetter
	local Stand = Vector3.new(0,0,0)
	local oldVal = twoWS.Value
	twoWS.Main.Value = false
	wait()
	twoWS.Main.Value = oldVal
	local hum = char:WaitForChild("Humanoid")
	hum:GetPropertyChangedSignal("MoveDirection"):Connect(function()
		if twoWS.Value then
		        local speed = tonumber(WalkSpeed.Value)
			if speed then
			    local direction = hum.MoveDirection *Vector3.new(speed,speed,speed)
			    local absDir = Vector3.new(math.abs(direction.X),math.abs(direction.Y),math.abs(direction.Z))
			    SpeedVelocity.MaxAxesForce = absDir*Vector3.new(2000,2000,2000)
			    SpeedVelocity.VectorVelocity = direction
			end
		end
		if hum.MoveDirection == Stand then
			if MoveSetter then MoveSetter:Disconnect() end
            		MoveSetter = nil
		elseif not MoveSetter and Setter.Value then
			MoveSetter = hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				if Setter.Value then
                    			hum.WalkSpeed = tonumber(WalkSpeed.Value)
                		end
			end)
			wait()
			hum.WalkSpeed = tonumber(WalkSpeed.Value)
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
	LocalPlayer.Character.Humanoid.UseJumpPower = true
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

local ReloadMJ = false
game:GetService("UserInputService").JumpRequest:Connect(function()
	if MultyJump.Value and not ReloadMJ then
		ReloadMJ = true
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.None)
		wait(0)
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		wait(0.1)
		ReloadMJ = false
	end
end)

local NoCollideForOther = Player.Create(2,"NoCollide","No collide for other players","Проходка сквозь других игроков",function(val)
	if NoCollideForOther.Value then
		for _,v in pairs(game.Players:GetPlayers()) do
			if v~= LocalPlayer then
				if not v.Character then continue end
				local clone = v.Character:FindFirstChild("Clone")
				if not clone then continue end
				for _,i in pairs(clone:GetChildren()) do
					if i:IsA("BasePart") and i.CanCollide then
						i.CanCollide = false
					end
				end
			end
		end
	end
end) 
RunService.PreSimulation:Connect(function()
	if NoCollideForOther.Value then
		for _,v in pairs(game.Players:GetPlayers()) do
			if v~= LocalPlayer then
				if not v.Character then continue end
				for _,i in pairs(v.Character:GetChildren()) do
					if i:IsA("BasePart") and i.CanCollide then
						i.CanCollide = false
					end
				end
			end
		end
	end
end)
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
	end
end)

local NoT = Player.Create(2,"Notouch","No CanTouch","Убрать косания",function(val)
	for k,v in pairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanTouch = not val.Value
		end
	end
end)
local AnimSpeed = Player.Create(3,"AnimSpeed","Speed for animation:","Скорость анимации:")
local AnimSpeedEnabled = Player.Create(2,"AnimSpeedEnabled","Enable speed for animation","Включить скорость анимации")
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
local Dashing
local DashSettings = _G.TimGui.Groups.CreateNewGroup("DashSettings")
DashSettings.Visible = false
Player.Create(1,"DashSettings","Dash settings","Настройки рывка",DashSettings.OpenGroup)
local dashOffset,dashAdd = Vector3.new(0,0,0),Vector3.new(0,0,0)
local UpdDSettings
local function UpdateDashSettings()
    UpdDSettings()
end
local DefaultDashEnabled = DashSettings.Create(2,"DefDash","Default dash enabled","Рывок по умолчанию",UpdateDashSettings)
DefaultDashEnabled.Main.Value = true
DefaultDashEnabled.CFGSave = true
DashSettings.Create(0,"OffsetTittle","Offset","Смещение")
local XDash = DashSettings.Create(3,"X","X:","X:",UpdateDashSettings)
local YDash = DashSettings.Create(3,"Y","Y:","Y:",UpdateDashSettings)
local ZDash = DashSettings.Create(3,"Z","Z:","Z:",UpdateDashSettings)
DashSettings.Create(0,"AddingTittle","Add velocity","Добавления")
local XAddDash = DashSettings.Create(3,"XAdd","X:","X:",UpdateDashSettings)
local YAddDash = DashSettings.Create(3,"YAdd","Y:","Y:",UpdateDashSettings)
local ZAddDash = DashSettings.Create(3,"ZAdd","Z:","Z:",UpdateDashSettings)
function UpdDSettings()
    print(XDash.Value)
    dashOffset = Vector3.new(tonumber(XDash.Value)or 0,tonumber(YDash.Value)or 0,tonumber(ZDash.Value)or 0)
    dashAdd = Vector3.new(tonumber(XAddDash.Value)or 0,tonumber(YAddDash.Value)or 0,tonumber(ZAddDash.Value)or 0)
    if DefaultDashEnabled.Value then
        dashAdd += Vector3.new(0,50,-200)
    end
end UpdDSettings()
Player.Create(1,"Dash","Dash","Рывок",function()
    local HRP = LocalPlayer.Character.HumanoidRootPart
    countingDash.CFrame = HRP.CFrame
    countingDash.Position = Vector3.new(1,1,1)
    Dashing = (countingDash.CFrame * dashAdd)+dashOffset
    HRP.Velocity = Dashing
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
			LocalPlayer.Character.PrimaryPart.CFrame = (CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z))
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

LocalPlayer:WaitForChild("Backpack").ChildAdded:Connect(NewItem)
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
local walkfling = Player.Create(2,"WalkFling","Walkfling","Отпуливатель o_o",function()
	Dashing = nil
end)
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
		if Dashing then
			HRP.Velocity = Dashing
			Dashing = nil
		end
            end
        end
    end
end)
--Invisible
local InvisibleSettings = _G.TimGui.Groups.CreateNewGroup("InvisibleSettings")
InvisibleSettings.Visible = false
Player.Create(1,"InvsSet","Invisible settings","Настройки невидимости",function()
	InvisibleSettings.OpenGroup()
end)

local InvsTypes = {}
local Types = {}
local InvisVariant = 1
InvisibleSettings.Create(0,0,"R15","R15")
Types[1] = {"Default","Стандартный"}
Types[2] = {"Change character","Смена персонажа"}
Types[3] = {"HipHeight change","Смена высоты"}
for k,v in pairs(Types) do
	InvsTypes[k] = InvisibleSettings.Create(2,k,v[1],v[2],function(val)
		local i = 0
		for CheckK,v in pairs(InvsTypes) do
			if v.Value then i += 1 end
			if CheckK ~= k then
				v.Main.Value = false
			end
		end
		if i == 0 then
			val.Main.Value = true
		end if val.Value then
			InvisVariant = k
		end
	end)
	InvsTypes[k].CFGSave = true
end
InvsTypes[1].Main.Value = true
local InvsYPosCustom = InvisibleSettings.Create(3,"YPos","Y Position:","Y позиция:")
InvsYPosCustom.Main.Text = 1000

local FirstVInvFolder
_G.TimGui.Values.InvisibleCharacter = false
local function SetInvisible(val)
	_G.TimGui.Values.InvisibleCharacter = val.Value
	local char = LocalPlayer.Character
	if char:FindFirstChildOfClass("Humanoid").RigType.Name == "R15" then
		local YPos = tonumber(InvsYPosCustom.Value) or 1000
		if val.Value == false then
			YPos = -YPos
		end
		if InvisVariant == 1 then
			if val.Value then
				_G.TimGui.Print("R15 - Default","Touch working","R15 - Стандарт","Косания работают")
			end
			LocalPlayer.Character.Humanoid.CameraOffset -= Vector3.new(0,YPos,0)
			LocalPlayer.Character.LowerTorso.Root.C0 -= Vector3.new(0,YPos,0)
			LocalPlayer.Character.HumanoidRootPart.CFrame += Vector3.new(0,YPos,0)
			if val.Value then
				local CollisionTable = {}
				FirstVInvFolder = Instance.new("Folder",game.Workspace.CurrentCamera)
				for k,v in pairs(LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
						v.Touched:Connect(function(other)
							if other.CanCollide and FirstVInvFolder then
								if CollisionTable[other] == nil then
									local temp
									if other:IsA("TrussPart") then
										temp = Instance.new("TrussPart",FirstVInvFolder)
									else
										temp = Instance.new("Part",FirstVInvFolder)
									end
									temp.Anchored = true
									temp.CanTouch = false
									temp.Transparency = 1
									temp.CFrame = other.CFrame + Vector3.new(0,YPos,0)
									temp.Size = other.Size
									if other:IsA("Part") then
										temp.Shape = other.Shape
									end if other.Anchored then
										temp.Velocity = other.Velocity
									end
									CollisionTable[other] = {obj=temp,Deleting=false}
									wait(10)
									CollisionTable[other].Deleting = true
								else
									CollisionTable[other].Size = other.Size
									CollisionTable[other].CFrame = other.CFrame
								end
							end
						end)
						v.TouchEnded:Connect(function(other)
							if not CollisionTable[other] then return end
							wait(15)
							if CollisionTable[other] and CollisionTable[other].Deleting then
								CollisionTable[other].obj:Destroy()
								CollisionTable[other] = nil
							end
						end)
					end
				end
			else
				FirstVInvFolder:Destroy()
			end
		elseif InvisVariant == 2 then
			if val.Value then
				_G.TimGui.Print("R15 - Change Character","Touch don't working","R15 - Изменение персонажа","Косания не работают")
				char.Archivable = true
				local newchar = char:Clone()
				char.PrimaryPart.CFrame = CFrame.new(0,1000000,0)
				char.PrimaryPart.Anchored = true
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
					oldChar.PrimaryPart.Anchored = true
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
		elseif InvisVariant == 3 then
			if val.Value then
				_G.TimGui.Print("R15 - HipHeight","Touch working","R15 - Высота","Косания работают")
			end
			char.Humanoid.CameraOffset -= Vector3.new(0,YPos,0)
			char.Humanoid.HipHeight += YPos
		end
	else
		if val.Value then
            		_G.TimGui.Print("R6","Touch working","R6","Косания работают")
			local oldHRP = char.HumanoidRootPart
			local pos = oldHRP.CFrame
			local newHRP = oldHRP:Clone()
			oldHRP.CFrame = CFrame.new(0,1000000,0)
			wait(LocalPlayer:GetNetworkPing()+0.25)
			oldHRP.Name = "HRP"
			newHRP.Parent = char
			wait()
			newHRP.CFrame = pos
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
end
local InvisiblePlayer = Player.Create(2,"InvisiblePlayer","Invisible","Невидимость",SetInvisible)
LocalPlayer.CharacterAdded:Connect(function(char)
	if InvisiblePlayer.Value then
		char:WaitForChild("HumanoidRootPart",math.huge)
		char:WaitForChild("Humanoid",math.huge)
		wait()
		if not script:FindFirstChild(LocalPlayer.Name) then	
			SetInvisible({Value=true})
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
safeInvisFly.Main.Value = true
safeInvisFly.CFGSave = true
UsePS.CFGSave = true
ParentCamera.CFGSave = true
SeatOnFly.CFGSave = true
SeatOnFly.Main.Value = true
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
local ESPG = _G.TimGui.Groups.CreateNewGroup("ESP","Подсветка")
local ESPB = {}
ESPG.Create(3,"SizeTxt","Size of text:","Размер текста",function(val)
	if tonumber(val.Value) then
		_G.TimGui.Modules.ESP.SetBoardSize(val.Value)
	end
end).Main.Text = 7
local enableBoards = ESPG.Create(2,"Txt","Enable text","Включить текст",function(val)
	_G.TimGui.Modules.ESP.EnableBoards = val.Value
	_G.TimGui.Modules.ESP.Refresh()
end) enableBoards.CFGSave = true
enableBoards.Main.Value = true
local function refreshESP() _G.TimGui.Modules.ESP.Refresh() end
local MercyESP = ESPG.Create(2,"colorMercy","Change color for mercy","Заменять цвет для пощады",refreshESP)
local allESP = ESPG.Create(2,"All","ESP to all","Подсветить всех",refreshESP)
ESPB["NoTeam"] = ESPG.Create(2,"NoTeam","ESP to neutral(without a team)","Подсветить без команды",refreshESP)
_G.TimGui.Modules.ESP.Bind(1,function(Player)
	if allESP.Value or ESPB[Player.Team or"NoTeam"].Value then
		if MercyESP.Value then
            if _G.TimGui.Values.Spare[Player.Name] then
				return Color3.new(0.25,1,0.25)
			end
		end return Player.TeamColor.Color
	end
end) _G.TimGui.Modules.Players.ForEveryone(function(Player)
	Player:GetPropertyChangedSignal("Team"):Connect(function()
		_G.TimGui.Modules.ESP.Refresh(Player)
	end)
end,false)
local NoTeamEnabled
for k,v in pairs(game.Teams:GetChildren()) do
    ESPB[v] = ESPG.Create(2,v.Name,"Esp to "..v.Name,"Подсветить "..v.Name,function()
		_G.TimGui.Modules.ESP.Refresh(v)
	end)
    NoTeamEnabled = true
end if not NoTeamEnabled then
    ESPB["NoTeam"].Visible = false
end
-- Freeze -----------------------------
local FreezeG = _G.TimGui.Groups.CreateNewGroup("Freeze","Заморозка")
local FreezeReturn = {}
local FreezeSettings = _G.TimGui.Groups.CreateNewGroup("FreezeSettings")
local EnableFakeCharacters = FreezeSettings.Create(2,"EnableFakeCharacters","Enable clones for Freezing","Включить клонов для Заморозки",function(val)
	_G.TimGui.Modules.Freeze.EnableFakeChars = val.Value
end) EnableFakeCharacters.Main.Value = true
FreezeSettings.Visible = false
FreezeG.Create(0,"WhatIsIt","It's Freeze players/Killaura","Это Заморозка игроков/Killaura")
FreezeG.Create(1,"Settings","Freeze settings","Настройки заморозки",function()
	FreezeSettings.OpenGroup()
end) FreezeSettings.Create(0,"KillAuraTxt","KillAura: position from you","KillAura: позиция от тебя")
local XKillAura = FreezeSettings.Create(3,"XKillAura","X(right/left):","X(право/лево):")
local YKillAura = FreezeSettings.Create(3,"YKillAura","Y(up/down):","Y(верх/низ):")
local ZKillAura = FreezeSettings.Create(3,"ZKillAura","Z(back/front):","Z(зад/перед):")
local DistanceForKillAura = FreezeSettings.Create(3,"KillAuraDistance","Distance for KillAura:","Дистанция KillAura'ы:")
local EnableDistanceForKA = FreezeSettings.Create(2,"KillAuraDistanceEnable","Enable distance for KillAura","Включить дистанцию KillAura'ы")
ZKillAura.Main.Text = "-3"
DistanceForKillAura.Main.Text = "50"
local function KillauraF(Root,Player,PlInts)
	local thisInt = PlInts[Player]
	local LPCharacter = LocalPlayer.Character
	local Character = Player.Character
	local KillauraAdd = Vector3.new(tonumber(XKillAura.Value)or 0,tonumber(YKillAura.Value)or 0,tonumber(ZKillAura.Value)or -3)
	local inDistance = true
	local LHRP = LPCharacter:FindFirstChild("HumanoidRootPart")or LPCharacter.PrimaryPart
	local HRP = Character:FindFirstChild("HumanoidRootPart")or Character.PrimaryPart
	task.spawn(function()
		if EnableDistanceForKA.Value then
			while thisInt == PlInts[Player] do
				if not LHRP.Parent then
					local newLHRP = LPCharacter:FindFirstChild("HumanoidRootPart")or LPCharacter.PrimaryPart
					if not newLHRP then
						task.wait(0.5)
					continue end
				end
				local dist = (LHRP.Position-HRP.Position).Magnitude
				local neededDist = tonumber(DistanceForKillAura.Value)or 50
				if dist<neededDist then
					inDistance = true
				else inDistance = false
				end
				task.wait(0.25)
			end
		end
	end) task.wait()
	while thisInt == PlInts[Player] do
		if not LPCharacter or not LPCharacter.Parent then
			LPCharacter = LocalPlayer.Character
		elseif LPCharacter and LPCharacter.PrimaryPart then
			if inDistance then
				local Pos = LPCharacter.PrimaryPart.CFrame
				Pos += (Pos*KillauraAdd)-Pos.Position
				Root.CFrame = Pos
			else Root.CFrame = CFrame.new(0,100000,0)
			end
		end 
		RunService.PreRender:Wait()
	end return true
end
local function NewFreezeButtons(Inst,Group,rusName)
	local Buttons = {} 
	local InstName = Inst
	if typeof(Inst)=="Instance" then InstName = Inst.Name end
	Buttons["Text"] = Group.Create(0,"Text"..InstName,InstName,rusName)
	local function RefreshButtons(val,res)
		if val.Value then
			for k,v in pairs(Buttons) do
				if v.Value and v ~= val then
					v.Main.Value = false
				end
			end FreezeReturn[Inst] = res
		else for k,v in pairs(Buttons) do
				if v.Value then return false end
			end FreezeReturn[Inst] = nil
		end if res then _G.TimGui.Modules.Freeze.Refresh(Inst) end 
		return true
	end Buttons["Killaura"] = Group.Create(2,"Killaura"..InstName,"KillAura","KillAura",function(val)
		RefreshButtons(val,KillauraF)
	end) Buttons["TPFreeze"] = Group.Create(2,"TPFreeze"..InstName,"Freeze with TP","Заморозка с ТП",function(val)
		if RefreshButtons(val) then
			if val.Value then
				local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
				if not Character.PrimaryPart then Character:GetPropertyChangedSignal("PrimaryPart"):Wait() end
				FreezeReturn[Inst] = Character.PrimaryPart.CFrame
			end	_G.TimGui.Modules.Freeze.Refresh(Inst)
		end
	end) Buttons["Freeze"] = Group.Create(2,"Freeze"..InstName,"Freeze","Заморозка",function(val)
		RefreshButtons(val,true)
	end) return Buttons
end local NoTeamName,NoTeamNeeded = "Without a team",false
NewFreezeButtons("All players",FreezeG,"Все игроки")
FreezeG.Create(0,"FreezeCom","Freeze Commands","Заморозка Комманд")
local NoTeamButtonsFreeze = NewFreezeButtons(NoTeamName,FreezeG,"Без комманды")
for k,team in pairs(game.Teams:GetChildren()) do
	NewFreezeButtons(team,FreezeG)
	NoTeamNeeded = true
end if NoTeamNeeded == false then
	for k,v in pairs(NoTeamButtonsFreeze) do
		v.Visible = false
	end
end local PlFreezeButtons = {}
_G.TimGui.Modules.Players.ForEveryone(function(player)
	PlFreezeButtons[player] = NewFreezeButtons(player,FreezeG)
end,false)
game.Players.PlayerRemoving:Connect(function(Player)
	for k,v in pairs(PlFreezeButtons[Player]) do
		v.Destroy()
	end PlFreezeButtons[Player] = nil
end)
_G.TimGui.Modules.Freeze.Bind(1,function(Player)
	local notForSpare = (not _G.TimGui.Values.Spare[Player.Name])and(FreezeReturn[Player.Team or NoTeamName]or FreezeReturn["All players"])
	return FreezeReturn[Player]or notForSpare or nil
end)
-- FUN --------------------------------
local FUN = _G.TimGui.Groups.CreateNewGroup("FUN","ВЕСЕЛЬЕ")

FUN.Create(1,"KickYou","Kick for you(use for bugs)","Кикнуть тебя",function()
    if _G.TimGui.Values.RusLang then
        LocalPlayer:Kick("Пакеда, хихихи")
    else
        LocalPlayer:Kick("Bye bye.")
    end
end)

FUN.Create(1,"Reset","Reset Character","Перевозродится",function()
    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Health = -1
    end
end)

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

local SlowFall = FUN.Create(2,"SlowFall","Slow fall for character","Замедленное падение")
RunService.RenderStepped:connect(function()
	if LocalPlayer.Character then
		local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character.PrimaryPart
		if HRP then 
			if Happy and HappyMod.Value then
				LocalPlayer.Character.Humanoid:ChangeState(4)
			end if NotFling.Value then
			    HRP.AssemblyAngularVelocity += Vector3.new(0,500,0)
			end if SlowFall.Value then
		            HRP.Velocity = Vector3.new(HRP.Velocity.X,0,HRP.Velocity.Z)
		        end
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
local ChatGroup = _G.TimGui.Groups.CreateNewGroup("Chat","Чат")
local ChatsChannels = {}
if game.TextChatService:FindFirstChild("TextChannels") then
    ChatGroup.Create(0,"Channels","Channels","Каналы")
    for k,v in pairs(game.TextChatService.TextChannels:GetChildren()) do
        ChatsChannels[v.Name] = ChatGroup.Create(2,"Ch"..v.Name,v.Name,v.Name)
        ChatsChannels[v.Name].CFGSave = true
        ChatsChannels[v.Name].Channel = v
        ChatsChannels[v.Name].Value = v.Name == "RBXGeneral"
    end
end
local function SendToChat(message)
    for k,v in pairs(ChatsChannels) do
        if v.Value then
            v.Channel:SendAsync(message)
        end
    end
    local ChatFolder = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
    if ChatFolder then
        ChatFolder.SayMessageRequest:FireServer(message,"All")
    end
end
ChatGroup.Create(0,"MessagesPL","Messages with player","Сообщения с игроком")
local JoinText = ChatGroup.Create(3,"PlayerJoined","On player join:","При входе игрока:")
local JoinValue = ChatGroup.Create(2,"SendPlJoined","Sending player join","Отправка при входе")
JoinText.Main.Text = "#name is joined"
local LeftText = ChatGroup.Create(3,"PlayerLefted","On player left:","При выходе игрока:")
local LeftValue = ChatGroup.Create(2,"SendPlLefted","Sending player left","Отправка при выходе")
LeftText.Main.Text = "#name is left"
local DiesText = ChatGroup.Create(3,"PlayerDied","On player die:","При смерти игрока:")
local DiesValue = ChatGroup.Create(2,"SendPlDied","Sending player died","Отправка при смерти")
DiesText.Main.Text = "#name is dead"
game.Players.PlayerRemoving:Connect(function(player)
    if LeftValue.Value then
        SendToChat(string.gsub(LeftText.Value,"#name",player.Name))
    end
end)
local function PlayerDieConnect(player)
    local function NewChar(char)
        char:WaitForChild("Humanoid",math.huge).Died:Connect(function()
            if DiesValue.Value then
                SendToChat(string.gsub(DiesText.Value,"#name",player.Name))
            end
        end)
    end
    player.CharacterAdded:Connect(NewChar)
    if player.Character ~= nil then
        NewChar(player.Character)
    end
end
game.Players.PlayerAdded:Connect(function(player)
    if JoinValue.Value then
        SendToChat(string.gsub(JoinText.Value,"#name",player.Name))
    end
    PlayerDieConnect(player)
end)
ChatGroup.Create(0,"Message","Message","Сообщение")
local Mess = ChatGroup.Create(3,"MessageTxt","Message:","Сообщение:")
ChatGroup.Create(1,"Send","Send","Отправить",function()
    SendToChat(Mess.Value)
end)
local Couldown = ChatGroup.Create(3,"TimerSpam","Timer for spam:","Перезарядка спама:")
ChatGroup.Create(2,"Spam","Spam","Спам",function(val)
    while val.Value do
        task.wait(tonumber(Couldown.Value))
        SendToChat(Mess.Value)
    end
end)
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
	if not BrightnessChange.Value then return end
	game.Lighting.Brightness = tonumber(BrightnessTxt.Value) 
end)

local ClockTime = Light.Create(3,"ClcTime","Clock time:","Время:") 
local setClcTime = Light.Create(1,"SetClc","Set clock time","Установить время",function() 
	game.Lighting.ClockTime = tonumber(ClockTime.Value) 
end) 

game.Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
	if not setClcTime.Value then return end
	game.Lighting.ClockTime = tonumber(ClockTime.Value) 
end)

local light
local LRange = Light.Create(3,"LRange","Light range:","Дистанция света:") 
local LBright = Light.Create(3,"LBright","Light Brightness:","Яркость света:") 
Light.Create(2,"Lighting","Lighting Character","Свечащийся персонаж",function(val)
	if val.Value then
		light = Instance.new("PointLight") 
		light.Name = "Light"
		light.Range = tonumber(LRange.Value) 
		light.Brightness = tonumber(LBright.Value) 
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
group.Create(1,"ToggleTE","Toggle TimExplorer","Переключить TExplorer",function()
    if game.CoreGui:FindFirstChild("TExplorer") then
        game.CoreGui.TExplorer.Enabled = not game.CoreGui.TExplorer.Enabled
        return
    end 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimExplorer/Explorer.lua"))()
end)
group.Create(0,"Try hack game","Try hack game","Попытки взлома игры")
local function CheckParent(v,name)
    local res = v
    while true do
        if res == nil then error(v:GetFullName()) end
        res = res.Parent
        if res == nil then return end
        if res == game then return end
        if type(name) ~= "string" then
            local result = name(res)
            if result then
                return res
            end
        elseif string.find(string.lower(res.Name),name) ~= nil == name then
            return res
        end
    end
end
local function FireObj(into,class,name,par,fire)
    if type(into) == "table" then
        for _,v in pairs(into) do
            FireObj(v,class,name,par,fire)
        end return
    end
    for k,v in pairs(into:GetDescendants()) do
        if class == nil or v:IsA(class) then
            local res = string.lower(v.Name)
            if par then
                if CheckParent(v,name) then
                    fire(v) continue
            end end
            if string.find(res,name) ~= nil then fire(v) end
        end
    end
end

group.Create(1,"Attempt delete kill","Attempt delete killparts","Попытаться удалить все убивашки",function()
    local Attempt = 0 
    FireObj(game.Workspace,"BasePart","kill",true,function(v)
        Attempt += 1
        v:Destroy()
    end)
    if Attempt == 0 then
        _G.TimGui.Print("Killbricks","Not found","Убивашки","Не найдено")
    else
        _G.TimGui.Print("Killbricks",Attempt.." parts has been delete","Убивашки","Удаленно: "..Attempt)
    end
end)

group.Create(1,"Attempt Get Passes","Attempt Get All Passes","Попытаться получить все геймпассы",function()
    local Attempt = 0
    FireObj(LocalPlayer,"BoolValue","pass",true,function(v)
        Attempt += 1
        v.Value = not v.Value
    end)
    if Attempt == 0 then
        _G.TimGui.Print("Gamepasses","Not found","Gamepasses","Не найдено")
    else
        _G.TimGui.Print("Gamepasses",Attempt.." has been activated","Gamepasses","Активировано: "..Attempt)
    end
end)

group.Create(1,"Attempt disable anticheat","Attempt disable anticheat","Попытаться отключить античит",function()
    local Attempt = 0
    FireObj({LocalPlayer,LocalPlayer.Character,game.ReplicatedFirst},"BaseScript","anticheat",true,function(v)
        Attempt += 1
        v.Enabled = false
    end)
    if Attempt == 0 then
        _G.TimGui.Print("Anticheat","Not found","Античит","Не найдено")
    else
        _G.TimGui.Print("Anticheat",Attempt.." scripts has been disabled","Античит","Выключено: "..Attempt.." скриптов")
    end
end)

group.Create(1,"Attempt disable scripts with Kick","Attempt disable scripts with Kick","Попытаться отключить скрипты с киком",function()
    local Attempt = 0
    for k,v in pairs(game:GetDescendants()) do
        if v:IsA("BaseScript") then
            pcall(function()
                local decoder = decompile(v)
                if string.find(decoder,":Kick") then
                    Attempt += 1
                    v.Enabled = false
                end
            end)
            if Attempt == 0 then
                _G.TimGui.Print("Antikick","Not found","Антикик","Не найдено")
            else
                _G.TimGui.Print("Antikick",Attempt.." scripts has been disabled","Антикик","Выключено: "..Attempt.." скриптов")
            end
        end
    end
end).Visible = (decompile ~= nil)

group.Create(1,"Attempt Get PassesGUI","Attempt Make Visible All Gui(for pass)","Попытаться открыть все окна (с пассами)",function()
    local Attempt = 0 
    FireObj(LocalPlayer,"LayerCollector","pass",false,function(v)
        Attempt += 1
        v.Enabled = not v.Enabled
    end) FireObj(LocalPlayer,"GuiObject","pass",false,function(v)
        Attempt += 1
        v.Visible = not v.Visible
    end)
    if Attempt == 0 then
        _G.TimGui.Print("Gamepasses","Not found","Gamepasses","Не найдено")
    else
        _G.TimGui.Print("Gamepasses",Attempt.." has been activated","Gamepasses","Активировано: "..Attempt)
    end
end)

group.Create(1,"Attempt activate all privilegies","Attempt activate all privilegies?","Попытаться получить все привилегии?",function()
    local Attempt = 0
    for k,v in pairs(LocalPlayer:GetDescendants()) do
        if v:IsA("BoolValue") then
            if not v.Value then
                Attempt += 1
            end v.Value = true
        end
    end
    if Attempt == 0 then
        _G.TimGui.Print("Privilegies?","Not found","Privilegies?","Не найдено")
    else
        _G.TimGui.Print("Privilegies?",Attempt.." has been activated","Привилегии?","Активировано: "..Attempt)
    end
end)
local function parentF(p)
    if p:IsA("Model") then
        return game.Players:GetPlayerFromCharacter(p)
    end
end
local ProxPrompts = {}
local FProxPrompts
local function ChangeProxPrompt(v)
    ProxPrompts[v] = v.HoldDuration
    v.HoldDuration = 0
    v:GetPropertyChangedSignal("HoldDuration"):Once(function()
        if FProxPrompts.Value then
            ChangeProxPrompt(v)
        end
    end)
end
FProxPrompts = group.Create(2,"FProxPrompts","Fast Proximity Prompts","Быстрое Задержевание(подберание)",function(val)
    if val.Value then
        for k,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                ChangeProxPrompt(v)
            end
        end
    else
        for p,v in pairs(ProxPrompts) do
            p.HoldDuration = v
        end
    end
end) game.Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("ProximityPrompt") then
        if FProxPrompts.Value then
            ChangeProxPrompt(v)
        end
    end
end)
group.Create(1,"SetVelocityToYourChar","Set Velocity To Your Char","Прикрепить все обьекты в твою позицию",function()
    local folder = Instance.new("Folder",game.Workspace.CurrentCamera)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if not v.Anchored then
                if not CheckParent(v,parentF) then
                    local Velocity = Instance.new("AlignPosition",folder)
                    Velocity.Mode = 0
                    Velocity.MaxForce = math.huge
                    Velocity.Attachment0 = v:FindFirstChildOfClass("Attachment") or Instance.new("Attachment",v)
                    Velocity.Position = LocalPlayer.Character.PrimaryPart.Position
                end
            end
        end
    end
end)

local PinedObjects
local OldPosition
local function addPartToPin(Part)
    if not CheckParent(Part,parentF) then
        local Velocity = Instance.new("AlignPosition",PinedObjects)
        Velocity.Mode = 0
        Velocity.MaxForce = math.huge
        Velocity.MaxVelocity = math.huge
        Velocity.Attachment0 = Part:FindFirstChildOfClass("Attachment") or Instance.new("Attachment",Part)
        Velocity.Position = OldPosition
    end
end
local Pinning = group.Create(2,"Pinning","Pinning all","Прикреплять все в твою позицию",function(val)
    if val.Value then
        PinedObjects = Instance.new("Folder",game.Workspace.CurrentCamera)
        OldPosition = LocalPlayer.Character.HumanoidRootPart.Position
        for k,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                if not v.Anchored then
                    addPartToPin(v)
                end
            end
        end
    else
        PinedObjects:Destroy()
    end
end)

game.Workspace.DescendantAdded:Connect(function(v)
    if Pinning.Value then
        if v:IsA("BasePart") then
            if not v.Anchored then
                addPartToPin(v)
            end
        end
    end
end)

local PowerOfKick = group.Create(3,"PowerOfKick","Power:","Сила:")
group.Create(1,"UpVelocity2","Set velocity to up for all","Подкинуть обьетки",function(val)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if not v.Anchored then
                if not CheckParent(v,parentF) then
                    v.Velocity = Vector3.new(0,tonumber(PowerOfKick.Value) or 100,0)
                end
            end
        end
    end
end)

group.Create(1,"UpRotation2","Set rotation to up for all","Повернуть обьетки",function(val)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if not v.Anchored then
                if not CheckParent(v,parentF) then
                    local rot = tonumber(PowerOfKick.Value) or 100
                    v.AssemblyAngularVelocity = Vector3.new(rot,rot,rot)
                end
            end
        end
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
-- ANIMATIONS -----------------------------------------------
local Animations = _G.TimGui.Groups.CreateNewGroup("Animations(R15)","Анимации(R15)")
local Anims = game.HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/AnimationsR15.json"))
local function Update()
    local Character = LocalPlayer.Character
    if not Character then return end
    local hum = Character:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local Animator = hum:FindFirstChildOfClass("Animator")
    if not Animator then return end
    local animsEnabled = false
    for k,v in pairs(Anims) do
        if v[1] == true then 
            animsEnabled = true
            break
        end
    end local Animate = Character:FindFirstChild("Animate")
    if Animate then
        if animsEnabled and Animate.Enabled then
            for k,v in pairs(Animator:GetPlayingAnimationTracks()) do
                v:Stop()
            end
        end
        Animate.Enabled = not animsEnabled
    end for k,v in pairs(Anims) do
        pcall(function()
            if not v[2] then
                v[2] = Animator:LoadAnimation(v[3])
                v[2].Looped = true
            end
            if v[1] == true then
                if not v[2].IsPlaying then
                    v[2]:Play()
                end
            else v[2]:Stop()
            end
        end)
    end
end LocalPlayer.CharacterAdded:Connect(function(char)
    for k,v in pairs(Anims) do
        v[2] = nil
    end
    char:WaitForChild("Humanoid"):WaitForChild("Animator")
    Update()
end)
for k,v in pairs(Anims) do
    local Anim = Instance.new("Animation")
    Anim.AnimationId = v[1]
    Anims[k] = {false,nil,Anim}
    Animations.Create(2,v[1],v[2],v[3],function(val)
        Anims[k][1] = val.Value
        Update()
    end)
end
-- Servers -------------------------------------------------
local ServersG = _G.TimGui.Groups.CreateNewGroup("Servers")
ServersG.Visible = false
_G.TimGui.Groups.Settings.Create(1,"Servers","Servers","Сервера",function()
	ServersG.OpenGroup()
end) ServersG.Create(0,"Warn","It's may don't work(Test it)","Это может не работать(Проверь)")
ServersG.Create(1,"Rejoin","Rejoin on this server","Перезайти на этот сервер",function()
	_G.TimGui.Modules.Servers.Rejoin()
end) ServersG.Create(0,"Tip","Saved servers last for 12 hours, as they close when everyone leaves","Сохраненные сервера живут 12 часов, так как при выходе всех они закрываются")
local SavedServers = _G.TimGui.Saves.Load("SavedServers")or{}
local HttpService = game:GetService("HttpService")
if type(SavedServers)=="string"then 
	s,SavedServers=pcall(function()
		return HttpService:JSONDecode(SavedServers)
	end) if not s then SavedServers={} end
end ServersG.Create(0,"TittleJFP","Join from server path(PlaceId@JobId)","Присоединиться с помощью пути к серверу(PlaceId@JobId)")
local serverPath = ServersG.Create(3,"ServerPath","Server path:","Путь к серверу:")
ServersG.Create(1,"JoinFromPath","Join from path","Зайти по пути к серверу",function()
	if not _G.TimGui.Modules.Servers.Join(serverPath.Value) then
		_G.TimGui.Print("Join","Path is not corrected","Зайти","Путь не корректный")
	end
end) if toclipboard then
	ServersG.Create(1,"CopyServerPath","Copy this ServerPath","Копировать путь этого сервера",function()
		toclipboard(_G.TimGui.Modules.Servers.GetThisServerPath())
	end)
end ServersG.Create(0,"TittleSS","Saving servers","Сохранение серверов")
local serverTimeMax = 12*60*60 -- 12 hours
local ServersSavedLTime = os.time()-serverTimeMax
local ServerCreateName = ServersG.Create(3,"SNameFC","Name(for save server):","Имя(для сохранения сервера):")
local USureWantJoinWarn = "The server was saved @n@ seconds ago"
local USureWantJoinWarnRus = "Сервер был сохранён @n@ секунд назад"
local function CreateSSButton(SPath)
	local Tab = SavedServers[SPath]
	ServersG.Create(1,SPath,Tab[1],Tab[1],function()
		_G.TimGui.Modules.AskYN("You're sure want to join?",string.gsub(USureWantJoinWarn,"@n@",os.time()-Tab[2]),"Ты точно хочешь зайти?",string.gsub(USureWantJoinWarnRus,"@n@",os.time()-Tab[2]),function()
			_G.TimGui.Modules.Servers.Join(SPath)
		end)
	end)
end ServersG.Create(1,"SaveServer","Save server","Сохранить сервер",function()
	local SPath = _G.TimGui.Modules.Servers.GetThisServerPath()
	SavedServers[SPath] = {ServerCreateName.Value,os.time()}
	if ServersG.Objects[SPath] then ServersG.Objects[SPath].Destroy() end
	CreateSSButton(SPath)
end) for k,v in pairs(SavedServers) do
	if v[2]<ServersSavedLTime then
		SavedServers[k]=nil
	else CreateSSButton(k)
	end
end
