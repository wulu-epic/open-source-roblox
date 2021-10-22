local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdde:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

--toggle------------
_G.enabled = false
--------------------

local function getAllChests()
   while _G.enabled == true do
    for i,v in pairs(workspace:GetDescendants()) do
      if v.Name == "Mesh" then
        if v.Parent.Name:match("Chest") then
          wait(0.1)
          hrp.CFrame = v.Parent.CFrame
        end
      end
    end
 end
end

getAllChests()