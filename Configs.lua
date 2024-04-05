local getF = function(name)
local post = {"operation": "fileget", "id": "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ==", "file": name}
local response = game:HttpPost("http://bagirovict.temp.swtest.ru", game:GetService("HttpService"):DecodeJSON(post))
response = string.gsub(response, "%.q_%.", '"')
response = string.gsub(response, "%.ns_%.", '\n')
response = game:GetService("HttpService"):EncodeJSON(response)
return response[game.Players.LocalPlayer.Name]
end

local setF = function(name, data)
local post = {"operation": "fileget", "id": "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ==", "file": name}
local response = game:HttpPost("http://bagirovict.temp.swtest.ru", game:GetService("HttpService"):DecodeJSON(post))
response = string.gsub(response, "%.q_%.", '"')
response = string.gsub(response, "%.ns_%.", '\n')
response = game:GetService("HttpService"):EncodeJSON(response)
response[game.Players.LocalPlayer.Name] = data
post = {"operation": "savefile", "id": "Yzk2MzY4NzI0NmNhOTIwNDI4NGMxNDUyZmRhYmYyM2RlZGYwOGRiM2U5ODhmN2Q2ZGI0MzI1MjllN2IzMDJhMQ==", "file": name, "content": response}
response = game:HttpPost("http://bagirovict.temp.swtest.ru", game:GetService("HttpService"):DecodeJSON(post))
end

local plset = getF("Settings")

local ren = _G.TimGui.Add.TB("sc", "Rename(if not null)", 3, "Переименовать конфиг \n (ничего = ненадо)")
_G.TimGui.Add.B("sc", "Set config", 4, "Настроить конфиг", function()
if not (ren == "") then
plset.Configs[plset.Config] = ren.Text
end
local tab = {}
for k,v in pairs(_G.TimGui.Path.Buttons:GetChildren()) do 
if not (v.group.Value == "Settings") then
if v:FindFirstChild("Value") then
tab[v.group.Value .. v.Name] = v.Value.Value
elseif v.Text.ClassName == "TextBox" then
tab[v.group.Value .. v.Name] = v.Text.Text
end
end -- group not settings
end
setF("Config" .. plset.Config, tab)
end)

local SetConfig = function(Conf)
for k,v in pairs(Conf) do
if v == false or v == true then
_G.TimGui.TimControlSet(k, "CB", v)
else
_G.TimGui.TimControlSet(k, "TB", v)
end
end
end

if plset == nil then
plset = {}
plset.ru = _G.TimGui.Get("rus", "Settings").Value
plset.xtwo = _G.TimGui.Get("x2", "Settings").Value
plset.Config = 1
plset.Configs[1] = "1"
plset.Configs[2] = "2"
plset.Configs[3] = "3"
setF("Settings", plset)
end
local success, response = pcall(function()
_G.TimGui.Add.CB(1, plset.Configs[1], "Settings", 5, plset.Configs[1], function(Tmp)
_G.TimGui.Set(plset.Config, "Settings", false)
Tmp.Value = true
plset.Config = 1
SetConfig(getF("Config1"))
setF("Settings", plset)
end)
_G.TimGui.Add.CB(2, plset.Configs[2], "Settings", 6, plset.Configs[2], function(Tmp)
_G.TimGui.Set(plset.Config, "Settings", false)
Tmp.Value = true
plset.Config = 2
SetConfig(getF("Config2"))
setF("Settings", plset)
end)
_G.TimGui.Add.CB(3, plset.Configs[3], "Settings", 7, plset.Configs[3], function(Tmp)
_G.TimGui.Set(plset.Config, "Settings", false)
Tmp.Value = true
plset.Config = 3
SetConfig(getF("Config3"))
setF("Settings", plset)
end)
_G.TimGui.Set(plset.Config, "Settings", true)
_G.TimGui.Set("rus", "Settings", plset.ru)
_G.TimGui.Set("x2", "Settings", plset.xtwo)
end)
if not success then
warn("Error get plr data:\n" .. response)
end
