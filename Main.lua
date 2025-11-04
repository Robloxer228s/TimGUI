--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]
local function Open()
    if _G.TimGui and _G.TimGui.Configs and _G.TimGui.Configs.ResetToDefault then
      _G.TimGui.Configs.ResetToDefault()
    end loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
end
if type(_G.TimGui)~="table" then
    _G.TimGui = {}
    Open()
else 
  if _G.TimGui.Modules and _G.TimGui.Modules.AskYN then
    _G.TimGui.Modules.AskYN("TimGui is alredy running", "Do you want to continue? \n (This may break the script)", "TimGui уже запущен", "Вы хотите продолжить? \n (Это может сломать скрипт)", Open) 
  else Open()
  end
end
