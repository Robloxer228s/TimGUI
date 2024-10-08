local enemies = game.Workspace.enemies
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

local esp = _G.TimGui.Add.CB("ESPZ","ESP to zombie","ESP",3,"Подсветка на зомби",function(val)
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

_G.TimGui.Add.G("Zombie","Зомбаки")
local distY = _G.TimGui.Add.TB("DZY","Distance of attack(up):","Zombie",1,"Дистанция аттаки(в верх):")
local distZ = _G.TimGui.Add.TB("DZZ","Distance of attack(back):","Zombie",2,"Дистанция аттаки(назад):")
distY.Text = 5
distZ.Text = 10
local KillingBoss = false

_G.TimGui.Add.CB("AAZ","Auto attack zombie","Zombie",3,"Авто аттаковать зомбарей",function(value)
    while value.Value and task.wait(0.1) do
        if KillingBoss == true then continue end
        local zombie
        local ZH
        if enemies:FindFirstChildOfClass("Model") then
            zombie = enemies:FindFirstChildOfClass("Model").HumanoidRootPart
            ZH = enemies:FindFirstChildOfClass("Model").Head
        end
        if not zombie then continue end
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
        KillingBoss = nil
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
            elseif zombie.Parent.Parent ~= enemies then
                break
            end
        end
        KillingBoss = false
    end
end)

_G.TimGui.Add.CB("AAB","Auto attack boss","Zombie",4,"Авто аттаковать босса",function(value)
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
        local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
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