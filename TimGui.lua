--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]
print([[=============================================
			| ---  *  |\  /|						    |
			|  |   |  | \/ |						    |
			|  |   |  |    |       gui                  |
			=============================================]])
_G.TimGui = {}
_G.TimGui.Groups = {}
_G.TimGui.Values = {}
_G.TimGui.Colors = {}
_G.TimGui.Path = {}
_G.TimGui.Keybinds = {}

--_G.TimGui.Values.x2 = false
_G.TimGui.Values.Spare = {}
_G.TimGui.Values.PlayersWithSpare = {}
_G.TimGui.Values.Opened = false
_G.TimGui.Values.SpareButtons = {}
_G.TimGui.Values.GroupOpened = nil
_G.TimGui.Values.RusLang = false

local Colors = _G.TimGui.Colors
Colors.Logo = {}
Colors.ToggleButton = {}
Colors.Print = {}
Colors.Print.Outline = Color3.fromRGB(100,100,200)
Colors.Print.Background = Color3.fromRGB(38,38,76)
Colors.Print.Timer = Color3.fromRGB(60,60,110)
Colors.Text = Color3.new(1,1,1)
Colors.Arrow = Color3.new(1,1,1)
Colors.Button = Color3.fromRGB(50,50,100)
Colors.MainBackground = Color3.new(0.15, 0.15, 0.3) 
Colors.GroupsBackground = Color3.new(0.15, 0.15, 0.25) 
Colors.TextBoxBackground = Color3.fromRGB(38, 38, 76)
Colors.ToggleButton.Enabled = Color3.new(0.25, 1, 0.25) 
Colors.ToggleButton.Disabled = Color3.new(1, 0.25, 0.25)
Colors.Logo.One = Color3.new(1,1,0) 
Colors.Logo.Two = Color3.new(1,0,1) 
Colors.Logo.Separator = Color3.new(0,0,0)

local DefaultColors = table.clone(Colors)
local OptimizeTable = {}
local LocalPlayer = game.Players.LocalPlayer
local XTG = UDim.new(1, -400)
--local ButtonColor = Colors.Buttons
local Count = 0
local updTime = 0.25
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui",game.CoreGui)
local f = Instance.new("Frame",gui) 
local AO = Instance.new("ImageButton",f)
local Groups = Instance.new("ScrollingFrame",f) 
local Objects = Instance.new("ScrollingFrame",f) 
local Logo = Instance.new("Frame",f)
local tittleOne = Instance.new("TextLabel",Logo)
local tittleTwo = Instance.new("Frame",Logo)
local tittleThr = Instance.new("TextLabel",Logo)
local timeLol = Instance.new("TextLabel",Logo)
local Commands = {}

f.Name = "Main"
f.Position = UDim2.new(XTG,UDim.new(1,-25)) 
f.Size = UDim2.new(0, 400, 1, 0) 
f.BackgroundColor3 = Colors.MainBackground

Logo.Name = "Logo"
Logo.BackgroundTransparency = 1
Logo.Size = UDim2.new(1, -25, 0, 25)
Logo.Position = UDim2.new(0, 25, 0, 0)
tittleThr.Position = UDim2.new(0.5,2,0,0)
tittleTwo.Position = UDim2.new(0.5,-1,0,0)
tittleTwo.BackgroundColor3 = Colors.Logo.Separator
tittleOne.Font = Enum.Font.SourceSansBold
tittleThr.Font = Enum.Font.SourceSansBold
tittleOne.TextColor3 = Colors.Logo.One
tittleThr.TextColor3 = Colors.Logo.Two
tittleOne.Size = UDim2.new(0.5,-2,1,0)
tittleThr.Size = UDim2.new(0.5,-2,1,0)
tittleTwo.Size = UDim2.new(0,2,1,0)
tittleOne.BackgroundTransparency = 1
tittleThr.BackgroundTransparency = 1
tittleOne.TextScaled = true
tittleThr.TextScaled = true
tittleOne.TextXAlignment = 1
tittleThr.TextXAlignment = 0
tittleOne.Text = "Tim"
tittleThr.Text = "Gui"
tittleOne.Name = "1"
tittleTwo.Name = "2"
tittleThr.Name = "3"

timeLol.TextXAlignment = 1
timeLol.Name = "SystemTime"
timeLol.TextColor3 = Colors.Text
timeLol.Size = UDim2.new(1,0,1,0)
timeLol.Text = "Loading"
timeLol.TextScaled = true
timeLol.BackgroundTransparency = 1
task.spawn(function()
	while task.wait(0.5) and timeLol.Parent do
		timeLol.Text = os.date("%H:%M:%S",os.time())
	end
end)

AO.Name = "Arrow"
AO.BackgroundTransparency = 100
AO.Size = UDim2.new(0, 25, 0, 25)
AO.Image = "rbxassetid://16341277046"
AO.ImageColor3 = Colors.Arrow

Groups.Name = "Groups"
Groups.Parent = f
Groups.ScrollBarThickness = 5
Groups.BackgroundColor3 = Colors.GroupsBackground
Groups.Size = UDim2.new(0, 100, 1, -25) 
Groups.Position = UDim2.new(0, 0, 0, 25) 
Groups.ScrollingDirection = 2

Objects.Name = "Objects"
Objects.Parent = f
Objects.ScrollBarThickness = 5
Objects.BackgroundColor3 = Colors.MainBackground
Objects.Size = UDim2.new(1, -100, 1, -25) 
Objects.Position = UDim2.new(0, 100, 0, 25) 
Objects.ScrollingDirection = 2

