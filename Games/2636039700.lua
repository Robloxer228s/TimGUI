_G.TimGui.Add.G("UP","Доберись до вершины")
_G.TimGui.Add.B("UP", "TP to finish", "UP", 1, "ТП в конец", function() 
local tp = game.Workspace:WaitForChild("TowerSpawn")
tp = tp:WaitForChild("TowerTop")
tp = tp:WaitForChild("EndingButton")
tp = tp:WaitForChild("TipTop")
tp = tp:WaitForChild("weldo")
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tp.CFrame
end) 
