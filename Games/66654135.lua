--MM2
local ESP = _G.ACBF("ESP", "MM2", "ESP", 3)
local ESPM = _G.ACBF("ESPM", "ESP Murder", "ESP", 4, "ESP на убийцу")
local ESPS = _G.ACBF("ESPS", "ESP Sheriff", "ESP", 5, "ESP на шерифа")
local ESPA = _G.ACBF("ESPA", "ESP All", "ESP", 6, "ESP на всех")
local ESPGD = _G.ACBF("ESPGD", "ESP Dropped gun", "ESP", 7, "ESP на пистолет")
local murd
local sher 
_G.AGF("MM2") 

 _G.ABF("TPSM", "TP to map", "MM2", 6, "ТП на карту", function() 
local rand = game.Workspace.Normal.Spawns:GetChildren() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rand[math.random(1, #rand)].CFrame + Vector3.new(0, 2.5, 0) 
end) 

_G.ABF("TPMM", "TP to spawn", "MM2", 5, "ТП на спавн", function()
local rand = game.Workspace.Lobby.Spawns:GetChildren() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rand[math.random(1, #rand)].CFrame + Vector3.new(0, 2.5, 0) 
end)

_G.ABF("TDG", "TP to dropped gun", "MM2", 4, "ТП к пистолету", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.GunDrop.CFrame
end) 


_G.ABF("TPM", "TP to murder", "MM2", 1, "ТП к убийце", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = murd.Character.HumanoidRootPart.CFrame
end) 

local TPS = _G.ABF("TPS", "TP to sheriff", "MM2", 2, "ТП к шерифу", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sher.Character.HumanoidRootPart.CFrame
end) 

local KA = _G.ABF("KA", "Kill All", "MM2", 3, "Убить всех", function()
for k,v in pairs(game.Players:GetChildren()) do
if not (v == game.Players.LocalPlayer) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
wait(0.75) 
end
end
end) 

local Money = _G.ACBF("Money", "Farm (with fly)", "MM2", 7, "АФК(С полëтом)") 
--local Time = _G.ATBF("Time", "Farm time: ", "MM2", 7, "АФК таймер: ") 
--Time.Text = 1
local lastmon

local MoneyGet = function() 
local poss
local mon
if game.Workspace:FindFirstChild("Normal") == nil then return nil end
if game.Workspace.Normal:FindFirstChild("CoinContainer") then
for k, v in pairs(game.Workspace.Normal.CoinContainer:GetChildren()) do
local monn = v.CFrame
local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local pos = 0
local Check = monn.X - playerPos.X
if Check < 0 then
Check = - Check
end
pos = pos + Check
local Check = monn.Y - playerPos.Y
if Check < 0 then
Check = - Check
end
pos = pos + Check
local Check = monn.Z - playerPos.Z
if Check < 0 then
Check = - Check
end
pos = pos + Check
if poss == nil and not (lastmon == v) then
poss = pos
mon = v
elseif not (lastmon == v) then
if poss > pos then
poss = pos
mon = v
end
end
end
end
if not (lastmon == nil) then lastmon:Destroy() end
lastmon = mon
local send = {}
send.obj = mon
send.pos = poss
return send
end

local whileee = Instance.new("BoolValue")
whileee.Changed:Connect(function() 
while true do 
wait(0.75) 
pcall(function()
local Moneyy
if Money.Value then Moneyy = MoneyGet() end
if Money.Value and not (Moneyy == nil) then
local MoneyOb = Moneyy.obj
--local timer = tonumber(Time.Text) 
local timer = 1
if timer == nil then timer = 1 end
if timer < 1 then timer = 1 end
timer = timer * (Moneyy.pos / 100)
if timer < 45 then
local pos = Instance.new("Part") 
pos.Position = MoneyOb.Position + Vector3.new(0, -2.75, 0) 
pos.Orientation = Vector3.new(0, 180, 0)
local goal = {}
goal.CFrame = pos.CFrame
game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(timer), goal):Play() 
wait(timer)
end
end
end) 
end
end) 
whileee.Value = true

while true do 
wait(1) 
pcall(function()
local char = game.Workspace:FindFirstChild("GunDrop") 
if char then
if ESP.Value and ESPGD.Value then
if not char:FindFirstChild("NotEsp") then
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
if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
murd = v
end
if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
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
_G.murd = murd
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