_G.TimGui.askYN = function(name,text,rusname,rustxt,onyes,onno)
	local Menu = Instance.new("ImageLabel",_G.TimGui.Path.Main.Parent) 
	Menu.Name = "askYN"
	Menu.Size = UDim2.new(0, 425, 0, 300)
	Menu.Position = UDim2.new(0.5, -212.5, -2, 0) 
	Menu.BackgroundTransparency = 100
	if _G.TimGui.Values.RusLang then
	Menu.Image = "rbxassetid://17041335616"
	else
	Menu.Image = "rbxassetid://17041343700"
	end
	local nm = Instance.new("TextLabel",Menu) 
	nm.BackgroundTransparency = 1
	nm.Name = "Nametxt"
	nm.Text = name
	if _G.TimGui.Values.RusLang then nm.Text = rusname end
	nm.Size = UDim2.new(0, 300, 0, 50) 
	nm.TextScaled = true
	nm.Position = UDim2.new(0, 57, 0, 0) 
	nm.TextColor3 = Color3.new(1, 1, 1) 
	local textt = Instance.new("TextLabel",Menu) 
	textt.BackgroundTransparency = 1
	textt.Name = "text"
	textt.Text = text
	if _G.TimGui.Values.RusLang then textt.Text = rustxt end
	textt.TextScaled = true
	textt.Size = UDim2.new(0, 350, 0, 100) 
	textt.Position = UDim2.new(0, 3, 0, 70) 
	textt.TextColor3 = Color3.new(1, 1, 1) 
	local No = Instance.new("TextButton",Menu) 
	No.BackgroundTransparency = 1
	No.Name = "N"
	No.Text = ""
	No.Size = UDim2.new(0, 115, 0, 85) 
	No.Position = UDim2.new(0, 70, 0, 185) 
	local Yes = Instance.new("TextButton",Menu) 
	Yes.BackgroundTransparency = 1
	Yes.Name = "Y"
	Yes.Text = ""
	Yes.Size = UDim2.new(0, 115, 0, 85) 
	Yes.Position = UDim2.new(0, 190, 0, 185)
	No.Activated:Connect(function()
		local goal = {}
		goal.Position = UDim2.new(0.5, -212.5, 2, 0) 
		game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
		if onno then
		onno()
		end
		wait(1) 
		Menu:Destroy()
	end) 
	Yes.Activated:Connect(function()
	local goal = {}
		goal.Position = UDim2.new(0.5, -212.5, 2, 0) 
		game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
		onyes()
		wait(1)
		Menu:Destroy()
	end) 
	local goal = {}
	goal.Position = UDim2.new(0.5, -212.5, 0.5, -150) 
	game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
	return Menu
end

_G.TimGui.Open = function()
	local OC = not _G.TimGui.Values.Opened
	_G.TimGui.Values.Opened = OC
	if OC then
		local goal = {}
		goal.Position = UDim2.new(XTG,UDim.new(0,0))
		AO.Rotation = 0
		TweenService:Create(f, TweenInfo.new(0.5), goal):Play()
		TweenService:Create(AO, TweenInfo.new(0.5), {Rotation=180}):Play()
	else
		local goal = {}
		goal.Position = UDim2.new(XTG,UDim.new(1,-25)) 
		TweenService:Create(f, TweenInfo.new(0.5), goal):Play() 
		TweenService:Create(AO, TweenInfo.new(0.5), {Rotation=360}):Play()
	end
end 
AO.Activated:Connect(_G.TimGui.Open)

--Keybinds----------------------------------------------------------------------------------------
local Keybinds = {}
local SelectKeybind = {}
local AddTB = {}
AddTB.LeftShift = {ShortName="LShift", Pressed=false}
AddTB.RightShift = {ShortName="RShift", Pressed=false}
AddTB.LeftControl = {ShortName="LCtrl", Pressed=false}
AddTB.RightControl = {ShortName="RCtrl", Pressed=false}
AddTB.LeftAlt = {ShortName="LAlt", Pressed=false}
AddTB.RightAlt = {ShortName="RAlt", Pressed=false}
_G.TimGui.Keybinds.GetTable = function() return table.clone(Keybinds) end

_G.TimGui.Keybinds.Set = function(Button,Key)
	if Keybinds[Key] == nil then
		Keybinds[Key] = {}
	end
	local GB = Button.Parent.Name .. "." .. Button.Object.Name
	for b,v in pairs(Keybinds) do
		for k,v in pairs(v) do 
			if k == GB then
				Keybinds[b][k] = nil
				Button.Object.Keybind.Text = ""
			end
		end
		if Key ~= "" and Key ~= nil then
			Button.Object.Keybind.Text = Key
			if Button.Type == 1 then
				Keybinds[Key][GB] = Button.EmulateClick
			elseif Button.Type == 2 then
				Keybinds[Key][GB] = Button.ChangeValue
			end
		end
	end
end

local function NewButton(Button)
	if SelectKeybind.YN ~= nil then return end
	SelectKeybind.Key = ""
	SelectKeybind.YN = _G.TimGui.askYN("Select a key","Key is not selected","Выбери клавишу","Клавиша не выбрана",function()
		_G.TimGui.Keybinds.Set(Button,SelectKeybind.Key)
		SelectKeybind = {}
	end,function()
		SelectKeybind = {}
	end)
end

game:GetService("UserInputService").InputEnded:Connect(function(input)
	local button = input.KeyCode.Name
	for k,v in pairs(AddTB) do
		if k == button then
			v.Pressed = false
		end
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input,focus)
	local button = input.KeyCode.Name
    if not (button == "Unknown") then
		local adding = ""
		for k,v in pairs(AddTB) do
			if v.Pressed then
				adding = v.ShortName .. " + " .. adding
			elseif k == button then
				v.Pressed = true
				return
			end
		end
		button = adding .. button
		if not game.UserInputService:GetFocusedTextBox() then
			if SelectKeybind.YN == nil then
				if Keybinds[button] ~= nil then
					local tmp = Instance.new("BoolValue")
					for k,v in pairs(Keybinds[button]) do
						tmp.Changed:Connect(function()
							v()
						end)
					end
					tmp.Value = true
				end
			else
				SelectKeybind.Key = button
				if _G.TimGui.Values.RusLang then
					SelectKeybind.YN.text.Text = "Выбранная клавиша: "..button
					if focus then
						SelectKeybind.YN.text.Text = SelectKeybind.YN.text.Text .. ". Эта клавиша может помешать игре"
					end
				else
					SelectKeybind.YN.text.Text = "Selected key: "..button
					if focus then
						SelectKeybind.YN.text.Text = SelectKeybind.YN.text.Text .. ". This may interfere with the game"
					end
				end
			end
		end
	end
end)

