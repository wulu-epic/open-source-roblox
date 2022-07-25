--[[
    getgenv().enabled = true;
    getgenv().range = 4;
    getgenv().parryHold = 0.4;
    getgenv().alerts = true;
--]]

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')
local hrp = character:WaitForChild('HumanoidRootPart')

local vim = game:GetService('VirtualInputManager')

local anims = {}

for i,v in pairs(game:GetService("ReplicatedStorage").ChangeLanternColor:GetDescendants()) do
    if v:IsA("Animation") and v.Parent.Name == "SwingAnimations" then
        table.insert(anims,v.AnimationId)
    end
end

spawn(function()
    while wait() do
        pcall(function()
            player = game.Players.LocalPlayer
            character = player.Character or player.CharacterAdded:Wait()
            hrp = character:WaitForChild("HumanoidRootPart")
            humanoid = character:WaitForChild('Humanoid')
        end)
    end
end)


print(unpack(anims))

function m1()
	vim:SendMouseButtonEvent(0,0,1,true,game,0)
	wait(parryHold)
	vim:SendMouseButtonEvent(0,0,1,false,game,0)
end

function findMatchingAnim(trackName) 
    if table.find(anims,trackName) then
        return true;
    else
        return false;
    end
end

local function sendMesssage(message, duration)
    spawn(function ()
      local CoreGui = game:GetService("StarterGui")
      CoreGui:SetCore("SendNotification", {
      Title = "Notification";
      Text = message;
      Duration = duration; 
      Button1 = "ok";
      Button2 = "stfu";
      })
    end)
end


sendMesssage("Auto Parry by wulu#0827 loaded.", 3)

function autoParry() 
    spawn(function()
        while enabled do 
            local s,e = pcall(function()
                for i,v in pairs(workspace:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") ~= nil and v:FindFirstChild("HumanoidRootPart") ~= hrp and v:FindFirstChild("Humanoid") ~= nil and v:FindFirstChild("Humanoid").Health > 0 and (v:FindFirstChild("HumanoidRootPart").Position-hrp.Position).Magnitude < range then
                        for k,g in pairs(v:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
                            if findMatchingAnim(g.Animation.AnimationId) then
                                m1()
                                if alerts then sendMesssage("parry NOW", 0.01) end
                            end
                        end
                    end
                end
            end)
            if e then print(e) end
            task.wait()
        end
    end)
end

autoParry()

player.CharacterAdded:Connect(function(character)
    autoParry()
end)