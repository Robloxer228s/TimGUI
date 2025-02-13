local LocalPlayer = game.Players.LocalPlayer
local group = _G.TimGui.Groups.CreateNewGroup("Tower of HELL","Башня ада :>")

local Speed = group.Create(3,"SpeedT","Speed:","Скорость:")
group.Create(1,"Set speed","Set speed","Установить скорость",function()
    game.ReplicatedStorage.globalSpeed.Value = Speed.Value
end)

local NoKill = group.Create(2,"NoKill","Disable kill bricks","Выключить убивашки",function(val)
    LocalPlayer.Character.KillScript.Disabled = val.Value
end)
LocalPlayer.CharacterAdded:Connect(function()
    LocalPlayer.Character:WaitForChild("KillScript").Disabled = NoKill.Value
end)

group.Create(1,"Infinity jump","Infinity jump","Бесконечный прыжок",function()
    game.ReplicatedStorage.globalJumps.Value = 10000000000
end)

group.Create(1,"FTT","Finish the tower","Завершить башню",function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.tower.sections.finish.FinishGlow.CFrame
end)

group.Create(1,"OffBunny","Off bunny hop","Выключить банихоп",function()
    game.ReplicatedStorage.bunnyJumping.Value = false
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
NotAC["Allow Sit on fly v2"].Visible = false
_G.TimGui.Groups.ACGroup.Objects.FlyUPS.Main.Changed:Connect(function()
    _G.TimGui.Groups.ACGroup.Objects.FlyUPS.Main.Value = false
end)
_G.TimGui.Groups["Freeze players"].Visible = false
local NotAC = _G.TimGui.Groups.FUN.Objects
NotAC.HappyModSwim.Visible = false
NotAC.Fling.Value = false
NotAC.GetPing.Visible = false
