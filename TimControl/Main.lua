local function Connect()
local servers = game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/echo/echo.php?slot=1&token=52307216790Robloxer228s35873790094")
for v=1, servers, 1 do
local val = game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/echo/echo.php?slot=".. v+1 .."&token=52307216790Robloxer228s35873790094")
if val == "C1" then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|C2")
elseif val == "C2" then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|C3")
elseif val == "C3" then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|C4")
elseif val == "C4" then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|C5")
elseif val == "C5" then
val = game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|null")
elseif not (val == "null") then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|C1")
end
if val == "null" then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. v+1 .."|Ok")
return v
end
end
return 0
end

local code = 0
_G.TimGui.Add.CB("TC", "TimConnect", "Settings", 8, "TimConnect", function(TC)
if TC.Value then 
TC.Parent.Text.Text = "Connecting"
code = Connect()
TC.Parent.Text.Text = "Code: ".. code
if code == 0 then
TC.Value = false
end
else
TC.Parent.Text.Text = "TimConnect"
if not (code == 0) then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. code+1 .."|null")
code = 0
end
end
end) 

local Control = function(get) 
if get == "C1" or get == "C2" or get == "C3" or get == "C4" or get == "C5" then 
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. code+1 .."|Ok")
end

if string.sub(get, 1, 2) == "F." then
_G.TimGui.TimControlSet(string.sub(get, 3, string.len(get)+1), "CB", false)
end
if string.sub(get, 1, 2) == "T." then
_G.TimGui.TimControlSet(string.sub(get, 3, string.len(get)+1), "CB", true)
end
if string.sub(get, 1, 2) == "B." then
_G.TimGui.TimControlSet(string.sub(get, 3, string.len(get)+1), "B")
end
if string.sub(get, 1, 3) == "TB." then
local name = string.sub(get, 4, string.len(get)+1)
local split = name:split(':')
_G.TimGui.TimControlSet(split[1], "TB", split[2])
end
if string.sub(get, 1, 2) == "G." then
_G.TimGui.SetGroup(string.sub(get, 3, string.len(get)+1))
wait(0.1)
local tab = {}
local i = 0
for k,v in pairs(_G.TimGui.Path.Buttons:GetChildren()) do
if v.Visible then
local buttab = {}
buttab[1] = v.group.Value -- group name
buttab[2] = v.Name -- name
buttab[3] = v.pos.Value -- y pos
if v:FindFirstChild("Value") then
buttab[4] = "CB" --type
buttab[5] = v.Text.Text -- text
buttab[6] = v.Value.Value -- Value
elseif v:FindFirstChild("TextBox") then
buttab[4] = "TB" --type
buttab[5] = v.Text.Text -- text
buttab[6] = v.TextBox.Text -- Value
else
buttab[4] = "B" --type
buttab[5] = v.Text.Text -- text
end
i += 1
tab[i] = buttab
end
end
local gg = "SG." .. string.gsub(game:GetService("HttpService"):JSONEncode(tab),"\n","")
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. code+1 .."|" .. gg)
print(code+1 .."|" .. gg)
end
end

local Armatura = Instance.new("BoolValue")

Armatura.Changed:Connect(function() 
while true do
wait(0.25) 
if not (code == 0) then
local get = game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/echo/echo.php?slot=".. code+1 .."&token=52307216790Robloxer228s35873790094")
if string.sub(get, 1, 1) == "[" then
for k, v in pairs(game:GetService("HttpService"):JSONDecode(get)) do
Control(v)
end
elseif get == "GC" then
local tab = {}
tab[1] = _G.TimGui.ru
tab[2] = game.GameId
if not (_G.UBF == nil) then
tab[3] = _G.UBF
end
local get = "S" .. string.gsub(game:GetService("HttpService"):JSONEncode(tab),"\n","")
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. code+1 .."|" .. get)
end
if not (get == "Ok") and not (string.sub(get, 1, 1) == "S") then
game:HttpGet("http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=52307216790Robloxer228s35873790094&get_pe=".. code+1 .."|Ok")
end 
end
end
end) 


Armatura.Value = true
