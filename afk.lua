-- Ожидание загрузки игры
repeat task.wait() until game:IsLoaded()

local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")

-- НАСТРОЙКИ:
local clickX = 920 -- Сдвинуто под твой скриншот (правее)
local clickY = 220 -- Сдвинуто под твой скриншот (выше)
local delayAfterLoad = 15 -- Ждем прогрузки интерфейса
local VIP_LINK = https://www.roblox.com/share?code=3046f09d83e2924e852a2afa6a06cf23&type=Server"" -- СЮДА ВСТАВЬ ССЫЛКУ НА СВОЙ ВИП СЕРВЕР (в кавычках)

local function doClick()
    task.wait(delayAfterLoad)
    -- Пробуем нажать по координатам
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(clickX, clickY))
    print("Нажал на Auto Click по координатам!")
end

-- Запуск клика
task.spawn(doClick)

-- Логика перезахода
local function doRejoin()
    task.wait(3)
    if VIP_LINK ~= "" then
        -- Если ты указал ссылку на випку, скрипт попытается зайти туда
        -- Но самый надежный способ для вип-сервера — обычный перезаход, 
        -- если ты УЖЕ запустил скрипт, находясь на вип-сервере.
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    else
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    end
end

-- Защита от вылетов и ошибок
GuiService.ErrorMessageChanged:Connect(doRejoin)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        doRejoin()
    end
end)

-- Анти-АФК (чтобы не кикало за бездействие)
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("Система AFK + AutoClick + Rejoin запущена!")
