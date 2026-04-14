-- Ждем загрузку игры
repeat task.wait() until game:IsLoaded()

local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")

-- ТВОИ ТОЧНЫЕ НАСТРОЙКИ:
local clickX = 2200 
local clickY = 750 
local delayBeforeClick = 20 -- Ждем 20 секунд, чтобы всё прогрузилось

-- Функция разового клика
local function doSingleClick()
    task.wait(delayBeforeClick)
    VirtualUser:CaptureController()
    -- Кликаем один раз точно в цель
    VirtualUser:ClickButton1(Vector2.new(clickX, clickY))
    print("Нажал на кнопку по твоим координатам: " .. clickX .. "x" .. clickY)
end

-- Запуск клика при заходе
task.spawn(doSingleClick)

-- Логика возврата на VIP (если зашел с випки — вернет на випку)
local function doRejoin()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- Перезаход при вылете или ошибке
GuiService.ErrorMessageChanged:Connect(doRejoin)
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        doRejoin()
    end
end)

-- Анти-АФК чтобы не кикало за бездействие
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

print("Скрипт запущен! Нажмет на X=2200 Y=750 через 20 секунд.")
