-- DALBAEB SCRIPT WITH COLOR CUSTOMIZATION
-- FRANK THE DESTROYER EDITION

if not game:IsLoaded() then return end

-- ЦВЕТОВАЯ СХЕМА ПО УМОЛЧАНИЮ
local DALBAEB_Colors = {
    Main = Color3.fromRGB(255, 0, 0),    -- Красный (основной)
    Background = Color3.fromRGB(0, 0, 0), -- Черный (фон)
    Text = Color3.fromRGB(255, 255, 255), -- Белый (текст)
    Accent = Color3.fromRGB(0, 0, 255)    -- Синий (акцент)
}

-- ФУНКЦИЯ СМЕНЫ ЦВЕТОВ
local function ChangeColors(newColors)
    if newColors then
        DALBAEB_Colors = newColors
        -- Здесь будет код применения цветов к интерфейсу
        print("[DALBAEB] Colors changed to:", newColors)
    end
end

-- МЕНЮ ВЫБОРА ЦВЕТОВ
local function CreateColorMenu()
    local colorPresets = {
        ["Red Theme"] = {
            Main = Color3.fromRGB(255, 0, 0),
            Background = Color3.fromRGB(30, 0, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(200, 0, 0)
        },
        ["Blue Theme"] = {
            Main = Color3.fromRGB(0, 0, 255),
            Background = Color3.fromRGB(0, 0, 30),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(0, 0, 200)
        },
        ["Black Theme"] = {
            Main = Color3.fromRGB(50, 50, 50),
            Background = Color3.fromRGB(0, 0, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(100, 100, 100)
        },
        ["Green Theme"] = {
            Main = Color3.fromRGB(0, 255, 0),
            Background = Color3.fromRGB(0, 30, 0),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(0, 200, 0)
        },
        ["Purple Theme"] = {
            Main = Color3.fromRGB(128, 0, 128),
            Background = Color3.fromRGB(30, 0, 30),
            Text = Color3.fromRGB(255, 255, 255),
            Accent = Color3.fromRGB(100, 0, 100)
        }
    }

    -- ДОБАВЛЯЕМ КНОПКИ В МЕНЮ ДЛЯ СМЕНЫ ЦВЕТОВ
    for themeName, colors in pairs(colorPresets) do
        -- Здесь должен быть код создания кнопки в твоем мод-меню
        -- Пример: addButton(themeName, function() ChangeColors(colors) end)
        print("[DALBAEB] Added color theme:", themeName)
    end
end

-- ФУНКЦИЯ ДЛЯ РУЧНОЙ СМЕНЫ ЦВЕТА
local function SetCustomColor(colorType, r, g, b)
    if colorType and r and g and b then
        local newColor = Color3.fromRGB(r, g, b)
        if DALBAEB_Colors[colorType] then
            DALBAEB_Colors[colorType] = newColor
            print("[DALBAEB] Changed", colorType, "to RGB:", r, g, b)
        end
    end
end

-- АВТОМАТИЧЕСКИЕ ЦВЕТА (РАДУГА)
local function RainbowColors()
    local hue = 0
    while true do
        hue = (hue + 0.01) % 1
        DALBAEB_Colors.Main = Color3.fromHSV(hue, 1, 1)
        -- Применяем изменения к интерфейсу
        wait(0.1)
    end
end

-- ДОБАВЛЯЕМ КОМАНДЫ В КОНСОЛЬ
local function AddColorCommands()
    -- Команда для смены темы
    -- addCommand("colors", {"theme"}, function(themeName)
    --     local themes = {"red", "blue", "black", "green", "purple"}
    --     if table.find(themes, themeName:lower()) then
    --         ChangeColors(colorPresets[themeName:gsub("^%l", string.upper)])
    --     end
    -- end, "Change color theme")

    -- Команда для ручной установки RGB
    -- addCommand("color", {"type", "r", "g", "b"}, function(type, r, g, b)
    --     SetCustomColor(type, tonumber(r), tonumber(g), tonumber(b))
    -- end, "Set custom color RGB")
end

-- ИНИЦИАЛИЗАЦИЯ ЦВЕТОВОГО МЕНЮ
CreateColorMenu()
AddColorCommands()

print("[DALBAEB] Color system loaded! Available themes: Red, Blue, Black, Green, Purple")

-- ТВОЙ ОСНОВНОЙ КОД ДЛЯ 99 NIGHTS ЗДЕСЬ
-- ... (остальная часть твоего скрипта) ...

-- ФУНКЦИЯ ДЛЯ ПРИМЕНЕНИЯ ЦВЕТОВ К ИНТЕРФЕЙСУ
local function ApplyColorsToUI()
    -- Этот код будет применять выбранные цвета к твоему мод-меню
    -- Пример:
    -- if mainWindow then
    --     mainWindow.Color = DALBAEB_Colors.Background
    --     mainWindow.TextColor3 = DALBAEB_Colors.Text
    -- end
end

-- АВТОМАТИЧЕСКИ ПРИМЕНЯЕМ ЦВЕТА ПРИ ИЗМЕНЕНИИ
while true do
    ApplyColorsToUI()
    wait(1)
end
