_G.TimGui.Add.G("Hide and seek","Прятки")

_G.TimGui.Add.B("TPTMoney","Grab all moneys","Hide and seek",1,"Взять все деньги",function()
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

_G.TimGui.Add.B("FJ","Free jail","Hide and seek",2,"Освободить тюрьму",function()
    local jail = game.Workspace.MapHolder:FindFirstChildOfClass("Folder").Jail.Unlock
    local oldCFrame = jail.CFrame
    jail.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait()
    jail.CFrame = oldCFrame
end)

local unFreeze = _G.TimGui.Add.CB("HASUnfreeze","Auto unfreeze freezed players","Hide and seek",3,"Автоматически размораживать замороженных")

local Seekers = _G.TimGui.Add.CB("ESPSeekers","ESP to seekers","ESP",3,"Подсветка на искателей")
local Hiders = _G.TimGui.Add.CB("ESPHiders","ESP to hiders","ESP",4,"Подсветка на прячущихся")

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
    if not game.Players.LocalPlayer.Character then continue end
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
