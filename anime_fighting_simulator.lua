local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/WetCheezit/Bracket-V2/main/src.lua"))()
local Window, MainGUI = Library:CreateWindow("Anime Fighting Simulator")

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("Settings")

local maingbx = Tab1:CreateGroupbox("Main", "Left")
local misc = Tab1:CreateGroupbox("Misc", "Right")

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

local function swordStat()
  spawn(function()
    pressKey(Enum.KeyCode.Four)
    wait()
    m1click()
  end)
end

local function chakraStat()
   spawn(function()
    pressKey(Enum.KeyCode.Three)
    wait()
    m1click()
   end)
end

local function strengthStat()
   spawn(function()
    pressKey(Enum.KeyCode.One)
    wait()
    m1click()
   end)
end

local function agilityStat()
   spawn(function()
       if not hrp.Position == Vector3.new(1,1,1) then
        hrp.CFrame = CFrame.new(Vector3.new(1,1,1))
        pressKey(Enum.KeyCode.Space)
       end
       hrp.CFrame = CFrame.new(Vector3.new(1,1,1))
       pressKey(Enum.KeyCode.Space)
   end)
end

local function durabilityStat()
    spawn(function()
      pressKey(Enum.KeyCode.Two)
      wait()
      m1click()
    end)
 end

 local function speedStat()
    spawn(function()
        hrp.CFrame = CFrame.new(Vector3.new(1,1,1))
        pressKey(Enum.KeyCode.W)
    end)
 end

local function m1click() 
    vim:SendMouseButtonEvent(753,700,0,true,game,0)
    wait()
    vim:SendMouseButtonEvent(753,700,0,false,game,0)
end

local function pressKey(key)
    vim:SendKeyEvent(true, key, false, game)
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
        wait()
    end
    sendMesssage("finished trying to redeeming all codes", 5)
  end)
end

local function grabChikraCrates()
    spawn(function()
        local oldpos = hrp.Position
        while _AutoCollectChakraCrates do
            for i,v in pairs(workspace.MouseIgnore:GetChildren()) do
                if v.Name == "ChikaraCrate" then
                    hrp.Position = v.ClickBox.Position
                    fireclickdetector(v.ClickBox.ClickDetector, 3)
                end
                wait(2)
            end
            if not _AutoCollectChakraCrates() then
                hrp.Position = oldpos
            end
            wait(2)
        end
    end)
end

local chikaraToggle = maingbx:CreateToggle("Grab chikara crates", function(state)
    _AutoCollectChakraCrates = state
    grabChikraCrates()
 end)
 
 local RedeemCodesButton = misc:CreateButton("Redeem all codes", function()
    print("Pressed")
    redeemCodes ()
    sendMesssage("started redeeming codes")
end)