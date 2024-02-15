--MM2
local ESP = _G.ACBF("ESP", "MM2", "ESP", 3)
local ESPM = _G.ACBF("ESPM", "ESP Murder", "ESP", 4)
local ESPS = _G.ACBF("ESPS", "ESP Sheriff", "ESP", 5)
local ESPA = _G.ACBF("ESPA", "ESP All", "ESP", 6)
local ESPGD = _G.ACBF("ESPGD", "ESP Dropped gun", "ESP", 7)
local murd
local sher 
_G.AGF("MM2") 
local TDG = _G.ABF("TPM", "TP to dropped gun", "MM2", 4)
TDG.Activated:Connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.GunDrop.CFrame
end) 


local TPM = _G.ABF("TPM", "TP to murder", "MM2", 1)
TPM.Activated:Connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = murd.Character.HumanoidRootPart.CFrame
end) 

local TPS = _G.ABF("TPS", "TP to sheriff", "MM2", 2)
TPS.Activated:Connect(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sher.Character.HumanoidRootPart.CFrame
end) 

local KA = _G.ABF("KA", "Kill All", "MM2", 3)
KA.Activated:Connect(function()
for k,v in pairs(game.Players:GetChildren()) do
if not (v == game.Players.LocalPlayer) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
wait(0.75) 
end
end
end) 

while true do 
wait(3) 
pcall(function()
local char = game.Workspace:FindFirstChild("GunDrop") 
if char then
print(1) 
if ESP.Value and ESPGD.Value then
print(2) 
if not char:FindFirstChild("NotEsp") then
print(3) 
local ESPn = Instance.new("Highlight")
ESPn.Parent = char
ESPn.Name = "NotEsp"
ESPn.Adornee = char
ESPn.Archivable = true
ESPn.Enabled = true
ESPn.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESPn.FillColor = Color3.new(0,1,1)
ESPn.FillTransparency = 0.5
ESPn.OutlineColor = ESPn.FillColor
ESPn.OutlineTransparency = 0
end
elseif char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy() 
end
end
for k,v in pairs(game.Players:GetChildren()) do
if v.Character then
if v.Backpack:FindFirstChild("Knife") then
murd = v
end
if v.Backpack:FindFirstChild("Gun") then
sher = v
end
local char = v.Character
if ESPA.Value or v == sher or v == murd then 
if ESP.Value then
if not char:FindFirstChild("NotEsp") then
local ESPn = Instance.new("Highlight")
ESPn.Parent = char
ESPn.Name = "NotEsp"
ESPn.Adornee = char
ESPn.Archivable = true
ESPn.Enabled = true
ESPn.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESPn.FillColor = Color3.new(0,1,0)
ESPn.FillTransparency = 0.5
ESPn.OutlineColor = ESPn.FillColor
ESPn.OutlineTransparency = 0
else
char.NotEsp.FillColor = Color3.new(0,1,0) 
end
elseif char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
elseif char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
end
if murd then
if murd.Character then
if murd.Character:FindFirstChild("NotEsp") and not ESPM.Value then
murd.Character.NotEsp:Destroy() 
elseif murd.Character:FindFirstChild("NotEsp") and ESPM.Value then
murd.Character.NotEsp.FillColor = Color3.new(1, 0, 0) 
end
end
end
if sher then
if sher.Character then
if sher.Character:FindFirstChild("NotEsp") and not ESPS.Value then
sher.Character.NotEsp:Destroy() 
elseif sher.Character:FindFirstChild("NotEsp") and ESPS.Value then
sher.Character.NotEsp.FillColor = Color3.new(0, 0, 1) 
end
end
end
end
end) --pcall
end
