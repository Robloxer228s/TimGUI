local group = _G.TimGui.Groups.CreateNewGroup("DeathBall_FIXED24?")
local BallShadow,Ball
local LP = game.Players.LocalPlayer
local WhiteB = Color3.new(1, 1, 1)
local LastBallPos
local SpeedMulty = 5
group.Create(3,"AutoParrySpeedMulty","AutoParry distance multy:","Множитель дистанции для отбива:",function(val)
    if tonumber(val.Value) then SpeedMulty=tonumber(val.Value) end
end).Main.Text = SpeedMulty
local AutoParry = group.Create(2,"AutoParry","AutoParry","Авто отбивать")
local function Parry()
    print("Parry")
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
    task.wait()
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
end local HPBar = LP.PlayerGui.HUD.HealthBar
local function AFKTP()
    if not HPBar.Visible then
        LP.Character.PrimaryPart.CFrame = game.Workspace["New Lobby"].ReadyArea.ReadyZone.CFrame
    end
end local TPToInter = group.Create(2,"AFK","TP to intermission","ТП в интермиссию",function(v)
    if v.Value then
        AFKTP()
    end
end) HPBar:GetPropertyChangedSignal("Visible"):Connect(function()
    if TPToInter.Value then
        task.wait(5)
        AFKTP()
    end
end)
while task.wait() do
    if not BallShadow or not Ball then
        BallShadow = game.Workspace.FX:WaitForChild("BallShadow",math.huge)
        Ball = game.Workspace:WaitForChild("Part",math.huge)
        LastBallPos = nil
    elseif not BallShadow.Parent or not Ball.Parent then
        Ball,BallShadow = nil,nil
    else
        local BallPos = BallShadow.Position
        if not LastBallPos then LastBallPos = BallPos end
        local moveDir = (LastBallPos-BallPos)
        local speed = (moveDir.Magnitude-math.abs(moveDir.Y)+0.25)*SpeedMulty
        if AutoParry.Value and Ball.Highlight.FillColor ~= WhiteB then
            local HRP = LP.Character.PrimaryPart
            local distance = (HRP.Position-BallPos).Magnitude
            if distance<speed then
                Parry()
            end
        end
        LastBallPos = BallPos
    end 
end
