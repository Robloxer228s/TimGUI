-- How many
local group = _G.TimGui.Groups.CreateNewGroup("How many", "Сколько")
group.Create(1,"WC","Write count","Написать количество",function()
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

local getMoney = group.Create(2,"GetMoney","Get Money","Получать деньги")

while task.wait(0.1) do
	if getMoney.Value then
		local coin = game.Workspace:FindFirstChild("Coin")
		if coin then
			coin.PrimaryPart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
		end
	end
end
