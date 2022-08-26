local PathfindingService = game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");

local path = PathfindingService:CreatePath();

local player = Players.LocalPlayer;
local character = player.Character;
local humanoid = character:WaitForChild("Humanoid");

local utils = {}
utils.__index = utils;

function utils.new()
    local self = {}
    return setmetatable(self, utils);
end

function utils:pathfind(destination)
    local waypoints;
	local nextWaypointIndex;
	local reachedConnection;
	local blockedConnection;

	local function followPath()
		local success, errorMessage = pcall(function()
			path:ComputeAsync(character.PrimaryPart.Position, destination);
		end);
		if success and path.Status == Enum.PathStatus.Success then
			waypoints = path:GetWaypoints();
			blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
				if blockedWaypointIndex >= nextWaypointIndex then
					blockedConnection:Disconnect();
					followPath(destination);
				end;
			end);
			if not reachedConnection then
				reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
					if reached and nextWaypointIndex < (#waypoints) then
						nextWaypointIndex = nextWaypointIndex + 1;
						humanoid:MoveTo(waypoints[nextWaypointIndex].Position);
					else
						reachedConnection:Disconnect();
						blockedConnection:Disconnect();
					end;
				end);
			end;
			nextWaypointIndex = 2;
			humanoid:MoveTo(waypoints[nextWaypointIndex].Position);
		else
			warn("Path not computed!", errorMessage);
		end;
	end;
end

function utils:consoleUI()
	local screengui = Instance.new('ScreenGui', game.CoreGui)
	local frame = Instance.new('ScrollingFrame',screengui)
	frame.Position = UDim2.new(.3,0,0.3,0)
	frame.Size = UDim2.new(0.3,0,.3,0)
	frame.Draggable = true;
	frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
	frame.Visible = true
	
	local list = Instance.new('UIListLayout', frame)
	list.FillDirection = Enum.FillDirection.Vertical;
	

	function output(txt)
		local txtlabel = Instance.new("TextLabel", frame)
		txtlabel.Size = UDim2.new(0.05,0,0.05,0)
		txtlabel.TextColor3 = Color3.fromRGB(255,255,255)
		txtlabel.BackgroundTransparency=1;
		txtlabel.TextScaled = true;
		txtlabel.Text = txt;
	end

	local old ;
	old = hookfunction(print, function(...)
		local args = {...}
		frame.CanvasSize = list.AbsoluteContentSize;
		output(args[1])
		return old(unpack(args))
	end)

	local old3 ;
	old2 = hookfunction(error, function(...)
		local args = {...}
		frame.CanvasSize = list.AbsoluteContentSize;
		output(args[1])
		return old2(unpack(args))
	end)

	local old3 ;
	old3 = hookfunction(warn, function(...)
		local args = {...}
		frame.CanvasSize = list.AbsoluteContentSize;
		output(args[1])
		return old3(unpack(args))
	end)
end

function utils:test()
    print("utils initalized!")
end

return utils;