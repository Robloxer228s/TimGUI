_G.TimGui.Add.G("Leader", "Лидер") 
local leader = function()
for k, v in pairs(game.Players:GetChildren()) do
local hight = v.Character:FindFirstChild("LeaderHighlight")
if hight then
if _G.TimGui.SpareFriends then
if v:IsFriendsWith(game.Players.LocalPlayer.UserId) then return end
end
return hight.Parent
end
end
end


_G.TimGui.Add.B("Touch", "TP to leader", "Leader", 1, "ТП к лидеру", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end)

local ATP =  _G.TimGui.Add.CB("AutoTP", "AutoTP to leader", "Leader", 2, "АвтоТП к лидеру")

local boostEn = _G.TimGui.Add.CB("VisibleBoost", "Set visible for boost", "Leader", 3, "Делать усиление видимым")

while true do
wait(0.05) 
pcall(function()
if ATP.Value then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end 
if boostEn.Value then
    game.Players.LocalPlayer.PlayerGui.StayOnScreen.Boost.Visible =  true
end
end)
