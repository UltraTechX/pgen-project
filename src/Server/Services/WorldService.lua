-- World Service
-- Fay
-- February 27, 2021



local WorldService = {Client = {}}

local worldSlots = {}

local genCache = {}

local worldOffset = 2500
local chunkSize = 10
local chunkMaxHeight = 25
local initialPlayerSpawnRadius = 10

local function oneDimPerlinSeeded(givenSeed, seedDivisor, scalar)
    return ((math.abs(math.noise(givenSeed/math.sqrt(2)/seedDivisor)))+(math.abs(math.noise(givenSeed*math.sqrt(2)/seedDivisor))))*scalar
end

function WorldService:CreateNewWorld(spawnChunkX, spawnChunkY)
    local worldSeed = math.random(100000)
    local atmosphereColorSeed = math.abs(math.noise(worldSeed/11, worldSeed/23, worldSeed/7)*100000)
    local atmosphereDecaySeed = math.abs(math.noise(worldSeed/17, worldSeed/31, worldSeed/13)*100000)
    local atmR = math.clamp(oneDimPerlinSeeded(atmosphereColorSeed, 11, 100), 0, 100)
    local atmG = math.clamp(oneDimPerlinSeeded(atmosphereColorSeed, 17, 100), 0, 100)
    local atmB = math.clamp(oneDimPerlinSeeded(atmosphereColorSeed, 23, 100), 0, 100)
    local atmosphereColor = Color3.fromRGB(atmR, atmG, atmB)
    atmR = math.clamp(oneDimPerlinSeeded(atmosphereDecaySeed, 11, 55), 0, 55)+25
    atmG = math.clamp(oneDimPerlinSeeded(atmosphereDecaySeed, 17, 55), 0, 55)+25
    atmB = math.clamp(oneDimPerlinSeeded(atmosphereDecaySeed, 23, 55), 0, 55)
    local atmosphereDecay = Color3.fromRGB(atmR, atmG, atmB)
    local atmosphereHaze = math.clamp(oneDimPerlinSeeded(atmosphereColorSeed, 23, 5), 0, 5)
    local atmosphereGlare = math.clamp(oneDimPerlinSeeded(worldSeed, 17, 0.15), 0, 0.15)
    local atmosphereDensity = math.clamp(oneDimPerlinSeeded(atmosphereDecaySeed, 31, 0.25), 0, 0.25)+0.25
    local atmosphereBrightness = 136-(atmosphereHaze*10)
    local floorIndex = #worldSlots+1
    
    worldSlots[floorIndex] = {
        ["worldSeed"] = worldSeed,
        ["atmosphereColorSeed"] = atmosphereColorSeed,
        ["atmosphereDecaySeed"] = atmosphereDecaySeed,
        ["atmosphereColor"] = atmosphereColor,
        ["atmosphereHaze"] = atmosphereHaze,
        ["atmosphereDecay"] = atmosphereDecay,
        ["atmosphereGlare"] = atmosphereGlare,
        ["atmosphereDensity"] = atmosphereDensity,
        ["atmosphereBrightness"] = atmosphereBrightness,
    }

    print("--------------")
    print(worldSeed)
    print(atmosphereColorSeed)
    print(atmosphereDecaySeed)
    print("--------------")
    print(atmosphereColor)
    print(atmosphereHaze)
    print(atmosphereDecay)
    print(atmosphereGlare)
    print(atmosphereDensity)
    print(atmosphereBrightness)
    print("--------------")

    for i=spawnChunkX-initialPlayerSpawnRadius,spawnChunkX+initialPlayerSpawnRadius do
        for k=spawnChunkY-initialPlayerSpawnRadius,spawnChunkY+initialPlayerSpawnRadius do
            WorldService:GenerateWorld(floorIndex, i, k)
        end
    end

    return floorIndex
end

function WorldService:GenerateWorld(floorIndex, xChunkCoord, yChunkCoord)
    if genCache[floorIndex] == nil then
        genCache[floorIndex] = {}
    end

    local cahceIndex = tostring(xChunkCoord)..","..tostring(yChunkCoord)
    if genCache[floorIndex][cahceIndex] == nil then
        local part = Instance.new("Part", self.RootPart)
        local noiseValHeight = math.noise(xChunkCoord/10, yChunkCoord/10, worldSlots[floorIndex]["worldSeed"]/10) * chunkMaxHeight
        part.Anchored = true
        part.Position = Vector3.new((xChunkCoord*(chunkSize)), noiseValHeight+(floorIndex*worldOffset), (yChunkCoord*(chunkSize)))
        part.Size = Vector3.new(chunkSize, chunkMaxHeight, chunkSize)
        game.Workspace.Terrain:FillBlock(part.CFrame, part.Size, Enum.Material[ (noiseValHeight > .3) and "Grass" or "Sandstone" ])
        part:Destroy()

        genCache[floorIndex][cahceIndex] = true
    end
end

function WorldService:GetChunkSize()
    return chunkSize
end

function WorldService:GetWorldOffset()
    return worldOffset
end

function WorldService:GetWorldSeed(floorIndex)
    return  worldSlots[floorIndex]["worldseed"]
end

function WorldService:GetWorldTable(floorIndex)
    return  worldSlots[floorIndex]
end

function WorldService:Start()

end


function WorldService:Init()
	
end


return WorldService