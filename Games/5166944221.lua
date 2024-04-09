--DeathBall
local userInputService = game:GetService("UserInputService")
local attach = true
_G.TimGui.Add.G("DeathBall")
local Auto = _G.TimGui.Add.CB("Auto","Auto(bug)","DeathBall",2,"Авто(баганый)")
local Arabic = _G.TimGui.Add.CB("Arabic","Arabic","DeathBall",3,"Арабик")
local AFK = _G.TimGui.Add.CB("AFK","AFK(tp to intermission)","DeathBall",4,"АФК(ТП в интермиссию)")
local radios = _G.TimGui.Add.TB("rad","Radius(0-off):","DeathBall",1,"Радиус(0-выкл):")
_G.TimGui.Add.B("spawn","TP to spawn","DeathBall",5,"ТП на спавн", function() 
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


local InterFrame = game.Players.LocalPlayer.PlayerGui.HUD.HolderBottom.IntermissionFrame
InterFrame.DescriptionLabel.Changed:Connect(function()
if InterFrame.Visible and AFK.Value then
if _G.debug then
print(game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.DescriptionLabel.Text)
end
if InterFrame.DescriptionLabel.Text == "INTERMISSION 5" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["New Lobby"].ReadyArea.ReadyZone.CFrame
end
end
end)

while true do
wait(0.05) 
local ball = game.Workspace:WaitForChild("Part") 
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
