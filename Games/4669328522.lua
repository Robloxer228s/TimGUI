--Zooo
local group = _G.TimGui.Groups.ESP
group.Create(2,"ESPM","ESP Monsters","ESP на монстров",function(val)
for k, chr in pairs(game.Workspace.Maps:GetChildren()) do
chr = chr:FindFirstChild("Killers") 
if chr then
for k, char in pairs(chr:GetChildren()) do
if val.Value and char.ClassName == "Model" then
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
if char:FindFirstChild("NotEsp") and char.ClassName == "Model" then
char.NotEsp:Destroy()
end
end
end
end
end
end) 

group.Create(2,"ESPI","ESP Items","ESP На предметы",function(val)
for k, chr in pairs(game.Workspace.Maps:GetChildren()) do
for k, char in pairs(chr:GetChildren()) do
if char.Name == "Collections" then
for k, charr in pairs(char:GetChildren()) do
if charr.Name == "CollectionProvider" then
if val.Value and charr.ClassName == "Model" then
local ESP = Instance.new("Highlight")
ESP.Parent = charr
ESP.Name = "NotEsp"
ESP.Adornee = charr
ESP.Archivable = true
ESP.Enabled = true
ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
ESP.FillColor = Color3.new(0,1,1)
ESP.FillTransparency = 0.5
ESP.OutlineColor = ESP.FillColor
ESP.OutlineTransparency = 0
elseif char.ClassName == "Model" then
if char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
end
end
end
end
if char.Name == "CollectionProvider" then
if ESPI.Value and char.ClassName == "Model" then
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
elseif char.ClassName == "Model" then
if char:FindFirstChild("NotEsp") then
char.NotEsp:Destroy()
end
end
end
end
end
end) 
