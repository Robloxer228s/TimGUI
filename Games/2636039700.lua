_G.AGF("UP","Доберись до вершины")
_G.ABF("UP", "TP to finish", "UP", 1, "ТП в конец", function() 
local tp = game.Workspace:WaitForChild("TowerSpawn")
tp = tp:WaitForChild("TowerTop")
tp = tp:WaitForChild("EndingButton")
tp = tp:WaitForChild("TipTop")
tp = tp:WaitForChild("weldo")
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tp.CFrame
end) 
