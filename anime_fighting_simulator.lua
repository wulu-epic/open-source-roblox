local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

--// includes auto usage + auto quest wow im so nice B:
getgenv()._autoFarm = false;

-- // COLLECTING SHIT
getgenv()._AutoCollectChakraCrates = false;
getgenv()._autoCollectDf = false;

--// AUTO STAT
getgenv()._autoChakraStat = false;
getgenv()._autoStrengthStat = false;
getgenv()._autoSpeedStat = false;
getgenv()._autoAgilityStat = false;
getgenv()._autoDurabilityStat = false;
getgenv()._farmAllStat = false;

--// AUTO USE
getgenv()._autoSword = false;
getgenv()._autoChakra = false;
getgenv()._autoStrength= false;
getgenv()._autoDurability = false;
getgenv()._autoAgility = false;

--// PLAYER
getgenv()._noclip = false;
getgenv()._killPlayer = false;

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

sendMesssage("Script loaded, welcome, ".. player.Name.."!", 3)
sendMesssage("Made by wulu#0827", 3)

for i, v in next, getconnections(game.Players.LocalPlayer.Idled) do
    v:Disable();
end;
  
local function noclip()
    spawn(function()
      while _noclip do
        humanoid:ChangeState(11)
        wait()
      end
      if not _noclip then
        humanoid:ChangeState(11)
      end
    end)
end

local function redeemCodes()
  spawn(function()
    local codes = {"300ksubstigretv", "emperadorwapo", "sub2defildplays", "2millionsingroup!","1billionvisits!","Emperadorstar","Frangonewcode","kelvin600k","secretrazorfishcode", "elemperador100k!", "bigboi100k", "Mrrhino50k", "Defildpromo","anotherbugfix", "medtw50k", "thanksbugfixes", "subtodefildplays","NNG","sub2hakimbo", "defildstream", "emperadorsubs","Defildyen","GGgames40k","L3NI", "frango2yen", "defild700k","Tigre200k", "n1colas2sub","tigretvsub","subfrango", "Sub2tanqr", "sub2tplanetmilo", "subtomrrhino", "sub2razorfishgaming ","subtokelvingts"}

    for i,v in pairs(codes) do
        game:GetService("ReplicatedStorage").RSPackage.Events.GeneralFunction:InvokeServer("Code", v)
        wait(.05)
    end
    sendMesssage("finished redeeming all codes", 5)
  end)
end

local function grabChikraCrates()
    spawn(function()
        while _AutoCollectChakraCrates do
            for i,v in pairs(workspace.MouseIgnore:GetDescendants()) do
                if v.Name == "ChikaraCrate" then
                    hrp.Position = v.ClickBox.Position
                    wait(0.02)
                    fireclickdetector(v.ClickBox.ClickDetector, 3)
                end
                wait(0.3)
            end
        end
    end)
end