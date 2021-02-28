-- Player Proc Gen Service
-- Fay
-- February 27, 2021



local PlayerProcGenService = {Client = {}}
local worldService
local worldOffset
local worldChunkSize

local genCooldown = 5
local playerChunkSpawnRadius = 10

function PlayerProcGenService:Start()
	worldService = self.Services.WorldService
    worldOffset = worldService:GetWorldOffset()
    worldChunkSize = worldService:GetChunkSize()
    while wait(genCooldown) do
        local plyList = game.Players:GetPlayers()
        for i=1,#plyList do
            local ply = plyList[i]
            if ply.Character ~= nil then
                local char = ply.Character
                local plyPos = char:FindFirstChild("HumanoidRootPart").Position
                local plyFloor = math.floor(plyPos.Y/worldOffset)
                if plyFloor > 0 then
                    local curChunkX = math.floor(math.floor(plyPos.X)/worldChunkSize)
                    local curChunkY = math.floor(math.floor(plyPos.Z)/worldChunkSize)
                    for x = curChunkX-playerChunkSpawnRadius, curChunkX+playerChunkSpawnRadius do
                        for y = curChunkY-playerChunkSpawnRadius, curChunkY+playerChunkSpawnRadius do
                            worldService:GenerateWorld(plyFloor, x, y)
                        end
                    end
                end
            end
        end
    end
end


function PlayerProcGenService:Init()
	
end


return PlayerProcGenService