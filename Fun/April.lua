local LOL = _G.TimGui.Groups.CreateNewGroup("2 april","1 апреля")
local engText = "Your clicks: "
local ruText = "Твои клики: "
local count = _G.TimGui.Saves.Load("1aprilClc")
local Saved = false
if not count then
    count = 0
else
    Saved = true
    count = tonumber(count) or -25
end
local fart = Instance.new("Sound",_G.TimGui.Path.gui)
local ClickPerSec = 0
fart.SoundId = "rbxassetid://8551016315"
local txt = LOL.Create(0,"Warn","Oh, no groups is locked","О нет, вкладки заблокированы!")
local clicks = LOL.Create(0,"Clicks",engText..count,ruText..count)
LOL.Create(1,"Click","Click","Клик",function()
    count += 1
    ClickPerSec += 1
    if math.random(1,100) == 1 then
        txt.Text = "Hehe"
        txt.RusText = "Хихи"
        count -= math.random(5,20)
        fart:Play()
    end
    clicks.Text = engText..count
    clicks.RusText = ruText..count
    if _G.TimGui.Values.RusLang then
        clicks.Main.Text = ruText..count
    else
        clicks.Main.Text = engText..count
    end
end)

if _G.TimGui.Saves.Enabled then
    LOL.Create(1,"Save clicks","Save clicks(50 clicks)","Сохранить клики(50 кликов)",function(button)
        Saved = true
        count -= 50
        _G.TimGui.Saves.Save("1aprilClc",count)
        clicks.Text = engText..count
        clicks.RusText = ruText..count
    end)
end
LOL.Create(0,"Groups","Unlock groups","Разблокировка вкладок")
local UnlockPrice = 50
for k,v in pairs(_G.TimGui.Groups) do
    if type(v) == "table" and v ~= LOL then
        if v.Visible == true then
            v.Visible = false
            LOL.Create(1,"Unlock"..k,v.Name,v.RusName,function(button)
                _G.TimGui.askYN(v.Name,"Buy for "..UnlockPrice,v.RusName,"Купить за "..UnlockPrice,function()
                    _G.TimGui.askYN(v.Name,"You sure?",v.RusName,"Ты согласен?",function()
                        local clickBefore = count-UnlockPrice
                        if clickBefore > -1 then
                            _G.TimGui.askYN(v.Name,"You clicks before: "..clickBefore,v.RusName,"Твои клики после: "..clickBefore,function()
                                _G.TimGui.askYN(v.Name,"You sure?",v.RusName,"Ты согласен?",function()
                                    count = count-UnlockPrice
                                    if count > -1 then
                                        v.Visible = true
                                        UnlockPrice += 50
                                        button.Destroy()
                                        clicks.Text = engText..count
                                        clicks.RusText = ruText..count
                                        if Saved then
                                            _G.TimGui.Saves.Save("1aprilClc",count)
                                        end
                                    end
                                end)
                            end)
                        end
                    end)
                end)
            end)
        end
    end
end

LOL.OpenGroup()
task.spawn(function()
    while task.wait(0.75) do
        if ClickPerSec > 20 then
            if _G.TimGui.Values.RusLang then
                game.Players.LocalPlayer:Kick("С 1 апреля, автокликер")
            else
                game.Players.LocalPlayer:Kick("Happy 1 april, autoclicker")
            end
        end
        ClickPerSec = 0
    end
end)
