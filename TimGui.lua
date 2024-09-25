--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]
if game.CoreGui:FindFirstChild("TimEXPLORER") then
    game.CoreGui.TimEXPLORER:Destroy()
end

local atpp
local autotp
local FoldersT = {}
local BFuncs = {}
local TOCB = {}
_G.TimGui = {}
_G.TimGui.Opened = false
_G.TimGui.Add = {}
_G.TimGui.TimControlSet = function(GN, mode, data)
if mode == "CB" then
if data == nil then
TOCB[GN].Value = not TOCB[GN].Value
else
TOCB[GN].Value = data
end
elseif mode == "TB" then
TOCB[GN].Text = data
elseif mode == "B" then
local temp = BFuncs[GN]
pcall(temp)
end
end

_G.TimGui.Set = function(name, group, data)
local ButTab = FoldersT[group]
if ButTab[name].ClassName == "BoolValue" then
if data == nil then
ButTab[name].Value = not ButTab[name].Value
else
ButTab[name].Value = data
end
elseif ButTab[name].ClassName == "TextBox" then
ButTab[name].Text = data
else
local temp = BFuncs[group .. "." .. name]
temp()
end
end

_G.TimGui.Get = function(name, group)
local ButTab = FoldersT[group]
return ButTab[name]
end
local FA = "TP to player"
local TweenService = game:GetService("TweenService")
local gui = Instance.new("ScreenGui") 
gui.Name = "TimGUI"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false
_G.TimGui.Path = {}
local f = Instance.new("Frame") 
f.Position = UDim2.new(1, -400, 1,-25) 
f.Size = UDim2.new(0, 400, 1, 0) 
f.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
f.Parent = gui
_G.TimGui.Path.Main = f
local Open = Instance.new("ImageLabel") 
Open.Size = UDim2.new(0, 400, 0, 25)
Open.Position = UDim2.new(1, -400, 0, 0) 
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
_G.TimGui.Path.Groups = Folders
Folders.ScrollingDirection = 2

local Func = Instance.new("ScrollingFrame") 
Func.Parent = f
Func.ScrollBarThickness = 5
Func.BackgroundColor3 = Color3.new(0.15, 0.15, 0.3) 
Func.Size = UDim2.new(1, -100, 1, -25) 
Func.Position = UDim2.new(0, 100, 0, 25) 
_G.TimGui.Path.Buttons = Func
Func.ScrollingDirection = 2

local stroke = 5
local size = 250
local timeVis = 2.5
local NotEnable = true

_G.TimGui.Print = function(Zag,Txt,ZagRus,TxtRus)
    if not NotEnable then return end
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
    if _G.TimGui.ru then
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
    game.TweenService:Create(timer,TweenInfo.new(timeVis),goal):Play() 
    wait(timeVis) 
    goal = {}
    goal.Position = UDim2.new(0,-size,0,0) 
    game.TweenService:Create(Frame,TweenInfo.new(0.5),goal):Play() 
    wait(0.5) 
    Frame:Destroy()
    end)
    vall.Value = true
end

_G.TimGui.askYN = function(name, rusname, text, rustxt, onyes)
local Menu = Instance.new("ImageLabel") 
Menu.Name = "askYN"
Menu.Size = UDim2.new(0, 425, 0, 300)
Menu.Position = UDim2.new(0.5, -212.5, -2, 0) 
Menu.BackgroundTransparency = 100
if _G.TimGui.ru then
Menu.Image = "rbxassetid://17041335616"
else
Menu.Image = "rbxassetid://17041343700"
end
Menu.Parent = _G.TimGui.Path.Main.Parent

local Tempp = Instance.new("StringValue") 
Tempp.Name = "name"
Tempp.Value = text
Tempp.Parent = Menu

local nm = Instance.new("TextLabel") 
nm.Parent = Menu
nm.BackgroundTransparency = 1
nm.Name = "Nametxt"
nm.Text = name
if _G.TimGui.ru then nm.Text = rusname end
nm.Size = UDim2.new(0, 300, 0, 50) 
nm.TextScaled = true
nm.Position = UDim2.new(0, 57, 0, 0) 
nm.TextColor3 = Color3.new(1, 1, 1) 

