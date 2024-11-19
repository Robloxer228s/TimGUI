local colors = _G.TimGui.Colors
local group = _G.TimGui.Groups.CreateNewGroup("Themes")
local objpos = _G.TimGui.ObjectPosition
local TGPath = _G.TimGui.Path
local NormSize = TGPath.Main.Size
group.Visible = false
group.Create(0,"Sizes","Sizes","Размеры")

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
        double(function()
			TGPath.Main.Size = NormSize
			val.Main.Value = false
		end)
    else
        objpos.Disconnect()
    end
end)

group.Create(2,"DoubleMini","Double-mini","Двойной-мини",function(val)
    if val.Value then
		TGPath.Main.Size = NormSizes
        double(function()
			val.Main.Value = false
		end)
    else
        objpos.Disconnect()
    end
end)

group.Create(2,"Mini","Mini","Мини",function(val)
    if val.Value then
		TGPath.Main.Size = UDim2.new(0,250,1,0)
        objpos.Connect(UDim.new(1,0)-TGPath.Main.Size.X,function(k,v,def)
			def()
		end,function(k,v,def)
			def()
		end,function()
			TGPath.Main.Size = NormSize
		end)
    else
        objpos.Disconnect()
    end
end)

_G.TimGui.Groups.Settings.Create(1,"Themes","Themes","Темы",function()
    group.OpenGroup()
end)
