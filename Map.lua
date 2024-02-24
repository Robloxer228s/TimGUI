local Mouse = game.Players.LocalPlayer:GetMouse()
local obj
local nada
local sb
local hl

local function addParentRecursive(object, t)
	if (object and object.Parent) then
		table.insert(t, object.Parent == game and "game" or object.Parent.Name)
		addParentRecursive(object.Parent, t)
	end
end
local function getPath(object, useWaitForChild)
local t = {object.Name}
addParentRecursive(object, t)
local path = t[#t]
if (useWaitForChild) then
for i = #t-1, 1, -1 do
path = path .. ":WaitForChild(\"" .. t[i] .. "\")"
end
else
for i = #t-1, 1, -1 do
local name = t[i]
if (name:match("[^%w_]+") or name:sub(1, 1):match("%d")) then
path = path .. "[\"" .. name .. "\"]"
else
path = path .. "." .. name
end;
end
end
return path
end

Mouse.Button1Down:connect(function()
if not Mouse.Target then return end
if not nada then return end
if sb then sb:Destroy() end
if hl then hl:Destroy() end
obj = Mouse.Target
sb = Instance.new("SelectionBox")
sb.Parent = obj
sb.LineThickness = 0.075
sb.Adornee = obj
print(1) 
hl = Instance.new("Highlight")
hl.Parent = obj
hl.Name = "NotEsp"
hl.Adornee = obj
hl.Archivable = true
hl.Enabled = true
hl.FillColor = Color3.new(0,0,1)
hl.FillTransparency = 0.75
hl.OutlineColor = hl.FillColor
hl.OutlineTransparency = 0
nada = false
end)

_G.AGF("Map", "Карта") 
_G.ABF("SB", "Select", "Map", 1, "Выбрать").Activated:Connect(function() 
nada = true
end) 

_G.ABF("USB", "Unselect", "Map", 2, "Убрать выбор").Activated:Connect(function()
if sb then sb:Destroy() end
if hl then hl:Destroy() end
obj = nil
end) 

_G.ABF("DSB", "delete select", "Map", 3, "Удалить выбронное").Activated:Connect(function()
obj:Destroy()
end) 

_G.ABF("CP", "Copy path", "Map", 4, "Копировать путь").Activated:Connect(function()
setclipboard(tostring(getPath(obj, true)))
end) 


--Spectate
local lp = game.Players.LocalPlayer
local p = Instance.new("Part")
local actv = _G.ACBF("SFly", "Spectate(visual)", "Map", 5, "Наблюдать(только для тебя)") 
local jp
local safe = Instance.new("Part") 
safe.Position = Vector3.new(0, 1000000, 0) 

actv.Changed:Connect(function() 
if actv.Value then
local pos = lp.Character.HumanoidRootPart.CFrame
lp.Character.HumanoidRootPart.CFrame = safe.CFrame
wait(0.1) 
lp.Character.HumanoidRootPart.Anchored = true
lp.Character.HumanoidRootPart.CFrame = pos
else
lp.Character.HumanoidRootPart.Anchored = false
end
end) 
--Up/Down
local y = Instance.new("Frame")
y.Parent = game.CoreGui.TimGUI
y.Name = "SpectateY"
y.Size = UDim2.new(0,100,0,50)
local ypos = 0
local down = Instance.new("TextButton")
local up = Instance.new("TextButton")
down.Position = UDim2.new(0,0,0,0)
up.Position = UDim2.new(0.5,0,0,0)
down.Size = UDim2.new(0.5,0,1,0)
up.Size = UDim2.new(0.5,0,1,0)
down.BackgroundColor = Color3.new(1,0.5,0.5)
up.BackgroundColor = Color3.new(0.5,0.5,1)
down.Parent = y
up.Parent = y

down.MouseButton1Down:Connect(function()
ypos = -1
end)
down.MouseButton1Up:Connect(function()
ypos = 0
end)
up.MouseButton1Down:Connect(function()
ypos = 1
end)
up.MouseButton1Up:Connect(function()
ypos = 0
end)
local u = game:GetService("UserInputService")
u.InputEnded:Connect(function(input)
if input.KeyCode == Enum.KeyCode.Q then
ypos = 0
elseif input.KeyCode == Enum.KeyCode.E then
ypos = 0
end
end)
u.InputBegan:Connect(function(input)
if input.KeyCode == Enum.KeyCode.Q then
ypos = -1
elseif input.KeyCode == Enum.KeyCode.E then
ypos = 1
end
end)

--While spectator
game:GetService("RunService").Stepped:Connect(function()
local act = actv.Value
y.Visible = act
if not (lp.Character.Humanoid.JumpPower == 0) and act then
jp = lp.Character.Humanoid.JumpPower
lp.Character.Humanoid.JumpPower = 0
elseif lp.Character.Humanoid.JumpPower == 0 and not act then
lp.Character.Humanoid.JumpPower = jp
end
if act then
p.CFrame = game.Workspace.Camera.CFrame
p.Position = lp.Character.HumanoidRootPart.Position
p.Position += lp.Character.Humanoid.MoveDirection
p.Position.Y += ypos
lp.Character.HumanoidRootPart.CFrame = p.CFrame
end
end)
