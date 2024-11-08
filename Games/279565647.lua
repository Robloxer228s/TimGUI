-- LuckBlocks BattleGround
_G.TimGui.Add.G("LuckyBlocks") 
local count = _G.TimGui.Add.TB("count", "Quantity:", "LuckyBlocks", 1,"Количество:") 
if count.Text == "" then count.Text = 1 end
_G.TimGui.Add.B("zero", "LuckyBlock", "LuckyBlocks", 2, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnLuckyBlock:FireServer() 
end
end) 

_G.TimGui.Add.B("one", "SuperBlock", "LuckyBlocks", 3, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnSuperBlock:FireServer() 
end
end) 

_G.TimGui.Add.B("two", "DiamondBlock", "LuckyBlocks", 4, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnDiamondBlock:FireServer() 
end
end) 

_G.TimGui.Add.B("three", "RainbowBlock", "LuckyBlocks", 5, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnRainbowBlock:FireServer() 
end
end) 

_G.TimGui.Add.B("four", " GalaxyBlock", "LuckyBlocks", 6, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnGalaxyBlock:FireServer() 
end
end) 
