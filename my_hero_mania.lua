 local player = game.Players.LocalPlayer
 local character = player.Character or player.CharacterAdded:Wait()
 local humanoid = character:WaitForChild("Humanoid")
 local hrp = character:WaitForChild("HumanoidRootPart")
 
 local ts = game:GetService("TweenService")
 local tweenInfo = TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)

 for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
    v:Disable();
 end;
 
 getgenv()._autoAttack = false;
 getgenv()._autoSpin = false;
 getgenv()._autoTrain = false;
 getgenv()._autoFarm = false;
 
 getgenv().autofarmStatus = "";

 getgenv()._IncreaseStrengthStat = false;
 getgenv()._IncreaseSpeedStat = false;
 getgenv()._IncreaseDefenseStat = false;
 getgenv()._IncreaseEnergyStat = false;
 
 getgenv()._typeOfspin = "";
 getgenv()._CurrentSpinAMT = nil
 getgenv()._desiredQuirk = "";
 
 getgenv().hasQuesst = false

 getgenv()._bypassAntiTP = true;
 getgenv().updateChar = true;
 

 getgenv()._hideName = false;

 local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

 local USERID = game.Players.LocalPlayer.UserId

 local MainWindow = library:CreateWindow("Main") -- Creates the window
 local MiscWindow = library:CreateWindow("Misc/Settings") 
 local PlayerWindow = library:CreateWindow("Local Player") 

 local MainFolder = MainWindow:CreateFolder("Main") -- Creates the folder(U will put here your buttons,etc)
 local autoStatFolder = MainWindow:CreateFolder("Auto Stat")
 local autoSpinFolder = MainWindow:CreateFolder("Auto Spin")
 local PlayerFolder = PlayerWindow:CreateFolder("Player shit")
 
 local Settings = MiscWindow:CreateFolder("Settings")

 local vim = game:GetService('VirtualInputManager')
 local virtualUser = game:GetService('VirtualUser')

 
 local function constantCharUpdate()
    spawn(function ()
        while updateChar do
            character = player.Character
            hrp = character.HumanoidRootPart
            wait()
        end
    end)
  end
  
  
 constantCharUpdate()


 Settings:Button("Destroy UI", function ()
    for i,v in pairs(game.CoreGui:GetDescendants()) do
        if v.Name == "HiI'mSexyDon'tTouchMePls" then
            v.Parent:Destroy()
        end
    end
 end)

 Settings:Button("Rejoin Game", function ()
   game:GetService("TeleportService"):Teleport(player, game.GameId)
 end)


 local function HideName()
     spawn(function ()
        while _hideName do
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v.Name == 'Pants' or v.ClassName == "Accessory" or v.Name == 'Shirt' or v.Name == 'Title' then
                     v:Destroy()
                end
            end
            wait(1)
        end
     end)
 end

 local function autoTrain()
    spawn(function ()
        while _autoTrain do
          game:GetService("ReplicatedStorage").GymClick:InvokeServer()
          wait(0.1)
        end
    end)
 end

 local function tptoCurrentQuest()
    spawn(function ()
        game:GetService("ReplicatedStorage").Package.Events.TeleportToQuest:InvokeServer()
    end)
end

 local function hasQuest()
    if player.PlayerGui.HUD.Frames.Quest.Visible == true then
        return true
    else
        return false
    end
 end

 local function m1click() 
    vim:SendMouseButtonEvent(753,700,0,true,game,0)
    wait()
    vim:SendMouseButtonEvent(753,700,0,false,game,0)
