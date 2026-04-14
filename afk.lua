-- Авто-реджоин + клик по кнопке Auto Click
repeat task.wait() until game:IsLoaded()

local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")

-- НАСТРОЙКИ:
-- Эти координаты (X: 850, Y: 250) обычно соответствуют правой верхней части экрана
local clickX = 850 
local clickY = 250 
local delayAfterLoad = 15 -- Ждем 15 сек, чтобы всё прогрузилось перед кликом

local function doClick()
    task.wait(delayAfterLoad)
    -- Эмуляция клика в указанную точку
    VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(clickX, clickY))
    print("Нажал на Auto Click!")
end

-- Запуск клика после загрузки
task.spawn(doClick)

-- Логика перезахода при вылете
local function doRejoin()
    task.wait(2)
    TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
end

GuiService.ErrorMessageChanged:Connect(doRejoin)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(5)
        doRejoin()
    end
end)

print("Система AFK-защиты запущена. Ночь будет удачной!")
