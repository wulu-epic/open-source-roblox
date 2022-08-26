local x = loadstring(game:HttpGet("https://raw.githubusercontent.com/wulu-epic/open-source-roblox/main/Functional_Scripts/utils.lua"))()
local utils = x.new()

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Mighty Omega", HidePremium = false, SaveConfig = false, ConfigFolder = "OrionTest"})

getgenv().autoSleep = false;
getgenv().autoCalesthetic = false;
getgenv().calesthetic = "pushup"

getgenv().maxBodyFatigue = 100;
getgenv().minBodyFatigue = 50;

local function m1click() 
    vim:SendMouseButtonEvent(0,0,0,true,game,0)
    wait()
    vim:SendMouseButtonEvent(0,0,0,false,game,0)
end


local Training = Window:MakeTab({
	Name = "Training",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local calestheticsec = Training:AddSection({
	Name = "Calesthetics"
})


local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local mightyOmega = {}
mightyOmega.__index = mightyOmega;

function mightyOmega.new()
    local self = {}
    local x = player.PlayerGui.MainGui.Utility.BodyFatigue.Text; local bodyFatigue = tonumber(string.match(x, "[%d.]+"))

    self.stamina = character:FindFirstChild("CurrentStamina").Value
    self.bodyFatigue = bodyFatigue

    return setmetatable(self,mightyOmega)
end

function mightyOmega:update()
    spawn(function()
        while task.wait(0.4) do
            local x = player.PlayerGui.MainGui.Utility.BodyFatigue.Text; local bodyFatigue = tonumber(string.match(x, "[%d.]+"))
    
            self.stamina = character:FindFirstChild("CurrentStamina").Value
            self.bodyFatigue = bodyFatigue
            self.maxStamina = character:
            FindFirstChild("MaxStamina").Value

            player = game.Players.LocalPlayer
            character = player.Character or player.CharacterAdded:Wait()
            humanoid = character:WaitForChild("Humanoid")
            hrp = character:WaitForChild("HumanoidRootPart")
        end
    end)
end

function mightyOmega:autoCalesthetic(calesthetic)
    function mightyOmega:DoCalesthetic(c)
        humanoid:EquipTool(player.Backpack:FindFirstChild(c))
        while getgenv().autoCalesthetic do
            task.wait(.4)
            m1click();
            if self.stamina < 3 then
                repeat
                    wait(.1)
                until self.stamina == self.maxStamina;
            end
        end
    end

    if calesthetic == "pushup" then
        if not player.Backpack:FindFirstChild("Push up") then  
            OrionLib:MakeNotification({
            Name = "Alert!",
            Content = "Make sure you either dont have pushup equipped or you actually have it",
            Image = "rbxassetid://4483345998",
            Time = 5
            })
            return;
        end
        mightyOmega:DoCalesthetic("Push up")
    end

    if calesthetic == "Squat" then
        if not player.Backpack:FindFirstChild("Squat") then  
            OrionLib:MakeNotification({
            Name = "Alert!",
            Content = "Make sure you either dont have Squat equipped or you actually have it",
            Image = "rbxassetid://4483345998",
            Time = 5
            })
            return;
        end
        mightyOmega:DoCalesthetic("Squat")
    end
end

function mightyOmega:AutoSleep()
    function mightyOmega:sleep()
        --your mom
    end

    if self.bodyFatigue < self.minBodyFatigue then
        mightyOmega:sleep();
    end
end

function mightyOmega:test()
    print'initalized'
end 

local x = mightyOmega.new();
x:test()

calestheticsec:AddToggle({
	Name = "Auto Train",
	Default = false,
	Callback = function(Value)
        autoCalesthetic = true;
		x:autoCalesthetic(calesthetic)
	end    
})

calestheticsec:AddDropdown({
	Name = "Calesthetic Selector",
	Default = "pushup",
	Options = {"pushup", "Squat"},
	Callback = function(Value)
		getgenv().calesthetic = Value;
	end    
})

