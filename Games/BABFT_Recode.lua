local LocalPlayer = game.Players.LocalPlayer
local TweenService = game.TweenService
--game.Workspace.BoatStages.OtherStages.ToyFactoryStage.Water
local ChestTrigger = game.Workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Trigger
local OriginalPosChest = ChestTrigger.CFrame
local function TakeFinalChest(time)
    ChestTrigger.CFrame=LocalPlayer.Character.PrimaryPart.CFrame
    task.wait(time or 1)
    ChestTrigger.CFrame=OriginalPosChest
end local group = _G.TimGui.Groups.CreateNewGroup("recode BABFT","ещё ПОСТРОЙ КОРАБЛЬ")
group.Create(1,"TakeFinalChest","Take final golden chest","Взять последний золотой сундук",function()
    TakeFinalChest()
end)
local AFKStartPos = Vector3.new(-40, 40, 1270)
local AFKEndPos = Vector3.new(AFKStartPos.X,AFKStartPos.Y, 8415)
local timeForAFK = 20
local function AFKFunctionStart()
    local Char = LocalPlayer.Character
    Char.PrimaryPart.CFrame = CFrame.new(AFKStartPos)
    local AlignPos = Instance.new("AlignPosition",Char)
    AlignPos.Position = AFKStartPos
    AlignPos.MaxForce = math.huge
    AlignPos.MaxVelocity = math.huge
    AlignPos.Mode = Enum.PositionAlignmentMode.OneAttachment
    AlignPos.Attachment0 = Instance.new("Attachment",Char.PrimaryPart)
    TweenService:Create(AlignPos,TweenInfo.new(timeForAFK,Enum.EasingStyle.Linear),{
        Position=AFKEndPos
    }):Play()
    task.wait(timeForAFK-7.5)
    for i=1,15 do
        if not Char.Parent then return end
        TakeFinalChest(1.5)
        task.wait(1)
    end if Char.Parent then
        Char:FindFirstChildOfClass("Humanoid").Health = 0
    end
end
group.Create(3,"AFKSpeed","AFK speed(seconds):","Скорость АФК(секунды):",function(val)
    local new = tonumber(val.Value)or-1
    if new>0 then
        timeForAFK = new
    end
end).Main.Text = timeForAFK
local newAFK = group.Create(2,"AFK","AFK","AFK",function(v)
    if v.Value then
        AFKFunctionStart()
    else
        _G.TimGui.Modules.Print("AFK","Please,wait","AFK","Пожалуйста, подожди")
    end
end) LocalPlayer.CharacterAdded:Connect(function(Char)
    Char:WaitForChild("HumanoidRootPart")
    if newAFK.Value then
        AFKFunctionStart()
    end
end) 
local DisableObstacles = group.Create(2,"DisableObst","Disable Obstacles","Выключить препятствия",function(val)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            if v:FindFirstChild("BreakEvent") then
                v.CanCollide = not val.Value
                v.CanTouch = not val.Value
            end
        end
    end
end)

local WaterSpeed = 1
group.Create(3,"WaterSpeed","Water speed(1=default):","Скорость воды(1=default):",function(val)
    local new = tonumber(val.Value)or-1
    if new>=0 then
        WaterSpeed = new
    end
end)
local CustomWaterSpeed = group.Create(2,"CustomWaterSpeed","Enable custom water speed","Включить свою скорость воды",function(val)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name == "Water"or v.Name=="Sand") then
            if val.Value then
                v.Velocity = Vector3.new(0,0,25*WaterSpeed)
            else v.Velocity = Vector3.new(0,0,25)
            end
        end
    end
end) local DisableWater = group.Create(2,"DisableWater","Disable water","Выключить воду",function(val)
    for k,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Water" then
            v.CanTouch = not val.Value
        end
    end
end) game.Workspace.DescendantAdded:Connect(function(child)
    if child:IsA("BasePart") then
        task.wait()
        if child.Name=="Water" then
             if CustomWaterSpeed.Value then
                if (v.Name == "Water"or v.Name=="Sand") then
                    v.Velocity = Vector3.new(0,0,25*WaterSpeed)
                end
            end if DisableWater.Value then
                v.CanTouch = false
            end 
        elseif DisableObstacles.Value then
            if child:FindFirstChild("BreakEvent") then
                child.CanTouch = false
                child.CanCollide = false
            end
        end
    end
end)
