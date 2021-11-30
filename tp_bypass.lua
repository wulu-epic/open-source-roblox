local target = nil
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local function find()
   local success, err = pcall(function()
       local distX = Vector3.new(hrp.Position.X-target.Position.X,0,0).X
       local distY = Vector3.new(0,hrp.Position.Y-target.Position.Y,0).Y
       local distZ = Vector3.new(0,0,hrp.Position.Z-target.Position.Z).Z
       
       local combined = Vector3.new(distX,distY,distZ)
       
       print(combined.X)
       print(hrp.Position.X)
       
       for i = hrp.Position.X, combined.X, -1 do
             print(i)
             print("hi")
             hrp.Position = Vector3.new(i,0,0)
             wait()
           end
   end)
   if err then print(err) end
end


--my dumbass accidentally made tweening :skull: