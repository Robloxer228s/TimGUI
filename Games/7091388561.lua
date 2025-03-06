local mathing = game.Workspace.Map.Functional.Screen.SurfaceGui.MainFrame.MainGameContainer.MainTxtContainer.QuestionText
local group = _G.TimGui.Groups.CreateNewGroup("math")
local ansewer = group.Create(2,"GiveAnsw","Get ansewer","Получать ответы")
ansewer.CFGSave = true
mathing:GetPropertyChangedSignal("Text"):Connect(function()
    local text = mathing.Text
    local res = text
    if string.find(res,"= ") == nil and ansewer.Value then
        res = string.gsub(res,"=","")
        res = string.gsub(res," ","")
        for k,v in pairs({"+","-","x","/"}) do
            if string.find(res,v) ~= nil then
                local split = string.split(res,v)
                split[1] = tonumber(split[1])
                split[2] = tonumber(split[2])
                if k == 1 then
                    res = split[1]+split[2]
                elseif k == 2 then
                    res = split[1]-split[2]
                elseif k == 3 then
                    res = split[1]*split[2]
                elseif k == 4 then
                    res = split[1]/split[2]
                end
                mathing.Text = text.." "..res
                break
            end
        end
    end
end)
