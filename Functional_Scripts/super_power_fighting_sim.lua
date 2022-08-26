local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

getgenv()._autoQuest = false;

getgenv()._autoFistMultiplierTP = true;

getgenv()._autoStrength = false;
getgenv()._autoPhsychic = false;
getgenv()._autoEndurace = false;
getgenv()._autoSpeed = false;

local function autoSpeed()
  spawn(function()
      while _autoSpeed do
       local args = {
           [1] = "Speed"
       }
        game:GetService("ReplicatedStorage").Events.Train:FireServer(unpack(args))
        wait()
      end
  end)
end

local function getStrength()
   return player.leaderstats.extrastats.TotalStrength.Value
end

local function getEndurance()
    return player.leaderstats.extrastats.TotalEndurance.Value
end

local function getPhyschic()
    return player.leaderstats.extrastats.TotalPsychic.Value
end

local function getSpeed()
    return player.leaderstats.extrastats.TotalSpeed.Value
end

local function autoQuest()
  spawn(function()
      while _autoQuest do
       local args = {
           [1] = "GamesReborn"
       }

       game:GetService("ReplicatedStorage").Events.Quest:FireServer(unpack(args))
       wait(3)
      end
  end)
end

local function autoFistMultiplierTP()
    spawn(function()
        while _autoFistMultiplierTP do
            local strength
            strength = tostring(getStrength())
            for i,v in pairs(game:GetService("Workspace").TrainingAreaHitbox.Strength:GetDescendants()) do
                if v:IsA("TextLabel") then
                    if string.match(v.Text, "Strength Required") then
                        local fake = string.gsub(v.Text, "%l", "")
                        local fake2 = string.gsub(fake, "%u", "")
                        local real = string.gsub(fake2, "%c", "")
                        if real == strength then
                            print("foubnd")
                        end
                    end
                end
                wait()
            end
        end
    end)
end

autoFistMultiplierTP()

local function autoStrength()
  spawn(function()
      while _autoStrength do
       local args = {
           [1] = "Strength"
       }
        game:GetService("ReplicatedStorage").Events.Train:FireServer(unpack(args))
        wait()
      end
  end)
end

local function autoPhsychic()
  spawn(function()
      while _autoPhsychic do
       local args = {
           [1] = "Psychic"
       }
        game:GetService("ReplicatedStorage").Events.Train:FireServer(unpack(args))
        wait()
      end
  end)
end

local function autoEndurance()
    spawn(function()

        while _autoEndurace do
         local args = {
            [1] = "Endurance"
         }
          game:GetService("ReplicatedStorage").Events.Train:FireServer(unpack(args))
          wait()
        end

    end)
end

local function collectChests()
  spawn(function()
    local oldpos = hrp.Position 
    local chests = {}
    for i,v in pairs(workspace.Chests:GetChildren()) do
        table.insert(chests, v)
    end
    wait(.2)

    for g,x in pairs(chests) do
        print(x)
        succ,err = pcall(function()
            hrp.CFrame = x.TouchPart.CFrame
        end)
        if succ then print("nice") else print(err) end
        wait(.4)
    end

    hrp.Position = oldpos
  end)
end

local function collectSpiritPumpkins()
  spawn(function()
    for i,v in pairs(game.Workspace.EvilPumpkins:GetChildren()) do
        local hrp2 = game.Players.LocalPlayer.Character.HumanoidRootPart
        wait(.1)
        fireclickdetector(v.ClickDetector, 150)
        hrp2.CFrame = v.CFrame
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
      })
   end)
end

local function m1click()
   vim:SendMouseButtonEvent(753,700,0,true,game,0)
   wait()
   vim:SendMouseButtonEvent(753,700,0,false,game,0)
end

local function pressKey(key)
   vim:SendKeyEvent(true, key, false, game)
   wait()
   vim:SendKeyEvent(false, key, false, game)
end