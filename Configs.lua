local plset
local getF = function(name)
local post = {}
post.operation = "fileget"
post.id = "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ=="
post.file = name
local response = game:HttpPost("http://bagirovict.temp.swtest.ru", post)
response = string.gsub(response, "%.q_%.", '"')
response = string.gsub(response, "%.ns_%.", '\n')
--print(response) 
response = game:GetService("HttpService"):JSONDecode(response)
if response[game.Players.LocalPlayer.Name] == nil then
response[game.Players.LocalPlayer.Name] = {}
end
return response[game.Players.LocalPlayer.Name]
end

local setF = function(name, data)
local post = {}
post.operation = "fileget"
post.id = "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ=="
post.file = name
local response = game:HttpPost("http://bagirovict.temp.swtest.ru", post)
response = string.gsub(response, "%.q_%.", '"')
response = string.gsub(response, "%.ns_%.", '\n')
--print(response) 
local tab = game:GetService("HttpService"):JSONDecode(response)
tab[game.Players.LocalPlayer.Name] = data
local post = {}
post.operation = "savefile"
post.id = "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ=="
post.file = name
post.content = game:GetService("HttpService"):JSONEncode(tab)
--print(game:GetService("HttpService"):JSONEncode(post)) 
response = game:HttpPost("http://bagirovict.temp.swtest.ru", post)
end
local ren = _G.TimGui.Add.TB("ren", "Rename(if not null)", "Settings", 3, "Переименовать конфиг (ничего = ненадо)")
_G.TimGui.Add.B("sc", "Set config", "Settings", 4, "Настроить конфиг", function()
if not (ren.Text == "") then
plset.Configs[plset.Config] = ren.Text
setF("Settings", plset)
_G.TimGui.Get(plset.Config, "Settings").Parent.Text.Text = ren.Text
ren.Text = ""
end
local tab = _G.TimGui.config
for k,v in pairs(_G.TimGui.Path.Buttons:GetChildren()) do 
if not (v.group.Value == "Settings") then
--if v:FindFirstChild("Value") then
--tab[v.group.Value .. v.Name] = v.Value.Value
--else
if v:FindFirstChild("TextBox") then
if not (v.TextBox.Text == "") then
tab[v.group.Value .. "." .. v.Name] = v.TextBox.Text
else
tab[v.group.Value .. "." .. v.Name] = nil
end
end
end -- group not settings
end
_G.TimGui.config = tab
setF("Config" .. plset.Config, tab)
end)

local SetConfig = function(Conf)
_G.TimGui.config = Conf
for k,v in pairs(Conf) do
--if v == false or v == true then
--_G.TimGui.TimControlSet(k, "CB", v)
--else
pcall(function()
_G.TimGui.TimControlSet(k, "TB", v)
end) 
--end
end
end


local change = true
plset = getF("Settings")
if plset.ru == nil then
plset = {}
plset.ru = _G.TimGui.Get("rus", "Settings").Value
plset.xtwo = _G.TimGui.Get("x2", "Settings").Value
plset.Config = 1
plset.Configs = {}
plset.Configs[1] = "1"
plset.Configs[2] = "2"
plset.Configs[3] = "3"
setF("Settings", plset)
end
local success, response = pcall(function()
_G.TimGui.Add.CB(1, plset.Configs[1], "Settings", 5, plset.Configs[1], function(Tmp)
if change then
change = false
if (not (plset.Config == 1)) then
_G.TimGui.Set(plset.Config, "Settings", false)
end
Tmp.Value = true
plset.Config = 1
SetConfig(getF("Config1"))
setF("Settings", plset)
change = true
end
end)
_G.TimGui.Add.CB(2, plset.Configs[2], "Settings", 6, plset.Configs[2], function(Tmp)
if change then
change = false
if (not (plset.Config == 2)) then
_G.TimGui.Set(plset.Config, "Settings", false)
end
Tmp.Value = true
plset.Config = 2
SetConfig(getF("Config2"))
setF("Settings", plset)
change = true
end
end)
_G.TimGui.Add.CB(3, plset.Configs[3], "Settings", 7, plset.Configs[3], function(Tmp)
if change then
change = false
if (not (plset.Config == 3)) then
_G.TimGui.Set(plset.Config, "Settings", false)
end
Tmp.Value = true
plset.Config = 3
SetConfig(getF("Config3"))
setF("Settings", plset)
change = true
end
end)
_G.TimGui.Set(plset.Config, "Settings", true)
_G.TimGui.Set("rus", "Settings", plset.ru)
_G.TimGui.Set("x2", "Settings", plset.xtwo)
end)
if not success then
warn("Error get plr data:\n" .. response)
end

local rusBut = _G.TimGui.Get("rus", "Settings") 
rusBut.Changed:Connect(function()
plset.ru = rusBut.Value
setF("Settings", plset)
end)

local xtwoBut = _G.TimGui.Get("rus", "Settings") 
xtwoBut.Changed:Connect(function()
plset.xtwo = xtwoBut.Value
setF("Settings", plset)
end)
