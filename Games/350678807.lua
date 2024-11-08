-- The door
local door = _G.TimGui.Groups.CreateNewGroup("Door") 
door.Create(1,"BA","Become amogus","Стать амогусом",function() 
    game.ReplicatedStorage.Amogus:FireServer() 
end) 
