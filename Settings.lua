local NeedRus = _G.TimGui.Add.CB("rus", "Русский язык", "Settings", 1, "English language", function(rusV)
_G.TimGui.ru = rusV.Value
for k, v in pairs(_G.TimGui.Path.Buttons:GetChildren()) do
local tmp = v.Text.Text
v.Text.Text = v.Text.Value.Value
v.Text.Value.Value = tmp
end
for k, v in pairs(_G.TimGui.Path.Groups:GetChildren()) do
local tmp = v.Text.Text
v.Text.Text = v.Text.Value.Value
v.Text.Value.Value = tmp
end
end)
local tmp = game.LocalizationService.SystemLocaleId == "ru-ru"
tmp = tmp or game.LocalizationService.RobloxLocaleId == "ru-ru"
if os.date("%H",0) or tmp then
	NeedRus.Value = true
end
_G.TimGui.Add.CB("x2", "X2 interface", "Settings", 2, "2 кнопки", function(interface)
local int = 0
if _G.TimGui.TEOpen then
int = -0.2
end
if interface.Value then
_G.TimGui.Path.Main.Size = UDim2.new(0, 700, 1, 0)
_G.TimGui.Path.Main.Position = UDim2.new(1 + int, -700, 0, 0)
if not _G.TimGui.Opened then
_G.TimGui.Path.Main.Position = UDim2.new(1 + int, -700, 1, -25)
end
else
_G.TimGui.Path.Main.Size = UDim2.new(0, 400, 1, 0)
_G.TimGui.Path.Main.Position = UDim2.new(1 + int, -400, 0, 0)
if not _G.TimGui.Opened then
_G.TimGui.Path.Main.Position = UDim2.new(1 + int, -400, 1, -25)
end
end
for k,v in pairs(_G.TimGui.Path.Buttons:GetChildren()) do
_G.TimGui.XTwo = interface.Value
local pos = v.pos.Value
if interface.Value then
pos = pos / 2
local poss = math.ceil(pos) 
if poss == pos then
v.Position = UDim2.new(1, -300, 0, 50 * (poss - 1))
else
v.Position = UDim2.new(0, 0, 0, 50 * (poss - 1))
end
else
v.Position = UDim2.new(0, 0, 0, 50 * (pos - 1))
end
end
end)

_G.TimGui.SpareFriends = true
local sff = _G.TimGui.Add.CB("SF", "Spare friends", "Settings", 10, "Щадить друзей", function(sf)
_G.TimGui.SpareFriends = sf.Value
end) 
sff.Value = true
loadstring(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/main/Configs.lua"))()
