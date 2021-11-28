local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.6,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

getgenv()._autoAttack = false;
getgenv()._autoDodge = false;
getgenv()._autoFarm = true;



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

local function getLevel()
   return player.PlayerGui.HUD.Bottom.Stats.LVL.Val.Text
end

local function getNeededNPC() 
   level = getLevel()
   print(level)
   for i,v in pairs(game:GetService("Workspace").Live:GetChildren()) do
      local fake = string.gsub(v.Name, "%l", "")
      local fake2 = string.gsub(fake, "%u", "")
      local fake3 = string.gsub(fake2, "%c", "")
      local fake4 = string.gsub(fake3, "%p", "")
      local real = string.gsub(fake4, "%s", "")
      print(real)
        if real == level then
            print("found: "..v.Name)
            return v
        end
   end
end

local function teleport(object)
   ts:Create(hrp, tweenInfo, {CFrame = object.CFrame}):Play()
end

local function attack()
   succ,err = pcall(function()
       function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end

       local args = {
           [1] = {
               [1] = "md"
           },
           [2] = CFrame.new(hrp.Position),
           [3] = getNil("InputObject"),
           [4] = false
       }
           
       game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Input:FireServer(unpack(args))
   end)
   if err then print(err) else print("good") end
end

local function autoAttack()
  spawn(function()
      while _autoAttack do    
       local succ, err = pcall(function()
        function getNil(name,class) for _,v in pairs(getnilinstances())do if v.ClassName==class and v.Name==name then return v;end end end

           local args = {
               [1] = {
                   [1] = "md"
               },
               [2] = CFrame.new(hrp.Position),
               [3] = getNil("InputObject"),
               [4] = false
           }
               
           game:GetService("Players").LocalPlayer.Backpack.ServerTraits.Input:FireServer(unpack(args))
       end)
       
       if succ then
           print("W")
           else
               print(err)
       end
       wait(.1)
      end
  end)
end


local function autoFarm() 
   print'called'
   spawn(function()
       print'spawned'
     while _autoFarm == true do
       print("on")
         local npc  = getNeededNPC()
         if not npc then
             sendMesssage("no nmpc" , 1)
         end
        if npc then
           succ, err = pcall(function()
               if npc.Humanoid.Health ~= 0 then
                   humanoid:ChangeState(11)
                   print'notdead'
                     repeat wait(math.random(0.01, 1))
                       print('tpd')
                       ts:Create(hrp, tweenInfo, {CFrame = CFrame.new(npc.HumanoidRootPart.Position + Vector3.new(3,3,3), npc.Head.Position)}):Play()
                       m1click()                        
                     until npc.Humanoid.Health == 0
                     print'dead'
                     autoFarm2()
                 end
            end)
            if err then print(err) else print("succ") end
        end
        wait()
     end
 end)
end
autoFarm()
local function autoFarm2() 
   print'called'
   spawn(function()
       print'spawned'
     while _autoFarm == true do
       print("on")
         local npc  = getNeededNPC()
        succ, err = pcall(function()
           if npc.Humanoid.Health ~= 0 then
               humanoid:ChangeState(11)
               print'notdead'
                 repeat wait()
                   print('tpd')
                   ts:Create(hrp, tweenInfo, {CFrame = CFrame.new(npc.HumanoidRootPart.Position + Vector3.new(3,3,3), npc.Head.Position)}):Play()
                   while wait(.3) do attack() end 
                 until npc.Humanoid.Health == 0
                 print'dead'
                 autoFarm()
             end
        end)
        if err then print(err) else print("succ") end
        wait()
     end
 end)
end

--autoFarm()



sendMesssage("Script loaded, welcome, ".. player.Name.."!", 3)
sendMesssage("Made by wulu#0827", 3)

