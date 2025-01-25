local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game.UserInputService

local InstanceMouseSelection = "rbxasset://textures/GlueCursor.png"
local types = {
	Adornee="Instance",
	PrimaryPart="Instance",
	Attachment0="Instance",
	Attachment1="Instance",
	Part0="Instance",
	Part1="Instance",
}
local addingClass = {}
addingClass.Highlight = {"Adornee","DepthMode","Enabled","FillColor","FillTransparency","OutlineColor","OutlineTransparency"}
local ClassProperties do
	local Data = game.HttpService:JSONDecode(game:HttpGet("https://anaminus.github.io/rbx/json/api/latest.json"))
	print(2)
	ClassProperties = {}
	for i = 1, #Data do
		local Table = Data[i]
		local Type = Table.type
		if Type == "Class" then
			local ClassData = {}
			local Superclass = ClassProperties[Table.Superclass]
			if Superclass then
				for j = 1, #Superclass do
					ClassData[j] = Superclass[j]
				end
			end
			ClassProperties[Table.Name] = ClassData
		elseif Type == "Property" then
			if not next(Table.tags) then
				local Class = ClassProperties[Table.Class]
				local Property = Table.Name
				local Inserted
				for j = 1, #Class do
					if Property < Class[j] then
						Inserted = true
						table.insert(Class, j, Property)
						break
					end
				end
				if not Inserted then
					table.insert(Class, Property)
				end
			end
		elseif Type == "Function" then
		elseif Type == "YieldFunction" then
		elseif Type == "Event" then
		elseif Type == "Callback" then
		elseif Type == "Enum" then
		elseif Type == "EnumItem" then
		end
	end
end
local guiParent = LocalPlayer.PlayerGui
if not RunService:IsStudio() then
	guiParent = game.CoreGui
end
local Images = game.HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/TimExplorer/images.json"))

local Sizes = {}
Sizes.YObj = 25
Sizes.XObj = 30
Sizes.YProp = 30
Sizes.InsertProp = 5
Sizes.Menu = 25
Sizes.Enum = 25
local TEgui = Instance.new("ScreenGui",guiParent)
TEgui.DisplayOrder = 5
TEgui.ResetOnSpawn = false
TEgui.Name = "TExplorer"
TEgui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets

local Highlight = Instance.new("Highlight",TEgui)
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
Highlight.FillColor = Color3.new(0.3,0.3,1)
Highlight.FillTransparency = 0.75
Highlight.OutlineColor = Color3.new(0.1,0.1,1)
Highlight.OutlineTransparency = 0.1

local Frame = Instance.new("Frame",TEgui)
Frame.Size = UDim2.new(0.1,100,1,0)
Frame.Position = UDim2.new(0.9,-100,0,0)
Frame.BackgroundColor3 = Color3.fromRGB(64, 64, 64) -- BETA in studio (import from timgui)

local Objects = Instance.new("ScrollingFrame",Frame)
Objects.Size = UDim2.new(1,0,0.6,25)
Objects.BackgroundTransparency = 1
Objects.ScrollBarThickness = 6

local Props = Instance.new("ScrollingFrame",Frame)
Props.Size = UDim2.new(1,0,0.4,-25)
Props.Position = UDim2.new(0,0,0.6,25)
Props.BackgroundTransparency = 1
Props.ScrollBarThickness = 6

local function getParents(obj: Instance)
	local parents = 0
	local par = obj
	while true do
		if par.Parent == nil then
			return -1
		elseif par.Parent == game then
			return parents
		else
			par = par.Parent
			parents += 1
		end
	end
end

local Create
local Instances = {}
local SelectedTEobj
local CreateID = 0
local UpdateLoad = false
local WaitForReload = false
local UpdsPerS = 0
local OptimizeForUPS = 30
local function getSkipper(obj)
	local add = 0
	if obj.Childs then
		for _,v in pairs(obj.Object:GetChildren()) do
			if Instances[v] then
				add += 1
				add += getSkipper(Instances[v])
			else
				Create(v)
			end
		end
	end
	return add
