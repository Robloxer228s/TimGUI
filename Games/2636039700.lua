-- GET TO THE TOP!
local up = _G.TimGui.Groups.CreateNewGroup("UP","Доберись до вершины")
up.Create(1,"UP","TP to finish","ТП в конец",function() 
	local tp = game.Workspace:WaitForChild("TowerSpawn")
	tp = tp:WaitForChild("TowerTop")
	tp = tp:WaitForChild("EndingButton")
	tp = tp:WaitForChild("TipTop")
	tp = tp:WaitForChild("weldo")
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tp.CFrame
end) 
