_G.AGF("LuckyBlocks") 
local count = _G.ATBF("count", "Quantity:", "LuckyBlocks", 1,"Количество:") 
count.Text = 1
local zero = _G.ABF("zero", "LuckyBlock", "LuckyBlocks", 2) 
local one = _G.ABF("one", "SuperBlock", "LuckyBlocks", 3) 
local two = _G.ABF("two", "DiamondBlock", "LuckyBlocks", 4) 
local three = _G.ABF("three", "RainbowBlock", "LuckyBlocks", 5) 
local four = _G.ABF("four", " GalaxyBlock", "LuckyBlocks", 6) 

zero.Activated:Connect(function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnLuckyBlock:FireServer() 
end
end) 

one.Activated:Connect(function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnSuperBlock:FireServer() 
end
end) 

two.Activated:Connect(function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnDiamondBlock:FireServer() 
end
end) 

three.Activated:Connect(function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnRainbowBlock:FireServer() 
end
end) 

four.Activated:Connect(function() 
for v = 0, count.Text, 1 do
game.ReplicatedStorage.SpawnGalaxyBlock:FireServer() 
end
end) 
