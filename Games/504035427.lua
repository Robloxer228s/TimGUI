-- Zombie Attack
local enemies = game.Workspace.enemies
local Player = game.Players.LocalPlayer
local function ESPto(Who)
    local hl = Instance.new("Highlight",Who)
    hl.Name = "NotESP"
    hl.Adornee = Who
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = Color3.new(0,1,0)
    hl.OutlineColor = Color3.new(0,1,0)
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
end

local EspG = _G.TimGui.Groups.ESP
local esp = EspG.Create(2,"ESPZ","ESP to zombie","Подсветка на зомби",function(val)
    if val.Value then
        for k,v in pairs(enemies:GetChildren()) do
            ESPto(v)
        end
    else
        for k,v in pairs(enemies:GetChildren()) do
            if v:FindFirstChild("NotESP") then
                v.NotESP:Destroy()
            end
        end
    end
end)

enemies.ChildAdded:Connect(function(child)
    if esp.Value then
        ESPto(child)
    end
end)

local group = _G.TimGui.Groups.CreateNewGroup("Zombie","Зомбаки")
local distY = group.Create(3,"DZY","Distance of attack(up):","Дистанция аттаки(в верх):")
local distZ = group.Create(3,"DZZ","Distance of attack(back):","Дистанция аттаки(назад):")
distY.Main.Text = 5
distZ.Main.Text = 10
local KillingBoss = false

group.Create(2,"AAZ","Auto attack zombie","Авто аттаковать зомбарей",function(value)
    while value.Value and task.wait(0.1) do
        if KillingBoss == true then continue end
        local zombie
        local ZH
        if enemies:FindFirstChildOfClass("Model") then
            zombie = enemies:FindFirstChildOfClass("Model").HumanoidRootPart
            ZH = enemies:FindFirstChildOfClass("Model").Head
        end
        if not zombie then continue end
        local HRP = Player.Character.HumanoidRootPart
        KillingBoss = nil
        while value.Value and task.wait() do
            local Y = tonumber(distY.Value)
            local Z = tonumber(distZ.Value)
            if Y == nil then
                Y = 5
            end if Z == nil then
                Z = 10
            end
            HRP.CFrame = zombie.CFrame * CFrame.new(1,Y,Z)
            game.Workspace.Camera.CFrame = CFrame.lookAt(HRP.Parent.Head.Position,ZH.Position)
            if not (zombie.Parent and HRP.Parent) then
                break
            elseif zombie.Parent.Parent ~= enemies then
                break
            end
        end
        KillingBoss = false
    end
end)

group.Create(2,"AAB","Auto attack boss","Авто аттаковать босса",function(value)
    while value.Value and task.wait(0.09) do
        if KillingBoss == nil then continue end
        local zombie
        local ZH
        local bossF = game.Workspace.BossFolder
        if bossF:FindFirstChildOfClass("Model") then
            zombie = bossF:FindFirstChildOfClass("Model").HumanoidRootPart
            ZH = bossF:FindFirstChildOfClass("Model").Head
        end
        if not zombie then continue end
        local HRP = Player.Character.HumanoidRootPart
        KillingBoss = true
        while value.Value and task.wait() do
            local Y = tonumber(distY.Text)
            local Z = tonumber(distZ.Text)
            if Y == nil then
                Y = 5
            end if Z == nil then
                Z = 10
            end
            HRP.CFrame = zombie.CFrame * CFrame.new(1,Y,Z)
            game.Workspace.Camera.CFrame = CFrame.lookAt(HRP.Parent.Head.Position,ZH.Position)
            if not (zombie.Parent and HRP.Parent) then
                break
            elseif zombie.Parent.Parent ~= bossF then
                break
            end
        end
        KillingBoss = false
    end
end)

local Powerups = game.Workspace.Powerups
group.Create(2,"ATPP","AutoTP to Powerups","Авто тп в усиления",function(val)
    while val.Value and task.wait(0.25) do
        local char = Player.Character
        if not char then
            return
        elseif not char:FindFirstChild("HumanoidRootPart") then
            return
        end
        local HRP = char.HumanoidRootPart
        local OldCF = HRP.CFrame
        for k,v in pairs(Powerups:GetChildren()) do 
            HRP.CFrame = v:FindFirstChildOfClass("Part").CFrame
            wait()
        end
        HRP.CFrame = OldCF
    end
end)
