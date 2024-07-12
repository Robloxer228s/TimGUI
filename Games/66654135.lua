--MM2
local ESP = _G.TimGui.Add.CB("ESP", "MM2", "ESP", 3)
local ESPM = _G.TimGui.Add.CB("ESPM", "ESP Murder", "ESP", 4, "ESP на убийцу")
local ESPS = _G.TimGui.Add.CB("ESPS", "ESP Sheriff", "ESP", 5, "ESP на шерифа")
local ESPA = _G.TimGui.Add.CB("ESPA", "ESP All", "ESP", 6, "ESP на всех")
local ESPGD = _G.TimGui.Add.CB("ESPGD", "ESP Dropped gun", "ESP", 7, "ESP на пистолет")
local murd
local sher 
_G.TimGui.Add.G("MM2") 

local AutoShooting = _G.TimGui.Add.CB("ASB", "AutoShoot to murder(beta)", "MM2", 10, "Стрельнуть в убийцу") 
local shootOffsets = _G.TimGui.Add.TB("ASO", "ShootOffset", "MM2", 11, "ShootOffset") 
shootOffsets.Text = 3.5
AutoShooting.Changed:Connect(function()
				if sher == game.Players.LocalPlayer and AutoShooting.Value then
					print("Auto-shooting started.")
					repeat
						task.wait(0.1)
						if not murd then print("No murderer.") continue end
						local murdererPosition = murd.Character.HumanoidRootPart.Position
						local characterRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
						local rayDirection = murdererPosition - characterRootPart.Position
	
						local raycastParams = RaycastParams.new()
						raycastParams.FilterType = Enum.RaycastFilterType.Exclude
						raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
	
						local hit = workspace:Raycast(characterRootPart.Position, rayDirection, raycastParams)
						if not hit or hit.Instance.Parent == murderer.Character then -- Check if nothing collides or if it collides with the murderer
							print("Auto-shooting!")
							if not game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
								local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Gun") then
									game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Gun"))
								else
									print("You don't have the gun..?")
									return
								end
							end
							if toNumber(shootOffsets.Text) == nil then
							shootOffset = 3.5
							else
							shootOffset = toNumber(shootOffsets.Text) 
							end
							local args = {
								[1] = 1,
								[2] = murd.Character:FindFirstChild("HumanoidRootPart").Position + murd.Character:FindFirstChild("Humanoid").MoveDirection * shootOffset,
								[3] = "AH"
							}
	
							game:GetService("Players").LocalPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(unpack(args))
						end
					until findSheriff() ~= game.Players.LocalPlayer or not AutoShooting.Value
				end
AutoShooting.Value = false
end)

_G.TimGui.Add.B("TPSM", "TP to map", "MM2", 6, "ТП на карту", function() 
local rand = game.Workspace.Normal.Spawns:GetChildren() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rand[math.random(1, #rand)].CFrame + Vector3.new(0, 2.5, 0) 
end) 

_G.TimGui.Add.B("TPMM", "TP to spawn", "MM2", 5, "ТП на спавн", function()
local rand = game.Workspace.Lobby.Spawns:GetChildren() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = rand[math.random(1, #rand)].CFrame + Vector3.new(0, 2.5, 0) 
end)

_G.TimGui.Add.B("TDG", "TP to dropped gun", "MM2", 4, "ТП к пистолету", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Normal.GunDrop.CFrame
end) 


_G.TimGui.Add.B("TPM", "TP to murder", "MM2", 1, "ТП к убийце", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = murd.Character.HumanoidRootPart.CFrame
end) 

_G.TimGui.Add.B("TPS", "TP to sheriff", "MM2", 2, "ТП к шерифу", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sher.Character.HumanoidRootPart.CFrame
end) 

_G.TimGui.Add.B("KA", "Kill All", "MM2", 3, "Убить всех", function()
for k,v in pairs(game.Players:GetChildren()) do
if not (v == game.Players.LocalPlayer) then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
wait(0.75) 
end
end
end) 

local Money = _G.TimGui.Add.CB("Money", "Farm (with fly)", "MM2", 7, "АФК(С полëтом)") 
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
local timer = 2.25
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

local AIM = _G.TimGui.Add.CB("AIMM", "AIM to murd", "MM2", 8, "Автонаводка на марда", function(AIMV)
if AIMV.Value then
game.Players.LocalPlayer.CameraMode = 1
else
game.Players.LocalPlayer.CameraMode = 0
end
end)

local AAIM = _G.TimGui.Add.CB("AAIMM", "Auto AIM to murd", "MM2", 9, "АвтоАИМ на марда")

game:GetService("RunService").RenderStepped:Connect(function()
if AAIM.Value and game.Players.LocalPlayer.Character:FindFirstChild("Gun") then
AIM.Value = true
elseif AAIM.Value then
AIM.Value = false
end
if AIM.Value then
game.Workspace.Camera.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.Head.Position, murd.Character.HumanoidRootPart.Position) 
end
end) 

while true do 
wait(1) 
pcall(function()
local char = game.Workspace:FindFirstChild("GunDrop")
if not char then 
char = game.Workspace.Normal:FindFirstChild("GunDrop")
end
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
if sher then
if sher.Character then
if sher.Character:FindFirstChild("NotEsp") and not ESPS.Value then
sher.Character.NotEsp:Destroy() 
elseif sher.Character:FindFirstChild("NotEsp") and ESPS.Value then
sher.Character.NotEsp.FillColor = Color3.new(0, 0, 1) 
end
end
end
if murd then
if murd.Character then
if murd.Character:FindFirstChild("NotEsp") and not ESPM.Value then
murd.Character.NotEsp:Destroy() 
elseif murd.Character:FindFirstChild("NotEsp") and ESPM.Value then
murd.Character.NotEsp.FillColor = Color3.new(1, 0, 0) 
end
end
end
end
end) --pcall
end
