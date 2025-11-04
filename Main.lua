--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]

if type(_G.TimGui)~="table" then
_G.TimGui = {}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
else local function Open()
    if _G.TimGui.Configs and _G.TimGui.Configs.ResetToDefault then
      _G.TimGui.Configs.ResetToDefault()
    end loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
  end
  if _G.TimGui.Modules and _G.TimGui.Modules.askYN then
    _G.TimGui.Modules.askYN("TimGui is alredy running", "Do you want to continue? \n (This may break the script)", "TimGui уже запущен", "Вы хотите продолжить? \n (Это может сломать скрипт)", function()
      Open()
    end) 
  else Open()
  end
end