end



 local function autoquest()
    spawn(function ()
        wait()
        tptoCurrentQuest()
        wait(.1)
        for i,v in pairs(workspace.NPCs:GetDescendants()) do
            if v.Name == "QMark" then
             print("isA quest npc.")
                 if v.Parent.Parent.HumanoidRootPart then
                     print("has hrp")
                if (v.Parent.Parent.HumanoidRootPart.Position-hrp.Position).magnitude < 10 then
                 print("within dist.")
                   wait(0.1)

                   if character:FindFirstChild("Stats"):FindFirstChild("Speed") then
                     character:FindFirstChild("Stats"):FindFirstChild("Speed"):Destroy()     
                     print("destroyerd anticheat")
                   end   

                   hrp.Position = v.Parent.Parent.HumanoidRootPart.Position

                   m1click()
                   print("dialogue activate")
                   wait(0.3)
                   m1click()
                   print("click2")
                   wait(0.3)
                   m1click()
                   print("click2")
                   wait(0.3)
                   m1click()
                   print("click2")
                   wait(2)

                   vim:SendMouseButtonEvent(763,365,0,true,game,0)
                   wait()
                   vim:SendMouseButtonEvent(763,365,0,false,game,0)

                   print("yesclick")
                   wait(0.2)

                   m1click()
                end
              end
            end
        end
    end)
  end
 
 local function scanForNPCS()
 
     local plrLevel2 = string.gsub(player.PlayerGui.HUD.Display.Level.Text, "Lvl ", "")
     local plrLevel = tonumber(plrLevel2)
     
      if plrLevel <= 10 and plrLevel > 0 then
         print("thug")
          for i,v in pairs(workspace.Living:GetChildren()) do 
            if v.Name == "Thug" then 
                print(v.Parent)
                print(v.Humanoid.Health)
                return v.Humanoid;
            end
          end
      end
 
      if plrLevel >= 10 and plrLevel < 15 then
         print("criminal")
         for i,v in pairs(workspace.Living:GetChildren()) do 
           if v.Name == "Criminal" then 
            print(v.Parent)
            print(v.Humanoid)
            return v.Humanoid;
           end
         end
     end
 
     if plrLevel >= 15 and plrLevel < 40 then
         for i,v in pairs(workspace.Living:GetChildren()) do 
           if v.Name == "Weak Villain" then 
             print(v.Parent)
             print(v.Humanoid.Health)
             return v.Humanoid;
           end
         end
     end

     if plrLevel >= 40 and plrLevel < 75 then
        for i,v in pairs(workspace.Living:GetChildren()) do 
          if v.Name == "B-Rank Villains" then 
            print(v.Parent)
            print(v.Humanoid.Health)
            return v.Humanoid;
          end
        end
    end

    if plrLevel >= 75 and plrLevel < 105 then
        for i,v in pairs(workspace.Living:GetChildren()) do 
          if v.Name == "A-Rank Villains" then 
            print(v.Parent)
            print(v.Humanoid.Health)
            return v.Humanoid;
          end
        end
    end

    if plrLevel >= 105 and plrLevel < 115 then
        for i,v in pairs(workspace.Living:GetChildren()) do 
          if v.Name == "Six Eyes" then 
            print(v.Parent)
            print(v.Humanoid.Health)
            return v.Humanoid;
          end
        end
    end

    if plrLevel >= 115 and plrLevel < 125 then
        for i,v in pairs(workspace.Living:GetChildren()) do 
          if v.Name == "Eyelesses" then 
            print(v.Parent)
            print(v.Humanoid.Health)
            return v.Humanoid;
          end
        end
    end

    if plrLevel >= 125 then
        for i,v in pairs(workspace.Living:GetChildren()) do 
          if v.Name == "Eyelesses" then 
            print(v.Parent)
            print(v.Humanoid.Health)
            return v.Humanoid;
          end
        end
    end

end
 

local function actualAutoFarm()
    if humanoid.Health ~= 0 then
        repeat wait()
            character = player.Character
            hrp = character.HumanoidRootPart
    
            getgenv().autofarmStatus = "began"
            if character:FindFirstChild("Stats"):FindFirstChild("Speed") then
                character:FindFirstChild("Stats"):FindFirstChild("Speed"):Destroy()
            end
            getgenv().npc = scanForNPCS()
          if npc.Health ~=0 then 
               print("checks passed!")
               character = player.Character
               hrp = character.HumanoidRootPart
                if hasQuest()==false then
                    autoquest()
                    print(hasQuest())
                end
    
                wait(2*2)
    
                repeat wait()
                    character = player.Character
                    hrp = character.HumanoidRootPart
                    if character:FindFirstChild("Stats"):FindFirstChild("Speed") then
                        character:FindFirstChild("Stats"):FindFirstChild("Speed"):Destroy()
                    end
                    print("rip dat anticheat")
                    hrp.CFrame = npc.Parent.HumanoidRootPart.CFrame + Vector3.new(-3,-3,-3)
                    hrp.CFrame = CFrame.new(hrp.Position, npc.Parent.HumanoidRootPart.Position)
                    m1click()
                    print("attacking")
                    if npc.Health == 0 then
                        getgenv().autofarmStatus = "finished"
                    end
                until npc.Health == 0 
              end
        until npc.Health == 0
    end
    print("done")
end

 local function autoFarm()
    spawn(function()
          while _autoFarm do
              actualAutoFarm()
              if autofarmStatus == "finished" then
                  actualAutoFarm()
              end
              wait()
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
                  sendMesssage("you got the quirk: ".._desiredQuirk.." enjoy bbg", 9e9)
                  break
              end
              if i == _CurrentSpinAMT then
                 sendMesssage("you have ran out of spins and dont have the quirk you wanted L", 30)
                 break
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
 
  MainFolder:Toggle("Auto Farm",function(bool)
     _autoFarm = bool
     autoFarm()
 end)

 PlayerFolder:Toggle("Hide Name",function(bool)
    _hideName = bool
    HideName()
end)

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
 
 MainFolder:Button("Teleport to Gym", function ()
     tptogYm()
 end)

 