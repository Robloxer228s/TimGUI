_G.TimGui.Add.G("Floor is lava","Пол это лава")
local ClearLava = _G.TimGui.Add.CB("ClearLava","Clear Lava","Floor is lava",1,"Очищать лаву",function()
    if game.Workspace:FindFirstChild("LavaPart") then
        game.Workspace.LavaPart:Destroy()
    end
end)

while task.wait() do
    if ClearLava.Value then
        game.Workspace.Terrain:Clear()
    end
end
