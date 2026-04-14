-- Ждем загрузку игры
repeat task.wait() until game:IsLoaded()

local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")

-- НАСТРОЙКИ ПОД ЭКРАН 2400х1080:
local clickX = 2140 -- Далеко вправо под твой широкий экран
local clickY = 140  -- Высоко вверх, в область твоего кружка
local delayBeforeClick = 20 

-- Функция ОДНОГО клика
local function doSingleClick()
    task.wait(delayBeforeClick)
    VirtualUser:CaptureController()
    -- Нажимаем один раз точно в цель
    VirtualUser:ClickButton1(Vector2.new(clickX, clickY))
    print("Нажал в кружок на экране 2400x1080! Точка: " .. clickX .. "x" .. clickY)
end

-- Запуск клика
task.spawn(doSingleClick)

-- Перезаход (вернет тебя на VIP, если запустил там)
local function doRejoin()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- Защита от вылетов
GuiService.ErrorMessageChanged:Connect(doRejoin)
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        doRejoin()
    end
end)

-- Анти-АФК
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

print("Скрипт настроен под разрешение 2400x1080. Жди 20 сек!")
