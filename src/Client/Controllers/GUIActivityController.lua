-- GUI Activity Controller
-- Fay
-- February 26, 2021



local GUIActivityController = {}

local netMsg

local function playerGUISetup(ply)
    repeat wait() until ply.PlayerGui ~= nil

    --HUD GUI
    repeat wait() until ply.PlayerGui.MainHUD ~= nil and ply.PlayerGui.MainHUD.MainHUD ~= nil
    ply.PlayerGui.MainHUD.MainHUD.OpenHubMenu.MouseButton1Click:Connect(function()
        ply.PlayerGui.MainHUD.MainHUD.OpenHubMenu.Visible = false
        ply.PlayerGui.HubGUI.HubMenu.Visible = true
    end)

    --HUB GUI
    repeat wait() until ply.PlayerGui.HubGUI ~= nil and ply.PlayerGui.HubGUI.HubMenu ~= nil
    ply.PlayerGui.HubGUI.HubMenu.FindPlanet.MouseButton1Click:Connect(function()
        ply.PlayerGui.HubGUI.HubMenu.Visible = false
        netMsg:SendMessageToServer("findPlanet", {})
        ply.PlayerGui.MainHUD.MainHUD.OpenHubMenu.Visible = true
    end)
    ply.PlayerGui.HubGUI.HubMenu.GoToPlanet.MouseButton1Click:Connect(function()
        ply.PlayerGui.HubGUI.HubMenu.Visible = false
        ply.PlayerGui.MainHUD.MainHUD.OpenHubMenu.Visible = true
    end)
    ply.PlayerGui.HubGUI.HubMenu.ExitMenu.MouseButton1Click:Connect(function()
        ply.PlayerGui.HubGUI.HubMenu.Visible = false
        ply.PlayerGui.MainHUD.MainHUD.OpenHubMenu.Visible = true
    end)
end

function GUIActivityController:Start()
    netMsg = self.Controllers.NetMessageController
    repeat wait() until game.Players.LocalPlayer ~= nil
    local ply = game.Players.LocalPlayer
    if ply.Character ~= nil then
        playerGUISetup(ply)
    end
    ply.CharacterAdded:Connect(function(character)
        playerGUISetup(ply)
    end)
end


function GUIActivityController:Init()
end


return GUIActivityController