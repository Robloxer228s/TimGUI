--Mussically chairs
local MC = _G.TimGui.Groups.CreateNewGroup("Musicaly chairs","Музыкальные стулья")
local LocalPlayer = game.Players.LocalPlayer
local Chairs = game.Workspace.SpinnerStuff.ChairSpots
local function Sit(printer)
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            if hum.Sit then return end
            for _,v in pairs(Chairs:GetChildren()) do
                local seat = v:FindFirstChild("Seat")
                if seat then
                    if seat:GetChildren()[1] == nil then
                        seat:Sit(hum)
                        return seat
                    end
                end
            end
            if printer then
                _G.TimGui.Print("Chairs","Not found","Стулья","не найдены")
            end
        end
    end
end

MC.Create(1,"Sit","Sit on chair","Сесть на стул",function() Sit(true) end)

local autoSit = MC.Create(2,"AutoSit","Autosit on chair","Автосадиться на стул")

while task.wait(0.15) do
    if autoSit.Value then
        Sit(false)
    end
end
