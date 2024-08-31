_G.TimGui.Add.G("How many", "Сколько")
_G.TimGui.Add.B("WC", "Write count", "How many", 1, "Написать количество", function()
local items = game.Workspace.Items:GetChildren()
game.Players.LocalPlayer.PlayerGui.Guess.Frame.TextBox.Text = #items
local tab = {}
for kk,vv in pairs(items) do
local inf
for k,v in pairs(tab) do
if v == vv.Name then inf = true end
end
if not (inf == true) then
tab[#tab + 1] = vv.Name
print(vv.Name)
end
end
end)
