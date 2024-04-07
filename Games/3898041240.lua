_G.TimGui.Add.G("Leader", "Лидер") 
local leader = function()
for k, v in pairs(game.Players:GetChildren()) do
local hight = v.Character:FindFirstChild("LeaderHighlight")
if hight then
return hight.Parent
end
end
end


_G.TimGui.Add.B("Touch", "TP to leader", "Leader", 1, "ТП к лидеру", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end)

local ATP =  _G.TimGui.Add.CB("AutoTP", "AutoTP to leader", "Leader", 2, "АвтоТП к лидеру")

while true do
wait(0.05) 
pcall(function()
if ATP.Value then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end
end)
end
