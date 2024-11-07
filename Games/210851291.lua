--build a boat
local aw = Instance.new("Part") 
local awl = Instance.new("Part") 
local awm = Instance.new("Part") 
local awb = Instance.new("Part") 
local awv = Instance.new("Part") 
local awf = Instance.new("Part") 

aw.Anchored = true
awl.Anchored = true
awm.Anchored = true
awb.Anchored = true
awv.Anchored = true
awf.Anchored = true

--aw.CanTouch = false
--awf.CanTouch = false

aw.Parent = game.Workspace
awl.Parent = game.Workspace
awm.Parent = game.Workspace
awb.Parent = game.Workspace
awv.Parent = game.Workspace
awf.Parent = game.Workspace

aw.Size = Vector3.new(255,10,1780) 
awl.Size = Vector3.new(664,10,2048) 
awm.Size = Vector3.new(664,10,2048) 
awb.Size = Vector3.new(664,10,2048) 
awv.Size = Vector3.new(664,10,1525) 
awf.Size = Vector3.new(664+254.1-254.1,10,594) 

aw.Position = Vector3.new(-53.75,-17.5,4211.25-3528) 
awl.Position = Vector3.new(100,-17.5,4211.25-2048) 
awm.Position = Vector3.new(100,-17.5,4211.25) 
awb.Position = Vector3.new(100,-17.5,4211.25+2048)
awv.Position = Vector3.new(145.5,-17.5,4211.25+3623)  
awf.Position = Vector3.new(-117.9,-365,8918) 

aw.Velocity = Vector3.new(0,0,25) 
awl.Velocity = Vector3.new(0,0,25) 
awm.Velocity = Vector3.new(0,0,25) 
awb.Velocity = Vector3.new(0,0,25) 
awv.Velocity = Vector3.new(0,0,25) 
awf.Velocity = Vector3.new(0,0,25) 

aw.CanCollide = false
awl.CanCollide = false
awm.CanCollide = false
awb.CanCollide = false
awv.CanCollide = false
awf.CanCollide = false

aw.Transparency = 100
awl.Transparency = 100
awm.Transparency = 100
awb.Transparency = 100
awv.Transparency = 100
awf.Transparency = 100

local Final = Instance.new("Part")
Final.Position = Vector3.new(-56.22, -340.33, 9490.73) 
local Start = Instance.new("Part")
Start.Position = Vector3.new(-55, 19.52, 1306.33) 

local AFK

local babft = _G.TimGui.Groups.CreateNewGroup("BABFT","Построй корабль..")
local WH = babft.Create(2,"WH","WaterHacks","Взлом воды",function(val)
if not AFK.Value then
aw.CanCollide = val.Value
awl.CanCollide = val.Value
awm.CanCollide = val.Value
awb.CanCollide = val.Value
awv.CanCollide = val.Value
awf.CanCollide = val.Value
end
if game.Workspace:FindFirstChild("Water") then
game.Workspace.Water:Destroy() 
end
end)

local BDel = babft.Create(2,"BDel","Remove obstacles","Удалять препятствия(каждые 30 сек)")

local WS = babft.Create(3,"WS","WaterSpeed:","Скорость воды:",function(val)
if not AFK.Value then
local speed = val.Value
if tonumber(speed) == nil then
speed = 0
end
aw.Velocity = Vector3.new(0,0,25*speed) 
awl.Velocity = Vector3.new(0,0,25*speed) 
awm.Velocity = Vector3.new(0,0,25*speed) 
awb.Velocity = Vector3.new(0,0,25*speed) 
awv.Velocity = Vector3.new(0,0,25*speed) 
awf.Velocity = Vector3.new(0,0,25*speed) 
end
end)
if WS.Main.Text == "" then WS.Main.Text = 0 end

AFK = babft.Create(2,"AFK","AFK","АФК (сдохни чтоб начать)",function(val)
if val.Value then
aw.Velocity = Vector3.new(0,0,250) 
awl.Velocity = Vector3.new(0,0,250) 
awm.Velocity = Vector3.new(0,0,250) 
awb.Velocity = Vector3.new(0,0,250) 
awv.Velocity = Vector3.new(0,0,250) 
awf.Velocity = Vector3.new(0,0,250) 
aw.CanCollide = true
awl.CanCollide = true
awm.CanCollide = true
awb.CanCollide = true
awv.CanCollide = true
awf.CanCollide = true
else
local speed = WS.Value
if tonumber(speed) == nil then
speed = 0
end
aw.Velocity = Vector3.new(0,0,25*speed) 
awl.Velocity = Vector3.new(0,0,25*speed) 
awm.Velocity = Vector3.new(0,0,25*speed) 
awb.Velocity = Vector3.new(0,0,25*speed) 
awv.Velocity = Vector3.new(0,0,25*speed) 
awf.Velocity = Vector3.new(0,0,25*speed)
aw.CanCollide = WH.Value
awl.CanCollide = WH.Value
awm.CanCollide = WH.Value
awb.CanCollide = WH.Value
awv.CanCollide = WH.Value
awf.CanCollide = WH.Value
end
end)


awf.Touched:Connect(function() 
if AFK.Value then 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Final.CFrame
wait(5) 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Final.CFrame
local char = game.Players.LocalPlayer.Character
wait(30) 
if char then
char.Humanoid:TakeDamage(100)
end
end
end) 
game.Players.LocalPlayer.CharacterAdded:Connect(function()
wait(5) 
if AFK.Value then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Start.CFrame
end
end)
local function Next(old)
for k,v in pairs(old:GetChildren()) do
if v:FindFirstChild("BreakEvent")  then
v:Destroy() 
else 
Next(v) 
end
end
end
while true do
wait(30) 
if BDel.Value or AFK.Value then
for k,v in pairs(game.Workspace:GetChildren()) do
if v:FindFirstChild("BreakEvent")  then
v:Destroy() 
else 
Next(v) 
end
end
end
end