local textt = Instance.new("TextLabel") 
textt.Parent = Menu
textt.BackgroundTransparency = 1
textt.Name = "text"
textt.Text = text
if _G.TimGui.ru then textt.Text = rustxt end
textt.TextScaled = true
textt.Size = UDim2.new(0, 350, 0, 100) 
textt.Position = UDim2.new(0, 3, 0, 70) 
textt.TextColor3 = Color3.new(1, 1, 1) 

local No = Instance.new("TextButton") 
No.Parent = Menu
No.BackgroundTransparency = 1
No.Name = "N"
No.Text = ""
No.Size = UDim2.new(0, 115, 0, 85) 
No.Position = UDim2.new(0, 70, 0, 185) 

local Yes = Instance.new("TextButton") 
Yes.Parent = Menu
Yes.BackgroundTransparency = 1
Yes.Name = "Y"
Yes.Text = ""
Yes.Size = UDim2.new(0, 115, 0, 85) 
Yes.Position = UDim2.new(0, 190, 0, 185)

No.Activated:Connect(function()
local goal = {}
goal.Position = UDim2.new(0.5, -212.5, 2, 0) 
game:GetService("TweenService"):Create(Menu, TweenInfo.new(1), goal):Play() 
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
end

local OC = false
AO.Activated:Connect(function() 
OC = not OC
_G.TimGui.Opened = OC
if OC then
local goal = {}
goal.Position = UDim2.new(1, -400, 0, 0) 
if _G.TimGui.TEOpen then
goal.Position = UDim2.new(0.8, -400, 0, 0)
end
if _G.TimGui.XTwo then
goal.Position = UDim2.new(1, -700, 0, 0) 
if _G.TimGui.TEOpen then
goal.Position = UDim2.new(0.8, -700, 0, 0)
end
end
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 180
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
else
local goal = {}
goal.Position = UDim2.new(1, -400, 1, -25) 
if _G.TimGui.TEOpen then
goal.Position = UDim2.new(0.8, -400, 1, -25)
end
if _G.TimGui.XTwo then
goal.Position = UDim2.new(1, -700, 1, -25) 
if _G.TimGui.TEOpen then
goal.Position = UDim2.new(0.8, -700, 1, -25)
end
end
local tween = TweenService:Create(f, TweenInfo.new(0.5), goal)
tween:Play() 
local goal = {}
goal.Rotation = 0
local tween = TweenService:Create(AO, TweenInfo.new(0.5), goal)
tween:Play() 
end
end) 

---------- Keybinds
local keybinding = nil
local keybinds = {}
local lastKeyB = nil

local function keybind(newMode, button, buttonName,focus)
    if newMode and keybinding == nil then
        lastKeyB = nil
        if button:FindFirstChildOfClass("BoolValue") then
            keybinding = "CB." .. buttonName
        else 
            keybinding = "B." .. buttonName
        end
        _G.TimGui.askYN("Select a key", "Выбири клавишу", "Key is not selected","Клавиша не выбрана", function()
		    for keey,v in pairs(keybinds) do
                if v == keybinding then 
                    keybinds[keey] = nil
			        button.Keybind.Text = ""
                end
                if keey == lastKeyB then
		    	    keybinds[keey] = nil
			        for k,v in pairs(Func:GetChildren()) do
                        if not v:FindFirstChild("Keybind") then continue end
			            if v.Keybind.Text == keey then
			                v.Keybind.Text = ""
                            break
                        end
			        end
			    end
		    end
            if not (lastKeyB == nil) then
                keybinds[lastKeyB] = keybinding
		        button.Keybind.Text = lastKeyB
            end
            keybinding = nil
        end)
        _G.TimGui.Path.Main.Parent.askYN.AncestryChanged:Connect(function(child, parent)
            keybinding = nil
        end)
    elseif not newMode then
        if keybinding and gui:FindFirstChild("askYN") then 
            lastKeyB = button
            gui.askYN.text.Text = "Key:" .. button
	    if focus then 
                gui.askYN.text.Text = "Key:" .. button .. ". This may interfere with the game"
            end
            if _G.TimGui.ru then
                gui.askYN.text.Text = "Клавиша:" .. button
		if focus then 
                    gui.askYN.text.Text = "Клавиша:" .. button .. ".Эта кнопка может помешать игре"
                end
            end
	    elseif keybinds[button] then
            local but = keybinds[button]
            if string.sub(but, 1, 2) == "B." then
		        local name = string.sub(but, 3, string.len(but)+1)
                _G.TimGui.TimControlSet(name, "B")
            else
                 local name = string.sub(but, 4, string.len(but)+1)
                _G.TimGui.TimControlSet(name, "CB")
            end
        end
    end
end

local addForKeybind = {}
addForKeybind.LeftControl = {}
addForKeybind.RightShift = {}
addForKeybind.LeftShift = {}
addForKeybind.RightControl = {}
addForKeybind.LeftControl.Name = "LCtrl"
addForKeybind.RightControl.Name = "RCtrl"
addForKeybind.LeftShift.Name = "LShift"
addForKeybind.RightShift.Name = "RShift"
addForKeybind.LeftControl.Value = false
addForKeybind.RightControl.Value = false
addForKeybind.LeftShift.Value = false
addForKeybind.RightShift.Value = false

game:GetService("UserInputService").InputBegan:Connect(function(input,Focus)
    local button = input.KeyCode
    if not (button.Name == "Unknown") then 
        if addForKeybind[button.Name] then
            addForKeybind[button.Name].Value = true
	    elseif not game.UserInputService:GetFocusedTextBox() then
            local temp = button.Name
            for k,v in pairs(addForKeybind) do
                if v.Value then
                    temp =  v.Name.." + "..temp
                end
            end
            keybind(false, temp,nil,Focus)
	  end
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    local button = input.KeyCode
    if addForKeybind[button.Name] then
        addForKeybind[button.Name].Value = false
    end
end)
---------- Phone Keybinds

local function phoneButton(but,name)
if gui:FindFirstChild(name) then
gui:FindFirstChild(name):Destroy()
_G.TimGui.Print("Flying buttons","Deleted","Летающие кнопки","Удаленно")
return
end
local Button = Instance.new("TextButton",gui)
local Res = but.Parent
Button.TextScaled = true
Button.BackgroundColor3 = Color3.new(0,0,0.1)
if Res:FindFirstChild("Value") then
local function updVal()
if Res.Value.Value then
Button.TextColor3 = Color3.new(0,1,0)
else
Button.TextColor3 = Color3.new(1,0,0)
end
end
Res.Value.Changed:Connect(updVal)
updVal()
else
Button.TextColor3 = Color3.new(1,1,1)
end -- CB end
Instance.new("UICorner",Button).CornerRadius = UDim.new(0.25,0)
Button.Size = UDim2.new(0,50,0,50)
Button.Position = UDim2.new(0.5,-25,0.1,0)
Button.Name = name
local MovedChecker = true
local Clicked = false
Button.MouseButton1Down:Connect(function()
MovedChecker = true
Clicked = true
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Move:Connect(function()
if Clicked then
local offset = game.Workspace.Camera.ViewportSize - gui.AbsoluteSize
local delta = Button.Position - UDim2.new(0,mouse.X-25 -offset.X,0,mouse.Y+25 -offset.Y)
delta = math.floor((delta.X.Offset + delta.Y.Offset) / 7.5)
print(delta)
if math.abs(delta) > 1 or not MovedChecker then
MovedChecker = false
Button.Position = UDim2.new(0,mouse.X-25 -offset.X,0,mouse.Y+25 -offset.Y)
end
end
end)
Button.MouseButton1Up:Connect(function()
Clicked = false
if MovedChecker then
if Res:FindFirstChild("Value") then
_G.TimGui.TimControlSet(name, "CB")
else
_G.TimGui.TimControlSet(name, "B")
end
end
end)
but:GetPropertyChangedSignal("Text"):Connect(function()
Button.Text = but.Text
end)
Button.Text = but.Text
end)
_G.TimGui.Print("Flying buttons","Created","Летающие кнопки","Созданно")
end

---------- Buttons

_G.TimGui.Add.CB = function(name, text, group, yy, rus, funct) 
if rus == nil then rus = text end
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("Frame") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Size = UDim2.new(0, 300, 0, 50)
local Tempp = Instance.new("StringValue",Temp) 
Tempp.Name = "group"
Tempp.Value = group
local Tempp = Instance.new("NumberValue",Temp) 
Tempp.Name = "pos"
Tempp.Value = yy
local ButTabb = Instance.new("TextButton",Temp) 
ButTabb.Name = "Text"
ButTabb.Text = text
ButTabb.Size = UDim2.new(1, 0, 1, 0) 
ButTabb.TextScaled = true
ButTabb.TextColor3 = Color3.new(1, 0.25, 0.25) 
ButTabb.BackgroundColor3 = Color3.fromRGB(50,50,100)
Instance.new("UICorner",ButTabb).CornerRadius = UDim.new(1,0)
local MegaTemp = Instance.new("TextLabel",Temp) 
MegaTemp.Parent = Temp
MegaTemp.BackgroundTransparency = 100
MegaTemp.Name = "Keybind"
MegaTemp.Text = ""
MegaTemp.Size = UDim2.new(1, 0, 0.5, 0) 
MegaTemp.TextScaled = true
MegaTemp.TextColor3 = Color3.new(0.75, 0.75, 1) 
MegaTemp.TextXAlignment = Enum.TextXAlignment.Left
local TmpTwo = Instance.new("StringValue",ButTabb)
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("BoolValue",Temp) 
FoldersT[group] = ButTab
ButTabb.MouseButton2Click:Connect(function() 
keybind(true, Temp, group .. "." .. name)
end) 
local hold = 0
local Flying = true
ButTabb.MouseButton1Down:Connect(function() 
hold += 1
local tmp = hold
wait(1.5)
if hold == tmp then
local UserInputService = game:GetService("UserInputService")
if not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then return true end
Flying = false
phoneButton(ButTabb,group .. "." .. name)
end
end) 
ButTabb.MouseButton1Up:Connect(function() 
print(Flying)
hold += 1
if Flying then
ButTab[name].Value = not ButTab[name].Value
else
Flying = true
end
end) 
ButTab[name].Changed:Connect(function() 		
local goal = {}
if ButTab[name].Value then
goal.TextColor3 = Color3.new(0.25, 1, 0.25) 
else
goal.TextColor3 = Color3.new(1, 0.25, 0.25) 
end
game:GetService("TweenService"):Create(ButTabb, TweenInfo.new(0.5), goal):Play() 

if not (funct == nil) then
funct(ButTab[name])
end
end)
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
TOCB[group .. "." .. name] = ButTab[name]
return ButTab[name]
end

_G.TimGui.Add.B = function(name, text, group, yy, rus, funct)
if rus == nil then rus = text end
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("Frame") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Size = UDim2.new(0, 300, 0, 50)
local Tempp = Instance.new("StringValue",Temp) 
Tempp.Name = "group"
Tempp.Value = group
local Tempp = Instance.new("NumberValue",Temp) 
Tempp.Name = "pos"
Tempp.Value = yy
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextButton",Temp) 
ButTab[name].Name = "Text"
ButTab[name].Text = text
ButTab[name].BackgroundColor3 = Color3.fromRGB(50,50,100)
Instance.new("UICorner",ButTab[name]).CornerRadius = UDim.new(1,0)
local MegaTemp = Instance.new("TextLabel",Temp) 
MegaTemp.BackgroundTransparency = 100
MegaTemp.Name = "Keybind"
MegaTemp.Text = ""
MegaTemp.Size = UDim2.new(1, 0, 0.5, 0) 
MegaTemp.TextScaled = true
MegaTemp.TextColor3 = Color3.new(0.75, 0.75, 1) 
MegaTemp.TextXAlignment = Enum.TextXAlignment.Left
local TmpTwo = Instance.new("StringValue",ButTab[name])
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
ButTab[name].Size = UDim2.new(1, 0, 1, 0) 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
ButTab[name].MouseButton2Click:Connect(function() 
keybind(true, Temp, group .. "." .. name) 
end) 
local hold = 0
local Flying = true
ButTab[name].MouseButton1Down:Connect(function() 
hold += 1
local tmp = hold
wait(1.5)
if hold == tmp then
local UserInputService = game:GetService("UserInputService")
if not UserInputService.TouchEnabled and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then return true end
Flying = false
phoneButton(ButTab[name],group .. "." .. name)
end
end) 
ButTab[name].MouseButton1Up:Connect(function() 
hold += 1
if Flying then
ButTab[name].Value = not ButTab[name].Value
else
Flying = true
end
end) 
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
if not (funct == nil) then
BFuncs[group .. "." .. name] = function() 
funct(ButTab[name])
end
end
return ButTab[name]
end

_G.TimGui.config = {}
_G.TimGui.Add.TB = function(name, text, group, yy, rus) 
if rus == nil then rus = text end
if _G.TimGui.ru then
local tmpp = text
text = rus
rus = tmpp
if text == nil then
text = rus
end
end
local Temp = Instance.new("Frame") 
if not (group == FA) then
Temp.Visible = false
end
Temp.Parent = Func
Temp.Name = name
Temp.BackgroundColor3 = Color3.fromRGB(50,50,100)
Instance.new("UICorner",Temp).CornerRadius = UDim.new(1,0)
Temp.Size = UDim2.new(0, 300, 0, 50)
local ButTab = FoldersT[group]
local But = Instance.new("TextLabel",Temp) 
But.BackgroundTransparency = 100
But.Text = text
But.Name = "Text"
But.Size = UDim2.new(0.5, 0, 1, 0) 
But.TextScaled = true
But.TextColor3 = Color3.new(1, 1, 1) 
local TmpTwo = Instance.new("StringValue",But)
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = text
end
local Tempp = Instance.new("StringValue",Temp) 
Tempp.Name = "group"
Tempp.Value = group
local Tempp = Instance.new("NumberValue",Temp) 
Tempp.Name = "pos"
Tempp.Value = yy
local ButTab = FoldersT[group]
ButTab[name] = Instance.new("TextBox",Temp) 
ButTab[name].BackgroundColor3 = Color3.fromRGB(38, 38, 76) 
ButTab[name].BackgroundTransparency = 0.4
ButTab[name].Size = UDim2.new(0.4, 0, 1, 0) 
ButTab[name].Position = UDim2.new(0.5, 0, 0, 0)
ButTab[name].Text = ""
if not (_G.TimGui.config[group .. "." .. name] == nil) then ButTab[name].Text = _G.TimGui.config[group .. "." .. name] end 
ButTab[name].ClearTextOnFocus = false 
ButTab[name].TextScaled = true
ButTab[name].TextColor3 = Color3.new(1, 1, 1) 
TOCB[group .. "." .. name] = ButTab[name]
FoldersT[group] = ButTab
local ftpmc = FoldersT[FA]
if FA == group then
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * #ftpmc) 
end
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
if _G.TimGui.XTwo then
local poss = math.ceil(yy / 2) 
if poss == yy / 2 then
Temp.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
Temp.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
end
return ButTab[name]
end

_G.TimGui.SetGroup = function(name)
for k,v in pairs(FoldersT[FA]) do
if v.Parent then
v.Parent.Visible = false
end
end
FA = name
for k,v in pairs(FoldersT[FA]) do
if v.Parent then
v.Parent.Visible = true
if FA == "TP to player" and not (v.ClassName == "BoolValue") then
v.Parent:Destroy() 
end
end
end
if FA == "TP to player" then
local fix = 0
for k, v in pairs(game.Players:GetChildren()) do 
if not (v == game.Players.LocalPlayer) then
_G.TimGui.Add.B(k, v.Name, FA, k + fix + 1, v.Name, function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
atpp = v
autotp.Parent.Text.Text = "Auto spam tp to " .. v.Name
autotp.Parent.Text.Value.Value = "Авто спам тп к " .. v.Name
if _G.TimGui.ru then 
autotp.Parent.Text.Text = "Авто спам тп к " .. v.Name
autotp.Parent.Text.Value.Value = "Auto spam tp to " .. v.Name
end
end) 
else
fix = -1
end
end
end
yy = 0
for k,v in pairs(Func:GetChildren()) do
if v.Visible then
yy += 1
end
end
Func.CanvasSize = UDim2.new(0, 0, 0, 50 * yy)
end

_G.TimGui.Add.G = function(name, rus) 
local Temp = Instance.new("Frame") 
Temp.Parent = Folders
Temp.Name = name
Temp.BackgroundTransparency = 100
Temp.Size = UDim2.new(1, -5, 0, 50)
FoldersT[name] = {}
local yy = Folders:GetChildren() 
yy = #yy
Temp.Position = UDim2.new(0, 0, 0, 50 * (yy - 1)) 
if _G.TimGui.HMGF then
local yyy = _G.TimGui.Path.HidedGroups:GetChildren()
yy = yy + #yyy
if _G.TimGui.HMGF[name] then 
Temp.Parent = _G.TimGui.Path.HidedGroups
end
end
local Tempp = Instance.new("NumberValue",Temp) 
Tempp.Name = "pos"
Tempp.Value = yy
local Tmp = Instance.new("TextButton",Temp) 
Tmp.Text = name
Tmp.Name = "Text"
Tmp.BackgroundColor3 = Color3.fromRGB(50,50,100)
Instance.new("UICorner",Tmp).CornerRadius = UDim.new(1,0)
local TmpTwo = Instance.new("StringValue",Tmp)
if not (rus == nil) then
TmpTwo.Value = rus
else
TmpTwo.Value = name
end
if _G.TimGui.ru then
Tmp.Text = TmpTwo.Value
TmpTwo.Value = name
end
Tmp.Size = UDim2.new(1, 0, 1, 0) 
Tmp.TextScaled = true
Tmp.TextColor3 = Color3.new(1, 1, 1) 
Tmp.Activated:Connect(function() 
_G.TimGui.SetGroup(name)
end) 
Folders.CanvasSize = UDim2.new(0, 0, 0, 50 * yy) 
end
_G.TimGui.Add.G("Settings","Настройки") 
local changeTimeVis = _G.TimGui.Add.TB("changeTimeVis","time of notification:","Settings",11,"Время уведомления")
changeTimeVis.Changed:Connect(function()
timeVis = tonumber(changeTimeVis.Text)
if timeVis == nil then
timeVis = 0.5
end
if timeVis < 0.5 then
timeVis = 0.5
end
if timeVis > 30 then
timeVis = 30
end
end)
changeTimeVis.Text = timeVis

_G.TimGui.Add.CB("NotEnable","Enable notification","Settings",12,"Включить уведомления",function(val)
NotEnable = val.Value
end).Value = true

_G.TimGui.Add.B("Example notification","Example notification","Settings",13,"Пример уведомления",function()
_G.TimGui.Print("Example","Hello world!","Пример","Прив")
end)

_G.TimGui.Add.G(FA,"ТП к игрокам")
autotp = _G.TimGui.Add.CB("atp", "Auto spam", FA, 1, "Авто спам") 
game:GetService("RunService").Stepped:Connect(function()
if autotp.Value then
pcall(function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = atpp.Character.HumanoidRootPart.CFrame
end)
end
end) 
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/Standard.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimExplorer/Load.lua"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimControl/Main.lua"))()
local success, response = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Freeze.lua"))()
end)
if not success then
warn("Error load freeze playes:\n" .. response)
end
local success, response = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGui/main/Settings.lua"))()
end)
_G.TimGui.SetGroup("Settings")
if not success then
warn("Error to load settings:\n" .. response)
end
local gameScr = game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Games/".. game.GameId ..".lua")
print(game.GameId)
_G.TimGui.Print("Loaded","TimGui is loaded","Загружен","TimGui загружен.")
local success, response = pcall(function()
loadstring(gameScr)()
end)
if not success then
if response == "HTTP 404 (Not Found)" then
print("game script not found")
else
warn("Error load game script:\n" .. response)
end
end
