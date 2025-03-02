--DeathBall
local userInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local attach = true
local group = _G.TimGui.Groups.CreateNewGroup("DeathBall")
local Auto = group.Create(2,"Auto","Auto(buged)","Авто(баганый)")
local Arabic = group.Create(2,"Arabic","Arabic","Арабик")
local radios = group.Create(3,"rad","Radius(50studs)(0-off):","Радиус(50шпилек):")
local AutoRadius = group.Create(2,"AutoForRad","Auto for selected radius","Авто для выбраного радиуса")
group.Create(1,"spawn","TP to spawn","ТП на спавн", function() 
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.SpawnLocation.CFrame
end) 
radios.Main.Text = 1


local rad = 0
local RB = Color3.new(1, 0, 0) 
local prev

local ReLoad = Instance.new("BoolValue")
local ReloadEnable = group.Create(2,"Reload","Reload enabled","Перезарядка для авто отбивания")
ReloadEnable.Value = true
ReloadEnable.CFGSave = true
ReLoad.Changed:Connect(function()
    wait(1.25)
    attach = true
end)

local function CLC()
    game:service("VirtualInputManager"):SendKeyEvent(true, "F", false, game) 
    if ReloadEnable.Value then
        attach = false
        ReLoad.Value = not ReLoad.Value
    end
    prev = nil
    rad = 0
end

local AFKvvv = Instance.new("BoolValue")
AFKvvv.Changed:Connect(function()
    local InterFrame = game.Players.LocalPlayer.PlayerGui:WaitForChild("HUD").HolderBottom.IntermissionFrame
    local AFK = group.Create(2,"AFK","AFK(tp to intermission)","АФК(ТП в интермиссию)")
    InterFrame.DescriptionLabel.Changed:Connect(function()
        if InterFrame.Visible and AFK.Value then
            if _G.debug then
                print(game.Players.LocalPlayer.PlayerGui.UI.HUD.HolderBottom.GeneralNotifications.IntermissionFrame.DescriptionLabel.Text)
            end
            if InterFrame.DescriptionLabel.Text == "INTERMISSION 5" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["New Lobby"].ReadyArea.ReadyZone.CFrame
            end
        end
    end)
end)
AFKvvv.Value = true


while RunService.RenderStepped:Wait() do
    local ball = game.Workspace:WaitForChild("Part",math.huge) 
    if ball.Highlight.FillColor == RB and attach then
        local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local pos = math.abs((playerPos-ball.CFrame.Position).Magnitude)
        --local Check = ball.CFrame.X - playerPos.X
        --pos = pos + math.abs(Check)
        --Check = ball.CFrame.Y - playerPos.Y
        --pos = pos + math.abs(Check)
        --Check = ball.CFrame.Z - playerPos.Z
        --pos = pos + math.abs(Check)
        if tonumber(radios.Main.Text) then
            radios.Main.Text = 1
        end
        if Auto.Value == true then
            if not (prev == nil) then
                rad = math.abs(pos - prev) * 2.25
                print("--------------------")
                print("prev:" .. prev .. "\n pos:" .. pos .. "\n rad(x2.25):" .. rad)
                if rad > 300 then
                    rad = 300
                end
            end
            prev = pos
            if pos < rad or pos < 50 then
                CLC() 
            end
        elseif Arabic.Value then
            CLC()
            wait(0.15)
            for v=1,20 do
                if ball.Highlight.FillColor == RB then
                    wait(0.05)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame
                end
            end
        elseif AutoRadius.Value then
            if pos < radios.Value*50 then
                CLC() 
            end
        end
    elseif not (ball.Highlight.FillColor == RB) then
        attach = true
    end
end
