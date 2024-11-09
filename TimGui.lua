--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]

_G.TimGui = {}
_G.TimGui.Groups = {}
_G.TimGui.Values = {}
_G.TimGui.Path = {}

--_G.TimGui.Values.x2 = false
_G.TimGui.Values.Spare = {}
_G.TimGui.Values.Opened = false
_G.TimGui.Values.SpareButtons = {}
_G.TimGui.Values.GroupOpened = nil

_G.TimGui.Values.RusLang = false

local LocalPlayer = game.Players.LocalPlayer
local XTG = UDim.new(1, -400)
local ButtonColor = Color3.fromRGB(50,50,100)
local Count = 0
local updTime = 0.25
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui",game.CoreGui)
local f = Instance.new("Frame",gui) 
local Open = Instance.new("ImageLabel",f)
local AO = Instance.new("ImageButton",f)
local Groups = Instance.new("ScrollingFrame",f) 
local Objects = Instance.new("ScrollingFrame",f) 

f.Position = UDim2.new(XTG,UDim.new(1,-25)) 
f.Size = UDim2.new(0, 400, 1, 0) 
f.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 

Open.Size = UDim2.new(0, 400, 0, 25)
Open.Image = "rbxassetid://16341271803"
 
AO.BackgroundTransparency = 100
AO.Size = UDim2.new(0, 25, 0, 25)
AO.Image = "rbxassetid://16341277046"

Groups.Parent = f
Groups.ScrollBarThickness = 5
Groups.BackgroundColor3 = Color3.new(0.15, 0.15, 0.25) 
Groups.Size = UDim2.new(0.25, 0, 1, -25) 
Groups.Position = UDim2.new(0, 0, 0, 25) 
Groups.ScrollingDirection = 2

