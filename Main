local FoldersT = {}
local FA = "TP to player"
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui") 
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
AO.Activated:Connect(function () 
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

local function ACBF(name, text, group, yy) 
local Temp = Instance.new("ImageLabel") 
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTab = FoldersT[group]
local ButTabb = Instance.new("TextButton") 
ButTabb.Parent = Temp
ButTabb.BackgroundTransparency = 100
ButTabb.Text = text
ButTabb.Size = UDim2.new(1, 0, 1, 0) 
ButTabb.TextScaled = true
ButTabb.TextColor3 = Color3.new(1, 0, 0) 
ButTab[name] = Instance.new("BoolValue") 
ButTab[name].Parent = Temp
FoldersT[group] = ButTab
ButTab[name].Activated:Connect(function() 
ButTabb.Value = not ButTabb.Value
end) 
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
print(yy - 1) 
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
return ButTab[name]
end

local function ABF(name, text, group, yy) 
local Temp = Instance.new("ImageLabel") 
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
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
print(yy - 1) 
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
return ButTab[name]
end

local function ATBF(name, text, group, yy) 
local Temp = Instance.new("ImageLabel") 
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTab = FoldersT[group]
local But = Instance.new("TextButton") 
But.Parent = Temp
But.BackgroundTransparency = 100
But.Text = text
But.Size = UDim2.new(0.5, 0, 1, 0) 
But.TextScaled = true
But.TextColor3 = Color3.new(1, 1, 1) 
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextBox") 
ButTab[name].Parent = Temp
ButTab[name].BackgroundTransparency = 100
ButTab[name].Size = UDim2.new(0.5, 0, 1, 0) 
ButTab[name].Position = UDim2.new(0.5, 0, 0, 0)
ButTab[name].Text = ""
ButTab[name].ClearTextOnFocus = false 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
print(yy - 1) 
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
return ButTab[name]
end

local function ATBF(name, text, group, yy) 
local Temp = Instance.new("ImageLabel") 
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50)
local ButTab = FoldersT[group]
local But = Instance.new("TextButton") 
But.Parent = Temp
But.BackgroundTransparency = 100
But.Text = text
But.Size = UDim2.new(0.5, 0, 1, 0) 
But.TextScaled = true
But.TextColor3 = Color3.new(1, 1, 1) 
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextBox") 
ButTab[name].Parent = Temp
ButTab[name].BackgroundTransparency = 100
ButTab[name].Size = UDim2.new(0.5, 0, 1, 0) 
ButTab[name].Position = UDim2.new(0.5, 0, 0, 0)
ButTab[name].Text = ""
ButTab[name].ClearTextOnFocus = false 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
print(yy - 1) 
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
return ButTab[name]
end

local function AGF(name) 
local Temp = Instance.new("ImageLabel") 
Temp.Parent = Folders
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Image = "rbxassetid://16342149164"
Temp.Size = UDim2.new(1, 0, 0, 50) 
local Tmp = Instance.new("TextButton") 
Tmp.Parent = Temp
Tmp.BackgroundTransparency = 100
Tmp.Text = name
Tmp.Size = UDim2.new(1, 0, 1, 0) 
Tmp.TextScaled = true
Tmp.TextColor3 = Color3.new(1, 1, 1) 
Tmp.Activated:Connect(function() 
for k,v in pairs(FoldersT[FA]) do
v.Visible = false
end
FA = name
local ftpmc = FoldersT[FA]
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
for k,v in pairs(FoldersT[FA]) do
v.Visible = true
if FA == "TP to player" then
if v then
v.Parent:Destroy() 
end
end
end
if FA == "TP to player" then
local fix = 0
for k, v in pairs(game.Players:GetChildren()) do 
if not (v == game.Players.LocalPlayer) then
local buttonka = ABF(k, v.Name, FA, k + fix) 
buttonka.Activated:Connect(function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
end) 
else
fix = -1
end
end
end
end) 
Folders.CanvasSize = UDim2.new(0, 0, 0, 50 * #FoldersT) 
FoldersT[name] = {}
end

AGF(FA)
