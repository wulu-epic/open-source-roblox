local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local ts = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(.1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
local vim = game:GetService('VirtualInputManager')

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "King Legacy, wulu#0827",
	Style = 6,
	SizeX = 500,
	SizeY = 350,
	Theme = "Dark",
	ColorOverrides = {
		MainFrame = Color3.fromRGB(27, 9, 9)
	}
})

local fruits = {
	"AlloFruit",
	"BarrierFruit",
	"BombFruit", 
	"BrachioFruit", 
	"BuddhaFruit", 
	"DarkFruit", 
	"DoughFruit", 
	"DragonFruit" , 
	"FlameFruit" , 
	"FoxFruit", 
	"GasFruit", 
	"GiraffeFruit", 
	"GravityFruit", 
	"GumFruit", 
	"HumanFruit", 
	"IceFruit", 
	"LeopardFruit", 
	"LightFruit", 
	"LoveFruit", 
	"MagmaFruit", 
	"OpFruit", 
	"PawFruit", 
	"PhoenixFruit", 
	"QuakeFruit" , 
	"RumbleFruit", 
	"SandFruit", 
	"ShadowFruit", 
	"SnowFruit", 
	"SpinFruit", 
	"SpinoFruit", 
	"SpiritFruit" , 
	"SpikeFruit", 
	"StringFruit", 
	"VenomFruit", 
	"WolfFruit"
}

local Farms = X.New({
	Title = "Farms"
})

local DevilFruit = X.New({
	Title = "Devil Fruits"
})

local Settings = X.New({
	Title = "Settings"
})

getgenv()._weaponName = ""
getgenv()._autoAttack = false;

getgenv()._fruitName = "";
getgenv()._pickupFruit  = false;
getgenv()._autoEatFruit = false;

getgenv()._fruit_toSnipe = "";
getgenv()._snipeFruit = false;


local weapons = {}

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

--actual script functions

local function getTools() 
  local unpacked = unpack(table)
  for i,v in pairs(player.Backpack:GetChildren()) do
      if v:IsA("Tool") then
          if unpacked ~= v.Name then
            table.insert(weapons, v.Name)
          end
      end
  end
end

local function hasQuest()
   if player.CurrentQuest.Value == "" then
	   return false
   else
	return true
   end
end

print(hasQuest())

local function requiredAmountofKills()
	if hasQuest() then
    	local progress = player.QuestProgress.Value
    	local requirement = string.match(player.CurrentQuest.Value, "%d+")
        local needed = tonumber(requirement) - tonumber(progress)
	end
	return needed	
end

local function autoEat()
    spawn(function()
        while _autoEatFruit do
            wait(0.1)
            for i,v in pairs(player.Backpack:GetChildren()) do
                    print("found tool")
					print(v.Name)
                    if v.Name == _fruitName then
                        print("found fruit")
                        humanoid:EquipTool(v)
						wait(0.1)
                        for x,g in pairs(character:GetChildren()) do
                            if g:IsA("Tool") then
                                if g.Name == _fruitName then
									sendMesssage("found tool in backpack")
                                    g:Activate()
									wait(1.4)
                                    clickinstance(player.PlayerGui:WaitForChild("EatFruitBecky").Dialogue.Accept)
                                    break
                                 end
                             end
                        end
                     end
                 end
         end
    end)    
end

local function pickupFruits()
    spawn(function()
        while _pickupFruit do
          for i,v in pairs(workspace:GetChildren()) do
              if v:IsA("Tool") then
                  v.Handle.Position = hrp.Position
              end
          end
          wait()
        end
    end)
  end


local function snipeFruit()
    spawn(function()
		while _snipeFruit do
            local args = {
                [1] = _fruit_toSnipe,
                [2] = true
            }
            
            game:GetService("ReplicatedStorage").Remotes.Functions.dfbeli:InvokeServer(unpack(args))
		 wait(.6)
		end
	end)
  end

--// ui shit

local fruitSelector = DevilFruit.Dropdown({
	Text = "Select a fruit",
	Callback = function(Value)
		_fruitName = Value
	end,
	Options = {
		
	},
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "For autoeat"
			})
		end
	}
})

fruitSelector:SetOptions(fruits)



local AutoEat = DevilFruit.Toggle({
	Text = "Auto Eat",
	Callback = function(Value)
		getgenv()._autoEatFruit = Value
        autoEat()
	end,
	Enabled = false
})

local fruitSniperSelector = DevilFruit.Dropdown({
	Text = "Select a fruit",
	Callback = function(Value)
		_fruit_toSnipe = Value
	end,
	Options = {
		
	},
	Menu = {
		Information = function(self)
			X.Banner({
				Text = "For auto blackmarket snipe"
			})
		end
	}
})

fruitSniperSelector:SetOptions(fruits)

local SnipeFruit = DevilFruit.Toggle({
	Text = "Auto Black Market Sniper",
	Callback = function(Value)
		getgenv()._snipeFruit = Value
        snipeFruit()
	end,
	Enabled = false
})

local AutoPickUp = DevilFruit.Toggle({
	Text = "Auto Pickup",
	Callback = function(Value)
		getgenv()._pickupFruit = Value
        pickupFruits()
	end,
	Enabled = false
})

