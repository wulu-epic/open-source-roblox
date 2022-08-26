local PathfindingService = game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local path = PathfindingService:CreatePath({
	AgentCanJump = true
});
local player = Players.LocalPlayer;
local character = player.Character;
local humanoid = character:WaitForChild("Humanoid");
local utils = {};
utils.__index = utils;
function utils.new()
	local self = {};
	return setmetatable(self, utils);
end;
function utils:pathfind(destination)
	local function followPath()
		local human = game.Players.LocalPlayer.Character.Humanoid;
		local Body = game.Players.LocalPlayer.Character.Torso or game.Players.LocalPlayer.Character.HumanoidRootPart;
		local Destination = destination;
		local path = (game:GetService("PathfindingService")):CreatePath();
		path:ComputeAsync(Body.Position, Destination);
		if path.Status == Enum.PathStatus.Success then
			local wayPoints = path:GetWaypoints();
			for i = 1, #wayPoints do
				local point = wayPoints[i];
				human:MoveTo(point.Position);
				local success = human.MoveToFinished:Wait();
				if point.Action == Enum.PathWaypointAction.Jump then
					human.WalkSpeed = 0;
					wait(0);
					human.WalkSpeed = 16;
					human.Jump = true;
				end;
				if not success then
					print("trying again");
					human.Jump = true;
					human:MoveTo(point.Position);
					if not human.MoveToFinished:Wait() then
						break;
					end;
				end;
			end;
		end;
	end;
	followPath(destination);
end;

function utils:consoleUI()
	local screengui = Instance.new("ScreenGui", game.CoreGui);
	local frame = Instance.new("ScrollingFrame", screengui);
	frame.Position = UDim2.new(0, 0, 0, 0);
	frame.Size = UDim2.new(0, 0, 0, 0);
	frame.Draggable = true;
	frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18);
	frame.AutomaticCanvasSize = Enum.AutomaticSize.XY;
	frame.Visible = true;
	frame.ScrollingEnabled = true;
	local exit = Instance.new("TextButton", frame);
	exit.Position = UDim2.new(1, 0, 1, 0);
	exit.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
	exit.TextColor3 = Color3.new(1, 1, 1);
	exit.Text = "X";
	exit.Size = UDim2.new(0, 0, 0, 0);
	exit.MouseButton1Click:Connect(function()
		screengui:Destroy();
	end);
	local list = Instance.new("UIListLayout", frame);
	list.FillDirection = Enum.FillDirection.Vertical;
	local TIME_ZONE = 1;
	local date = os.date("!*t");
	local hour = (date.hour + TIME_ZONE) % 24;
	local ampm = hour < 12 and "AM" or "PM";
	local timestamp = string.format("%02i:%02i %s", (hour - 1) % 12 + 1, date.min, ampm);
	function output(txt, typ)
		local txtlabel = Instance.new("TextLabel", frame);
		txtlabel.Size = UDim2.new(1, 0, 0, 0);
		if typ == 1 then
			txtlabel.TextColor3 = Color3.fromRGB(255, 255, 255);
		end;
		if typ == 2 then
			txtlabel.TextColor3 = Color3.fromRGB(255, 0, 0);
		end;
		if typ == 3 then
			txtlabel.TextColor3 = Color3.fromRGB(0, 255, 0);
		end;
		txtlabel.BackgroundTransparency = 1;
		txtlabel.TextXAlignment = Enum.TextXAlignment.Left;
		txtlabel.Text = timestamp .. ": " .. txt;
		txtlabel.Size = 34;
	end;
	local old;
	old = hookfunction(print, function(...)
		local args = {
			...
		};
		output(args[1], 1);
		return old(unpack(args));
	end);
	local old3;
	old2 = hookfunction(error, function(...)
		local args = {
			...
		};
		output(args[1], 2);
		return old2(unpack(args));
	end);
	local old3;
	old3 = hookfunction(warn, function(...)
		local args = {
			...
		};
		output(args[1], 3);
		return old3(unpack(args));
	end);
end;

function utils:test()
	print("utils initalized!");
end;

function utils:findClosestAlivePlayer()
	local old = nil;
	local c = nil;
	for i, v in pairs(game.Players:GetChildren()) do
		if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character ~= character then
			if old ~= nil and old.magntiude < ((v.Character:FindFirstChild("HumanoidRootPart")).Position - hrp.Position).magntiude then
				old = (v.Character:FindFirstChild("HumanoidRootPart")).Position - hrp.Position;
				local c = v.Character:FindFirstChild("HumanoidRootPart");
			elseif old.magntiude < 200 then
				old = (v.Character:FindFirstChild("HumanoidRootPart")).Position - hrp.Position;
				local c = v.Character:FindFirstChild("HumanoidRootPart");
			end;
		end;
	end;
	print(c);
	return old;
end;
return utils;
