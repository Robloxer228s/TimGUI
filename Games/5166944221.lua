local group = _G.TimGui.Groups.CreateNewGroup("DeathBall")
local BallShadow,Ball
local LP = game.Players.LocalPlayer
local WhiteB = Color3.new(1, 1, 1)
local LastBallPos,LastYPos
local SpeedMulty = 5
local RaycastParam = RaycastParams.new()
RaycastParam.FilterType = Enum.RaycastFilterType.Exclude
local FilterRP = {game.Workspace.FX}
RaycastParam.FilterDescendantsInstances = FilterRP
local function AddToFilter(Inst)
    table.insert(FilterRP,Inst)
end _G.TimGui.Modules.Players.ForEveryone(function(Player)
    Player.CharacterAdded:Connect(AddToFilter)
    if Player.Character then AddToFilter(Player.Character) end
end,false)
group.Create(3,"AutoParrySpeedMulty","AutoParry distance multy:","Множитель дистанции для отбива:",function(val)
    if tonumber(val.Value) then SpeedMulty=tonumber(val.Value) end
end).Main.Text = SpeedMulty
local AutoParry = group.Create(2,"AutoParry","AutoParry","Авто отбивать")
local EnableRaycast = group.Create(2,"RaycastEnable","Enable raycast","Включить raycast(проверка стен)")
local TryToAnticipate = group.Create(2,"TryToAnticipate","try to anticipate speed changing","Попытаться предугадать следующую скорость")
local useClickF = pcall(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
    task.wait()
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
end) if not useClickF then
    group.Create(0,"WarnMouse","Using mouse clicks","Использует нажатия мыши")
end
local function Parry()
    print("Parry")
    if useClickF then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
        task.wait()
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
    else mouse1click()
    end
end local Interm = LP.PlayerGui.HUD.HolderBottom.IntermissionFrame
local function AFKTP()
    if Interm.Visible then
        LP.Character.PrimaryPart.CFrame = game.Workspace["New Lobby"].ReadyArea.ReadyZone.CFrame
    end
end local TPToInter = group.Create(2,"AFK","TP to intermission","ТП в интермиссию",function(v)
    if v.Value then
        AFKTP()
    end 
end) Interm:GetPropertyChangedSignal("Visible"):Connect(function()
    if TPToInter.Value then
        task.wait(5)
        AFKTP()
    end
end) local function CheckRaycast(Pos,Pos2)
    if EnableRaycast.Value then
        local Dir = Pos2-Pos
        local ray = game.Workspace:Raycast(Pos,Dir,RaycastParam)
        if ray then print(ray.Instance:GetFullName()) end
        return not ray
    else return true
    end
end
while task.wait() do
    if not BallShadow or not Ball then
        BallShadow = game.Workspace.FX:WaitForChild("BallShadow",math.huge)
        Ball = game.Workspace:WaitForChild("Part",math.huge)
        AddToFilter(Ball)
        LastBallPos = nil
        LastYPos = nil
    elseif not BallShadow.Parent or not Ball.Parent then
        Ball,BallShadow = nil,nil
    else local BallPos = BallShadow.Position
        if not LastBallPos then LastBallPos = BallPos end
        local moveDir = (LastBallPos-BallPos)
        local speed = (moveDir.Magnitude-math.abs(moveDir.Y)+0.5)*SpeedMulty
        if AutoParry.Value and Ball.Highlight.FillColor ~= WhiteB then
            local HRP = LP.Character.PrimaryPart
            local distance = (HRP.Position-BallPos).Magnitude-math.abs(HRP.Position.Y-BallPos.Y)
            if TryToAnticipate.Value then
                if game.Workspace:Raycast(BallPos,moveDir,RaycastParam) then
                    speed = speed/2
                end
            end local y = (BallShadow.Decal.Transparency-0.3)*400
            if distance<speed then
                if CheckRaycast(HRP.Position,BallPos) then
                    local yMagn = math.abs((BallPos.Y+y)-HRP.Position.Y)
                    if not LastYPos then LastYPos = y end
                    if yMagn<(speed+math.abs(LastYPos-y)*SpeedMulty) then
                        Parry()
                    else print("YMagnitude blocked, ymagn:",yMagn)
                    end
                else print("Parry blocked!")
                end
            end
        end LastYPos = y
        LastBallPos = BallPos
    end 
end
