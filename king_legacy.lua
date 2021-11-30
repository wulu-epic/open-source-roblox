local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

getgenv()._fruitName = "";

getgenv()._autoEatFruit = false;

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

local function teleport(object)
    ts:Create(hrp, tweenInfo, {CFrame = object.CFrame}):Play()
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

local function clickinstance(a)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,true,a,1)
    wait()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,false,a,1)
end

local function autoEat()
    spawn(function()
        while _autoEatFruit do
            wait(0.1)
            for i,v in pairs(player.Backpack:GetDescendants()) do
                if v:IsA("Tool") then
                    print("found tool")
                    if v.Name == fruitName then
                        print("found fruit")
                        humanoid:EquipTool(v)
                        for x,g in pairs(character:GetChildren()) do
                            if g:IsA("Tool") then
                                if g.Name == fruitName then
                                    g:Activate()
                                    break
                                 end
                             end
                        end
                        wait(1.4)
                        clickinstance(player.PlayerGui.EatFruitBecky.Dialogue.Accept)
                     end
                 end
             end
         end
    end)    
end