-- FlyButton ------------------------------------------------
local FBGui = Instance.new("ScreenGui",game.CoreGui)
FBGui.DisplayOrder = 100
FBGui.IgnoreGuiInset = true
FBGui.ClipToDeviceSafeArea = true
FBGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
FBGui.ScreenInsets = Enum.ScreenInsets.None
FBGui.ResetOnSpawn = false
FBGui.Name = "TimGui FlyButtons"
local function FlyButton(button)
	local name = button.Parent.Name .. "." .. button.Name
	if FBGui:FindFirstChild(name) then
		FBGui:FindFirstChild(name):Destroy()
		_G.TimGui.Print("Flying buttons","Deleted","Летающие кнопки","Удаленно")
		return
	end
	local Button = Instance.new("TextButton",FBGui)
	Instance.new("UICorner",Button).CornerRadius = UDim.new(0.25,0)
	Button.Name = name
	Button.Text = button.Object.text
	Button.Size = UDim2.new(0,60,0,60)
	Button.Position = UDim2.new(0.5,-25,0.1,0)
	Button.TextScaled = true
	Button.BackgroundColor3 = Color3.new(0,0,0.1)
	button.Object:GetPropertyChangedSignal("Text"):Connect(function()
		Button.Text = button.Object.text
	end)
	if button.Type == 2 then
		local function updVal()
			if button.Main.Value then
				Button.TextColor3 = Color3.new(0,1,0)
			else
				Button.TextColor3 = Color3.new(1,0,0)
			end
		end
		button.Main.Changed:Connect(updVal)
		updVal()
	else
		Button.TextColor3 = Color3.new(1,1,1)
	end
	local Clicked = false
	local Moved = false
	Button.MouseButton1Down:Connect(function()
		Clicked = true
		Moved = false
	end)
	Button.MouseMoved:Connect(function(x,y)
		if Clicked then
			local newX = x - (Button.Size.X.Offset /2)
			local newY = y - (Button.Size.Y.Offset /2)
			local oldMagnitude = Button.Position.Y.Offset + Button.Position.X.Offset
			oldMagnitude = oldMagnitude - (newX + newY)
			if (math.abs(oldMagnitude) > 10) or Moved then
				Button.Position = UDim2.new(0,newX,0,newY)
				Moved = true
			end
		end
	end)
	Button.MouseButton1Up:Connect(function()
		Clicked = false
	end)
	Button.Activated:Connect(function()
		if not Moved then
			if button.Type == 1 then
				button.EmulateClick()
			else
				button.ChangeValue()
			end
		end
	end)
	_G.TimGui.Print("Flying buttons","Created","Летающие кнопки","Созданно")
end

--Update-----------------------------------------------------
local Update
local SetPosForObjectCustom
local SetPosForGroupCustom
local onDisconnect
_G.TimGui.ObjectPosition = {}
_G.TimGui.ObjectPosition.Disconnect = function()
	SetPosForObjectCustom = nil
	SetPosForGroupCustom = nil
	Update()
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			Update(v)
		end
	end
	XTG = UDim.new(1, -400)
	f.Position = UDim2.new(XTG,f.Position.Y)
	if type(onDisconnect) == "function" then
		local onDis = onDisconnect
		onDisconnect = nil
		onDis()
	end
end
_G.TimGui.ObjectPosition.Connect = function(xpos,conG,con,onDis)
	_G.TimGui.ObjectPosition.Disconnect()
	SetPosForObjectCustom = con
	SetPosForGroupCustom = conG
	onDisconnect = onDis
	if xpos ~= nil then
		XTG = xpos
		f.Position = UDim2.new(XTG,f.Position.Y)
	end
	Update()
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			Update(v)
		end
	end
end

local function SetPosUnivers(k,v)
	v.Size = UDim2.new(1, 0, 0, 50)
	v.Position = UDim2.new(0, 0, 0, 50 * k)
end

local function SetPosForObject(k,v)
	if SetPosForObjectCustom ~= nil then
		SetPosForObjectCustom(k,v,function()
			SetPosUnivers(k,v.Object)
		end)
	else
		SetPosUnivers(k,v.Object)
	end
end
local function SetPosForGroup(k,v)
	if SetPosForGroupCustom ~= nil then
		SetPosForGroupCustom(k,v,function()
			SetPosUnivers(k,v.ButtonInList)
		end)
	else
		SetPosUnivers(k,v.ButtonInList)
	end
end

function Update(group)
	if group == nil then
		local Obj = {}
		for k,v in pairs(_G.TimGui.Groups) do
			if type(v) == "table" then
				table.insert(Obj,v)
			end
		end
		table.sort(Obj,function(a,b)
			if not a.Visible then
				if a.Visible ~= b.Visible then
					return false
				end
			elseif not b.Visible then
                if a.Visible ~= b.Visible then
					return true
				end
			end
			return a.Pos < b.Pos
		end)
		for k,v in pairs(Obj) do
			SetPosForGroup(k-1,v)
			if v.Visible then
				Groups.CanvasSize = UDim2.new(UDim.new(0,0),v.ButtonInList.Size.Y + v.ButtonInList.Position.Y)
			end
		end
	else
		local Obj = {}
		for k,v in pairs(group.Objects) do
			table.insert(Obj,v)
		end
		table.sort(Obj,function(a,b)
			if not a.Visible then
				if a.Visible ~= b.Visible then
					return false
				end
			elseif not b.Visible then
                if a.Visible ~= b.Visible then
					return true
				end
			end
			if a.Pos == b.Pos then
				return a.Count < b.Count
			else
				return a.Pos < b.Pos
			end
		end)
		for k,v in pairs(Obj) do
			if v.Visible then
				SetPosForObject(k-1,v)
				if _G.TimGui.Values.GroupOpened == group then
					Objects.CanvasSize = UDim2.new(UDim.new(0,0),v.Object.Size.Y + v.Object.Position.Y)
				end
			end
		end
	end
end

--ColorSetter---------------------------------------------------------------------
local OnChangeColor = {}
local DefColors
local LoaderValues = DefaultColors
Colors.OnChange = function(funct)
	table.insert(OnChangeColor,funct)
end

Colors.SetColors = function()
	f.BackgroundColor3 = Colors.MainBackground
	Objects.BackgroundColor3 = Colors.MainBackground
	Groups.BackgroundColor3 = Colors.GroupsBackground
	tittleOne.TextColor3 = Colors.Logo.One
	tittleThr.TextColor3 = Colors.Logo.Two
	tittleTwo.BackgroundColor3 = Colors.Logo.Separator
	timeLol.TextColor3 = Colors.Text
	AO.ImageColor3 = Colors.Arrow
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			v.ButtonInList.BackgroundColor3 = Colors.Button
			v.ButtonInList.TextColor3 = Colors.Text
			for k,v in pairs(v.Objects) do
				v.Object.BackgroundColor3 = Colors.Button
				if v.Type ~= 2 then
					v.TextObject.TextColor3 = Colors.Text
					if v.Type == 3 then
						v.Main.BackgroundColor3 = Colors.TextBoxBackground
					end
				elseif v.Value then
					v.TextObject.TextColor3 = Colors.ToggleButton.Enabled
				else
					v.TextObject.TextColor3 = Colors.ToggleButton.Disabled
				end
			end
		end
	end
	for _,v in pairs(OnChangeColor) do
		task.spawn(function() v() end)
	end
