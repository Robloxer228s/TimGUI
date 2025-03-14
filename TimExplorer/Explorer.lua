local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game.UserInputService

local types = {
	Adornee="Instance",
	PrimaryPart="Instance",
	Attachment0="Instance",
	Attachment1="Instance",
	Part0="Instance",
	Part1="Instance",
}
local SetOut
local addingClass = {}
addingClass.Highlight = {"Adornee","DepthMode","Enabled","FillColor","FillTransparency","OutlineColor","OutlineTransparency"}
local classMenu = {}
classMenu.BasePart = {TP=function(obj)
	LocalPlayer.Character.PrimaryPart.CFrame = obj.Object.CFrame
end}
if decompile then
	classMenu.BaseScript = {["📤"]=function(obj)
		SetOut(obj.Object.Name,decompile(obj.Object))
	end}
	classMenu.ModuleScript = classMenu.BaseScript
end
local ClassProperties do
	local Data
	if RunService:IsStudio() then
		Data = script.Parent.RemoteFunction:InvokeServer()
	else
		Data = game.HttpService:JSONDecode(game:HttpGet("https://anaminus.github.io/rbx/json/api/latest.json"))
	end
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
local guiParent,Images
if RunService:IsStudio() then
	guiParent = LocalPlayer.PlayerGui
	Images = {}
else
	guiParent = game.CoreGui
	Images = game.HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/TimExplorer/images.json"))
end

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
local latestNewInst
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

local MenuClass = Instance.new("Frame",TEgui)
MenuClass.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MenuClass.Position = UDim2.new(0.9,-100-Sizes.Menu,1,-Sizes.Menu)
MenuClass.Size = UDim2.new(0,Sizes.Menu,0,Sizes.Menu)
MenuClass.BackgroundTransparency = 1

local function GetProperties(ClassName)
	local res
	if ClassProperties[ClassName] then
		res = table.clone(ClassProperties[ClassName]) or {}
	else
		res = {}
		table.insert(res,"Archivable")
		table.insert(res,"Name")
		table.insert(res,"Parent")
	end
	table.insert(res,"ClassName")
	if addingClass[ClassName] then
		for _,v in pairs(addingClass[ClassName]) do
			table.insert(res,v)
		end
	end
	return res
end

local function SelectNew(obj)
	if settingNewInst ~= nil then
		settingNewInst(obj.Object)
		return
	end
	if SelectedTEobj then
		SelectedTEobj.Button.BackgroundTransparency = 1
	end SelectedTEobj = obj
	Highlight.Adornee = obj.Object
	obj.Button.BackgroundTransparency = 0
	Props:ClearAllChildren()
	for _,v in pairs(PropListeners) do
		v:Disconnect()
	end
	MenuClass:ClearAllChildren()
	for k,v in pairs(classMenu) do
		if obj.Object:IsA(k) then
			local y = 0
			for k,v in pairs(v) do
				local func = Instance.new("TextButton",MenuClass)
				func.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				func.Text = k
				func.Size = UDim2.new(1,0,0,Sizes.Menu)
				func.Position = UDim2.new(0,0,0,-y)
				func.TextScaled = true
				func.TextColor3 = Color3.new(1,1,1)
				func.Activated:Connect(function()
					v(obj)
				end)
				y += 1
			end
		end
	end
	local classProps = GetProperties(obj.Object.ClassName)
	local y = 0
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
							if settingNewInst then
								settingNewInst(nil)
								if latestNewInst == value then
									return
								end
							end
							latestNewInst = value
							value.Text = "Choose new"
							SetInstance(obj.Object,name)
						end)
					end
				else
					value.TextColor3 = Color3.new(0.6,0.6,0.6)
					value.Interactable = false
				end
			else
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
				elseif typ == "Instance" then
					if obj.Object[name] == nil then
						value.Text = ""
					else
						value.Text = obj.Object[name].Name
					end
				else
					value.Text = tostring(obj.Object[name])
				end
			end))
			y += 1
		end
	end
	Props.CanvasSize = UDim2.new(0,0,0,(Sizes.YProp+Sizes.InsertProp)*(y))
end

local OutputF = Instance.new("Frame",TEgui)
OutputF.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
OutputF.Size = UDim2.new(0.5,0,0.65,0)
OutputF.Position = UDim2.new(0.125,0,0.25,0)
local OutputMenu = Instance.new("Frame",OutputF)
OutputMenu.Size = UDim2.new(1,0,0.1,0)
OutputMenu.BackgroundColor3 = Color3.fromRGB(64,64,64)
Sizes.Square = OutputMenu.AbsoluteSize.Y
local Output = Instance.new("TextBox",OutputF)
Output.Size = UDim2.new(1,0,0.9,0)
Output.Position = UDim2.new(0,0,0.1,0)
Output.BackgroundTransparency = 1
Output.TextColor3 = Color3.new(1,1,1)
Output.MultiLine = true
Output.ClearTextOnFocus = false
Output.TextEditable = false
Output.TextXAlignment = Enum.TextXAlignment.Left
Output.TextYAlignment = Enum.TextYAlignment.Top
Output.TextScaled = true
local buttonsOut = {}
table.insert(buttonsOut,{"×",function()
	OutputF.Visible = false
end,Color3.new(1,0.1,0.1)})
if toclipboard then
	table.insert(buttonsOut,{"📑",function()
		toclipboard(Output.Text)
	end,Color3.new(0.1,0.4,1)})
