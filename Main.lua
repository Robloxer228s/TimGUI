--[[
Please, use this script(for updates):

loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()

]]

if _G.TimGui == nil then
_G.TimGui = {}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
else
_G.TimGui.askYN("TimGui is alredy running", "Do you want to continue? \n (This may break the script)", "TimGui уже запущен", "Вы хотите продолжить? \n (Это может сломать скрипт)", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
end) 
end