end
local function Update()
	if UpdateLoad then
		UpdateLoad = false
		UpdsPerS += 1
		local instCount = 0
		local tab = {}
		for _,v in pairs(Instances) do
			instCount += 1
			local parents = getParents(v.Object)+1
			if tab[parents] == nil then
				tab[parents] = {}
			end
			table.insert(tab[parents],v)
		end
		for k,v in pairs(tab) do
			local y = -1
			local latestParent
			table.sort(v,function(a,b)
				if a.Parent and b.Parent then
					if a.Parent ~= b.Parent then
						return a.Parent.Id < b.Parent.Id
					end
				end
				return a.Id < b.Id
			end)
			for _,v in pairs(v) do
				if v.Parent then
					if not v.Parent.Childs then
						v.Destroy()
						continue
					end
					if latestParent ~= v.Parent then
						latestParent = v.Parent
						y = v.Parent.Y
					end
				end
				y += 1
				v.Y = y
				v.Button.Visible = true
				v.Button.Position = UDim2.new(0,Sizes.XObj*(k-1),0,Sizes.YObj*v.Y)
				v.Button.add.Visible = #v.Object:GetChildren() > 0
				v.Button.add.TextColor3 = Color3.new(1,1,1)
				v.Button.Button.TextColor3 = Color3.new(1,1,1)
				if v.Childs then
					v.Button.add.Text = "-"
				else
					v.Button.add.Text = "+"
				end
				y += getSkipper(v)
			end
		end
		Objects.CanvasSize = UDim2.new(1,Sizes.XObj*(#tab-1)-10,0,Sizes.YObj*instCount)
		if RunService:IsStudio() then
			print("UPD")
		end
	else
		WaitForReload = true
	end
end

local PropListeners = {}
local enumMenu = Instance.new("Frame",TEgui)
enumMenu.Visible = false
enumMenu.Position = UDim2.new(0.75,-150-Sizes.Menu,0,0)
enumMenu.Size = UDim2.new(0.15,50,0,Sizes.Enum)
enumMenu.BackgroundColor3 = Color3.fromRGB(80,80,80)

local function StopEnum()
	enumMenu:ClearAllChildren()
	enumMenu.Visible = false
end

local function SetEnum(obj:Instance,name:string)
	StopEnum()
	local enum = obj[name].EnumType
	local tittle = Instance.new("TextLabel",enumMenu)
	tittle.BackgroundTransparency = 1
	tittle.TextScaled = true
	tittle.TextColor3 = Color3.new(1,1,1)
	tittle.Size = UDim2.new(1,-Sizes.Enum,1,0)
	tittle.Text = tostring(enum)
	local close = Instance.new("TextButton",enumMenu)
	close.BackgroundTransparency = 1
	close.TextScaled = true
	close.TextColor3 = Color3.new(1,1,1)
	close.Size = UDim2.new(0,Sizes.Enum,1,0)
	close.Position = UDim2.new(1,-Sizes.Enum,0,0)
	close.Text = "×"
	close.Activated:Connect(function()
		StopEnum()
	end)
	for y,en in pairs(enum:GetEnumItems()) do
		local button = Instance.new("TextButton",enumMenu)
		button.BackgroundColor3 = enumMenu.BackgroundColor3
		button.TextScaled = true
		button.TextColor3 = Color3.new(1,1,1)
		button.Size = UDim2.new(1,0,1,0)
		button.Position = UDim2.new(0,0,y,0)
		button.Text = en.Value .. ": " .. en.Name
		button.Activated:Connect(function()
			obj[name] = en
			StopEnum()
		end)
	end
	enumMenu.Visible = true
end

local settingNewInst
local function SetInstance(obj:Instance,name:string)
	settingNewInst = function(new)
		settingNewInst = nil
		obj[name] = new
	end
end

local function toNew(str:string)
	local new = string.split(str,", ")
	new = string.split(str,",")
	return table.unpack(new)
end

local function SelectNew(obj)
	if settingNewInst ~= nil then
		settingNewInst(obj.Object)
		return
	end
	if SelectedTEobj then
		SelectedTEobj.Button.BackgroundTransparency = 1
	end
	Highlight.Adornee = obj.Object
	obj.Button.BackgroundTransparency = 0
	Props:ClearAllChildren()
	for _,v in pairs(PropListeners) do
		v:Disconnect()
	end
	local classProps = ClassProperties[obj.Object.ClassName] or {}
	classProps = table.clone(classProps)
	local y = 0
	if classProps[1] == nil then
		table.insert(classProps,"Archivable")
		table.insert(classProps,"Name")
		table.insert(classProps,"Parent")
	end
	table.insert(classProps,"ClassName")
	if addingClass[obj.Object.ClassName] then
		for _,v in pairs(addingClass[obj.Object.ClassName]) do
			table.insert(classProps,v)
		end
	end
	for _,name in pairs(classProps) do
		local prop = Instance.new("Frame",Props)
		prop.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		prop.Size = UDim2.new(1,0,0,Sizes.YProp)
		prop.Position = UDim2.new(0,0,0,(Sizes.YProp+Sizes.InsertProp)*y)
		local naame = Instance.new("TextLabel",prop)
		naame.BackgroundTransparency = 1
		naame.Text = name
		naame.TextColor3 = Color3.new(1,1,1)
		naame.Size = UDim2.new(0.4,0,1,0)
		naame.TextScaled = true
		local value
		local typ
		local readonly = pcall(function()
			obj.Object[name] = obj.Object[name]
		end)
		readonly = not readonly
		if name == "Parent" then
			if obj.Object.Parent == game then
				readonly = true
			end
		end
		if readonly then
			warn(name,"read only")
		end
		local success,response = pcall(function()
			typ = typeof(obj.Object[name])
			if typ == "nil" then
				typ = "Instance"
				--typ = types[name]
			end
			if typ == "boolean" then
				value = Instance.new("TextButton",prop)
				value.BackgroundColor3 = Color3.new(1,1,1)
				value.TextColor3 = Color3.new(0,0,0)
				value.Size = UDim2.new(0,Sizes.YProp,1,0)
				value.Position = UDim2.new(0.7,-Sizes.YProp/2,0,0)
				local function updBool()
					if obj.Object[name] then
						value.Text = "✓"
					else
						value.Text = ""
					end
				end
				if not readonly then
					value.Activated:Connect(function()
						obj.Object[name] = not obj.Object[name]
						updBool()
					end)
				else
					value.BackgroundColor3 = Color3.new(0.6,0.6,0.6)
				end
				updBool()
			elseif typ == "EnumItem" or typ == "Instance" then
				value = Instance.new("TextButton",prop)
				value.BackgroundTransparency = 1
				if obj.Object[name] == nil then
					value.Text = ""
				else
					value.Text = obj.Object[name].Name
				end
				value.Size = UDim2.new(0.6,0,1,0)
				value.Position = UDim2.new(0.4,0,0,0)
				if not readonly then
					value.TextColor3 = Color3.new(1,1,1)
					if typ == "EnumItem" then
						value.Activated:Connect(function()
							SetEnum(obj.Object,name)
						end)
					else
						value.Activated:Connect(function()
							value.Text = "Choose new"
							SetInstance(obj.Object,name)
						end)
					end
				else
					value.TextColor3 = Color3.new(0.6,0.6,0.6)
					value.Interactable = false
				end
			else
				print(name,typ)
				value = Instance.new("TextBox",prop)
				value.BackgroundTransparency = 1
				value.Text = tostring(obj.Object[name])
				value.TextColor3 = Color3.new(1,1,1)
				value.Size = UDim2.new(0.6,0,1,0)
				value.Position = UDim2.new(0.4,0,0,0)
				value.ClearTextOnFocus = false
				if not readonly then
					value.InputEnded:Connect(function()
						if tostring(obj.Object[name]) ~= value.Text then
							if typ == "Vector3" then
								obj.Object[name] = Vector3.new(toNew(value.Text))
							elseif typ == "CFrame" then
								obj.Object[name] = CFrame.new(toNew(value.Text))
							elseif typ == "Color3" then
								obj.Object[name] = Color3.new(toNew(value.Text))
							elseif typ == "Vector2" then
								obj.Object[name] = Vector2.new(toNew(value.Text))
							elseif typ == "UDim" then
								obj.Object[name] = UDim.new(toNew(value.Text))
							elseif typ == "UDim2" then
								obj.Object[name] = UDim2.new(toNew(value.Text))
							elseif typ == "BrickColor" then
								obj.Object[name] = BrickColor.new(toNew(value.Text))
							else
								obj.Object[name] = value.Text 
							end
							
						end
						print(typ)
					end)
				else
					value.TextEditable = false
					value.TextColor3 = Color3.new(0.5,0.5,0.5)
				end
			end
			value.TextScaled = true
		end)
		if not success then
			warn("TimExplorer|Error:"..response.."\n property:"..name)
			prop:Destroy()
		else
			table.insert(PropListeners,obj.Object:GetPropertyChangedSignal(name):Connect(function()
				if typ == "boolean" then
					if obj.Object[name] then
						value.Text = "✓"
					else
						value.Text = ""
					end
				elseif typ == "EnumItem" then
					value.Text = obj.Object[name].Name
				else
					value.Text = tostring(obj.Object[name])
				end
			end))
			y += 1
		end
	end
	Props.CanvasSize = UDim2.new(0,0,0,(Sizes.YProp+Sizes.InsertProp)*(y))
end

local MenuFuncs = {}
local copy
MenuFuncs["🗑️"] = function()
	SelectedTEobj.Object:Destroy()
end 
MenuFuncs["📑"] = function()--📃📜📄🧾📝📥📤📩
	copy = SelectedTEobj.Object:Clone()
end 
MenuFuncs["✂️"] = function()
	copy = SelectedTEobj.Object
	copy.Parent = script
end 
MenuFuncs["📋"] = function()
	copy.Parent = SelectedTEobj.Object
	copy = copy:Clone()
end 
local Menu = Instance.new("Frame",TEgui)
Menu.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Menu.Position = UDim2.new(0.9,-100-Sizes.Menu,0,0)
local y = 0
for k,v in pairs(MenuFuncs) do
	local func = Instance.new("TextButton",Menu)
	func.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	func.Text = k
	func.Size = UDim2.new(1,0,0,Sizes.Menu)
	func.Position = UDim2.new(0,0,0,Sizes.Menu*y)
	func.TextScaled = true
	func.TextColor3 = Color3.new(1,1,1)
	func.Activated:Connect(function()
		v()
	end)
	y += 1
end
Menu.Size = UDim2.new(0,Sizes.Menu,0,Sizes.Menu*y)

function Create(obj: Instance)
	if obj == TEgui then return end
	CreateID += 1
	local Parents = getParents(obj)
	local button = Instance.new("Frame",Objects)
	button.Size = UDim2.new(1,0,0,Sizes.YObj)
	button.BackgroundTransparency = 1
	button.Visible = false
	button.BackgroundColor3 = Color3.fromRGB(64, 64, 255)
	local add = Instance.new("TextButton",button)
	add.Name = "add"
	add.TextScaled = true
	add.Text = "+"
	add.BackgroundTransparency = 1
	add.Size = UDim2.new(0,Sizes.YObj,1,0)
	local imageID = Images[obj.ClassName]
	if imageID then
		local imageObj = Instance.new("ImageLabel",button)
		imageObj.Name = "Image"
		imageObj.Size = UDim2.new(0,Sizes.YObj,1,0)
		imageObj.Position = UDim2.new(0,Sizes.YObj,0,0)
		imageObj.Image = imageID
		imageObj.BackgroundTransparency = 1
	end
	local Button = Instance.new("TextButton",button)
	Button.Name = "Button"
	Button.BackgroundTransparency = 1
	Button.TextScaled = true
	Button.Text = obj.Name
	Button.TextXAlignment = Enum.TextXAlignment.Left
	if imageID then
		Button.Size = UDim2.new(1,-Sizes.YObj*2,1,0)
		Button.Position = UDim2.new(0,Sizes.YObj*2,0,0)
	else
		Button.Size = UDim2.new(1,-Sizes.YObj,1,0)
		Button.Position = UDim2.new(0,Sizes.YObj,0,0)
	end
	local listeners = {}
	local TEobj = {}
	TEobj.Button = button
	TEobj.Object = obj
	TEobj.Id = CreateID
	TEobj.Childs = false
	TEobj.Parents = Parents
	TEobj.Parent = Instances[obj.Parent]
	Instances[obj] = TEobj
	add.Activated:Connect(function()
		TEobj.Childs = not TEobj.Childs
		for k,v in pairs(obj:GetChildren()) do
			if TEobj.Childs then
				Create(v)
			elseif Instances[v] then
				Instances[v].Destroy()
			end
		end
		if TEobj.Childs then
			listeners["ChildAdded"] = obj.ChildAdded:Connect(function(child)
				Create(child)
			end)
			listeners["ChildRemoved"] = obj.ChildRemoved:Connect(function(child)
				local TEob = Instances[child]
				if TEob then
					TEob.Destroy()
				end
				Update()
			end)
		else
			listeners["ChildAdded"]:Disconnect()
			listeners["ChildRemoved"]:Disconnect()
		end
	end)
	listeners["ParentChanged"] = obj.AncestryChanged:Connect(function()
		Update()
	end)
	TEobj.Destroy = function()
		button:Destroy()
		Instances[obj] = nil
		TEobj.Destroyed = true
		TEobj.Childs = false
		for _,v in pairs(listeners) do
			v:Disconnect()
		end
		Update()
	end
	Button.Activated:Connect(function()
		SelectNew(TEobj)
		SelectedTEobj = TEobj
	end)
	Update()
end

for k,v in pairs(game:GetChildren()) do
	Create(v)
end

TEgui:GetPropertyChangedSignal("Enabled"):Connect(function()
	if TEgui.Enabled then
		Update()
	end
end)
RunService.RenderStepped:Connect(function()
	if TEgui.Enabled then
		if UpdsPerS < OptimizeForUPS then
			if not UpdateLoad then
				UpdateLoad = true
			end
			if WaitForReload then
				Update()
				WaitForReload = false
			end
		end
	end
end)

task.spawn(function()
	while task.wait(10) do
		if TEgui.Enabled then
			if UpdateLoad then
				Update()
			end
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		if TEgui.Enabled then
			UpdsPerS = 0
		end
	end
end)