end

Colors.ResetColors = function()
	_G.TimGui.Colors = table.clone(DefColors)
	Colors = _G.TimGui.Colors
	Colors.SetColors()
end

Colors.GetDefaultColors = function(loader)
	if loader then
		return table.clone(LoaderValues)
	else
		return table.clone(DefaultColors)
	end
end
DefColors = table.clone(Colors)
-- Setup -----------------------------------------------------------------------
if _G.Setup ~= nil then
	local Setup = _G.Setup
	if Setup.Logo ~= nil then
		if Setup.Logo.Font ~= nil then
			local Font = Setup.Logo.Font
			tittleOne.Font = Font
			tittleThr.Font = Font
		end if Setup.Logo.One ~= nil then
			tittleOne.Text = Setup.Logo.One
		end	if Setup.Logo.Two ~= nil then
			tittleTwo.Text = Setup.Logo.Two
		end
	end
	if Setup.Colors ~= nil then
		for k,v in pairs(Setup.Colors) do
			if type(Colors[k]) ~= "function" then
				Colors[k] = v
			end
		end
		Colors.SetColors()
		LoaderValues = table.clone(Colors)
	end
end

--Group----------------------------------------------------------------------------
_G.TimGui.Groups.CreateNewGroup = function(name,rus)
	if _G.TimGui.Groups[name] ~= nil then
		error("Group "..name.." alredy used")
	end
	_G.TimGui.Groups[name] = {}
	if not rus then
		rus = name
	end
	local group = _G.TimGui.Groups[name]
	group.Name = name
	group.RusName = rus
	group.Objects = {}
	group.Visible = true
	group.OpenGroup = function()
		for k,v in pairs(Objects:GetChildren()) do
			v.Visible = false
		end
		for k,v in pairs(group.Objects) do
			v.Object.Visible = v.Visible
		end
		_G.TimGui.Values.GroupOpened = group
		Update(group)
	end
	local yy = #(Groups:GetChildren())
	local Button = Instance.new("TextButton",Groups) 
	local Pos = Instance.new("NumberValue",Temp)
	Button.Text = name
	if _G.TimGui.Values.RusLang then
		Button.Text = rus
	end
	Button.Name = name
	Button.BackgroundColor3 = Colors.Button
	Button.TextColor3 = Colors.Text
	Button.TextScaled = true
	Instance.new("UICorner",Button).CornerRadius = UDim.new(1,0)
	Button.Activated:Connect(group.OpenGroup)
	Pos.Value = yy 
	Groups.CanvasSize = UDim2.new(0, 0, 0, 50 * yy)
	group.ButtonInList = Button
	group.Pos = yy
	SetPosForGroup(yy,group)
	group.Create = function(typ,name,text,rus,funct)
		if not rus then
			rus = text
		end
		local oy = 0
        for k,v in pairs(group.Objects) do
            if oy <= v.Pos then
				oy = v.Pos +1
			end
        end
		Count += 1
		if group.Objects[name] ~= nil then
			error("Button "..name.." alredy used in this group")
		end
        group.Objects[name] = {}
		local Obj = group.Objects[name]
		Obj.Text = text
		Obj.RusText = rus
		Obj.Visible = true
		Obj.Pos = oy
		Obj.Type = typ
		Obj.Count = Count
		Obj.Parent = group
		Obj.Name = name
		local clcFuncs = {}
		if type(funct) == "function" then
			if typ == 0 then
				warn("Function in text?")
			elseif typ ~= 2 then
				table.insert(clcFuncs,funct)
			end
		end
		local Object
		if typ == 0 then
			Object = Instance.new("TextLabel",Objects)
			Object.BackgroundTransparency = 1
		elseif typ == 1 or typ == 2 then
			Object = Instance.new("TextButton",Objects)
			local Keybind = Instance.new("TextLabel",Object) 
			Keybind.BackgroundTransparency = 100
			Keybind.Name = "Keybind"
			Keybind.Text = ""
			Keybind.Size = UDim2.new(1, 0, 0.5, 0) 
			Keybind.TextScaled = true
			Keybind.TextColor3 = Color3.new(0.75, 0.75, 1) 
			Keybind.TextXAlignment = Enum.TextXAlignment.Left
			Object.MouseButton2Click:Connect(function() 
				NewButton(Obj)
			end)
		elseif typ == 3 then
			Object = Instance.new("Frame",Objects)
		else
			group.Objects[name] = nil
			error("Wrong type for create object in "..group.Name)
		end
		Object.Name = name
		Object.BackgroundColor3 = Colors.Button
		if typ <= 2 then
			Obj.TextObject = Object
			Object.Text = text
			if _G.TimGui.Values.RusLang then
				Object.Text = rus
			end
			if typ == 2 then
				Object.TextColor3 = Colors.ToggleButton.Disabled
			else
				Object.TextColor3 = Colors.Text
				Obj.Main = Object
			end
			Object.TextScaled = true
		end
		Obj.Object = Object
		SetPosForObject(oy,Obj)
		Object.Visible = _G.TimGui.Values.GroupOpened == group
		Instance.new("UICorner",Object).CornerRadius = UDim.new(1,0)
		local RunB
		if typ == 1 or typ == 2 then
			local FlyCount = 0
			local Fly = false
			Object.MouseButton1Down:Connect(function()
				if game:GetService("UserInputService").TouchEnabled then
					FlyCount += 1
					local FCount = FlyCount
					Fly = false
					wait(2)
					if FCount == FlyCount then
						Fly = true
						Object.BackgroundColor3 = Color3.new(0,0,0)
						wait(0.5)
						Object.BackgroundColor3 = Colors.Button
					end
				end
			end)
			RunB = function(funct)
				FlyCount += 1
				if Fly then
					FlyButton(Obj)
				else
					funct()
				end
			end
		end
		if typ == 1 then
			Obj.OnClick = function(funct)
				if type(funct) == "function" then
					table.insert(clcFuncs,funct)
				end
			end
			Obj.EmulateClick = function()
				local emul = Instance.new("BoolValue")
				for k,v in pairs(clcFuncs) do
					emul.Changed:Connect(function()
						v(Obj)
					end)
				end
				emul.Value = true
			end
			Object.Activated:Connect(function()
				RunB(Obj.EmulateClick)
			end)
		elseif typ == 2 then
			local Value = Instance.new("BoolValue",Object)
			Obj.Main = Value
			Obj.CFGSave = false
			Value.Changed:Connect(function()
				Obj.Value = Value.Value
				local goal = {}
				if Value.Value then
					goal.TextColor3 = Colors.ToggleButton.Enabled
				else
					goal.TextColor3 = Colors.ToggleButton.Disabled 
				end
				if OptimizeTable.AnimationTB then
					game:GetService("TweenService"):Create(Object, TweenInfo.new(0.5), goal):Play() 
				else
					Object.TextColor3 = goal.TextColor3
				end
				if type(funct) == "function" then
					funct(Obj)
				end
			end)
			Obj.ChangeValue = function()
				Value.Value = not Value.Value
			end
			Obj.OnChange = function(funct)
				if type(funct) == "function" then
					Value.Changed:Connect(function()
						wait()
						funct(Obj)
					end)
				end
			end
			Object.Activated:Connect(function()
				RunB(Obj.ChangeValue)
			end)
		elseif typ == 3 then
			local Tittle = Instance.new("TextLabel",Object)
			Obj.TextObject = Tittle
			Tittle.Name = "Text"
			Tittle.BackgroundTransparency = 1
			Tittle.Size = UDim2.new(0.5,0,1,0)
			Tittle.Text = text
			Tittle.TextScaled = true
			Tittle.TextColor3 = Color3.new(1,1,1) 
			if _G.TimGui.Values.RusLang then
				Tittle.Text = rus
			end
			if typ == 3 then
				local Value = Instance.new("TextBox",Object)
				Value.ClearTextOnFocus = false
				Value.Name = "Value"
				Value.BackgroundTransparency = 0.4
				Value.BackgroundColor3 = Colors.TextBoxBackground
				Value.Size = UDim2.new(0.4,0,1,0)
				Value.Text = text
				Value.TextScaled = true
				Value.TextColor3 = Color3.new(1,1,1)
				Value.Position = UDim2.new(0.5,0,0,0)
				Value.Text = ""
				Obj.Main = Value
				Obj.CFGSave = true
				Value:GetPropertyChangedSignal("Text"):Connect(function()
					Obj.Value = Value.Text
					local emul = Instance.new("BoolValue")
					for k,v in pairs(clcFuncs) do
						emul.Changed:Connect(function()
							v(Obj)
						end)
					end
					emul.Value = true
				end)
				Obj.ChangeValue = function(Val)
					Value.Text = Val
				end
				Obj.OnChange = function(funct)
					if type(funct) == "function" then
						table.insert(clcFuncs,funct)
					end
				end
			end
		end
		Obj.Destroy = function()
			Obj.Object:Destroy()
			group.Objects[name] = nil
			Obj.Parent = nil
			local FB = FBGui:FindFirstChild(group.Name .. "." .. Obj.Name)
			if FB then
				FB:Destroy()
			end
			Obj = nil
			Update(group)
		end
		Update(group)
		local oldParams = table.clone(Obj)
		local whil = Instance.new("BoolValue")
		whil.Changed:Connect(function()
			while Obj ~= nil do
				if _G.TimGui.Values.Opened or not OptimizeTable.OnClose then
					if _G.TimGui.Values.RusLang ~= true then
						if Obj.Text ~= oldParams.Text then
							Obj.TextObject.Text = Obj.Text
						end
					else
						if Obj.RusText ~= oldParams.RusText then
							Obj.TextObject.Text = Obj.RusText
						end
					end if Obj.Object ~= oldParams.Object then
						Obj.Object = oldParams.Object
					end if Obj.Pos ~= oldParams.Pos then
						Obj.Pos = oldParams.Pos
						Update(group)
					end if Obj.Visible ~= oldParams.Visible then
						if group.Name == _G.TimGui.Values.GroupOpened then
						    Obj.Object.Visible = Obj.Visible
							Update(group)
						end
					end if Obj.Type ~= oldParams.Type then
						Obj.Type = oldParams.Type
					end if Obj.OnClick ~= oldParams.OnClick then
						Obj.OnClick = oldParams.OnClick
					end if Obj.EmulateClick ~= oldParams.EmulateClick then
						Obj.EmulateClick = oldParams.EmulateClick
					end if Obj.OnChange ~= oldParams.OnChange then
						Obj.OnChange = oldParams.OnChange
					end if Obj.ChangeValue ~= oldParams.ChangeValue then
						Obj.ChangeValue = oldParams.ChangeValue
					end
					if typ == 2 then
						Obj.Value = Obj.Main.Value
					elseif typ == 3 then
						Obj.Value = Obj.Main.Text
					end
					oldParams = table.clone(Obj)
				end
				if OptimizeTable.Timer then wait(updTime) end
				wait()
				if OptimizeTable.TwoTimer then wait(updTime) end
			end
		end)
		whil.Value = true
		return Obj
	end
	group.Destroy = function()
		for k,v in pairs(group.Objects) do
			v.Destroy()
		end
		_G.TimGui.Groups[group.Name] = nil
		group.ButtonInList:Destroy()
		group = nil
		Update()
	end
	local oldGroup = table.clone(group)
	local whil = Instance.new("BoolValue")
	whil.Changed:Connect(function()
		while group ~= nil do
			if _G.TimGui.Values.Opened or not OptimizeTable.OnClose then
				if group.RusName ~= oldGroup.RusName then
					group.RusName = oldGroup.RusName
				end if group.Name ~= oldGroup.Name then
					group.Name = oldGroup.Name
				end if group.Open ~= oldGroup.Open then
					group.Open = oldGroup.Open
				end if group.Create ~= oldGroup.Create then
					group.Create = oldGroup.Create
				end if group.ButtonInList ~= oldGroup.ButtonInList then
					group.ButtonInList = oldGroup.ButtonInList
				end if group.Pos ~= oldGroup.Pos then
					group.Pos = oldGroup.Pos
				end if group.Visible ~= oldGroup.Visible then
					group.ButtonInList.Visible = group.Visible
					Update()
				end
				oldGroup = table.clone(group)
			end
			if OptimizeTable.Timer then wait(updTime) end
			wait()
			if OptimizeTable.TwoTimer then wait(updTime) end
		end
	end)
	whil.Value = true
	Update()
	return group
