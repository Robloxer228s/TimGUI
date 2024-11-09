-- Obby leader
local group = _G.TimGui.Groups.CreateNewGroup("Leader", "Лидер") 
local leader = function()
for k, v in pairs(game.Players:GetChildren()) do
  if v.Character:FindFirstChild("LeaderHighlight") then
    if _G.TimGui.Values.Spare[v.Name] then return nil end
      return v.Character
    end
   end
end


group.Create(1,"Touch","TP to leader","ТП к лидеру",function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end)

local ATP =  group.Create(2,"AutoTP","AutoTP to leader","АвтоТП к лидеру")

local boostEn = group.Create(2,"VisibleBoost","Set visible for boost","Делать усиление видимым")

while true do
wait(0.05) 
if not game.Players.LocalPlayer.Character then continue end
if not game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
if ATP.Value then
local lead = leader()
if lead then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end
end 
if boostEn.Value then
    game.Players.LocalPlayer.PlayerGui.StayOnScreen.Boost.Visible =  true
end
end
