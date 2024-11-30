local HttpService = game:GetService("HttpService")
if _G.TimGui.Saves.Enabled then
	local group = _G.TimGui.Groups.CreateNewGroup("Configs")
	local path = "TimGui/Configs/"
	local loadedCFG = {}
	local selected
	local lastCFG = _G.TimGui.Saves.Load("Config")
	group.Visible = false
	_G.TimGui.Groups.Settings.Create(1,"Configs","Configs","Конфигурации",function()
		group.OpenGroup()
	end)
	local function CreateCFGButton(path)
		local name = string.split(path,"/")
		name = name[#name]
		loadedCFG[name] = group.Create(2,name,name,name,function(val)
			if val.Value then
				local lastsel = selected
				selected = name
				if lastsel ~= nil then
					loadedCFG[lastsel].Main.Value = false
				end
				_G.TimGui.Saves.Save("Config",name)
			elseif selected == name then
				selected = nil
			end
		end)
		if name == lastCFG then
			loadedCFG[name].Main.Value = true
		end
	end
	makefolder(path)
	local name = group.Create(3,1,"Name:","Имя:",function(val)
		local result = string.gsub(val.Main.Text,"/","")
		if result ~= val.Main.Text then
			val.Main.Text = result
		end
	end)
	group.Create(1,2,"Create empty","Создать пустой",function()
		writefile(path..name.Value,"{}")
		CreateCFGButton(path..name.Value)
	end)
	group.Create(0,3,"Manage configs","Управление конфигами")
	group.Create(1,4,"Delete","Удалить",function()
		if selected ~= nil then
			delfile(path..selected)
			loadedCFG[selected].Destroy()
			loadedCFG[selected] = nil
		end
	end)
	group.Create(1,5,"Save","Сохранить",function()
		if selected ~= nil then
			local save = HttpService:JSONDecode(readfile(path..selected))
			for gn,g in pairs(_G.TimGui.Groups) do
				if type(g) == "table" and gn ~= groups then
					local groupsave = save[gn] or {}
					local adding = false
					for on,obj in pairs(g.Objects) do
						if obj.Type == 3 then
							groupsave[tostring(on)] = obj.Value
							adding = true
						end
					end
					if adding then
						save[gn] = groupsave
					end
				end
			end
			writefile(path..selected,HttpService:JSONEncode(save))
		end
	end)
	local loadCFG = group.Create(1,6,"Load","Загрузить",function()
		if selected ~= nil then
			local save = HttpService:JSONDecode(readfile(path..selected))
			for name,tab in pairs(save) do
				local LoadGroup = _G.TimGui.Groups[name]
				if LoadGroup ~= nil then
					for k,v in pairs(LoadGroup.Objects) do
						if tab[k] ~= nil then
							if v.Type == 3 then
								v.Main.Text = tab[k]
							end
						end
					end
				end
			end
		end
	end)
	group.Create(0,7,"Configs","Конфигурации")
	for _,v in pairs(listfiles(path)) do
		CreateCFGButton(v)
	end
	loadCFG.EmulateClick()
end