Objects.Parent = f
Objects.ScrollBarThickness = 5
Objects.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
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
local function NewButton(Button)
	if SelectKeybind.YN ~= nil then return end
	SelectKeybind.Key = ""
	SelectKeybind.GB = Button.Parent.Name .. "." .. Button.Object.Name
	SelectKeybind.YN = _G.TimGui.askYN("Select a key","Key is not selected","Выбери клавишу","Клавиша не выбрана",function()
		for b,v in pairs(Keybinds) do
			for k,v in pairs(v) do 
				if k == SelectKeybind.GB then
					Keybinds[b][k] = nil
					Button.Object.Keybind.Text = ""
				end
			end
		end
		if SelectKeybind.Key ~= "" then
			Button.Object.Keybind.Text = SelectKeybind.Key
			if Button.Type == 1 then
				Keybinds[SelectKeybind.Key][SelectKeybind.GB] = Button.EmulateClick
			elseif Button.Type == 2 then
				Keybinds[SelectKeybind.Key][SelectKeybind.GB] = Button.ChangeValue
			end
		end
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
				adding = v.ShortName .. " + "
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
				if Keybinds[button] == nil then
					Keybinds[button] = {}
				end
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
local onDisconnect
_G.TimGui.ObjectPosition = {}
_G.TimGui.ObjectPosition.Disconnect = function()
	SetPosForObjectCustom = nil
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			Update(v)
		end
	end
	XTG = UDim.new(1, -400)
	if type(onDisconnect) == "function" then
		onDisconnect()
	end
end
_G.TimGui.ObjectPosition.Connect = function(xpos,onDis,con)
	_G.TimGui.ObjectPosition.Disconnect()
	SetPosForObjectCustom = con
	onDisconnect = onDis
	for k,v in pairs(_G.TimGui.Groups) do
		if type(v) == "table" then
			Update(v)
		end
	end
end

local function SetPosForObject(k,v)
	if SetPosForObjectCustom ~= nil then
		SetPosForObjectCustom(k,v)
		return
	end
	v.Object.Size = UDim2.new(1, 0, 0, 50)
	v.Object.Position = UDim2.new(0, 0, 0, 50 * k)
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
			v.ButtonInList.Position = UDim2.new(0,0,0,50 * (k -1))
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
	Button.BackgroundColor3 = ButtonColor
	Button.Size = UDim2.new(1, -5, 0, 50)
	Button.Position = UDim2.new(0, 0, 0, 50 * yy)
	Button.TextColor3 = Color3.new(1, 1, 1) 
	Button.TextScaled = true
	Instance.new("UICorner",Button).CornerRadius = UDim.new(1,0)
	Button.Activated:Connect(group.OpenGroup)
	Pos.Value = yy 
	Groups.CanvasSize = UDim2.new(0, 0, 0, 50 * yy)
	group.ButtonInList = Button
	group.Pos = yy
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
		Object.BackgroundColor3 = ButtonColor
		if typ <= 2 then
			Object.Text = text
			if _G.TimGui.Values.RusLang then
				Object.Text = rus
			end
			if typ == 2 then
				Object.TextColor3 = Color3.new(1, 0.25, 0.25)
			else
				Object.TextColor3 = Color3.new(1, 1, 1) 
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
						Object.BackgroundColor3 = ButtonColor
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
			Value.Changed:Connect(function()
				Obj.Value = Value.Value
				local goal = {}
				if Value.Value then
					goal.TextColor3 = Color3.new(0.25, 1, 0.25) 
				else
					goal.TextColor3 = Color3.new(1, 0.25, 0.25) 
				end
				game:GetService("TweenService"):Create(Object, TweenInfo.new(0.5), goal):Play() 
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
				Value.BackgroundColor3 = Color3.fromRGB(38, 38, 76)
				Value.Size = UDim2.new(0.4,0,1,0)
				Value.Text = text
				Value.TextScaled = true
				Value.TextColor3 = Color3.new(1,1,1)
				Value.Position = UDim2.new(0.5,0,0,0)
				Value.Text = ""
				Obj.Main = Value
				Value.InputEnded:Connect(function()
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
			while task.wait(updTime) and Obj ~= nil do
				if _G.TimGui.Values.Opened then
					if typ <= 2 then
						if not _G.TimGui.Values.RusLang then
							if Obj.Text ~= oldParams.Text then
								Obj.Object.Text = Obj.Text
							end
						else
							if Obj.RusText ~= oldParams.RusText then
								Obj.Object.Text = Obj.RusText
							end
						end
					end if Obj.Object ~= oldParams.Object then
						Obj.Object = oldParams.Object
					end if Obj.Pos ~= oldParams.Pos then
						Obj.Pos = oldParams.Pos
						Update(group)
					end if Obj.Visible ~= oldParams.Visible then
						Obj.Object.Visible = Obj.Visible
						Update(group)
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
		while task.wait(updTime) and group ~= nil do
			if _G.TimGui.Values.Opened then
				if _G.TimGui.Values.RusLang then
					if group.Name ~= oldGroup.Name then
						group.Name = oldGroup.Name
					end
				else
					if group.RusName ~= oldGroup.RusName then
						group.RusName = oldGroup.RusName
					end
				end if group.Open ~= oldGroup.Open then
					group.Open = oldGroup.Open
				end if group.Create ~= oldGroup.Create then
					group.Create = oldGroup.Create
				end if group.ButtonInList ~= oldGroup.ButtonInList then
					group.ButtonInList = oldGroup.ButtonInList
				end if group.RusName ~= oldGroup.RusName then
					group.RusName = oldGroup.RusName
				end if group.Pos ~= oldGroup.Pos then
					group.Pos = oldGroup.Pos
				end if group.Visible ~= oldGroup.Visible then
					group.ButtonInList.Visible = group.Visible
					Update()
				end
				oldGroup = table.clone(group)
			end
		end
	end)
	whil.Value = true
	Update()
	return group
end

_G.TimGui.Path.gui = gui
_G.TimGui.Path.Main = f
_G.TimGui.Path.Groups = Groups
_G.TimGui.Path.Buttons = Objects

local Settings = _G.TimGui.Groups.CreateNewGroup("Settings","Настройки")
local RusLang = Settings.Create(2,"RusLang","Русский язык","English language",function(Value)
	_G.TimGui.Values.RusLang = Value.Value
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
local tmp = game.LocalizationService.SystemLocaleId == "ru-ru" or game.LocalizationService.RobloxLocaleId == "ru-ru"
if os.date("%H",0) or tmp then
	RusLang.Main.Value = true
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
local stroke = 5
local size = 250
_G.TimGui.Print = function(Zag,Txt,ZagRus,TxtRus)
    if not PrintEnable.Value then return end
    local Frame = Instance.new("Frame",gui)
    Frame.Size = UDim2.new(0,size,0,size/1.5)
    Frame.BackgroundColor3 = Color3.fromRGB(100,100,200)
    Frame.Name = "Print"
    local Main = Instance.new("Frame",Frame)
    Main.Size = UDim2.new(1,-stroke*2,1,-stroke*2)
    Main.Position = UDim2.new(0,stroke,0,stroke)
    Main.BackgroundColor3 = Color3.fromRGB(38,38,76)
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
    timer.BackgroundColor3 = Color3.fromRGB(60,60,110)
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

local SpareButtons = _G.TimGui.Values.SpareButtons
local SpareTable = _G.TimGui.Values.Spare
local Spare = _G.TimGui.Groups.CreateNewGroup("Spare")
local FS = Spare.Create(2,"FS","Spare friends","Щадить друзей")
Spare.Visible = false
FS.Main.Value = true
_G.TimGui.Groups.Settings.Create(1,"Spare","Spare","Пощада",function()
    Spare.OpenGroup()
end)

local function PlAdd(Player)
	local Name = Player.Name
	SpareTable[Name] = false
	SpareButtons[Name] = Spare.Create(2,Name,Name,Name,function(val)
		SpareTable[Name] = val.Value
	end)
	if FS.Value then
		if LocalPlayer:IsFriendsWith(Player.UserId) then
			SpareButtons[Name].Main.Value = true
		end
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
		print("SpareButton for "..pl.Name.." not found")
	end
end)

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/Standart.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/other.lua"))()
local gameScr = game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Games/".. game.GameId ..".lua")
print(game.GameId)
_G.TimGui.Print("Loaded","TimGui is loaded!","Загружено","TimGui загружен!")
local success, response = pcall(function()
	loadstring(gameScr)()
end)
if not success then
	warn("Error load game script:\n" .. response)
end
