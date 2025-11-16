local URL = "http://d90930x1.beget.tech/PocketCodeDB/DATABASE/get/get.php?slot=1&token=84096643436Robloxer2286033897412&name=@NAME@&data=@DATA@"
local HttpService = game:GetService("HttpService")
local LP = game.Players.LocalPlayer
local LastTab = {}
local EnableTPToMe = _G.TimGui.Saves.Enabled and _G.TimGui.Saves.Load("UsersConnectorEnabled")
if EnableTPToMe == nil then EnableTPToMe=true elseif type(EnableTPToMe)=="string" then EnableTPToMe=EnableTPToMe=="true" end
local TimeForUpdate = 10*60
local LeftToUpdate = TimeForUpdate
local AntiDDosBlock = false
local OnUpdate = {}
local Separator="@"
local function UpdateTable(data)
	if AntiDDosBlock and not data then return false end
	AntiDDosBlock = true
	if not data then
		data = {game.PlaceId}
		if EnableTPToMe then table.insert(data,game.JobId) end
	end
	local url = string.gsub(URL,"@DATA@",table.concat(data,Separator))
	local result = game:HttpGet(url)
	LastTab = HttpService:JSONDecode(result)
	task.delay(10,function()
		AntiDDosBlock = false
	end) for k,v in pairs(LastTab) do
		v.data = string.split(v.data,Separator)
	end for k,v in pairs(OnUpdate) do
		task.spawn(v)
	end LeftToUpdate = TimeForUpdate
end URL = string.gsub(URL,"@NAME@",LP.Name)
local group = _G.TimGui.Groups.CreateNewGroup("UsersConnector")
group.Visible = false
_G.TimGui.Groups.Settings.Create(1,"UsersConnector","Join to other TimGui users","Присоединяться к другим TimGui пользователям",function()
	group.OpenGroup()
end) group.Create(2,"AllowConnect","Allow connect to me","Разрешить подключение ко мне",function(val)
	if AntiDDosBlock then
		val.Main.Value = EnableTPToMe
		_G.TimGui.Print("Allow Connect","Please, wait","Разрешить Подключения","Подожди, чуть чуть")
		return
	end EnableTPToMe = val.Value
	UpdateTable()
	_G.TimGui.Saves.Save("UsersConnectorEnabled",tostring(val.Value))
end).Main.Value = EnableTPToMe
group.Create(1,"Refresh","Refresh","Обновить",function()
	if AntiDDosBlock then
		_G.TimGui.Print("Refresh","Please, wait","Обновить","Не спамь!")
		return
	end UpdateTable()
	_G.TimGui.Print("Refresh","Done!","Обновить","Выполнено!")
end)
group.Create(0,"Players","Players","Игроки")
local warnOnJoin = "The player might have already left, but he was definitely there @s@ seconds ago"
local warnOnJoinRus = "Игрок мог уже выйти, но он точно был @s@ секунд назад"
local Buttons = {}
table.insert(OnUpdate,function()
	local IAm = LastTab[LP.Name]
	local TimeOfUpd = IAm.time
	for k,v in pairs(LastTab) do
		if k == LP.Name then continue end
		local lastUpdateTime = TimeOfUpd-v.time-10
		local LastButton = Buttons[k]
		if LastButton then LastButton.Destroy() end
		print(lastUpdateTime,TimeForUpdate)
		if lastUpdateTime<TimeForUpdate then
			if v.data[2] then
				Buttons[k] = group.Create(1,"Pl:"..k,k,k,function()
					local timeAgo = os.time()-v.time
					_G.TimGui.Modules.AskYN(k,"You're sure want to join? "..string.gsub(warnOnJoin,"@s@",timeAgo),k,"Ты точно хочешь зайти? "..string.gsub(warnOnJoinRus,"@s@",timeAgo),function()
						local teleportData = {
							placeId = v.data[1],
							jobId = v.data[2]
						} UpdateTable(v.data)
						LP:Kick("TimGui: TP to "..k.." :>")
						local s,r = pcall(function()
							game:GetService("TeleportService"):Teleport(teleportData.placeId, LP, teleportData)
						end) task.wait(1)
						if not s then LP:Kick("Error: "..r) end
					end)
				end)
			else Buttons[k] = group.Create(0,"Pl:"..k,k,k)
			end
		end
	end
end) game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Wait()
	task.wait(10)
	if LastTab[Player.Name] and not Player:IsFriendWith(LP.UserId) then
		UpdateTable()
		if not LastTab[Player.Name] then return end
		local plTab = LastTab[Player.Name].data
		if plTab then
			if game.PlaceId == plTab[1] and game.JobId == plTab[2] then
				_G.TimGui.Print(Player.Name,"Joined with TimGui",Player.Name,"Зашел с TimGui")
			end
		end
	end
end)

UpdateTable()
while true do
	task.wait(1)
	LeftToUpdate -= 1
	if LeftToUpdate<=0 then
		local s,r = pcall(UpdateTable)
		if not s then
			task.spawn(function()error(r)end)
		end
	end
end
