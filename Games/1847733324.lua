-- Cart + car ride into giga noob
local group = _G.TimGui.Groups.CreateNewGroup("Carts1","Тележки")
local on = group.Create(2,"on","On all carts","Включить все тележки")
local off = group.Create(2,"off","Off all carts","Выключить все тележки",function(val)
    if val.Value then on.Main.Value = false end
end)
on.OnChange(function(val)
    if val.Value then off.Main.Value = false end
end)
local up = group.Create(2,"Up","Auto spam for all UP","Авто нажимать на вверх")
local down = group.Create(2,"Down","Auto spam for all DOWN","Авто нажимать на вниз")

local function finder(obj)
    local name = obj.Name
    if name == "Up" then
        if up.Value then
            return true
        end
    elseif name == "Down" then
        if down.Value then
            return true
        end
    elseif name == "On" then
        if string.sub(obj.Color.R,3,3) == "7" then
            if on.Value then
                return true
            end
        else
            if off.Value then
                return true
            end
        end
    end
    return false
end

local function clc(obj)
    for k,v in pairs(obj:GetChildren()) do
        if finder(v) then
            local detec = v:FindFirstChildOfClass("ClickDetector")
            if detec then
                fireclickdetector(detec)
            end
        end if v:IsA("Model") or v:IsA("folder") then
            clc(v)
        end
    end
end
local carts = game.Workspace.Building.Baseplate["Carts + Jeeps"]
local cartstwo = game.Workspace.Building.HalfWay.Carts

while task.wait() do
    clc(carts)
    clc(cartstwo)
end
