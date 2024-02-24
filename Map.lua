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

game:GetService("RunService").Stepped:Connect(function()
local act = actv.Value
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
lp.Character.HumanoidRootPart.CFrame = p.CFrame
end
end)
