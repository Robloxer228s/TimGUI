local colors = _G.TimGui.Colors
local group = _G.TimGui.Groups.CreateNewGroup("Themes")
local objpos = _G.TimGui.ObjectPosition
local SaveMode = _G.TimGui.Saves.Load("Modes")
local SaveColor = _G.TimGui.Saves.Load("Color")
local TGPath = _G.TimGui.Path
local NormSize = TGPath.Main.Size
local Colors = _G.TimGui.Colors
local Def = Colors.GetDefaultColors()
local TB = Def.ToggleButton
local Print = Def.Print
group.Visible = false
group.Create(0,"Modes","Modes","Режимы")

if SaveColor == nil then
	SaveColor = "Default"
end

local function double(Disconnect)
	local texts = 0
	objpos.Connect(UDim.new(1,0)-TGPath.Main.Size.X,function(k,v,def)
		def()
	end,function(k,v)
		if k == 0 then
			texts = 0
		end
		local ypos = (k+texts)/2
		local xpos = UDim.new(0,0)
		if v.Type == 0 then
			local PNT = k+texts
			ypos = math.ceil(ypos)
			v.Object.Size = UDim2.new(1,0,0,50)
			texts += 1
			if ypos*2 ~= PNT then
				texts += 1
			end
		else
			ypos = math.floor(ypos)
			v.Object.Size = UDim2.new(0.5,0,0,50)
			if ypos *2 ~= (k+texts) then
				xpos = v.Object.Size.X
			end
		end
		v.Object.Position = UDim2.new(xpos,UDim.new(0,50*ypos))
	end,Disconnect)
end

group.Create(2,"Double","Double","Двойной",function(val)
    if val.Value then
        _G.TimGui.Path.Main.Size = UDim2.new(0,700,1,0)
	_G.TimGui.Saves.Save("Modes","Double")
        double(function()
		TGPath.Main.Size = NormSize
		val.Main.Value = false
		_G.TimGui.Saves.Save("Modes",nil)
	end)
    else
        objpos.Disconnect()
    end
end).Main.Value = SaveMode == "Double"

group.Create(2,"DoubleMini","Double-mini","Двойной-мини",function(val)
    if val.Value then
		TGPath.Main.Size = NormSize
	_G.TimGui.Saves.Save("Modes","DoubleMini")
        double(function()
			val.Main.Value = false
			_G.TimGui.Saves.Save("Modes",nil)
		end)
    else
        objpos.Disconnect()
    end
end).Main.Value = SaveMode == "DoubleMini"

group.Create(2,"Mini","Mini","Мини",function(val)
    if val.Value then
		TGPath.Main.Size = UDim2.new(0,250,1,0)
	_G.TimGui.Saves.Save("Modes","Mini")
        objpos.Connect(UDim.new(1,0)-TGPath.Main.Size.X,function(k,v,def)
			def()
		end,function(k,v,def)
			def()
		end,function()
			val.Main.Value = false
			TGPath.Main.Size = NormSize
			_G.TimGui.Saves.Save("Modes",nil)
		end)
    else
        objpos.Disconnect()
    end
end).Main.Value = SaveMode == "Mini"

