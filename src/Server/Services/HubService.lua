-- Hub Service
-- Fay
-- February 27, 2021



local HubService = {Client = {}}

local netMsg
local worldServ

function HubService:Start()
	netMsg = self.Services.NetMessageService
    netMsg:DeclareServerMessage("findPlanet", function(ply, args)
        worldServ = self.Services.WorldService
        local xSpawnChunk = math.random(-10, 10)
        local ySpawnChunk = math.random(-10, 10)
        local curChunkSize = worldServ:GetChunkSize()
        local curBaseHeight = worldServ:GetWorldOffset()
        local floorIndex = worldServ:CreateNewWorld(xSpawnChunk, ySpawnChunk)
        if ply.Character ~= nil then
            ply.Character:MoveTo(Vector3.new(xSpawnChunk*curChunkSize, (floorIndex*curBaseHeight) + 50, ySpawnChunk*curChunkSize))
            netMsg:SendMessageToClient(ply, "ChangeAtmosphere", worldServ:GetWorldTable(floorIndex))
        end
    end)
end


function HubService:Init()
	
end


return HubService