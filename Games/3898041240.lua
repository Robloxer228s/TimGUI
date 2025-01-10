-- Obby leader
local LocalPlayer = game.Players.LocalPlayer
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
LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end)

group.Create(1,"GetAllMoney","Get All Money","Собрать все монетки",function()
    local pos = LocalPlayer.Character.PrimaryPart.CFrame
    for k,v in pairs(game.Workspace.ClearAfterRound:GetChildren()) do
        if v.Name == "Coin" then
            if v.Union.Transparency == 0 then
                LocalPlayer.Character.PrimaryPart.CFrame = v.Union.CFrame
                wait()
            end
        end
    end
    LocalPlayer.Character.PrimaryPart.CFrame = pos
end)

local ATP =  group.Create(2,"AutoTP","AutoTP to leader","АвтоТП к лидеру")

local boostEn = group.Create(2,"VisibleBoost","Set visible for boost","Делать усиление видимым")
local autogeter = group.Create(2,"AutoGet","Auto Get Money","Брать монеты автоматом")

while true do
wait(0.05) 
if not LocalPlayer.Character then continue end
if not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
if ATP.Value then
local lead = leader()
if lead then
if not lead:FindFirstChild("HumanoidRootPart") then continue end
LocalPlayer.Character.HumanoidRootPart.CFrame = leader().HumanoidRootPart.CFrame
end
end 
if boostEn.Value then
    LocalPlayer.PlayerGui.StayOnScreen.Boost.Visible =  true
end
if autogeter.Value then
  if not LocalPlayer.Character.PrimaryPart then continue end
  local pos = LocalPlayer.Character.PrimaryPart.CFrame
    for k,v in pairs(game.Workspace.ClearAfterRound:GetChildren()) do
        if v.Name == "Coin" then
            if v.Union.Transparency == 0 then
                LocalPlayer.Character.PrimaryPart.CFrame = v.Union.CFrame
                wait()
            end
        end
    end
    LocalPlayer.Character.PrimaryPart.CFrame = pos
  end
end
