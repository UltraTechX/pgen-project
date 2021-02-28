-- Net Message Controller
-- Username
-- February 26, 2021



local NetMessageController = {}

local messageList = {}

function NetMessageController:DeclareClientMessage(messageName, func)
    messageList[messageName] = func
end

function NetMessageController:SendMessageToServer(messageName, args)
    self.Services.NetMessageService.ExecuteServerMessage:Fire(messageName, args)
end

function NetMessageController:Start()
    self.Services.NetMessageService.ExecuteClientMessage:Connect(function(messageName, args)
        if messageList[messageName] ~= nil then
            messageList[messageName](args)
        end
    end)
end

function NetMessageController:Init()
end


return NetMessageController