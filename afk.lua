local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Твой AccessCode из ссылки
local ACCESS_CODE = "089c296b88655649ad9aae970ed7f46f" 

local function rejoinPrivateServer()
    warn("Реконнект на приватку...")
    task.wait(2)
    -- Телепортация на приватный сервер по коду
    TeleportService:TeleportToPrivateServer(game.PlaceId, ACCESS_CODE, {LocalPlayer})
end

-- Мониторинг отключения
game:GetService("CoreGui").RobloxGui.Modules.Common.Connection.ConnectionLost:Connect(function()
    rejoinPrivateServer()
end)

-- Дополнительная страховка: проверка наличия игрока в DataModel
task.spawn(function()
    while task.wait(10) do
        if not LocalPlayer or LocalPlayer.Parent == nil then
            rejoinPrivateServer()
        end
    end
end)
