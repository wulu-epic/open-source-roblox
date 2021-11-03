function tp(x,y,z)
    -- SETTINGS START
    local valtomove = 5
    noclip = true
    anchored = false
    -- SETTINGS END
    
    
    moving = true
    if x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
    while x < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X-valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
    while z < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z-valtomove))
    end
    end
    if x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X then
    while x > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X+valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z then
    while z > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z+valtomove))
    end
    end
    if y < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y then
    while y < game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y-valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    if y > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y then
    while y > game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y do
    wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y+valtomove,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z))
    end
    end
    moving = false
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(x,y,z))
    if anchored == true then
    game.Players.LocalPlayer.Character.Head.Anchored = false
    end
    end
    
    spawn (function()
    game:getService("RunService"):BindToRenderStep("",0,function()
    if not game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid") then return end
    if moving == true then
    if noclip == true then
    game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
    end
    if anchored == true then
    game.Players.LocalPlayer.Character.Head.Anchored = true
    end
    end
    end)
    end)
    tp(game:GetService("Workspace").NPCs.Doctor.HumanoidRootPart.Position.X, game:GetService("Workspace").NPCs.Doctor.HumanoidRootPart.Position.Y, game:GetService("Workspace").NPCs.Doctor.HumanoidRootPart.Position.Z)