end
-- Path ------------------------------------------
_G.TimGui.Path.Logo = Logo
_G.TimGui.Path.gui = gui
_G.TimGui.Path.Main = f
_G.TimGui.Path.Groups = Groups
_G.TimGui.Path.Buttons = Objects
_G.TimGui.Path.FlyButtonsGui = FBGui
-- Saves ------------------------------------------
_G.TimGui.Saves = {}
local pathSaves = "TimGui/Saves/"
local SavesSuccess,response = pcall(function()
	makefolder("TimGui")
	makefolder(pathSaves)
	writefile("TimGui/Test","TimGui|Testing saves...")
	print(readfile("TimGui/Test"))
	print(table.unpack(listfiles("TimGui")))
	delfile("TimGui/Test")
end)
if not SavesSuccess then
	warn("TimGui|Saves not success.\n"..response)
else
	print("TimGui|Saves working!")
end
_G.TimGui.Saves.Enabled = SavesSuccess
_G.TimGui.Saves.Save = function(name,value)
	if SavesSuccess then
		if value == nil then
			delfile(pathSaves..name)
		else
			writefile(pathSaves..name,tostring(value))
		end
	else
		return nil
	end
end
_G.TimGui.Saves.Load = function(name)
	if SavesSuccess then
		for _,path in listfiles(pathSaves) do
			if path == pathSaves..name then
				return readfile(path)
			end
		end
	end
	return nil
end
-- Functions --------------------------------------
_G.TimGui.AddCommand = function(com,funct)
     Commands[com] = funct
end

game.TextChatService.MessageReceived:Connect(function(Message)
     local message = Message.Text
     if string.sub(message,1,1) == "/" then
          local args = string.split(string.sub(message,2)," ")
          local com = args[1]
          args[1] = game.Players:GetPlayerByUserId(Message.TextSource.UserId)
          local com = Commands[com]
          if com then
               com(table.unpack(args))
          end
     end
end)

local function NewPlayer(player)
     player.Chatted:Connect(function(message)
          if string.sub(message,1,1) == "/" then
               local args = string.split(string.sub(message,2)," ")
               local com = args[1]
               args[1] = player
               local com = Commands[com]
               if com then
                    com(table.unpack(args))
		end
          end
     end)
end

for k,v in pairs(game.Players:GetPlayers()) do
     NewPlayer(v)
end
game.Players.PlayerAdded:Connect(NewPlayer)

local Settings = _G.TimGui.Groups.CreateNewGroup("Settings","Настройки")
local RusLang = Settings.Create(2,"RusLang","Русский язык","English language",function(Value)
	_G.TimGui.Values.RusLang = Value.Value
	_G.TimGui.Saves.Save("RussianLanguage",Value.Value)
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			if Value.Value then
				v.ButtonInList.Text = v.RusName
			else
				v.ButtonInList.Text = v.Name
			end
			for k,v in pairs(v.Objects) do
				if v.Type <= 2 then
					if Value.Value then
						v.Object.Text = v.RusText
					else
						v.Object.Text = v.Text
					end
				else
					if Value.Value then
						v.Object.Text.Text = v.RusText
					else
						v.Object.Text.Text = v.Text
					end
				end
			end
		end
	end
end)
if _G.TimGui.Saves.Enabled then
	RusLang.Main.Value = _G.TimGui.Saves.Load("RussianLanguage") == "true"
	local Secret = {
		{"I","Cura"},
		{"Пря","Рассиа"},
		{"Мышка","сосиска"},
		{"Babka","tapka"},
		{"Курица","на ножке"},
		{"Роскомнадзор","Т#а#и"}
	}
	if math.random(1,100) == 5 then
		local rand = Secret[math.random(1,#Secret)]
		_G.TimGui.Path.Logo[1].Text = rand[1]
		_G.TimGui.Path.Logo[3].Text = rand[2]
	end
else
	local tmp = game.LocalizationService.SystemLocaleId == "ru-ru" or game.LocalizationService.RobloxLocaleId == "ru-ru"
	if os.date("%H",0) or tmp then
		RusLang.Main.Value = true
	end
end
Settings.OpenGroup()

local TPTP = _G.TimGui.Groups.CreateNewGroup("TP to players","ТП к игрокам")
local MACP = 8
TPTP.Create(3,1,"Multyply anticipate","Множитель предугадывания",function(val)
	MACP = tonumber(val.Value)
	if MACP == nil then
		MACP = 8
	end
end).Main.Text = MACP
local ACP = TPTP.Create(2,2,"to anticipate position","Предугадать движение")
local TPRot = TPTP.Create(2,3,"TP with rotation","ТП с поворотом")
TPRot.Main.Value = true
local AutoTP = TPTP.Create(2,4,"Auto TP","Авто ТП")
local AutoTPto = nil
TPTP.Create(1,5,"TP to random player","ТП к случайному игроку",function()
	local player = game.Players:GetChildren()
	player = player[math.random(1,(#player)-1)+1]
	AutoTPto = player.Name
	AutoTP.Text = "Auto TP to "..AutoTPto
	AutoTP.RusText = "Авто ТП к "..AutoTPto
	if TPRot.Value then
		LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
	else
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position,LocalPlayer.Character.HumanoidRootPart.Orientation)
	end
end)
local TPoff = _G.TimGui.Groups.CreateNewGroup("TPoffset")
TPoff.Visible = false
local Offset = Vector3.new(0,0,0)
TPoff.Create(3,"X","X:","X:",function(value)
	local num = tonumber(value.Value)
	if num == nil then num = 0 end
	Offset = Vector3.new(num,Offset.Y,Offset.Z)
end)
TPoff.Create(3,"Y","Y:","Y:",function(value)
	local num = tonumber(value.Value)
	if num == nil then num = 0 end
	Offset = Vector3.new(Offset.X,num,Offset.Z)
end)
TPoff.Create(3,"Z","Z:","Z:",function(value)
	local num = tonumber(value.Value)
	if num == nil then num = 0 end
	Offset = Vector3.new(Offset.X,Offset.Y,num)
end)
TPTP.Create(1,6,"Offset","Смещение",function()
	TPoff.OpenGroup()
end)
TPTP.Create(0,"AllTpTittle","All TP","ТП ко всем")
local AllTpCouldown = TPTP.Create(3,"AllTpCD","All tp time:","КД при тп ко всем:")
local AllTP = TPTP.Create(2,"AllTp","All TP","ТП ко всем",function(val)
    AutoTP.Main.Value = val.Value
end)
task.spawn(function()
    while true do
        local KD = tonumber(AllTpCouldown.Value) or 1
        wait(KD)
        if AllTP.Value then
            for k,v in pairs(game.Players:GetPlayers()) do
                if not _G.TimGui.Values.Spare[v.Name] and v ~= LocalPlayer then
                    AutoTPto = v.Name
                    AutoTP.Text = "Auto TP to "..AutoTPto
                    AutoTP.RusText = "Авто ТП к "..AutoTPto
                    wait(KD)
                end
            end
        end
    end
end)
TPTP.Create(0,7,"Players","Игроки")
local function AddedPlayer(v)
	local n = v.Name
	TPTP.Create(1,n,n,n,function()
		AutoTPto = n
		AutoTP.Text = "Auto TP to "..AutoTPto
		AutoTP.RusText = "Авто ТП к "..AutoTPto
		local AddPos = Vector3.new(0,0,0)
		if ACP.Value then
			local hum = v.Character.Humanoid
			AddPos = hum.MoveDirection * Vector3.new(MACP,MACP,MACP)
		end
		AddPos += Offset
		if v.Character:FindFirstChild("HumanoidRootPart") then
			if TPRot.Value then
				LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + AddPos
			else
				LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position,LocalPlayer.Character.HumanoidRootPart.Orientation) + AddPos
			end
		else
			LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.WorldPivot
			wait(0.5)
			if v.Character:FindFirstChild("HumanoidRootPart") then
				if TPRot.Value then
					LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + AddPos
				else
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position,LocalPlayer.Character.HumanoidRootPart.Orientation) + AddPos
				end
			else
				_G.TimGui.Print("TP","Player not loaded.","ТП","Игрок не прогружен")
			end
		end
	end)
end
for k,v in pairs(game.Players:GetPlayers()) do
	if v == LocalPlayer then continue end
	AddedPlayer(v)
end
game.Players.PlayerAdded:Connect(AddedPlayer)
game.Players.PlayerRemoving:Connect(function(player)
	TPTP.Objects[player.Name].Destroy()
end)

RunService.RenderStepped:Connect(function()
	if AutoTPto ~= nil and AutoTP.Value then
		local v = game.Players:FindFirstChild(AutoTPto)
		if v then
			local AddPos = Vector3.new(0,0,0)
			if ACP.Value then
				local hum = v.Character.Humanoid
				AddPos = hum.MoveDirection * Vector3.new(MACP,MACP,MACP)
			end
			AddPos += Offset
			if v.Character:FindFirstChild("HumanoidRootPart") then
				if TPRot.Value then
					LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + AddPos
				else
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position,LocalPlayer.Character.HumanoidRootPart.Orientation) + AddPos
				end
			else
				LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.WorldPivot
				wait(0.5)
				if v.Character:FindFirstChild("HumanoidRootPart") then
					if TPRot.Value then
						LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + AddPos
					else
						LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.HumanoidRootPart.Position,LocalPlayer.Character.HumanoidRootPart.Orientation) + AddPos
					end
				else
					AutoTPto.Main.Value = false
					_G.TimGui.Print("TP","Player not loaded.","ТП","Игрок не прогружен")
				end
			end
		end
	end
end)

Settings.Create(0,"Notificaton","Notificaton","Уведомления")
local PrintTime = 2.5
local PrintTimeT = Settings.Create(3,"TimeNotification","Time of notification:","Время уведомления:",function(val)
	PrintTime = tonumber(val.Value)
	if PrintTime == nil then
		PrintTime = 2.5
	elseif PrintTime < 0.1 then
		PrintTime = 0.1
	elseif PrintTime > 30 then
		PrintTime = 30
	end
end)
PrintTimeT.Main.Text = 2.5
local PrintEnable = Settings.Create(2,"PrintEnable","Enable messages","Включить уведомления")
PrintEnable.Main.Value = true
PrintEnable.CFGSave = true
local stroke = 5
local size = 250
_G.TimGui.Print = function(Zag,Txt,ZagRus,TxtRus)
    if not PrintEnable.Value then return end
    local Frame = Instance.new("Frame",gui)
    Frame.Size = UDim2.new(0,size,0,size/1.5)
    Frame.BackgroundColor3 = Colors.Print.Outline
    Frame.Name = "Print"
    local Main = Instance.new("Frame",Frame)
    Main.Size = UDim2.new(1,-stroke*2,1,-stroke*2)
    Main.Position = UDim2.new(0,stroke,0,stroke)
    Main.BackgroundColor3 = Colors.Print.Background
    Instance.new("UICorner",Frame).CornerRadius = UDim.new(0.2,0)
    Instance.new("UICorner",Main).CornerRadius = UDim.new(0.2,0)
    local ZagVal = Instance.new("TextLabel",Main)
    ZagVal.Size = UDim2.new(0.9,0,0.25,0)
    ZagVal.Position = UDim2.new(0.05,0,0,0)
    ZagVal.TextColor3 = Color3.new(1,1,1)
    ZagVal.BackgroundTransparency = 1
    ZagVal.TextScaled = true
    local TxtVal = Instance.new("TextLabel",Main)
    TxtVal.Size = UDim2.new(0.9,0,0.75,-10)
    TxtVal.Position = UDim2.new(0.05,0,0.25,5)
    TxtVal.TextColor3 = Color3.new(1,1,1)
    TxtVal.BackgroundTransparency = 1
    TxtVal.TextScaled = true
    local timer = Instance.new("Frame",Main) 
    timer.BackgroundColor3 = Colors.Print.Timer
    timer.Position = UDim2.new(0.05,0,0.25,0)
    timer.Size = UDim2.new(0,0,0,5) 
    Instance.new("UICorner",timer).CornerRadius = UDim.new(1,0)
    if _G.TimGui.Values.RusLang then
        ZagVal.Text = ZagRus
        TxtVal.Text = TxtRus
    else
        ZagVal.Text = Zag
        TxtVal.Text = Txt
    end
    Frame.Position = UDim2.new(0,-size,0,0)
    local vall = Instance.new("BoolValue")
    vall.Changed:Connect(function()
    local goal = {}
    goal.Position = UDim2.new(0,0,0,0) 
    game.TweenService:Create(Frame,TweenInfo.new(0.5),goal):Play() 
    wait(0.5)
    local goal = {}
    goal.Size = UDim2.new(0.9,0,0,5) 
    game.TweenService:Create(timer,TweenInfo.new(0.5),goal):Play() 
    wait(0.5) 
    goal = {}
    goal.Size = UDim2.new(0,0,0,5) 
    game.TweenService:Create(timer,TweenInfo.new(PrintTime),goal):Play() 
    wait(PrintTime) 
    goal = {}
    goal.Position = UDim2.new(0,-size,0,0) 
    game.TweenService:Create(Frame,TweenInfo.new(0.5),goal):Play() 
    wait(0.5) 
    Frame:Destroy()
    end)
    vall.Value = true
