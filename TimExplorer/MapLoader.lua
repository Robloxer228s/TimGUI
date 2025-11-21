loadstring(_G.TimGui.HttpGet("./TimExplorer/PasteTEObject.lua"))()
local Group = _G.TimGui.Groups.CreateNewGroup("Map loader","Загрузка карт")
local LocalPlayer = game.Players.LocalPlayer
local pathYM = "TimGui/Maps/"
local Folder
local function loadMap(Array)
	if Folder == nil then
		Folder = Instance.new("Folder",game.Workspace)
		Folder.Name = tostring(math.random(1,1000))
	end 
	return _G.PasteTEObject(Array,Folder)
end
makefolder(pathYM)
local function CreateNew(path)
	local name = string.sub(path,string.len(pathYM)+1,string.len(path))
	Group.Create(2,path,name,name,function(val)
		if val.Value then
			local map = loadMap(readfile(path))
			map.Name = path
			if map:FindFirstChild("StartTP") then
				Group.Create(1,"TP/"..path,name,name,function()
					LocalPlayer.Character.PrimaryPart.CFrame = map.StartTP.CFrame
				end)
			end
		else
			local obj = Folder:FindFirstChild(path)
			if obj then obj:Destroy() end
		end
	end).CFGSave = true
end
Group.Create(0,1,"Built-in Maps","Встроенные карты")
local builtin = game.HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/TimExplorer/Maps/Maps.json"))
for name,v in pairs(builtin) do
	Group.Create(2,name,v[1],v[2],function(val)
		if val.Value then
			local map = loadMap(game:HttpGet("https://raw.githubusercontent.com/Robloxer228s/TimGUI/refs/heads/main/TimExplorer/Maps/"..name))
			map.Name = name
			if map:FindFirstChild("StartTP") then
				Group.Create(1,"TP/"..name,v[1],v[2],function()
					LocalPlayer.Character.PrimaryPart.CFrame = map.StartTP.CFrame
				end)
			end
		else
			local obj = Folder:FindFirstChild(name)
			if obj then obj:Destroy() end
		end
	end).CFGSave = true
end
if _G.TimGui.Saves.Enabled then
	local YourMap = Group.Create(0,2,"Your Maps","Твои карты")
	YourMap.Visible = false
	for k,v in pairs(listfiles(pathYM)) do
		if isfile(v) then
			CreateNew(v)
			YourMap.Visible = true
		end
	end
end
Group.Create(0,3,"TP in map","ТП на карту")
