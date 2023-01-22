--  Arsenal
-- Credit ·˚ ༘ゆきお˚₊· ͟͟͞➳❥ ( Yukio )



local DarkraiX = loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Kavo-Ui/main/Darkrai%20Ui", true))()
local Library = DarkraiX:Window("X Project\t","","",Enum.KeyCode.RightControl);
Tab1 = Library:Tab("Main")
Tab1:Seperator("Aimbot")



local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")
local target = false
local RunService = game:GetService("RunService")
 


Tab1:Toggle("Silent Aim",true,function(ATF)
    _G.Silentaim = ATF
end)

Tab1:Slider("FOV",1,1000,200,function(value)
    _G.Fov = value
end)



Tab1:Toggle("ESP Players",false,function(ATF)
	_G.ESP = ATF
end)


Number = math.random(1,1000000)
        function UpdatePlayer()
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                pcall(function()
                    if v.Character then
                        if _G.ESP then
                            if v.Character.Head and not v.Character.Head:FindFirstChild("PlayerESP"..Number) then
                                local Bb = Instance.new("BillboardGui", v.Character.Head)
                                Bb.Name = "PlayerESP"..Number
                                Bb.ExtentsOffset = Vector3.new(0, 1, 0)
                                Bb.Size = UDim2.new(1, 200, 1, 30)
                                Bb.Adornee = v.Character.Head
                                Bb.AlwaysOnTop = true
                                local Textlb = Instance.new("TextLabel", Bb)
                                Textlb.Font = "GothamBold"
                                Textlb.FontSize = "Size14"
                                Textlb.Text = v.Name.."\n"..math.round((v.Character.Head.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                                Textlb.Size = UDim2.new(1,0,1,0)
                                Textlb.BackgroundTransparency = 1
                                Textlb.TextStrokeTransparency = 0.5
                                if v.Team == game:GetService("Players").LocalPlayer.Team then
                                    Textlb.TextColor3 = Color3.new(0, 255, 0)
                                else
                                    Textlb.TextColor3 = Color3.new(0, 0, 204)
                                end
                            else
                                v.Character.Head["PlayerESP"..Number].TextLabel.Text = v.Name.."\n"..math.round((v.Character.Head.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude/3).." m."
                            end
                        else
                            if v.Character.Head:FindFirstChild("PlayerESP"..Number) then
                                v.Character.Head:FindFirstChild("PlayerESP"..Number):Destroy()
                            end
                        end
                    end
                end)
            end
        end


local features = {
	silentaim = _G.Silentaim;
	fov = _G.Fov;
	}

function getnearest()
local nearestmagnitude = math.huge
local nearestenemy = nil
local vector = nil
for i,v in next, Players:GetChildren() do
if v ~= Players.LocalPlayer then
if v.Character and  v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
local vector, onScreen = Camera:WorldToScreenPoint(v.Character["HumanoidRootPart"].Position)
if onScreen then
local ray = Ray.new(
Camera.CFrame.p,
(v.Character["Head"].Position-Camera.CFrame.p).unit*500
)
local ignore = {
LocalPlayer.Character,
}
local hit,position,normal=workspace:FindPartOnRayWithIgnoreList(ray,ignore)
if hit and hit:FindFirstAncestorOfClass("Model") and Players:FindFirstChild(hit:FindFirstAncestorOfClass("Model").Name)then
local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
if magnitude < nearestmagnitude and magnitude <= features["fov"] then
nearestenemy = v
nearestmagnitude = magnitude
end
end
end
end
end
end
return nearestenemy
end
 
 
local meta = getrawmetatable(game)
setreadonly(meta, false)
local oldNamecall = meta.__namecall
meta.__namecall = newcclosure(function(...)
local method = getnamecallmethod()
local args = {...}
if string.find(method,'Ray') then
if target then
args[2] = Ray.new(workspace.CurrentCamera.CFrame.Position, (target + Vector3.new(0,(workspace.CurrentCamera.CFrame.Position-target).Magnitude/500,0) - workspace.CurrentCamera.CFrame.Position).unit * 500)
end
end
return oldNamecall(unpack(args))
end)
 
 
RunService:BindToRenderStep("silentaim",1,function()
if UserInputService:IsMouseButtonPressed(0) and features["silentaim"] and Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") and Players.LocalPlayer.Character.Humanoid.Health > 0 then
local enemy = getnearest()
if enemy and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 0 then                
local vector, onScreen = Camera:WorldToScreenPoint(enemy.Character["Head"].Position)
local magnitude = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
target = workspace[enemy.Name]["Head"].Position
end
else
target = nil
end
end)



Tab1:Seperator("Auto Kill")

local TOOLS = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        table.insert(TOOLS,v.Name)
    end
end

Tab1:Toggle("Auto Kill All Players ( Team )",false,function(ATF)
	_G.Kill_AllT = ATF
end)

Tab1:Toggle("Auto Kill All Players ( Solo )",false,function(ATF)
	_G.Kill_AllS = ATF
end)

local rdropdwon = Tab1:Dropdown("Select Weapon",TOOLS,function(t)
    SelectedWeapon = t
end)
function equip()
    pcall(function()
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == SelectedWeapon then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            end
        end
    end)
end

Tab1:Button("Refresh Weapon",function()
    rdropdwon:Clear()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            rdropdwon:Add(v.Name)
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            rdropdwon:Add(v.Name)
        end
    end
end)


Tab1:Slider("Kill Magnitude",1,1000,200,function(value)
    _G.Distance = value
end)

Tab1:Slider("Distace Y",1,50,2,function(value)
    _G.Distance_Y = value
end)
Tab1:Slider("Distace Z",1,-50,-5,function(value)
    _G.Distance_Z = value
end)

 

spawn(function()
	while wait() do
		if _G.Kill_AllT then
			pcall(function()
				repeat game:GetService("RunService").Heartbeat:wait()
                    equip()
					for i,y in pairs(game:GetService("Players"):GetChildren()) do
						for i,x in pairs(game:GetService("Workspace"):GetChildren()) do
							if y.Name == x.Name and y.Team ~= game.Players.LocalPlayer.Team and (x.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 200  then
							    if v.Humanoid.Health > 0 then
								   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.HumanoidRootPart.CFrame * CFrame.new(0,_G.Distance_Y,_G.Distance_Z)
								   game:GetService("VirtualUser"):CaptureController()
								   game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
								end
							end
						end
					end
				until not v.Parent or v.Humanoid.Health <= 0 or _G.Kill_All == false 
			end)
		end
	end
end)


spawn(function()
	while wait() do
		if _G.Kill_AllS then
			pcall(function()
				repeat game:GetService("RunService").Heartbeat:wait()
                    equip()
					for i,y in pairs(game:GetService("Players"):GetChildren()) do
						for i,x in pairs(game:GetService("Workspace"):GetChildren()) do
							if y.Name == x.Name and (x.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 200  then
								if v.Humanoid.Health > 0 then
								   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = x.HumanoidRootPart.CFrame * CFrame.new(0,_G.Distance_Y,_G.Distance_Z)
								   game:GetService("VirtualUser"):CaptureController()
								   game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
								end
							end
						end
					end
				until not v.Parent or v.Humanoid.Health <= 0 or _G.Kill_All == false 
			end)
		end
	end
end)


