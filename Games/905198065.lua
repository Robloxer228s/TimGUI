-- Blocks and props
local group = _G.TimGui.Groups.CreateNewGroup("Game","Игра")

group.Create(1,"DelKillbrick","Del killbrick","Удалить убивалку",function()
    game.Workspace.Map.Classic.KillBrick:Destroy()
end)

group.Create(1,"Win","Win to tower","Победить за башню", function()
    if not game.Players.LocalPlayer.Team.Name == "Towers" then return end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Classic.Button.CFrame
end)
