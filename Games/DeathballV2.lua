local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local group = _G.TimGui.Groups.CreateNewGroup("DeathBall v2")

local LP = game.Players.LocalPlayer
local BallShadow, RealBall
local WhiteColor = Color3.new(1, 1, 1)
local LastBallPos
local SpeedMulty = 3
local AutoParryEnabled = true

local ParryDistance = 15
local ReactionTime = 0.0001
local SafetyMargin = 1.3

local AutoClickerEnabled = false
local ClickSpeed = 1000
local LastClickTime = 0.00001

local LastParryTime = 0
local ParryCooldown = 0.00001
local IsParrying = false

local VisualZoneEnabled = true
local ZoneSphere = nil

local Coordinates = group.Create(0,"Coordinates","X: 0.0 | Y: 0.0 | Z: 0.0\nSpeed: 0.0 | Height: 0.0 | Shadow: 0.0",nil)
local Status = group.Create(0,"Status","Searching for ball...",nil)
local Distance = group.Create(3,"Distance","Distance:","Дистанция")
Distance.Main.Text = ParryDistance

local useClickF = true

local function CreateZoneSphere()
    if ZoneSphere then
        ZoneSphere:Destroy()
    end
    
    ZoneSphere = Instance.new("Part")
    ZoneSphere.Name = "ParryZoneSphere"
    ZoneSphere.Anchored = true
    ZoneSphere.CanCollide = false
    ZoneSphere.Material = Enum.Material.Neon
    ZoneSphere.BrickColor = BrickColor.new("Bright red")
    ZoneSphere.Transparency = 0.8
    ZoneSphere.Shape = Enum.PartType.Ball
    ZoneSphere.Size = Vector3.new(ParryDistance * 2, ParryDistance * 2, ParryDistance * 2)
    ZoneSphere.Parent = workspace
    
    return ZoneSphere
end

local function UpdateZoneSphere()
    if not ZoneSphere or not VisualZoneEnabled then return end
    
    if LP.Character and LP.Character.PrimaryPart then
        local characterPos = LP.Character.PrimaryPart.Position
        ZoneSphere.Position = characterPos
        ZoneSphere.Size = Vector3.new(ParryDistance * 2, ParryDistance * 2, ParryDistance * 2)
        
        if AutoParryEnabled then
            ZoneSphere.BrickColor = BrickColor.new("Bright green")
        else
            ZoneSphere.BrickColor = BrickColor.new("Bright red")
        end
    end
end

local function ToggleVisualZone(value)
    VisualZoneEnabled = not VisualZoneEnabled
	if value~=nil then VisualZoneEnabled = value end
    if VisualZoneEnabled then
        if not ZoneSphere then
            CreateZoneSphere()
        else
            ZoneSphere.Transparency = 0.8
        end
    else
        if ZoneSphere then
            ZoneSphere.Transparency = 1
        end
    end
end

local function GetBallColor()
    if not RealBall then return WhiteColor end
    local highlight = RealBall:FindFirstChildOfClass("Highlight")
    if highlight then
        return highlight.FillColor
    end
    local surfaceGui = RealBall:FindFirstChildOfClass("SurfaceGui")
    if surfaceGui then
        local frame = surfaceGui:FindFirstChildOfClass("Frame")
        if frame and frame.BackgroundColor3 then
            return frame.BackgroundColor3
        end
    end
    
    if RealBall:IsA("Part") and RealBall.BrickColor ~= BrickColor.new("White") then
        return RealBall.Color
    end
    
    return WhiteColor
end

local function UltraAutoClicker()
    if not useClickF or not AutoClickerEnabled then return end
    
    local currentTime = tick()
    local timeBetweenClicks = 1 / ClickSpeed
    
    if currentTime - LastClickTime >= timeBetweenClicks then
        VirtualInputManager:SendKeyEvent(true, "F", false, game)
        task.wait(0.00001)
        VirtualInputManager:SendKeyEvent(false, "F", false, game)
        LastClickTime = currentTime
    end
end

local function Parry()
    if IsParrying then return end
    
    IsParrying = true
    local currentTime = tick()
    
    if currentTime - LastParryTime < ParryCooldown then
        IsParrying = false
        return
    end
    
    if useClickF then
        VirtualInputManager:SendKeyEvent(true, "F", false, game)
        task.wait(0.00001)
        VirtualInputManager:SendKeyEvent(false, "F", false, game)
    else 
        mouse1click()
    end
    
    LastParryTime = currentTime
    IsParrying = false
end

local function CalculateBallHeight(shadowSize)
    local baseShadowSize = 5
    local heightMultiplier = 8
    
    local shadowIncrease = math.max(0, shadowSize - baseShadowSize)
    local estimatedHeight = shadowIncrease * heightMultiplier
    
    return math.min(estimatedHeight, 50)
end

local function GetMaxHeightBySpeed(speedStuds)
    if speedStuds < 10 then
        return 225
    else
        return 240
    end
end

local function CalculateOptimalParryDistance(speed, horizontalDistance, ballHeight, playerPosY, ballPosY)
    local maxHeight = GetMaxHeightBySpeed(speed)
    if (ballPosY - playerPosY) > maxHeight then
        return math.huge
    end
    
    local baseDistance = ParryDistance
    local reactionDistance = speed * ReactionTime * SafetyMargin
    local optimalDistance = baseDistance + reactionDistance
    
    if speed > 20 then
        optimalDistance = optimalDistance * 1.4
    elseif speed > 12 then
        optimalDistance = optimalDistance * 1.3
    elseif speed > 6 then
        optimalDistance = optimalDistance * 1.2
    end
    
    return optimalDistance
