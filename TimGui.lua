--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]
local atpp
local autotp
local FoldersT = {}
local BFuncs = {}
local TOCB = {}
_G.TimGui = {}
_G.TimGui.Opened = false
_G.TimGui.Add = {}
_G.TimGui.TimControlSet = function(GN, mode, data)
if mode == "CB" then
TOCB[GN].Value = data
elseif mode == "TB" then
TOCB[GN].Text = data
elseif mode == "B" then
local temp = BFuncs[GN]
pcall(temp)
end
end

_G.TimGui.Set = function(name, group, data)
local ButTab = FoldersT[group]
if ButTab[name].ClassName == "BoolValue" then
if data == nil then
ButTab[name].Value = not ButTab[name].Value
else
ButTab[name].Value = data
end
elseif ButTab[name].ClassName == "TextBox" then
ButTab[name].Text = data
else
local temp = BFuncs[group .. "." .. name]
temp()
end
end

_G.TimGui.Get = function(name, group)
local ButTab = FoldersT[group]
return ButTab[name]
end
local FA = "TP to player"
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui") 
gui.Name = "TimGUI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
_G.TimGui.Path = {}
local f = Instance.new("Frame") 
f.Position = UDim2.new(1, -400, 1,-25) 
f.Size = UDim2.new(0, 400, 1, 0) 
f.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
f.Parent = gui
_G.TimGui.Path.Main = f
local Open = Instance.new("ImageLabel") 
Open.Size = UDim2.new(0, 400, 0, 25)
Open.Position = UDim2.new(1, -400, 0, 0) 
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
_G.TimGui.Path.Groups = Folders

local Func = Instance.new("ScrollingFrame") 
Func.Parent = f
Func.ScrollBarThickness = 5
Func.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
Func.Size = UDim2.new(1, -100, 1, -25) 
Func.Position = UDim2.new(0, 100, 0, 25) 
_G.TimGui.Path.Buttons = Func

_G.TimGui.askYN = function(name, rusname, text, rustxt, onyes)
local Menu = Instance.new("ImageLabel") 
Menu.Size = UDim2.new(0, 425, 0, 300)
Menu.Position = UDim2.new(0.5, -212.5, -2, 0) 
Menu.BackgroundTransparency = 100
if _G.TimGui.ru then
Menu.Image = "rbxassetid://17041335616"
else
Menu.Image = "rbxassetid://17041343700"
end
Menu.Parent = _G.TimGui.Path.Main.Parent

local Tempp = Instance.new("StringValue") 
Tempp.Name = "name"
Tempp.Value = text
Tempp.Parent = Menu

local nm = Instance.new("TextLabel") 
nm.Parent = Menu
nm.BackgroundTransparency = 1
nm.Name = "Nametxt"
nm.Text = name
if _G.TimGui.ru then nm.Text = rusname end
nm.Size = UDim2.new(0, 300, 0, 50) 
nm.TextScaled = true
nm.Position = UDim2.new(0, 57, 0, 0) 
nm.TextColor3 = Color3.new(1, 1, 1) 

local textt = Instance.new("TextLabel") 
textt.Parent = Menu
textt.BackgroundTransparency = 1
textt.Name = "text"
textt.Text = text
if _G.TimGui.ru then textt.Text = rustxt end
textt.TextScaled = true
textt.Size = UDim2.new(0, 350, 0, 100) 
textt.Position = UDim2.new(0, 3, 0, 70) 
textt.TextColor3 = Color3.new(1, 1, 1) 

local No = Instance.new("TextButton") 
No.Parent = Menu
No.BackgroundTransparency = 1
No.Name = "N"
No.Text = ""
No.Size = UDim2.new(0, 115, 0, 85) 
No.Position = UDim2.new(0, 70, 0, 185) 

local Yes = Instance.new("TextButton") 
Yes.Parent = Menu
Yes.BackgroundTransparency = 1
Yes.Name = "Y"
Yes.Text = ""
Yes.Size = UDim2.new(0, 115, 0, 85) 
Yes.Position = UDim2.new(0, 190, 0, 185)

No.Activated:Connect(function()
local goal = {}
goal.Position = UDim2.new(0.5, -212.5, 2, 0) 
game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
wait(1) 
Menu:Destroy()
end) 

Yes.Activated:Connect(function()
local goal = {}
goal.Position = UDim2.new(0.5, -212.5, 2, 0) 
game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
wait(1)
Menu:Destroy()
onyes()
end) 
local goal = {}
goal.Position = UDim2.new(0.5, -212.5, 0.5, -150) 
game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
end

