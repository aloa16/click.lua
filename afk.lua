-- Авто-реджоин + Умный автокликер
repeat task.wait() until game:IsLoaded()

local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local delayAfterLoad = 10 -- Ждем прогрузки интерфейса

local function doAutoClick()
    task.wait(delayAfterLoad)
    
    -- Ищем кнопку Auto Click в интерфейсе игрока
    local player = game.Players.LocalPlayer
    local pGui = player:WaitForChild("PlayerGui")
    
    -- Пытаемся найти кнопку по названию или тексту (обычно они в ScreenGui)
    local autoClickBtn = nil
    for _, v in pairs(pGui:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text:find("Auto Click") then
            autoClickBtn = v.Parent -- Обычно текст лежит внутри кнопки
            break
        elseif v:IsA("ImageButton") or v:IsA("TextButton") then
            if v.Name:lower():find("autoclick") then
                autoClickBtn = v
                break
            end
        end
    end

    if autoClickBtn then
        print("Кнопка найдена! Начинаю кликать...")
        while task.wait(0.5) do
            -- Кликаем прямо по центру найденной кнопки
            local absPos = autoClickBtn.AbsolutePosition
            local absSize = autoClickBtn.AbsoluteSize
            local centerX = absPos.X + (absSize.X / 2)
            local centerY = absPos.Y + (absSize.Y / 2)
            
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
        end
    else
        warn("Не удалось найти кнопку Auto Click в интерфейсе. Проверь название!")
    end
end

-- Логика перезахода
local function doRejoin()
    TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

GuiService.ErrorMessageChanged:Connect(doRejoin)

-- Запуск
task.spawn(doAutoClick)
print("Система AFK с автопоиском кнопки запущена!")