end

Settings.Create(1,"Example","Example notification","Пример уведомления",function()
	_G.TimGui.Print("Example","Hello World v2.0","Пример","Привт 2.0")
end)

Settings.Create(0,"Other","Other","Другое")
local PlayersToSpare = _G.TimGui.Values.PlayersWithSpare
local SpareButtons = _G.TimGui.Values.SpareButtons
local SpareTable = _G.TimGui.Values.Spare
local Spare = _G.TimGui.Groups.CreateNewGroup("Mercy")
local MAll = Spare.Create(2,"MA","Mercy all","Щадить всех")
local MS = Spare.Create(2,"FS","Mercy friends","Щадить друзей")
if _G.TimGui.Saves.Enabled then
	local loadedTab = _G.TimGui.Saves.Load("Mercy")
	if loadedTab ~= nil then
		loadedTab = HttpService:JSONDecode(loadedTab)
		_G.TimGui.Values.Spare = loadedTab
		SpareTable = loadedTab
	end
	Spare.Create(1,"SF","Save to file","Сохранить пощаду",function()
		_G.TimGui.Saves.Save("Mercy",HttpService:JSONEncode(SpareTable))
	end)
end
Spare.Visible = false
MS.Main.Value = true
Settings.Create(1,"Mercy","Mercy","Пощада",function()
    Spare.OpenGroup()
end)

local function PlAdd(Player)
	local Name = Player.Name
	SpareButtons[Name] = Spare.Create(2,Name,Name,Name,function(val)
		SpareTable[Name] = val.Value
		if val.Value then
			PlayersToSpare[Name] = Player
		else
			PlayersToSpare[Name] = nil
		end
	end)
	if SpareTable[Name] ~= nil then
		SpareButtons[Name].Main.Value = SpareTable[Name]
	elseif MS.Value then
		if LocalPlayer:IsFriendsWith(Player.UserId) then
			SpareButtons[Name].Main.Value = true
		end
	else
		SpareTable[Name] = false
		SpareButtons[Name].Main.Value = MAll.Value
	end
end

Spare.Create(0,"PT","Players","Игроки")
for k,v in pairs(game.Players:GetPlayers()) do
	if v ~= LocalPlayer then
		PlAdd(v)
	end
end
game.Players.PlayerAdded:Connect(PlAdd)
game.Players.PlayerRemoving:Connect(function(pl)
	if SpareButtons[pl.Name] then
		SpareButtons[pl.Name].Destroy()
	else
		print("MercyButton for "..pl.Name.." not found")
	end
end)

local Optimize = _G.TimGui.Groups.CreateNewGroup("Optimize")
Optimize.Visible = false
local OptimizeClose = Optimize.Create(2,"OptimizeOnClosed","Optimize on timgui if closed","Оптимизация timgui, если он закрыт",function(val)
    OptimizeTable.OnClose = val.Value
end)
Optimize.Create(2,"OptimizeTimer","Optimize timer","Оптимизация таймером",function(val)
    OptimizeTable.Timer = val.Value
end).Main.Value = true
Optimize.Create(2,"OptimizeTwoTimer","Optimize 2 timer","Оптимизация 2 таймером",function(val)
    OptimizeTable.TwoTimer = val.Value
end)
Optimize.Create(2,"AnimTB","Animate toggle button","Анимировать изменяемые кнопки",function(val)
    OptimizeTable.AnimationTB = val.Value
end).Main.Value = true
Settings.Create(1,"Optimize","Optimize","Оптимизация",function()
    Optimize.OpenGroup()
end)

local loading = {true,true,true,true}
local FoundScript = true
local AprilFUN = false
if _G.Setup ~= nil then
	local loader = _G.Setup.Load
	if loader ~= nil then
		loading[1] = loader.All
		loading[2] = loader.Themes
		loading[3] = loader.Game
		loading[4] = loader.Configs
	end
end
if loading[1] ~= false then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/Standart.lua"))()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/TimExplorer/MapLoader.lua"))()
end if loading[2] ~= false then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/Themes.lua"))()
end if loading[3] ~= false then
	pcall(function()
		local gameScr = game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Games/".. game.GameId ..".lua")
		print("TimGui|"..game.GameId)
		if string.sub(gameScr,1,3)=="404" then
			print("TimGui|Game script not found")
			FoundScript = false
		else
			task.spawn(function()
				local success, response = pcall(function()
					loadstring(gameScr)()
				end)
				if not success then
					error("TimGui|Error load game script:\n" .. response)
				end
			end)
		end
	end)
end if loading[4] ~= false then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/Configs.lua"))()
end if os.date("%m",os.time()) == "04" then
    if tonumber(os.date("%d",os.time())) < 4 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/Fun/April.lua"))()
	AprilFUN = true
    end
end
OptimizeClose.Main.Value = true
_G.Setup = nil
print("TimGui|Loaded!")
if AprilFUN then
	_G.TimGui.Print("Loaded","Happy 1 april","Загружено","С 1 апреля")
elseif FoundScript then
	_G.TimGui.Print("Loaded","TimGui is loaded!","Загружено","TimGui загружен!")
else
	_G.TimGui.Print("Loaded","TimGui is loaded!Game script not found.","Загружено","TimGui загружен!Игры не найдена.")
end
