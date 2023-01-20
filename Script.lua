local Tools = loadstring(game:HttpGet('https://raw.githubusercontent.com/AltLexon/Tools/main/Tools.lua'))()
local Players = game:GetService('Players')

local Character = Tools:GetCharacter()

local ladderName = Players.LocalPlayer.Name..'_ladder'

local function equipTool(name)
    local Tool = Players.LocalPlayer.Backpack:FindFirstChild(name)
    if Tool ~= nil and name ~= nil then
        Tool.Parent = Character
    end
end

local function getLadder()
    local ladder = Tools:FindPartByNameAndClass(ladderName, 'Model')
    equipTool('Ladder')
    
    if ladder ~= nil then
        local OldCFrame = Character.HumanoidRootPart.CFrame
        
        Character.HumanoidRootPart.CFrame = ladder.PrimaryPart.CFrame
        task.wait(0.2)
        Character.Ladder.Event:FireServer('Destroy', workspace.playerPlaced[ladderName])
        
        Character.HumanoidRootPart.CFrame = OldCFrame
    end

end

getLadder()
