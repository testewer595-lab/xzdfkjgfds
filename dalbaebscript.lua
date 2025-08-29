-- DALBAEB СКРИПТ ДЛЯ 99 NIGHTS
-- ФИКСИРОВАННАЯ ВЕРСИЯ ОТ FRANK

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ОСНОВНЫЕ НАСТРОЙКИ
getgenv().DALBAEB_Settings = {
    Бессмертие = false,
    УбитьВсех = false,
    Скорость = 50,
    Прыжок = 50,
    НочноеЗрение = false
}

-- ЦВЕТОВАЯ СИСТЕМА
getgenv().DALBAEB_Colors = {
    Основной = Color3.fromRGB(255, 0, 0),
    Фон = Color3.fromRGB(20, 20, 20),
    Текст = Color3.fromRGB(255, 255, 255),
    Кнопка = Color3.fromRGB(50, 50, 50),
    ТекстКнопки = Color3.fromRGB(255, 255, 255)
}

-- СОЗДАЕМ ОКНО МЕНЮ
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/uwuware-ui/main/library.lua"))()
local Window = Library:CreateWindow("DALBAEB MENU 🇷🇺")

-- ВКЛАДКА ОСНОВНЫЕ ФУНКЦИИ
local MainTab = Window:AddTab("Основные")
MainTab:AddToggle("Бессмертие", {flag = "Бессмертие"}):OnChanged(function(value)
    getgenv().DALBAEB_Settings.Бессмертие = value
    print("Бессмертие:", value and "ВКЛ" or "ВЫКЛ")
end)

MainTab:AddToggle("Убить всех мобов", {flag = "УбитьВсех"}):OnChanged(function(value)
    getgenv().DALBAEB_Settings.УбитьВсех = value
    print("Убить всех:", value and "ВКЛ" or "ВЫКЛ")
end)

MainTab:AddSlider("Скорость", 16, 100, 50, {flag = "Скорость"}):OnChanged(function(value)
    getgenv().DALBAEB_Settings.Скорость = value
    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
end)

MainTab:AddSlider("Сила прыжка", 50, 200, 50, {flag = "Прыжок"}):OnChanged(function(value)
    getgenv().DALBAEB_Settings.Прыжок = value
    if LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
    end
end)

MainTab:AddToggle("Ночное зрение", {flag = "НочноеЗрение"}):OnChanged(function(value)
    getgenv().DALBAEB_Settings.НочноеЗрение = value
    if value then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.Brightness = 2
    else
        game.Lighting.Ambient = Color3.new(0, 0, 0)
        game.Lighting.Brightness = 1
    end
end)

-- ВКЛАДКА ЦВЕТА
local ColorTab = Window:AddTab("Цвета")

ColorTab:AddButton("Красная тема", function()
    getgenv().DALBAEB_Colors = {
        Основной = Color3.fromRGB(255, 0, 0),
        Фон = Color3.fromRGB(30, 0, 0),
        Текст = Color3.fromRGB(255, 255, 255),
        Кнопка = Color3.fromRGB(80, 0, 0),
        ТекстКнопки = Color3.fromRGB(255, 255, 255)
    }
    Library:ChangeColor(Color3.fromRGB(255, 0, 0))
    print("Активирована красная тема")
end)

ColorTab:AddButton("Синяя тема", function()
    getgenv().DALBAEB_Colors = {
        Основной = Color3.fromRGB(0, 100, 255),
        Фон = Color3.fromRGB(0, 0, 30),
        Текст = Color3.fromRGB(255, 255, 255),
        Кнопка = Color3.fromRGB(0, 30, 80),
        ТекстКнопки = Color3.fromRGB(255, 255, 255)
    }
    Library:ChangeColor(Color3.fromRGB(0, 100, 255))
    print("Активирована синяя тема")
end)

ColorTab:AddButton("Зеленая тема", function()
    getgenv().DALBAEB_Colors = {
        Основной = Color3.fromRGB(0, 255, 0),
        Фон = Color3.fromRGB(0, 20, 0),
        Текст = Color3.fromRGB(255, 255, 255),
        Кнопка = Color3.fromRGB(0, 50, 0),
        ТекстКнопки = Color3.fromRGB(255, 255, 255)
    }
    Library:ChangeColor(Color3.fromRGB(0, 255, 0))
    print("Активирована зеленая тема")
end)

ColorTab:AddButton("Фиолетовая тема", function()
    getgenv().DALBAEB_Colors = {
        Основной = Color3.fromRGB(160, 0, 255),
        Фон = Color3.fromRGB(20, 0, 30),
        Текст = Color3.fromRGB(255, 255, 255),
        Кнопка = Color3.fromRGB(40, 0, 60),
        ТекстКнопки = Color3.fromRGB(255, 255, 255)
    }
    Library:ChangeColor(Color3.fromRGB(160, 0, 255))
    print("Активирована фиолетовая тема")
end)

-- ВКЛАДКА ИНФОРМАЦИЯ
local InfoTab = Window:AddTab("Информация")
InfoTab:AddLabel("DALBAEB MENU v1.0")
InfoTab:AddLabel("Для 99 Nights In The Forest")
InfoTab:AddLabel("Сделано с помощью FRANK")
InfoTab:AddButton("Обновить скрипт", function()
    print("Перезагрузите скрипт для обновления")
end)

-- ОСНОВНЫЕ ФУНКЦИИ
local function Бессмертие()
    while task.wait() and getgenv().DALBAEB_Settings.Бессмертие do
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 100
            end
        end
    end
end

local function УбитьМобов()
    while task.wait(1) and getgenv().DALBAEB_Settings.УбитьВсех do
        for _, mob in ipairs(workspace:GetChildren()) do
            if mob.Name:find("Monster") or mob.Name:find("Enemy") then
                mob:Destroy()
            end
        end
    end
end

-- ЗАПУСК ФУНКЦИЙ
task.spawn(Бессмертие)
task.spawn(УбитьМобов)

-- АВТОМАТИЧЕСКАЯ НАСТРОЙКА ПЕРСОНАЖА
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(1)
    if getgenv().DALBAEB_Settings.Скорость then
        character:WaitForChild("Humanoid").WalkSpeed = getgenv().DALBAEB_Settings.Скорость
    end
    if getgenv().DALBAEB_Settings.Прыжок then
        character:WaitForChild("Humanoid").JumpPower = getgenv().DALBAEB_Settings.Прыжок
    end
end)

print("DALBAEB MENU ЗАГРУЖЕН! 🇷🇺")
print("Нажми Insert чтобы открыть/закрыть меню")
print("Доступны функции: Бессмертие, Убить всех, Настройки скорости")

-- АВТОМАТИЧЕСКОЕ ОТКРЫТИЕ МЕНЮ
Library:Notify("DALBAEB MENU загружен!", 5)
