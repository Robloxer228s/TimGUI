_G.TimGui.Add.G("Game","Игра")

_G.TimGui.Add.B("DelKillbrick","Del killbrick","Game",1,"Удалить убивалку",function()
    game.Workspace.Kill:Destroy()
end)

_G.TimGui.Add.B("Win","Win to tower","Game",2,"Победить за башню", function()
    if game.Players.LocalPlayer.Team.Name ~= "Survivors" then return end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Button.CFrame
end)
