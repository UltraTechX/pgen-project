-- Net Message Service
-- Fay
-- February 26, 2021



local NetMessageService = {Client = {}}


local messageList = {}

function NetMessageService:DeclareServerMessage(messageName, func)
    messageList[messageName] = func
end

function NetMessageService:SendMessageToClient(ply, messageName, args)
    self:FireClient("ExecuteClientMessage", ply, messageName, args)
end

function NetMessageService:SendMessageToClients(messageName, args)
    self:FireAllClients("ExecuteClientMessage", messageName, args)
end

function NetMessageService:Start()
    self:ConnectClientEvent("ExecuteServerMessage", function(ply, messageName, args)
        if messageList[messageName] ~= nil then
            messageList[messageName](ply, args)
        end
    end)
end

function NetMessageService:Init()
    self:RegisterClientEvent("ExecuteClientMessage")
    self:RegisterClientEvent("ExecuteServerMessage")
end


return NetMessageService