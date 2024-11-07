-- Break IN
local Events = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")

if Events:FindFirstChild("OutsideRole") then
	local group = _G.TimGui.Groups.CreateNewGroup("Roles", "Роли") 
	local costume = group.Create(2,0,"Use costume","Использовать костюм")
	group.Create(1,1,"The Swat","The Swat",function() 
	Events.OutsideRole:FireServer("SwatGun",costume.Value)
	end) 
	group.Create(1,2,"The Officer","The Officer",function() 
	Events.OutsideRole:FireServer("Gun",costume.Value)
	end) 
	group.Create(1,3,"The Fighter","The Fighter",function() 
	Events.OutsideRole:FireServer("Sword",costume.Value)
	end) 
end	if Events:FindFirstChild("GiveTool") then
	local group = _G.TimGui.Groups.CreateNewGroup("Items", "Предметы") 
	local Items = {
			["Cure"]="Инъекция",
			["Apple"]="Яблоко",
			["Cookie"]="Печенье",
			["Bloxy Cola"]="Блокси кола",
			["Chips"]="Чипсы",
			["Lollipop"]="Леденец",
			["Epic Pizza"]="Эпическая пицца",
			["Pizza 3"]="Большая пицца",
			["Expired Bloxy Cola"]="Улучшенная блокси кола",
			["Teddy Bloxpin"]="Медведка",
			["Bat"]="Бита",
			["Linked Sword"]="Меч",
			["Hammer"]="Молоток",
			["Plank"]="Доски", 
			["Key"]="Ключ"
	}

	for k, v in Items do
		group.Create(1,k,k,v, function() 
			Events:WaitForChild("GiveTool"):FireServer(tostring(k:gsub(" ", "")))
		end) 
	end
end
