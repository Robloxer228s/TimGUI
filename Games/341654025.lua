-- Floor is lava
local group = _G.TimGui.Groups.CreateNewGroup("Floor is lava","Пол это лава")
local ClearLava = group.Create(2,"ClearLava","Clear Lava","Очищать лаву",function()
    if game.Workspace:FindFirstChild("LavaPart") then
        game.Workspace.LavaPart:Destroy()
    end
end)

while task.wait() do
    if ClearLava.Value then
        game.Workspace.Terrain:Clear()
    end
end
