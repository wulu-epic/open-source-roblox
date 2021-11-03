local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)

getgenv()._autoAttack = false;
getgenv()._autoSpin = false;
getgenv()._autoTrain = false;
getgenv()._autoFarm = false;

getgenv()._IncreaseStrengthStat = false;
getgenv()._IncreaseSpeedStat = false;
getgenv()._IncreaseDefenseStat = false;
getgenv()._IncreaseEnergyStat = false;

getgenv()._typeOfspin = "";
getgenv()._CurrentSpinAMT = nil
getgenv()._desiredQuirk = "";

getgenv()._bypassAntiTP = true;

character.Stats:WaitForChild("Speed"):Destroy()


player.Character.CharacterAdded:Connect(function (char)
    char.Stats.Speed:Destroy()
end)-- tp bypass pogpgogpogpgopgogoggoogogggp

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local MainWindow = library:CreateWindow("Main") -- Creates the window

local MainFolder = MainWindow:CreateFolder("Main") -- Creates the folder(U will put here your buttons,etc)
local autoStatFolder = MainWindow:CreateFolder("Auto Stat")
local autoSpinFolder = MainWindow:CreateFolder("Auto Spin")

local function autoTrain()
  while _autoTrain do
      spawn(function ()
        game:GetService("ReplicatedStorage").GymClick:InvokeServer()
      end)
      wait(0.02)
  end
end

local function tptoCurrentQuest()
    spawn(function ()
        game:GetService("ReplicatedStorage").Package.Events.TeleportToQuest:InvokeServer()
    end)
end

local function autoFarm()
   spawn(function()
      while _autoFarm do
         local plrLevel
         char.Stats.Speed:Destroy()
         ---tp bypass, tptocurentquest, activation promt is gui so use getconnections() v:fire(mousebutton1click) also check how close that npc close and check its dialogue and then check what type of enemy and then tp to that enemy and attack and check level reepeat.
        end
   end) 
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

local function autoSpin()
   spawn(function ()
    local args = {
        [1] = _typeOfspin
     }
       while _autoSpin do
           for i = 0, tonumber(_CurrentSpinAMT), 1 do 
             game:GetService("ReplicatedStorage").Package.Events.QuirkSpin:InvokeServer(unpack(args))
             print(i)
             if player.PlayerGui.HUD.Display.QuirkMastery.Quirk.Text == _desiredQuirk then
                 _autoSpin = false;
                 print("u got what u want")
                 sendMesssage("you got the quirk: ".._desiredQuirk.." enjoy bbg", 500)
                 break
             end
             if i == _CurrentSpinAMT then
                sendMesssage("you have ran out of spins and dont have the quirk you wanted L", 30)
             end
             end
           end
           wait(.4)
   end)
end

local function autoAttack()
    spawn(function()
       while _autoAttack do
        for i = 1, 5 do
            game:GetService("ReplicatedStorage").Package.Events.Combat:FireServer(i)
            print(i)
            wait(.5)
        end
        wait(0.4)
       end
    end)
end

local function autoRedeem()
  spawn(function()
        wait()
        for i,v in pairs(game:GetService("ReplicatedStorage").Package.Codes:GetChildren()) do
        game:GetService("ReplicatedStorage").Package.Events.RedeemCode:InvokeServer(v.Name)
       end
  end)
end

local function increaseStrength()
   spawn(function ()
    local args = {
        [1] = "Strength",
        [2] = "1"
    }
       while _IncreaseStrengthStat do
        game:GetService("ReplicatedStorage").Package.Events.Point:InvokeServer(unpack(args))
       wait(0.1)
      end
   end)
end

local function increaseSpeed()
    spawn(function ()
     local args = {
         [1] = "Speed",
         [2] = "1"
     }
        while _IncreaseSpeedStat do
         game:GetService("ReplicatedStorage").Package.Events.Point:InvokeServer(unpack(args))
        wait(0.1)
       end
    end)
 end

 local function increaseEnergy()
    spawn(function ()
     local args = {
         [1] = "Energy",
         [2] = "1"
     }
        while _IncreaseEnergyStat do
         game:GetService("ReplicatedStorage").Package.Events.Point:InvokeServer(unpack(args))
        wait(0.1)
       end
    end)
 end

 
 local function increaseDefense()
    spawn(function ()
     local args = {
         [1] = "Defense",
         [2] = "1"
     }
        while _IncreaseDefenseStat do
         game:GetService("ReplicatedStorage").Package.Events.Point:InvokeServer(unpack(args))
        wait(0.1)
       end
    end)
 end

 local function tptogYm ()
     spawn(function ()
        game:GetService("ReplicatedStorage").Package.Events.TeleportToGym:InvokeServer()
     end)
 end


MainFolder:Toggle("Auto Attack",function(bool)
    _autoAttack =  bool
    autoAttack()
end)

if game.PlaceId == 7007601294 then
    MainFolder:Toggle("Auto Train GYM", function (bool)
        _autoTrain = bool
        autoTrain()
    end)
end

MainFolder:Button("Teleport to quest", function ()
    tptoCurrentQuest()
end)

autoStatFolder:Toggle("Strength", function(bool)
   _IncreaseStrengthStat = bool
   increaseStrength()
end)

autoStatFolder:Toggle("Speed", function(bool)
    _IncreaseSpeedStat = bool
    increaseSpeed()
 end)

 autoStatFolder:Toggle("Energy", function(bool)
    _IncreaseEnergyStat = bool
    increaseEnergy()
 end)

 autoStatFolder:Toggle("Defense", function(bool)
    _IncreaseDefenseStat = bool
    increaseDefense()
 end)

 autoSpinFolder:Slider("Spins you have",{
    min = 0; -- min value of the slider
    max = 1000; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    _CurrentSpinAMT = value
end)

autoSpinFolder:Dropdown("Rarity",{"Common","Rare","Epic", "Legendary"},true,function(rarity) --true/false, replaces the current title "Dropdown" with the option that t
    _typeOfspin = rarity;
end)

autoSpinFolder:Dropdown("Quirk you want", {"Ice", "Invisibility", "Shock Absorption", "Super Regeneration", "Super Strength", "Engine", "Zero Gravity", "Air Cannon", "Explosion","Dark Shadow","Dark Shadow","Phoenix","Permeation","Electrification","One For All", "Hell Flame","Cremation", "Fierce Wings", "Overhaul", "Half Hot Half Cold"}, true, function(quirk)
  _desiredQuirk = quirk
end)


autoSpinFolder:Toggle("Auto Spin", function(value)
   _autoSpin = value
   autoSpin()
end)

MainFolder:Button("Redeem codes", function ()
    autoRedeem()
end)

MainFolder:Button("Teleport to GYM", function ()
    tptogYm()
end)



