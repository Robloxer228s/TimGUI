loadstring(game:HttpGet("https://pastebin.com/raw/bf9DPYWp"))()
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
