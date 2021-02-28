-- Skybox Controller
-- Username
-- February 27, 2021



local SkyboxController = {}
local Skybox3D
local sky


function SkyboxController:Start()
    Skybox3D = require(game:GetService("ReplicatedStorage"):FindFirstChild("Skybox3D"))
    sky = Skybox3D.new()
	sky:SetWorldScale(0.1)
    sky:SetCameraOrigin(Vector3.new(0,10,0))

    local skyModel = game:GetService("ReplicatedStorage"):FindFirstChild("Model"):Clone()
    skyModel.Parent = sky.ViewportFrame
    sky:SetActive(true)
end


function SkyboxController:Init()
	
end


return SkyboxController