end
for y,v in pairs(buttonsOut) do
	local ButtonM = Instance.new("TextButton",OutputMenu)
	ButtonM.Size = UDim2.new(0,Sizes.Square,1,0)
	ButtonM.Text = v[1]
	ButtonM.TextColor3 = Color3.new(1,1,1)
	ButtonM.BackgroundColor3 = v[3]
	ButtonM.TextScaled = true
	ButtonM.Position = UDim2.new(1,-Sizes.Square*y,0,0)
	ButtonM.Activated:Connect(v[2])
end
local OutInfo = Instance.new("TextLabel",OutputMenu)
OutInfo.Size = UDim2.new(1,-Sizes.Square*#buttonsOut,1,0)
OutInfo.TextColor3 = Color3.new(1,1,1)
OutInfo.BackgroundTransparency = 1
OutInfo.TextScaled = true
OutputF.Visible = false
function SetOut(Z,T)
	OutInfo.Text = Z
	Output.Text = T
	OutputF.Visible = true
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
MenuFuncs["🔗"] = function()
	SetOut("Path to ".. SelectedTEobj.Object.Name,"game." .. SelectedTEobj.Object:GetFullName())
end
local lastPage = 0
local LenLast
MenuFuncs["🌐"] = function()
	local Object = {}
	local function GetObject(obj)
		local thisObjTab = {}
		if obj == nil then
			obj = SelectedTEobj.Object
		end
		thisObjTab["Props"] = {}
		for _,prop in pairs(GetProperties(obj.ClassName)) do
			local prTab = {}
			prTab["type"] = typeof(obj[prop])
			if prTab["type"] == "Instance" then
				prTab["value"] = obj[prop]:GetFullName()
			elseif prTab["type"] == "number" or prTab["type"] == "string" or prTab["type"] == "boolean" then
				prTab["value"] = obj[prop]
			elseif prTab["type"] == "EnumItem" then
				prTab["value"] = obj[prop].Value
			else
				local val = tostring(obj[prop])
				if string.find(val,", ") then
					prTab["value"] = string.split(val,", ")
				else
					prTab["value"] = tostring(val)
				end
			end
			if prTab["type"] == "nil" then
				prTab["type"] = "Instance"
				prTab["value"] = nil
			end
			thisObjTab["Props"][prop] = prTab
		end
		local children = {}
		for _,v in pairs(obj:GetChildren()) do
			table.insert(children,GetObject(v))
		end
		thisObjTab["Children"] = children
		return thisObjTab
	end
	local result = game.HttpService:JSONEncode(GetObject())
	local len = string.len(result)
	if len > 199999 then
		local pages = math.ceil(len/199999)
		if LenLast ~= len then
			lastPage = 0
		end
		lastPage += 1
		SetOut("TEObject for ".. SelectedTEobj.Object.Name.." ("..lastPage.."/"..pages..")",string.sub(result,199999*(lastPage-1),199999*lastPage))
		LenLast = string.len(result)
	else
		SetOut("TEObject for ".. SelectedTEobj.Object.Name,result)
	end
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
	listeners["NameChanged"] = obj:GetPropertyChangedSignal("Name"):Connect(function()
		Button.Text = obj.Name
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

local holdingCTRL = false
local holdingShift = false
UIS.InputBegan:Connect(function(input)
	if not UIS:GetFocusedTextBox() then
		if input.KeyCode == Enum.KeyCode.Delete then
			if SelectedTEobj then
				SelectedTEobj.Object:Destroy()
			end
		elseif holdingCTRL == true then
			if input.KeyCode == Enum.KeyCode.V then
				if holdingShift then
					copy.Parent = SelectedTEobj.Object
				else
					copy.Parent = SelectedTEobj.Object.Parent
				end
				copy = copy:Clone()

			elseif input.KeyCode == Enum.KeyCode.C then
				copy = SelectedTEobj.Object:Clone()
			elseif input.KeyCode == Enum.KeyCode.X then
				copy = SelectedTEobj.Object
				copy.Parent = script
			end
		end
	end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		holdingCTRL = true
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		holdingShift = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		holdingCTRL = false
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		holdingShift = false
	end
end)
