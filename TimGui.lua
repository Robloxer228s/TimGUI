--[[
Please, use this script(for english language):


_G.eng = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()


]]
local atpp
local autotp
local FoldersT = {}
_G.TFuncs = {}
_G.TCBs = {}
local FA = "TP to player"
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui") 
gui.Name = "TimGUI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
local f = Instance.new("Frame") 
f.Position = UDim2.new(1, -400, 1,-25) 
f.Size = UDim2.new(0, 400, 1, 0) 
f.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
f.Parent = gui
local Open = Instance.new("ImageLabel") 
Open.Size = UDim2.new(0, 400, 0, 25)
Open.Position = UDim2.new(0, 0, 0, 0) 
Open.Image = "rbxassetid://16341271803"
Open.Parent = f
local AO = Instance.new("ImageButton") 
AO.BackgroundTransparency = 100
AO.Size = UDim2.new(0, 25, 0, 25)
AO.Position = UDim2.new(0, 0, 0, 0) 
AO.Image = "rbxassetid://16341277046"
AO.Parent = f

local Folders = Instance.new("ScrollingFrame") 
Folders.Parent = f
Folders.ScrollBarThickness = 5
Folders.BackgroundColor3 = Color3.new(0.15, 0.15, 0.25) 
Folders.Size = UDim2.new(0, 100, 1, -25) 
Folders.Position = UDim2.new(0, 0, 0, 25) 

local Func = Instance.new("ScrollingFrame") 
Func.Parent = f
Func.ScrollBarThickness = 5
Func.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
Func.Size = UDim2.new(1, -100, 1, -25) 
Func.Position = UDim2.new(0, 100, 0, 25) 

local OC = false
AO.Activated:Connect(function() 
OC = not OC
if OC then
local goal = {}
goal.Position = UDim2.new(1, -400, 0, 0) 
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 180
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
else
local goal = {}
goal.Position = UDim2.new(1, -400, 1, -25) 
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 0
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
end
end) 

_G.ACBF = function(name, text, group, yy, rus, funct) 
if not _G.eng and not (rus == nil) then
text = rus
end
local Temp = Instance.new("ImageLabel") 
if not (group == "TP to player") then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTabb = Instance.new("TextButton") 
ButTabb.Parent = Temp
ButTabb.BackgroundTransparency = 100
ButTabb.Text = text
ButTabb.Size = UDim2.new(1, 0, 1, 0) 
ButTabb.TextScaled = true
ButTabb.TextColor3 = Color3.new(1, 0.25, 0.25) 
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("BoolValue") 
ButTab[name].Parent = Temp
FoldersT[group] = ButTab
ButTabb.Activated:Connect(function() 
ButTab[name].Value = not ButTab[name].Value
end) 
ButTab[name].Changed:Connect(function() 
if ButTab[name].Value then
ButTabb.TextColor3 = Color3.new(0.25, 1, 0.25) 
else
ButTabb.TextColor3 = Color3.new(1, 0.25, 0.25) 
end
if not (funct == nil) then
funct(ButTab[name])
end
end)
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
_G.TCBs[group .. "." .. name] = ButTab[name]
return ButTab[name]
end

_G.ABF = function(name, text, group, yy, rus, funct)
if not _G.eng and not (rus == nil) then
text = rus
end
local Temp = Instance.new("ImageLabel") 
if not (group == "TP to player") then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextButton") 
ButTab[name].Parent = Temp
ButTab[name].BackgroundTransparency = 100
ButTab[name].Text = text
ButTab[name].Size = UDim2.new(1, 0, 1, 0) 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
ButTab[name].Activated:Connect(function() 
if not (funct == nil) then
funct(ButTab[name])
end
end) 
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if not (funct == nil) then
_G.TFuncs[group .. "." .. name] = function() 
funct(ButTab[name])
end
end
return ButTab[name]
end

_G.ATBF = function(name, text, group, yy, rus) 
if not _G.eng and not (rus == nil) then
text = rus
end
local Temp = Instance.new("ImageLabel") 
if not (group == "TP to player") then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTab = FoldersT[group]
local But = Instance.new("TextLabel") 
But.Parent = Temp
But.BackgroundTransparency = 100
But.Text = text
But.Size = UDim2.new(0.5, 0, 1, 0) 
But.TextScaled = true
But.TextColor3 = Color3.new(1, 1, 1) 
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextBox") 
ButTab[name].Parent = Temp
ButTab[name].BackgroundColor3 = Color3.new(38 / 255, 38 / 255, 76 / 255) 
ButTab[name].BackgroundTransparency = 0.4
ButTab[name].Size = UDim2.new(0.5, -40, 1, 0) 
ButTab[name].Position = UDim2.new(0.5, 0, 0, 0)
ButTab[name].Text = ""
ButTab[name].ClearTextOnFocus = false 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
_G.TCBs[group .. "." .. name] = ButTab[name]
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
return ButTab[name]
end

_G.AGF = function(name, rus) 
local Temp = Instance.new("ImageLabel") 
Temp.Parent = Folders
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, -5, 0, 50)
FoldersT[name] = {}
local yy = Folders:GetChildren() 
yy = #yy
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
local Tmp = Instance.new("TextButton") 
Tmp.Parent = Temp
Tmp.BackgroundTransparency = 100
Tmp.Text = name
if not _G.eng and not (rus == nil) then 
Tmp.Text = rus
end
Tmp.Size = UDim2.new(1, 0, 1, 0) 
Tmp.TextScaled = true
Tmp.TextColor3 = Color3.new(1, 1, 1) 
Tmp.Activated:Connect(function() 
for k,v in pairs(FoldersT[FA]) do
if v.Parent then
v.Parent.Visible = false
end
end
FA = name
for k,v in pairs(FoldersT[FA]) do
if v.Parent then
v.Parent.Visible = true
if FA == "TP to player" and not (v.ClassName == "BoolValue") then
v.Parent:Destroy() 
end
end
end
if FA == "TP to player" then
local fix = 0
for k, v in pairs(game.Players:GetChildren()) do 
if not (v == game.Players.LocalPlayer) then
local buttonka = _G.ABF(k, v.Name, FA, k + fix + 1) 
buttonka.Activated:Connect(function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
atpp = v
autotp.Parent.TextButton.Text = "Auto spam tp to " .. v.Name
if not _G.eng then 
autotp.Parent.TextButton.Text = "Авто спам тп к " .. v.Name
end
end) 
else
fix = -1
end
end
end
yy = 0
for k,v in pairs(Func:GetChildren()) do
if v.Visible then
yy += 1
end
end
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * yy) 
end) 
Folders.CanvasSize = UDim2.new(0, 0, 0, 50 * yy) 
end
_G.AGF(FA,"ТП к игрокам")
autotp = _G.ACBF("atp", "Auto spam", FA, 1, "Авто спам") 
game:GetService("RunService").Stepped:Connect(function()
if autotp.Value then
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = atpp.Character.HumanoidRootPart.CFrame
end)
end
end) 
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/Standard.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimControl/Main.lua"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/WayPoints.lua"))()
print(game.GameId)
local success, response = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Games/".. game.GameId ..".lua"))()
end)
if not success then
if response == "HTTP 404 (Not Found)" then
print("game script not found")
else
warn("Error load game script:\n" .. response)
end
end