local OC = false
AO.Activated:Connect(function() 
OC = not OC
_G.TimGui.Opened = OC
if OC then
local goal = {}
goal.Position = UDim2.new(1, -400, 0, 0) 
if _G.TimGui.XTwo then
goal.Position = UDim2.new(1, -700, 0, 0) 
end
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 180
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
else
local goal = {}
goal.Position = UDim2.new(1, -400, 1, -25) 
if _G.TimGui.XTwo then
goal.Position = UDim2.new(1, -700, 1, -25) 
end
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 0
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
end
end) 

_G.TimGui.Add.CB = function(name, text, group, yy, rus, funct) 
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("ImageLabel") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(0, 300, 0, 50)
local Tempp = Instance.new("StringValue") 
Tempp.Name = "group"
Tempp.Value = group
Tempp.Parent = Temp
local Tempp = Instance.new("NumberValue") 
Tempp.Name = "pos"
Tempp.Value = yy
Tempp.Parent = Temp
local ButTabb = Instance.new("TextButton") 
ButTabb.Parent = Temp
ButTabb.BackgroundTransparency = 100
ButTabb.Name = "Text"
ButTabb.Text = text
ButTabb.Size = UDim2.new(1, 0, 1, 0) 
ButTabb.TextScaled = true
ButTabb.TextColor3 = Color3.new(1, 0.25, 0.25) 
local TmpTwo = Instance.new("StringValue")
TmpTwo.Parent = ButTabb
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
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
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
TOCB[group .. "." .. name] = ButTab[name]
return ButTab[name]
end

_G.TimGui.Add.B = function(name, text, group, yy, rus, funct)
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("ImageLabel") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(0, 300, 0, 50)
local Tempp = Instance.new("StringValue") 
Tempp.Name = "group"
Tempp.Value = group
Tempp.Parent = Temp
local Tempp = Instance.new("NumberValue") 
Tempp.Name = "pos"
Tempp.Value = yy
Tempp.Parent = Temp
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextButton") 
ButTab[name].Parent = Temp
ButTab[name].BackgroundTransparency = 100
ButTab[name].Name = "Text"
ButTab[name].Text = text
local TmpTwo = Instance.new("StringValue")
TmpTwo.Parent = ButTab[name]
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
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
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
if not (funct == nil) then
BFuncs[group .. "." .. name] = function() 
funct(ButTab[name])
end
end
return ButTab[name]
end

_G.TimGui.Add.TB = function(name, text, group, yy, rus) 
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("ImageLabel") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(0, 300, 0, 50)
local ButTab = FoldersT[group]
local But = Instance.new("TextLabel") 
But.Parent = Temp
But.BackgroundTransparency = 100
But.Text = text
But.Name = "Text"
But.Size = UDim2.new(0.5, 0, 1, 0) 
But.TextScaled = true
But.TextColor3 = Color3.new(1, 1, 1) 
local TmpTwo = Instance.new("StringValue")
TmpTwo.Parent = But
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
local Tempp = Instance.new("StringValue") 
Tempp.Name = "group"
Tempp.Value = group
Tempp.Parent = Temp
local Tempp = Instance.new("NumberValue") 
Tempp.Name = "pos"
Tempp.Value = yy
Tempp.Parent = Temp
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
TOCB[group .. "." .. name] = ButTab[name]
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
return ButTab[name]
end

_G.TimGui.SetGroup = function(name)
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
_G.TimGui.Add.B(k, v.Name, FA, k + fix + 1, v.Name, function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
atpp = v
autotp.Parent.Text.Text = "Auto spam tp to " .. v.Name
autotp.Parent.Text.Value.Value = "Авто спам тп к " .. v.Name
if _G.TimGui.ru then 
autotp.Parent.Text.Text = "Авто спам тп к " .. v.Name
autotp.Parent.Text.Value.Value = "Auto spam tp to " .. v.Name
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
end

_G.TimGui.Add.G = function(name, rus) 
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
Tmp.Name = "Text"
local TmpTwo = Instance.new("StringValue")
TmpTwo.Parent = Tmp
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = name
end
if _G.TimGui.ru then
Tmp.Text = TmpTwo.Value
TmpTwo.Value = name
end
Tmp.Size = UDim2.new(1, 0, 1, 0) 
Tmp.TextScaled = true
Tmp.TextColor3 = Color3.new(1, 1, 1) 
Tmp.Activated:Connect(function() 
_G.TimGui.SetGroup(name)
end) 
Folders.CanvasSize = UDim2.new(0, 0, 0, 50 * yy) 
end
_G.TimGui.Add.G("Settings","Настройки") 
_G.TimGui.Add.G(FA,"ТП к игрокам")
autotp = _G.TimGui.Add.CB("atp", "Auto spam", FA, 1, "Авто спам") 
game:GetService("RunService").Stepped:Connect(function()
if autotp.Value then
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = atpp.Character.HumanoidRootPart.CFrame
end)
end
end) 
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/Standard.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimControl/Main.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/Settings.lua"))()
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
