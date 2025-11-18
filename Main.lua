--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]
local RepoURL = "https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/"
local function Open()
	if not _G.TimGui then
		_G.TimGui = {}
    elseif _G.TimGui.Configs and _G.TimGui.Configs.ResetToDefault then
			_G.TimGui.Configs.ResetToDefault()
		end 
    end if not _G.TimGui.HttpGet then
		_G.TimGui.HttpGet = function(Path)
			if not Path then return error("Is not URL") end
			if string.sub(Path,1,2) == "./" then
				Path = RepoURL..string.sub(Path,3,string.len(Path))
			end return game:HttpGet(Path)
		end
	end	loadstring(_G.TimGui.HttpGet("./TimGui.lua"))()
end
if type(_G.TimGui)~="table" then
    Open()
else if not _G.TimGui.Modules or not _G.TimGui.Modules.AskYN then task.wait(2.5) end
  if _G.TimGui.Modules and _G.TimGui.Modules.AskYN then
    _G.TimGui.Modules.AskYN("TimGui is alredy running", "Do you want to continue? \n (This may break the script)", "TimGui уже запущен", "Вы хотите продолжить? \n (Это может сломать скрипт)", Open) 
  else Open()
  end
end
