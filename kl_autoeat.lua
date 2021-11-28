local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local vim = game:GetService("VirtualInputManager")


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

local function click(a)
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,true,a,1)
    wait()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(a.AbsolutePosition.X+a.AbsoluteSize.X/2,a.AbsolutePosition.Y+50,0,false,a,1)
end

while enabled do
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
               click(player.PlayerGui.EatFruitBecky.Dialogue.Accept)
            end
        end
    end
end
