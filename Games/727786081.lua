local Blocks = _G.TimGui.Groups.CreateNewGroup("Blocks","Исчезающие блоки")
local Poses = {}
local LocalPlayer = game.Players.LocalPlayer

for k,v in pairs(workspace:GetChildren()) do
    if v:IsA("Part") and v.BrickColor == BrickColor.new("Toothpaste") then
        if v:FindFirstChild("TouchInterest") and v:FindFirstChild("Script") then
            Poses[v] = v.CFrame
        end
    end
end
local Anchor = Blocks.Create(2,"Anchor","Anchor parts","Закрепить блоки",function(val)
	if val.Value then
		local pos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
		for v,old in pairs(Poses) do
			v.CFrame = pos
		end
	else
		for v,old in pairs(Poses) do
			v.CFrame = old
		end
	end
end)

Blocks.Create(1,"Trigger touch","Fire touch","Докаснуться до блоков",function()
	local pos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
	for v,old in pairs(Poses) do
		v.CFrame = pos
		v.CanCollide = true
	end
	if Anchor.Value then return end
	wait()
	for v,old in pairs(Poses) do
		v.CFrame = old
	end
end)
