
getgenv().enabled = false;
getgenv().range = 5;
getgenv().parryHold = 0.3;
getgenv().alerts = false;

getgenv().faceUserAttacking = false; 
getgenv().facingsmoothning = 0.01; 


local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild('Humanoid')
local hrp = character:WaitForChild('HumanoidRootPart')

local ts = game:GetService('TweenService')
local Players = game:GetService('Players')
local vim = game:GetService('VirtualInputManager')

local ti = TweenInfo.new(facingsmoothning)

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "ZO Auto Parry", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Section = Tab:AddSection({
	Name = "Auto Parry"
})

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
	task.wait(parryHold)
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


local function tweenRotation(part)
    ti = TweenInfo.new(facingsmoothning)
    ts:Create(hrp, ti, {CFrame = CFrame.lookAt(hrp.Position, Vector3.new(part.Position.X, hrp.Position.Y, part.Position.Z))}):Play()
end

function autoParry() 
    spawn(function()
        while enabled do 
            local s,e = pcall(function()
                for i,v in pairs(Players:GetPlayers()) do
                    if v.Character ~= nil and  v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= hrp and v.Character:FindFirstChild("Humanoid").Health > 0 and (v.Character:FindFirstChild("HumanoidRootPart").Position-hrp.Position).Magnitude < range and v.Character:FindFirstChild("Humanoid") ~= nil then
                        for k,g in pairs(v.Character:FindFirstChild("Humanoid"):GetPlayingAnimationTracks()) do
                            if findMatchingAnim(g.Animation.AnimationId) then
                                m1()
                                if faceUserAttacking then
                                    spawn(function()
                                        tweenRotation(v.Character:FindFirstChild("HumanoidRootPart"))
                                    end)
                                end
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

Tab:AddToggle({
	Name = "Auto Parry",
	Default = false,
	Callback = function(Value)
		enabled=Value;
        autoParry()
	end    
})

Tab:AddToggle({
	Name = "Face towards attacker",
	Default = false,
	Callback = function(Value)
		faceUserAttacking=Value;     
	end    
})

Tab:AddSlider({
	Name = "Face Towards Attacker Smoothning",
	Min = 0,
	Max = 0.5,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Smoothning Value",
	Callback = function(Value)
		facingsmoothning = Value
	end    
})

Tab:AddToggle({
	Name = "Alerts",
	Default = false,
	Callback = function(Value)
		alerts=Value;     
	end    
})

Tab:AddSlider({
	Name = "Range",
	Min = 0,
	Max = 15,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Range Value",
	Callback = function(Value)
		range = Value
	end    
})

Tab:AddSlider({
	Name = "Hold Parry For",
	Min = 0,
	Max = 1,
	Default = 0.3,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Hold Parry Value",
	Callback = function(Value)
		parryHold = Value
	end    
})

player.CharacterAdded:Connect(function(character)
    autoParry()
end)

Tab:AddLabel("If you use face towards player and its not working properly")
Tab:AddLabel("try disabling shiftlock")
Tab:AddLabel("script by wulu#0827")