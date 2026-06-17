local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ACCESS_CODE = "089c296b88655649ad9aae970ed7f46f" 

local function rejoinPrivateServer()
    warn("Реконнект на приватку...")
    task.wait(2)
    -- Здесь должны быть {LocalPlayer}
    TeleportService:TeleportToPrivateServer(game.PlaceId, ACCESS_CODE, {LocalPlayer})
end

game:GetService("CoreGui").RobloxGui.Modules.Common.Connection.ConnectionLost:Connect(function()
    rejoinPrivateServer()
end)

task.spawn(function()
    while task.wait(10) do
        if not LocalPlayer or LocalPlayer.Parent == nil then
            rejoinPrivateServer()
        end
    end
end)
