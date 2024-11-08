-- Cart Ride into RDite
local function clc(obj,UoD)
    for k,v in pairs(obj:GetChildren()) do
        if v.Name == UoD then
            local detec = v:FindFirstChildOfClass("ClickDetector")
            if detec then
                fireclickdetector(detec)
            end
        end if v:IsA("Model") or v:IsA("folder") then
            clc(v,UoD)
        end
    end
end
local group = _G.TimGui.Groups.CreateNewGroup("Carts","Тележки")
local carts
for k,v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "Carts" then
        if v:FindFirstChildOfClass("Model") then
            carts = v
            break
        end
    end
end
group.Create(2,"Up","Auto spam for all UP","Авто нажимать на вверх",function(val)
    while task.wait() and val.Value do
        clc(carts,"Up")
    end
end)
group.Create(2,"Down","Auto spam for all DOWN","Авто нажимать на вниз",function(val)
    while task.wait() and val.Value do
        clc(carts,"Down")
    end
end)
