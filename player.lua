_G.AGF("Main")
local WST = _G.ATBF("WalkspeedV","WalkSpeed:","Main",1) 
local WSB = _G.ABF("WalkspeedB", "Set walkSpeed", "Main", 2)
WSB.Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WST.Text
end)
local JT = _G.ATBF("JumpPowerV","JampPower:","Main",3) 
local JB = _G.ABF("JumpPowerB", "Set jampPower", "Main", 4)
JB.Activated:Connect(function()
game.Players.LocalPlayer.Character.Humanoid.JumpPower = JT.Text
end)

local PP = _G.ATBF("SpinV","SpinPower:","Main",5) 
local PB = _G.ACBF("SpinB", "Spining", "Main", 6)
PB.Changed:Connect(function()
if PB.Value then
wait(.1)
local bambam = Instance.new("BodyThrust")
bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bambam.Force = Vector3.new(PP.Text,0,PP.Text)
bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
else
game.Players.LocalPlayer.Character.HumanoidRootPart.BodyThrust:Destroy()
end
end)

local IJ = _G.ACBF("IJ", "Infinity Jump", "Main", 7)
local plr = game.Players.LocalPlayer  -- Переменная для игрока
IJ.Changed:Connect(function()
 local UserInputService = game:GetService("UserInputService")
 if (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) then
  local button = plr.PlayerGui.TouchGui.TouchControlFrame.JumpButton
  local function onButtonActivated()
   if IJ.Value then
    local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
    Humanoid:ChangeState("Jumping")
    wait(0.1)
    Humanoid:ChangeState("Seated")
   end
  end
  button.Activated:Connect(onButtonActivated)
 else
  local Player = game:GetService("Players").LocalPlayer
  local Mouse = Player:GetMouse()
  
  Mouse.KeyDown:Connect(function(k)
   if IJ.Value then
    if k.KeyCode == Enum.KeyCode.Space then  -- Использование Enum.KeyCode для клавиши Space
     local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
     Humanoid:ChangeState("Jumping")
     wait(0.1)
     Humanoid:ChangeState("Seated")
    end
   end
  end)
 end
end)

local TPT = _G.ABF("TPT", "TPTool", "Main", 8)
TPT.Activated:Connect(function()
local Tele = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
Tele.RequiresHandle = false
Tele.RobloxLocked = true
Tele.Name = "TPTool"
Tele.ToolTip = "Teleport Tool"
Tele.Equipped:connect(function(Mouse)
Mouse.Button1Down:connect(function()
if Mouse.Target then
game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart.CFrame = (CFrame.new(Mouse.Hit.x, Mouse.Hit.y + 5, Mouse.Hit.z))
end
end)
end)
end)

local Noclip = _G.ACBF("Noclip","Noclip","Main",9)
local Stepped
Noclip.Changed:Connect(function()
if Noclip.Value then
Stepped = game:GetService("RunService").Stepped:Connect(function()
if Noclip.Value then
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end
else
Stepped:Disconnect()
end
end)
else
Clipon = false
Status.TextColor3 = Color3.new(170,0,0)
end
end)

_G.AGF("ESP")
local espLoad = false
local ESPV = _G.ACBF("Esp","ESP-Main","ESP",1) 
local ESPTC = _G.ACBF("Esptc", "Use Team Color(esp-main)", "ESP", 2) 

ESPV.Changed:Connect(function() 
if not espLoad then
for k,player in pairs(game.Players:GetChildren()) do
if not (player == game.Players.LocalPlayer) then
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end)
end
end
game.Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end) 
end) 
end
espLoad = true
for k,player in pairs(game.Players:GetChildren()) do
if ESPV.Value and not (player == game.Players.LocalPlayer) then
local ESP = Instance.new("Highlight")
ESP.Parent = player.Character
ESP.Name = "NotEsp"
ESP.Adornee = player.Character
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
else
local Esp = player.Character:FindFirstChildOfClass("Highlight") 
if Esp then
Esp:Destroy()
end
end
end
end)

ESPTC.Changed:Connect(function() 
if ESPV.Value then
for k,player in pairs(game.Players:GetChildren()) do
if ESPV.Value then
local ESP = player.Character:FindFirstChild("NotEsp")
if ESP then
if ESPTC.Value then
ESP.FillColor = player.TeamColor.Color
else
ESP.FillColor = Color3.new(1,1,1)
end
end
end
end
end
end) 
