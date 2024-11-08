-- Break IN 2
local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
local ForOut = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")

if ForOut then
	local group = _G.TimGui.Groups.CreateNewGroup("Lobby", "Лобби")
	group.Create(1,"RRS","Reconect to random server","Подключится в рандомную игру",function() 
		ForOut:WaitForChild("ReconnectEvent"):FireServer()
	end) 	
	group.Create(1,1,"Hacker(costume)","Хакер(костюм)",function() 
		ForOut.OutsideRole:FireServer("Phone",true,false)
	end) 
	group.Create(1,2,"Nerd(costume)","Нерд(костюм)",function() 
		ForOut.OutsideRole:FireServer("Book",true,false)
	end) 
end	if Events:FindFirstChild("GiveTool") then
	local group = _G.TimGui.Groups.CreateNewGroup("Items", "Предметы") 
	local Items = {
			["Armor"]="Броня",
			["Med Kit"]="Аптечка",
			["Key"]="Ключ",
			["Gold Key"]="Золотой ключ",
			["Louise"]="Крыса",
			["Lollipop"]="Леденец",
			["Chips"]="Чипсы",
			["Golden Apple"]="Золотое Яблоко",
			["Pizza"]="Пицца",
			["Gold Pizza"]="Золотая пицца",
			["Rainbow Pizza"]="Радужная пицца",
			["Rainbow Pizza Box"]="Коробка радужной пиццы",
			["Book"]="Книга",
			["Phone"]="Телефон", 
			["Cookie"]="Печенье",
			["Apple"]="Яблоко",
			["Bloxy Cola"]="Блокси кола",
			["Expired Bloxy Cola"]="Улучшенная блокси кола",
			["Bottle"]="Бутылка",
			["Ladder"]="Лестница",
			["Battery"]="Батарея"
	}

	for k, v in Items do
		group.Create(1,k,k,v, function() 
			if k == "Armor" then
				Events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(game.Players.LocalPlayer), 1)
			else
				Events:WaitForChild("GiveTool"):FireServer(tostring(k:gsub(" ", "")))
			end
		end) 
	end
end if Events:FindFirstChild("RainbowWhatStat") then
	local group = _G.TimGui.Groups.CreateNewGroup("Stats", "Статистика") 
	group.Create(1,"TSp","Train speed","Прокачать скорость",function() 
		Events:WaitForChild("RainbowWhatStat"):FireServer("Speed")
	end) 
	group.Create(1,"TSt","Train strength","Прокачать силу",function() 
		Events:WaitForChild("RainbowWhatStat"):FireServer("Strength")
	end) 
end
