_G.TimGui.Add.G("Game","Игра")

_G.TimGui.Add.B("DelKillbrick","Del killbrick","Game",1,"Удалить убивалку",function()
    game.Workspace.Map.Classic.KillBrick:Destroy()
end)

_G.TimGui.Add.B("Win","Win to tower","Game",2,"Победить за башню", function()
    if not game.Players.LocalPlayer.Team.Name == "Towers" then return end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Classic.Button.CFrame
end)
