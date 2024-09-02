_G.TimGui.Add.G("Musicaly chairs","Музыкальные стулья")

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

_G.TimGui.Add.B("ButtB","Del boundary","Musicaly chairs",1,"Удалить барьер",function()
game.Workspace.Boundary:Destroy()
end)

_G.TimGui.Add.B("ButS","Sit to chair","Musicaly chairs",2,"Сесть на стул", function()
    seat()
end)

_G.TimGui.Add.B("ButSNC","Sit (not chair)","Musicaly chairs",3,"Сесть(не на стул)", function()
    seat()
end)

local autoB = _G.TimGui.Add.CB("autoB","Auto del boundary","Musicaly chairs",4,"Авто удаление барьера")
local autoS = _G.TimGui.Add.CB("autoS","Auto sit to chair","Musicaly chairs",5,"Авто садится на стул")
local autoSNC = _G.TimGui.Add.CB("autoSNC","Auto sit(not chair)","Musicaly chairs",6,"Авто садится(не на стул)")


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
    end
end