group.Create(0,"Colors","Colors","Цвета")
local ButtonColors = {}
local Color = {}
Color.Name = "Default"
Color.Text = "Blue(Default)"
Color.Rus = "Синяя(стандартная)"
Color.Colors = Def
table.insert(ButtonColors,Color)
local Color = {}
Color.Name = "Green"
Color.Text = "Green"
Color.Rus = "Зелёная"
Color.Colors = {
	MainBackground=Color3.new(Def.MainBackground.R,Def.MainBackground.B,Def.MainBackground.G),
	GroupsBackground=Color3.new(Def.GroupsBackground.R,Def.GroupsBackground.B,Def.GroupsBackground.G),
	TextBoxBackground=Color3.new(Def.TextBoxBackground.R,Def.TextBoxBackground.B,Def.TextBoxBackground.G),
	Button = Color3.new(Def.Button.R,Def.Button.B,Def.Button.G),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton=TB,
	Print={
		Background=Color3.new(Print.Background.R,Print.Background.B,Print.Background.G),
		Outline=Color3.new(Print.Outline.R,Print.Outline.B,Print.Outline.G),
		Timer=Color3.new(Print.Timer.R,Print.Timer.B,Print.Timer.G)
	}
}
table.insert(ButtonColors,Color)
Color = {}
Color.Name = "Red"
Color.Text = "Red"
Color.Rus = "Красная"
Color.Colors = {
	MainBackground=Color3.new(Def.MainBackground.B,Def.MainBackground.G,Def.MainBackground.R),
	GroupsBackground=Color3.new(Def.GroupsBackground.B,Def.GroupsBackground.G,Def.GroupsBackground.R),
	TextBoxBackground=Color3.new(Def.TextBoxBackground.B,Def.TextBoxBackground.G,Def.TextBoxBackground.R),
	Button = Color3.new(Def.Button.B,Def.Button.G,Def.Button.R),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton=TB,
	Print={
		Background=Color3.new(Print.Background.B,Print.Background.G,Print.Background.R),
		Outline=Color3.new(Print.Outline.B,Print.Outline.G,Print.Outline.R),
		Timer=Color3.new(Print.Timer.B,Print.Timer.G,Print.Timer.R)
	}
}
table.insert(ButtonColors,Color)
Color = {}
Color.Name = "Yellow"
Color.Text = "Yellow"
Color.Rus = "Жёлтый"
Color.Colors = {
	MainBackground=Color3.new(0.3, 0.3, 0.15),
	GroupsBackground=Color3.new(0.25,0.25,0.15),
	TextBoxBackground=Color3.fromRGB(76,76,38),
	Button=Color3.fromRGB(100,100,50),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton={
		Enabled=Color3.new(0,1,0.3),
		Disabled=Color3.new(1,0,0.3)
	},
	Print={
		Background=Color3.fromRGB(76,76,38),
		Outline=Color3.fromRGB(200,200,100),
		Timer=Color3.fromRGB(110,110,60)
	}
}
table.insert(ButtonColors,Color)
Color = {}
Color.Name = "Grey"
Color.Text = "Grey"
Color.Rus = "Серая"
Color.Colors = {
	MainBackground=Color3.new(0.3, 0.3, 0.3),
	GroupsBackground=Color3.new(0.25,0.25,0.25),
	TextBoxBackground=Color3.fromRGB(76,76,76),
	Button=Color3.fromRGB(100,100,100),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton={
		Enabled=Color3.new(0.1,1,0.1),
		Disabled=Color3.new(1,0.1,0.1)
	},
	Print={
		Background=Color3.fromRGB(76,76,76),
		Outline=Color3.fromRGB(200,200,200),
		Timer=Color3.fromRGB(110,110,110)
	}
}
table.insert(ButtonColors,Color)
Color = {}
Color.Name = "DGray"
Color.Text = "DarkGray"
Color.Rus = "Тёмно серая"
Color.Colors = {
	MainBackground=Color3.new(0.15, 0.15, 0.15),
	GroupsBackground=Color3.new(0.1,0.1,0.1),
	TextBoxBackground=Color3.fromRGB(38,38,38),
	Button=Color3.fromRGB(50,50,50),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton={
		Enabled=Color3.new(0.15,1,0.15),
		Disabled=Color3.new(1,0.15,0.15)
	},
	Print={
		Background=Color3.fromRGB(38,38,38),
		Outline=Color3.fromRGB(100,100,100),
		Timer=Color3.fromRGB(60,60,60)
	}
}
table.insert(ButtonColors,Color)
Color = {}
Color.Name = "Black"
Color.Text = "Black"
Color.Rus = "Чёрная"
Color.Colors = {
	MainBackground=Color3.new(0.05, 0.05, 0.05),
	GroupsBackground=Color3.new(0.02,0.02,0.02),
	TextBoxBackground=Color3.new(0.1,0.1,0.1),
	Button=Color3.fromRGB(25,25,25),
	Text=Def.Text,
	Arrow=Def.Arrow,
	ToggleButton={
		Enabled=Color3.new(0.2,1,0.2),
		Disabled=Color3.new(1,0.2,0.2)
	},
	Print={
		Background=Color3.new(0.1,0.1,0.1),
		Outline=Color3.fromRGB(50,50,50),
		Timer=Color3.fromRGB(30,30,30)
	}
}
table.insert(ButtonColors,Color)
Color = table.clone(ButtonColors)
local actived = SaveColor
local updating = false
for k,v in pairs(Color) do
	local ke = group.Create(2,v.Name,v.Text,v.Rus,function(val)
		if val.Value then
			for key,value in pairs(v.Colors) do
				Colors[key] = value
			end
			Colors.SetColors()
		elseif actived == val.Name and not updating then
			val.Main.Value = true
		end
	end)
	ButtonColors[ke] = v.Colors
	if v.Name == SaveColor then
		ke.Main.Value = true
	end
	ButtonColors[k] = nil
end

Colors.OnChange(function()
	_G.TimGui.Saves.Save("Color",nil)
	updating = true
	for k,v in pairs(ButtonColors) do
		local this = true
		for key,val in pairs(v) do
			if Colors[key] ~= val then 
				this = false
				break
			end
		end
		k.Main.Value = this
		if this then
			actived = k.Name
			_G.TimGui.Saves.Save("Color",k.Name)
		end
	end
	updating = false
end)

_G.TimGui.Groups.Settings.Create(1,"Themes","Themes","Темы",function()
    group.OpenGroup()
end)
