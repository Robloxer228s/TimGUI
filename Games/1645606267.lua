local ESPV = _G.TimGui.Add.CB("ESPV", "ESP all", "ESP", 3, "ESP все") 
local ESPF = _G.TimGui.Add.CB("ESPF", "ESP froggy", "ESP", 4, "ESP к лягушке") 

local function CESP(char)
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,1,1)
local dest = false
if char.Name == "Frogge" then
if ESPF.Value then
ESP.FillColor = Color3.new(0, 1, 0) 
else
dest = true
end
end
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
if dest then
ESP:Destroy() 
end
end

for k,player in pairs(game.Players:GetChildren()) do
if not (player == game.Players.LocalPlayer) then
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
CESP(char) 
elseif char.Name == "Frogge" and ESPF.Value then
CESP(char) 
end
end)
end
end
game.Players.PlayerAdded:Connect(function(player)
player.CharacterAdded:Connect(function(char) 
if ESPV.Value then
CESP(char) 
elseif char.Name == "Frogge" and ESPF.Value then
CESP(char) 
end
end) 
end) 

ESPV.Changed:Connect(function() 
for k,player in pairs(game.Players:GetChildren()) do
local char = player.Character
if ESPV.Value and not (player == game.Players.LocalPlayer) then
CESP(char) 
elseif not ESPV.Value and char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy() 
end
end
end) 

ESPF.Changed:Connect(function() 
for k,player in pairs(game.Players:GetChildren()) do
local char = player.Character
if char.Name == "Frogge" and ESPF.Value then
CESP(char) 
elseif char.Name == "Frogge" and char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy() 
end
end
end) 
