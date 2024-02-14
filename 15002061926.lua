--DeathBall
local userInputService = game:GetService("UserInputService")
local attach = true
_G.AGF("DeathBall")
local Auto = _G.ACBF("Auto","Auto","DeathBall",2)
local Arabic = _G.ACBF("Arabic","Arabic","DeathBall",3)
local AFK = _G.ACBF("AFK","AFK","DeathBall",4)
local radios = _G.ATBF("rad","Radius:","DeathBall",1)
local spawn = _G.ABF("spawn","TP to spawn","DeathBall",5)
spawn.Activated:Connect(function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.SpawnLocation.CFrame
end) 
radios.Text = 0
radios:GetPropertyChangedSignal("Text"):Connect(function()
local without_letters = string.gsub(radios.Text, "[A-z]","")
if without_letters == radios.Text then
return
end
radios.Text = without_letters
end)


local rad = 0
local RB = Color3.new(1, 0, 0) 
local prev  = 0

local function CLC()
if attach then
game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game) 
attach = false
prev = 0
rad = 0
end
end

game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.DescriptionLabel.Changed:Connect(function()
if game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.Visible and AFK.Value then
if _G.debug then
print(game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.DescriptionLabel.Text)
end
if game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.DescriptionLabel.Text == "INTERMISSION 5" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["New Lobby"].ReadyArea.ReadyZone.CFrame
end
end
end)

while true do
wait(0.05) 
local ball = game.Workspace.FX:WaitForChild("Mobile_Default") 
if ball.Highlight.FillColor == RB then
local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local pos = 0
local Check = ball.CFrame.X - playerPos.X
if Check < 0 then
Check = - Check
end
pos = pos + Check
local Check = ball.CFrame.Y - playerPos.Y
if Check < 0 then
Check = - Check
end
pos = pos + Check
local Check = ball.CFrame.Z - playerPos.Z
if Check < 0 then
Check = - Check
end
pos = pos + Check
if radios.Text == "" then
radios.Text = 1
end
if Auto.Value == true then
rad = 0
if not prev == 0 then
local check = prev.X - ball.CFrame.X
if check < 0 then
check = - check
end
rad = rad + check
check = prev.Y - ball.CFrame.Y
if check < 0 then
check = - check
end
rad = rad + check
check = prev.Z - ball.CFrame.Z
if check < 0 then
check = - check
end
rad = rad + check
rad = rad * 3
end
prev = ball.CFrame
if pos < rad or pos < 50 then
if _G.debug then
print(rad)
end
CLC() 
end
elseif Arabic.Value then
CLC()
wait(0.05)
for v=1,20 do
if ball.Highlight.FillColor == RB then
wait(0.05)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame
end
end
elseif pos < radios.Text*50 then
CLC() 
end
elseif not (ball.Highlight.FillColor == RB) then
attach = true
end
end
