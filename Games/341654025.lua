-- Floor is lava
local group = _G.TimGui.Groups.CreateNewGroup("Floor is lava","Пол это лава")
group.Create(1,"CollectCoins","Collect coins","Собрать монеты",function()
	local cf = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
	for k,v in pairs(game.Workspace.CurrentMap:FindFirstChildOfClass("Model").Coins:GetChildren()) do
		if v:IsA("BasePart") then
			game.Players.LocalPlayer.Character.PrimaryPart.CFrame = v.CFrame
			wait()
		end
	end
	game.Players.LocalPlayer.Character.PrimaryPart.CFrame = cf
end)
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
