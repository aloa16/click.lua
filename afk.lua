-- Ждем загрузку игры
repeat task.wait() until game:IsLoaded()

local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")

-- Настройки задержек
local startDelay = 20 -- Ждем прогрузки интерфейса
local keyDelay = 0.5   -- Пауза между нажатиями кнопок

local function doCombo()
    task.wait(startDelay)
    print("Начинаю выполнение комбинации: \, D, Enter")

    -- 1. Нажимаем "/"
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Slash, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Slash, false, game)
    task.wait(keyDelay)

    -- 2. Нажимаем "D" (вправо)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, false, game)
    task.wait(keyDelay)

    -- 3. Нажимаем "Enter" (подтверждение)
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)

    print("Комбинация выполнена!")
end

-- Запуск клика
task.spawn(doCombo)

-- Логика возврата на твой VIP
local function doRejoin()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

-- Перезаход при ошибках
GuiService.ErrorMessageChanged:Connect(doRejoin)
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        doRejoin()
    end
end)

-- Анти-АФК
game.Players.LocalPlayer.Idled:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end)

print("Скрипт Combo-Click запущен. Жду 20 сек...")
