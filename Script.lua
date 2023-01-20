if getgenv().Activated == true then
    print('Script Already Executed!')
    return
end
getgenv().Activated = true
local Tools = loadstring(game:HttpGet('https://raw.githubusercontent.com/AltLexon/Tools/main/Tools.lua'))()
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local Character = Tools:GetCharacter()
local ladderName = Players.LocalPlayer.Name..'_ladder'
local Humanoid = Character.Humanoid

local function equipTool(name)
    Character = Tools:GetCharacter()
    
    local Tool = Players.LocalPlayer.Backpack:FindFirstChild(name)
    
    if Tool ~= nil and name ~= nil then
        Tool.Parent = Character
    end
end

local function getLadder()
    local ladder = Tools:FindPartByNameAndClass(ladderName, 'Model')
    Character = Tools:GetCharacter()
    
    if ladder ~= nil then
        local OldCFrame = Character.HumanoidRootPart.CFrame
        
        equipTool('Ladder')
        
        Character.HumanoidRootPart.CFrame = ladder.PrimaryPart.CFrame
        
        task.wait(0.2)
        
        Character.Ladder.Event:FireServer('Destroy', workspace.playerPlaced[ladderName])
        
        Character.HumanoidRootPart.CFrame = OldCFrame
    end

end

local function tpToLadder()
    local ladder = Tools:FindPartByNameAndClass(ladderName, 'Model')
    Character = Tools:GetCharacter()
    
    if ladder ~= nil then
        Character.HumanoidRootPart.CFrame = ladder.PrimaryPart.CFrame
    end
end

getgenv().Jump = true
local function EnableJump()
    Character = Tools:GetCharacter()
    local old;
    old = hookmetamethod(Character, '__index', function(self, key)
        if tostring(self) == 'Humanoid' and key == 'JumpPower' then
            return 0
        end
        return old(self, key)
    end)
    if Humanoid then
        if getgenv().Jump == false then
            Humanoid.JumpPower = 50
            getgenv().Jump = true
        else
            Humanoid.JumpPower = 0
            getgenv().Jump = false
        end
    end
end

UserInputService.InputBegan:Connect(function(int, gameProcessedEvent)
    if gameProcessedEvent then return end
    if int.KeyCode == Enum.KeyCode.K then
        EnableJump()
    elseif int.KeyCode == Enum.KeyCode.L then
        getLadder()
    elseif int.KeyCode == Enum.KeyCode.M then
        tpToLadder()
    end
end)

print('K: Enable Jump Toggle\nL: Get Ladder\nM: Tp To Ladder')
