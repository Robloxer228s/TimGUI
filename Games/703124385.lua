local LocalPlayer = game.Players.LocalPlayer
local group = _G.TimGui.Groups.CreateNewGroup("Tower of HELL","Башня ада :>")
group.Create(0,"Warn","Warning: You can get banned for standard functions, experiment on 2 account","Предупреждение:за стандартные функции тебя могут забанить, эксперементируй на 2 акке")
local Speed = group.Create(3,"SpeedT","Speed:","Скорость:")
group.Create(1,"Set speed","Set speed","Установить скорость",function()
    game.ReplicatedStorage.GameValues.globalSpeed.Value = Speed.Value
end)

local NoKill = group.Create(2,"NoKill","Disable kill bricks","Выключить убивашки",function(val)
    game.ReplicatedStorage.GameValues.killbricksDisabled.Value = val.Value
end) game.ReplicatedStorage.GameValues.killbricksDisabled.Changed:Connect(function()
    if not game.ReplicatedStorage.GameValues.killbricksDisabled.Value then
        game.ReplicatedStorage.GameValues.killbricksDisabled.Value = NoKill.Value    
    end
end)
LocalPlayer.CharacterAdded:Connect(function()
    LocalPlayer.Character:WaitForChild("KillScript").Disabled = NoKill.Value
end)

group.Create(1,"Infinity jump","Infinity jump","Бесконечный прыжок",function()
    game.ReplicatedStorage.GameValues.globalJumps.Value = 10000000000
end)

group.Create(1,"FTT","Finish the tower","Завершить башню",function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.tower.sections.finish.FinishGlow.CFrame
end)

group.Create(1,"OffBunny","Off bunny hop","Выключить банихоп",function()
    game.ReplicatedStorage.GameValues.bunnyJumping.Value = false
end)

local NotAC = _G.TimGui.Groups.Map.Objects
NotAC.GravityTittle.Destroy()
NotAC.GravityValue.Destroy()
NotAC.SetGravity.Destroy()
NotAC.SetDefaultGravity.Destroy()
local NotAC = _G.TimGui.Groups.Player.Objects
NotAC.SetWalkSpeed.Visible = false
NotAC.JumpPower.Destroy()
NotAC.SetJump.Destroy()
NotAC.Spin.Destroy()
NotAC.MultyJump.Visible = false
NotAC.NoCollide.Visible = false
NotAC.Sit.Destroy()
NotAC.PlatformStand.Destroy()
NotAC.TPTool.Destroy()
NotAC.GodMode.Destroy()
NotAC.Backpack.Destroy()
NotAC.SettingsWF.Destroy()
NotAC.WalkFling.Destroy()
NotAC.FlyNMS.Destroy()
NotAC.FlyNM.Destroy()
_G.TimGui.Groups.ACGroup.Objects.FlyUPS.Main.Changed:Connect(function()
    _G.TimGui.Groups.ACGroup.Objects.FlyUPS.Main.Value = false
end)
_G.TimGui.Groups["Freeze"].Visible = false
local NotAC = _G.TimGui.Groups.FUN.Objects
NotAC.HappyModSwim.Visible = false
NotAC.Fling.Value = false
NotAC.GetPing.Visible = false
