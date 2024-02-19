local ESPM = _G.ACBF("ESPM", "ESP Monsters", "ESP", 3, "ESP на монстров") 
ESPM.Changed:Connect(function()
for k, char in pairs(game.Workspace.Monsters:GetChildren()) do
if ESPM.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,0,0)
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
else
if char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
end
end
end) 

game.Workspace.Monsters.ChildAdded:Connect(function(char)
if ESPM.Value then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(1,0,0)
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end) 

local ESPI = _G.ACBF("ESPI", "ESP Items", "ESP", 4, "ESP на предметы") 
ESPI.Changed:Connect(function()
for k, char in pairs(game.Workspace:GetChildren()) do
if ESPI.Value and char.ClassName == "Model" then
local chec = false
for kk, v in pairs(char:GetChildren()) do
if v.Name == "Handle" or v.Name == "ItemLight" or v.Name == "TouchTrigger" then
chec = true
end
end
if chec then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(0,1,1)
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
elseif char.ClassName == "Model" then
if char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
end
end
end) 

game.Workspace.ChildAdded:Connect(function(char)
if ESPI.Value and char.ClassName == "Model" then
local chec = false
for kk, v in pairs(char:GetChildren()) do
if v.Name == "Handle" or v.Name == "ItemLight" or v.Name == "TouchTrigger" then
chec = true
end
end
if chec then
local ESP = Instance.new("Highlight")
ESP.Parent = char
ESP.Name = "NotEsp"
ESP.Adornee = char
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(0,1,1)
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
end
end
end)
