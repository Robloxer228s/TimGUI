--[[
Please, use this script(for english language):


_G.eng = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Main.lua"))()


]]

if _G.TimGui.askYN == nil then
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
else
_G.TimGui.askYN("TimGui is alredy running", "TimGui уже запущен", "Do you want to continue? \n (This may break the script)", "Вы хотите продолжить? \n (Это может сломать скрипт)", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/TimGui.lua"))()
end) 
end
