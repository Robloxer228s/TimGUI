_G.AGF("LuckyBlocks") 
local count = _G.ATBF("count", "Quantity:", "LuckyBlocks", 1,"Количество:") 
count.Text = 1
_G.ABF("zero", "LuckyBlock", "LuckyBlocks", 2 ,nil , function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnLuckyBlock:FireServer() 
end
end) 

_G.ABF("one", "SuperBlock", "LuckyBlocks", 3, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnSuperBlock:FireServer() 
end
end) 

_G.ABF("two", "DiamondBlock", "LuckyBlocks", 4, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnDiamondBlock:FireServer() 
end
end) 

_G.ABF("three", "RainbowBlock", "LuckyBlocks", 5, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnRainbowBlock:FireServer() 
end
end) 

_G.ABF("four", " GalaxyBlock", "LuckyBlocks", 6, nil, function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnGalaxyBlock:FireServer() 
end
end) 
