local HttpService = game:GetService("HttpService")
if _G.TimGui.Configs.Enabled then
	local group = _G.TimGui.Groups.CreateNewGroup("Configs")
	local path = _G.TimGui.Configs.Path
	local CFGData = _G.TimGui.Saves.Load("ConfigsData")
	if CFGData then
		CFGData = game:GetService("HttpService"):JSONDecode(CFGData)
	else CFGData = {Games={}}
	end
	local loadedCFG = {}
	local selected
	local SaveDefGame,OnlyOpen
	local LoadCFG = CFGData.Games[tostring(game.GameId)] or CFGData.Selected
	group.Visible = false
	group.CFGSave = false
	_G.TimGui.Groups.Settings.Create(1,"Configs","Configs","Конфигурации",function()
		group.OpenGroup()
	end) local function SaveCFGData()
		if SaveDefGame.Value then
			CFGData.Games[tostring(game.GameId)] = selected
		else CFGData.Selected = selected
			CFGData.Games[tostring(game.GameId)] = nil
		end _G.TimGui.Configs.Saves.Save("SaveAllValues",_G.TimGui.Configs.IgnoreCFGSaveFuncs)
		_G.TimGui.Saves.Save("ConfigsData",game:GetService("HttpService"):JSONEncode(CFGData))
	end
	local name = group.Create(3,1,"Name:","Имя:",function(val)
		local result = string.gsub(val.Main.Text,"/","")
		if result ~= val.Main.Text then
			val.Main.Text = result
		end
	end) local function CreateCFGButton(path)
		local name = string.split(path,"/")
		name = name[#name]
		loadedCFG[name] = group.Create(2,name,name,name,function(val)
			if val.Value then
				local lastsel = selected
				selected = name
				if lastsel ~= nil then
					loadedCFG[lastsel].Main.Value = false
				end if LoadCFG == name then
					LoadCFG = nil
				else SaveCFGData()
				end if OnlyOpen.Value then
					_G.TimGui.Configs.Open(name)
				else _G.TimGui.Configs.Load(name)
				end
			elseif selected == name then
				selected = nil
			end
		end)
		if name == LoadCFG then
			loadedCFG[name].Main.Value = true
		end
	end
	group.Create(1,2,"Create empty","Создать пустой",function()
		writefile(path..name.Value,HttpService:JSONEncode({Funcs={},Values={}}))
		CreateCFGButton(path..name.Value)
		_G.TimGui.Print("Configs","Created","Конфигурации","Создано")
	end)
	group.Create(0,3,"Manage configs","Управление конфигами")
	group.Create(1,4,"Save","Сохранить",function()
		if selected ~= nil then
			_G.TimGui.Configs.Save()
		else
			_G.TimGui.Print("Configs","Config not selected","Конфигурации","Не выбрано")
		end
	end)
	group.Create(1,5,"Reload","Перезагрузить",function()
		if selected ~= nil then
			_G.TimGui.Configs.Load()
		else
			_G.TimGui.Print("Configs","Config not selected","Конфигурации","Не выбрано")
		end
	end)
	group.Create(1,6,"Delete","Удалить",function()
		if selected ~= nil then
			delfile(path..selected)
			loadedCFG[selected].Destroy()
			loadedCFG[selected] = nil
			selected = nil
			_G.TimGui.Print("Configs","Deleted","Конфигурации","Удалено")
		else
			_G.TimGui.Print("Configs","Please, select config","Конфигурации","Пожалуйста, выбири конфигурацию")
		end
	end) OnlyOpen = group.Create(2,7,"Only open(dont load saves)","Только открытие(не загружать сохранения)",function(val)
		if selected ~= nil then
			SaveCFGData()
		end
	end)
	SaveDefGame = group.Create(2,8,"Set default for this game","Установить по умолчанию для этой игры",function(val)
		if selected ~= nil then
			SaveCFGData()
		end
	end) SaveDefGame.Main.Value = CFGData.Games[tostring(game.GameId)]~= nil
	group.Create(2,9,"Save ALL Values","Сохранять ВСЕ значения(может конфликтовать с игрой)",function(val)
		_G.TimGui.Configs.IgnoreCFGSaveFuncs = val.Value
		SaveCFGData()
	end).Main.Value = _G.TimGui.Configs.Saves.Load("SaveAllValues")
	group.Create(0,10,"Configs","Конфигурации")
	for _,v in pairs(listfiles(path)) do
		CreateCFGButton(v)
	end
end