end

local function IsBallComingTowardsPlayer(ballPos, lastPos, playerPos)
    if not lastPos then return true end
    
    local ballToPlayer = (playerPos - ballPos).Unit
    local ballMovement = (ballPos - lastPos).Unit
    
    local dotProduct = ballToPlayer:Dot(ballMovement)
    
    return dotProduct > 0.1
end
Distance.OnChange(function()
	local newDistance = tonumber(Distance.Value)
	if newDistance then
		ParryDistance = newDistance
		if ZoneSphere and VisualZoneEnabled then
			ZoneSphere.Size = Vector3.new(ParryDistance * 2, ParryDistance * 2, ParryDistance * 2)
		end
	end
end)

group.Create(2,"AutoParry","AutoParry","Авто отбивание",function(val)
	AutoParryEnabled = val.Value
end).Main.Value = AutoParryEnabled
group.Create(2,"AutoClickerEnabled","Autoclicker","Автокликер",function(val)
	AutoClickerEnabled = val.Value
end)
group.Create(2,"ToggleVisualZone","Visible Zone","Видить зону",function(val)
	ToggleVisualZone(val.Value)
end)

CreateZoneSphere()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        MainFrame.Visible = not MainFrame.Visible
    
    elseif input.KeyCode == Enum.KeyCode.E then
        AutoClickerEnabled = not AutoClickerEnabled
        ClickerButton.BackgroundColor3 = AutoClickerEnabled and Color3.new(0.2, 0.8, 0.2) or Color3.new(0.3, 0.3, 0.3)
        ClickerButton.Text = AutoClickerEnabled and "Clicker ON" or "Clicker OFF"
    
    elseif input.KeyCode == Enum.KeyCode.F then
        Parry()
    end
end)

coroutine.wrap(function()
    local BallVelocity = Vector3.new(0, 0, 0)
    local LastBallPosForVelocity = nil
    local LastParryCheckTime = 0
    local ParryCheckCooldown = 0.0001

    while true do
        task.wait(0.0001)
        
        UpdateZoneSphere()
        
        if AutoClickerEnabled and useClickF then
            UltraAutoClicker()
        end
        
        if not BallShadow then
            BallShadow = game.Workspace.FX:FindFirstChild("BallShadow")
        end
        
        if not RealBall then
            RealBall = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Part")
        end
        
        if BallShadow then
            if not LastBallPos then
                LastBallPos = BallShadow.Position
                LastBallPosForVelocity = BallShadow.Position
                Status.TextObject.Text = "Ball found"
            end
        else
            Status.TextObject.Text = "Searching for ball..."
        end
        
        if BallShadow and (not BallShadow.Parent) then
            Status.TextObject.Text = "Ball removed"
            BallShadow = nil
            RealBall = nil
        end
        
        if BallShadow and LP.Character and LP.Character.PrimaryPart then
            local BallPos = BallShadow.Position
            local PlayerPos = LP.Character.PrimaryPart.Position
            
            if not LastBallPos then 
                LastBallPos = BallPos 
            end

            if LastBallPosForVelocity then
                local deltaTime = 0.0001
                BallVelocity = (BallPos - LastBallPosForVelocity) / deltaTime
            end
            LastBallPosForVelocity = BallPos
            
            local currentShadowSize = BallShadow.Size.X
            local ballHeight = CalculateBallHeight(currentShadowSize)
            local ballPosY = BallPos.Y + ballHeight
            
            local moveDir = (LastBallPos - BallPos)
            local rawSpeed = moveDir.Magnitude
            local horizontalSpeed = Vector3.new(moveDir.X, 0, moveDir.Z).Magnitude
            local speedStuds = (horizontalSpeed + 0.25) * SpeedMulty
            
            local horizontalDistance = (Vector3.new(PlayerPos.X, 0, PlayerPos.Z) - Vector3.new(BallPos.X, 0, BallPos.Z)).Magnitude
            local verticalDistance = ballPosY - PlayerPos.Y
            
            local ballColor = GetBallColor()
            local isBallWhite = ballColor == WhiteColor
            
            local maxHeight = GetMaxHeightBySpeed(speedStuds)
            
            local isComingTowardsPlayer = IsBallComingTowardsPlayer(BallPos, LastBallPos, PlayerPos)
            local optimalDistance = CalculateOptimalParryDistance(speedStuds, horizontalDistance, ballHeight, PlayerPos.Y, ballPosY)
            
            Coordinates.TextObject.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f\nSpeed: %.1f studs/s | Height: %.1f | Shadow: %.1f", 
                BallPos.X, ballPosY, BallPos.Z, speedStuds, ballHeight, currentShadowSize)
            
            if isBallWhite then
                Status.TextObject.Text = "White ball - safe"
            elseif verticalDistance > maxHeight then
                Status.TextObject.Text = "Ball too high (" .. maxHeight .. ")"
            else
                Status.TextObject.Text = "Dangerous ball"
            end
            
            local currentTime = tick()
            if AutoParryEnabled and currentTime - LastParryCheckTime > ParryCheckCooldown then
                local shouldParryNow = horizontalDistance <= optimalDistance 
                    and isComingTowardsPlayer 
                    and verticalDistance <= maxHeight
                    and not isBallWhite
                
                if shouldParryNow then
                    Parry()
                end
                
                LastParryCheckTime = currentTime
            end
            
            LastBallPos = BallPos
        else
            Coordinates.TextObject.Text = "X: 0.0 | Y: 0.0 | Z: 0.0\nSpeed: 0.0 studs/s | Height: 0.0 | Shadow: 0.0"
        end
    end
end)()
