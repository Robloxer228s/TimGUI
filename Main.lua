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


loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/service.lua"))()
AGF(FA)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/player.lua"))()
local gameURL = game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/".. game.PlaceId ..".lua")()
loadstring(gameURL)() 
