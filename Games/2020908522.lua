-- Mega hide and seek
local HideASeek = _G.TimGui.Groups.CreateNewGroup("Mega hide and seek","Мега прятки")

HideASeek.Create(1,"TPTMoney","Grab all moneys","Взять все деньги",function()
    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    local oldCFrame = HRP.CFrame
    for k,v in pairs(game.Workspace.MapHolder:GetChildren()) do
        if v.Name == "Coin" then
            HRP.CFrame = v.CFrame
            wait()
        end
    end
    HRP.CFrame = oldCFrame
end)

HideASeek.Create(1,"FJ","Free jail","Освободить тюрьму",function()
    local jail = game.Workspace.MapHolder:FindFirstChildOfClass("Folder").Jail.Unlock
    local oldCFrame = jail.CFrame
    jail.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait()
    jail.CFrame = oldCFrame
end)

local unFreeze = HideASeek.Create(2,"HASUnfreeze","Auto unfreeze freezed players","Автоматически размораживать замороженных")

local ESPG = _G.TimGui.Groups.ESP
local Seekers =  ESPG.Create(2,"ESPSeekers","ESP to seekers","Подсветка на искателей")
local Hiders = ESPG.Create(2,"ESPHiders","ESP to hiders","Подсветка на прячущихся")

local function ESP(Who,Seek)
    local hl = Instance.new("Highlight",Who)
    hl.Name = "NotESP"
    hl.Adornee = Who
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    local color
    if Seek then
        color = Color3.new(1,0,0)
    else
        color = Color3.new(0,1,0)
    end
    hl.FillColor = color 
    hl.OutlineColor = color
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
end

while task.wait(0.5) do
pcall(function()
    if not game.Players.LocalPlayer.Character then return end
    local MyHRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    for k,v in pairs(game.Players:GetPlayers()) do
        local char = v.Character
        if not char then continue end
        if char:FindFirstChild("NotESP") then
            char.NotESP:Destroy()
        end
        if char:FindFirstChild("FreezeTagFrozenIce") then
            if unFreeze.Value then
                local oldCFrame = char.HumanoidRootPart.CFrame
                char.HumanoidRootPart.CFrame = MyHRP.CFrame
                wait()
                char.HumanoidRootPart.CFrame = oldCFrame
            end
        end
        if char:FindFirstChild("KillScript") and char:FindFirstChild("SpeedScript") then
            if Seekers.Value then
                ESP(char,true)
            end
        else
            if Hiders.Value then
                ESP(char,false)
            end
        end
    end
end)
end
