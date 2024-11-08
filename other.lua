local group = _G.TimGui.Groups.CreateNewGroup("Other","Другое")
group.Create(2,"Clicker","AutoClicker","Автокликер",function(val)
    wait(1)
    while task.wait() and val.Value do
        mouse1click()
    end
end)
