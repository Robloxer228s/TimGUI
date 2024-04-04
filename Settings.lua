_G.TimGui.Add.CB("rus", "Русский язык", "Settings", 1, "English language", function(rusV)
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
