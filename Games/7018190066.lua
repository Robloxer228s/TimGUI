local LocalPlayer = game.Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local ESP = _G.TimGui.Groups.ESP
local ESPTab = {}
ESP.Create(0,"DR","Deadly rails","Смертельные рельсы")

--LocalPlayer.Character:FindFirstChild("Shovel").SwingEvent:FireServer(mouse.Hit.LookVector)

local EnemiesESP = Instance.new("Folder",_G.TimGui.Path.gui)
local EnemiesESPValue = ESP.Create(2,"Enemies","Enemies(night)","Враги(ночные)")
local Enemies = game.Workspace.NightEnemies

local function ESPEnable(v,Fold,Color,val)
    if not ESPTab[v] then
        local Esp = Instance.new("Highlight",Fold)
        Esp.Adornee = v
        Esp.Enabled = val
        Esp.FillColor = Color
        Esp.OutlineColor = Color
        Esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ESPTab[v] = true
        v.AncestryChanged:Connect(function()
            Esp:Destroy()
            ESPTab[v] = nil
        end)
    end
end

task.spawn(function()
    while task.wait(0.5) do
        for k,v in pairs(Enemies:GetChildren()) do
            ESPEnable(v,EnemiesESP,Color3.new(1,0.1,0.1),EnimiesESPValue.Value)
        end
    end
end) EnemiesESPValue.OnChange(function(v)
    for _,va in pairs(EnemiesESP:GetChildren()) do
        va.Enabled = v.Value
    end
end)

local ItemsESP = Instance.new("Folder",_G.TimGui.Path.gui)
local ItemsESPValue = ESP.Create(2,"Items","Items","Вещи")
local Items = game.Workspace.RuntimeItems

task.spawn(function()
    while task.wait(0.5) do
        for k,v in pairs(Items:GetChildren()) do
            ESPEnable(v,ItemsESP,Color3.new(0.1,1,0.1),ItemsESPValue.Value)
        end
    end
end) ItemsESPValue.OnChange(function(v)
    for _,va in pairs(ItemsESP:GetChildren()) do
        va.Enabled = v.Value
    end
end)

local BuildsESP = Instance.new("Folder",_G.TimGui.Path.gui)
local BuildsESPValue = ESP.Create(2,"Buildings","Buildings","Постройки")
local Builds = game.Workspace.RandomBuildings

task.spawn(function()
    while task.wait(0.5) do
        for k,v in pairs(Builds:GetChildren()) do
            ESPEnable(v,BuildsESP,Color3.new(1,1,0.1),BuildsESPValue.Value)
        end
    end
end) BuildsESPValue.OnChange(function(v)
    for _,va in pairs(BuildsESP:GetChildren()) do
        va.Enabled = v.Value
    end
end)
