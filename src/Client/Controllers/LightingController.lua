-- Lighting Controller
-- Username
-- February 27, 2021



local LightingController = {}

local netMsg

function LightingController:Start()
	netMsg = self.Controllers.NetMessageController
    netMsg:DeclareClientMessage("ChangeAtmosphere", function(args)
        local atmos = game.Lighting:FindFirstChild("Atmosphere")
        atmos.Color = args["atmosphereColor"]
        atmos.Decay = args["atmosphereDecay"]
        atmos.Haze = args["atmosphereHaze"]
        atmos.Density = args["atmosphereDensity"]
        game.Lighting.OutdoorAmbient = Color3.fromRGB(args["atmosphereBrightness"], args["atmosphereBrightness"], args["atmosphereBrightness"])
    end)
end


function LightingController:Init()
	
end


return LightingController