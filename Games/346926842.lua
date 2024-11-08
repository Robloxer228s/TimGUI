-- Musicaly chairs --
local MC = _G.TimGui.Groups.CreateNewGroup("Musicaly chairs","Музыкальные стулья")

local chairs = game.Workspace.Chairs
local function seat()
    chairs:WaitForChild("Chair") 
    for k,v in pairs(chairs:GetChildren()) do
        if not v:FindFirstChild("Seat") then continue end
        if v.Seat:FindFirstChild("SeatWeld") then continue end
        v.Seat:Sit(game.Players.LocalPlayer.Character.Humanoid)
        return
    end
    print("Chair not found") 
    game.Players.LocalPlayer.Character.Humanoid.Sit = true
end

MC.Create(1,"ButtB","Del boundary","Удалить барьер",function()
game.Workspace.Boundary:Destroy()
end)

MC.Create(1,"ButS","Sit to chair","Сесть на стул", function()
    seat()
end)

MC.Create(1,"ButSNC","Sit (not chair)","Сесть(не на стул)", function()
    seat()
end)

local autoB = MC.Create(2,"autoB","Auto del boundary","Авто удаление барьера")
local autoS = MC.Create(2,"autoS","Auto sit to chair","Авто садится на стул")
local autoSNC = MC.Create(2,"autoSNC","Auto sit(not chair)","Авто садится(не на стул)")


while task.wait(0.1) do
    if autoB.Value and game.Workspace:FindFirstChild("Boundary") then
        game.Workspace.Boundary:Destroy()
    end
    if not game.Players.LocalPlayer.Character then continue end
    if not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then continue end
    if autoS.Value and not game.Players.LocalPlayer.Character.Humanoid.Sit then
        seat()
    elseif autoSNC.Value and not game.Players.LocalPlayer.Character.Humanoid.Sit then
        game.Players.LocalPlayer.Character.Humanoid.Sit = true
    elseif not chairs:FindFirstChild("Chair") then
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
    end
end
