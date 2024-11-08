-- Chaos Jenga
local group = _G.TimGui.Groups.CreateNewGroup("Game","Игра")

group.Create(1,"DelKillbrick","Del killbrick","Удалить убивалку",function()
    game.Workspace.Kill:Destroy()
end)

group.Create(1,"Win","Win to tower","Победить за башню", function()
    if game.Players.LocalPlayer.Team.Name ~= "Survivors" then return end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Button.CFrame
end)
