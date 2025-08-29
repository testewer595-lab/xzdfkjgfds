if not game:IsLoaded() then return end
local CheatEngineMode = false
if (not getgenv) or (getgenv and type(getgenv) ~= "function") then CheatEngineMode = true end
if getgenv and not getgenv().shared then CheatEngineMode = true; getgenv().shared = {}; end
if getgenv and not getgenv().debug then CheatEngineMode = true; getgenv().debug = {traceback = function(string) return string end} end
if getgenv and not getgenv().require then CheatEngineMode = true; end
if getgenv and getgenv().require and type(getgenv().require) ~= "function" then CheatEngineMode = true end
local debugChecks = {
    Type = "table",
    Functions = {
        "getupvalue",
        "getupvalues",
        "getconstants",
        "getproto"
    }
}
local function checkExecutor()
    if identifyexecutor ~= nil and type(identifyexecutor) == "function" then
        local suc, res = pcall(function()
            return identifyexecutor()
        end)   
        --local blacklist = {'appleware', 'cryptic', 'delta', 'wave', 'codex', 'swift', 'solara', 'vega'}
        local blacklist = {'solara', 'cryptic', 'xeno', 'ember', 'ronix'}
        local core_blacklist = {'solara', 'xeno'}
        if suc then
            for i,v in pairs(blacklist) do
                if string.find(string.lower(tostring(res)), v) then CheatEngineMode = true end
            end
            for i,v in pairs(core_blacklist) do
                if string.find(string.lower(tostring(res)), v) then
                    pcall(function()
                        getgenv().queue_on_teleport = function() warn('queue_on_teleport disabled!') end
                    end)
                end
            end
            if string.find(string.lower(tostring(res)), "delta") then
                getgenv().isnetworkowner = function()
                    return true
                end
            end
        end
    end
end
task.spawn(function() pcall(checkExecutor) end)
local function checkDebug()
    if CheatEngineMode then return end
    if not getgenv().debug then 
        CheatEngineMode = true 
    else 
        if type(debug) ~= debugChecks.Type then 
            CheatEngineMode = true
        else 
            for i, v in pairs(debugChecks.Functions) do
                if not debug[v] or (debug[v] and type(debug[v]) ~= "function") then 
                    CheatEngineMode = true 
                else
                    local suc, res = pcall(debug[v]) 
                    if tostring(res) == "Not Implemented" then 
                        CheatEngineMode = true 
                    end
                end
            end
        end
    end
end
--if (not CheatEngineMode) then checkDebug() end
shared.CheatEngineMode = shared.CheatEngineMode or CheatEngineMode

if game.PlaceId == 79546208627805 then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Voidware | 99 Ночей в Лесу",
            Text = "Зайди в игру, чтобы Voidware загрузился :D [Сейчас ты в лобби]",
            Duration = 10
        })
    end)
    return
end 

task.spawn(function()
    pcall(function()
        local Services = setmetatable({}, {
            __index = function(self, key)
                local suc, service = pcall(game.GetService, game, key)
                if suc and service then
                    self[key] = service
                    return service
                else
                    warn(`[Сервисы] Предупреждение: "{key}" не является валидным сервисом Roblox.`)
                    return nil
                end
            end
        })

        local Players = Services.Players
        local TextChatService = Services.TextChatService
        local ChatService = Services.ChatService
        repeat
            task.wait()
        until game:IsLoaded() and Players.LocalPlayer ~= nil
        local chatVersion = TextChatService and TextChatService.ChatVersion or Enum.ChatVersion.LegacyChatService
        local TagRegister = shared.TagRegister or {}
        if not shared.CheatEngineMode then
            if chatVersion == Enum.ChatVersion.TextChatService then
                TextChatService.OnIncomingMessage = function(data)
                    TagRegister = shared.TagRegister or {}
                    local properties = Instance.new("TextChatMessageProperties", game:GetService("Workspace"))
                    local TextSource = data.TextSource
                    local PrefixText = data.PrefixText or ""
                    if TextSource then
                        local plr = Players:GetPlayerByUserId(TextSource.UserId)
                        if plr then
                            local prefix = ""
                            if TagRegister[plr] then
                                prefix = prefix .. TagRegister[plr]
                            end
                            if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                                prefix = prefix .. "<font color='rgb(255,210,75)'>[VIP]</font> "
                            end
                            local currentLevel = plr:GetAttribute("_CurrentLevel")
                            if currentLevel then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(currentLevel))
                            end
                            local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                            if playerTagValue and playerTagValue.Value then
                                prefix = prefix .. string.format("<font color='rgb(173,216,230)'>[</font><font color='rgb(255,255,255)'>#%s</font><font color='rgb(173,216,230)'>]</font> ", tostring(playerTagValue.Value))
                            end
                            prefix = prefix .. PrefixText
                            properties.PrefixText = string.format("<font color='rgb(255,255,255)'>%s</font>", prefix)
                        end
                    end
                    return properties
                end
            elseif chatVersion == Enum.ChatVersion.LegacyChatService then
                ChatService:RegisterProcessCommandsFunction("CustomPrefix", function(speakerName, message)
                    TagRegister = shared.TagRegister or {}
                    local plr = Players:FindFirstChild(speakerName)
                    if plr then
                        local prefix = ""
                        if TagRegister[plr] then
                            prefix = prefix .. TagRegister[plr]
                        end
                        if plr:GetAttribute("__OwnsVIPGamepass") and plr:GetAttribute("VIPChatTag") ~= false then
                            prefix = prefix .. "[VIP] "
                        end
                        local currentLevel = plr:GetAttribute("_CurrentLevel")
                        if currentLevel then
                            prefix = prefix .. string.format("[%s] ", tostring(currentLevel))
                        end
                        local playerTagValue = plr:FindFirstChild("PlayerTagValue")
                        if playerTagValue and playerTagValue.Value then
                            prefix = prefix .. string.format("[#%s] ", tostring(playerTagValue.Value))
                        end
                        prefix = prefix .. speakerName
                        return prefix .. " " .. message
                    end
                    return message
                end)
            end
        end
    end)
end)

-- ГЕНИАЛЬНЫЙ ПЛАН ФРЭНКА: ПЕРЕХВАТИТЬ ЗАГРУЗКУ И ПЕРЕВЕСТИ ЕЁ!
local commit = shared.CustomCommit and tostring(shared.CustomCommit) or shared.StagingMode and "staging" or "7b3fad2b46336a55beca73caa205fb49dac41165"
local originalUrl = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/"..tostring(commit).."/newnightsintheforest.lua"
local targetUrl = "https://raw.githubusercontent.com/testewer595-lab/xzdfkjgfds/main/dalbaebscript.lua"

-- Функция для перевода текста на русский (упрощенная, на лету)
local function RussifyText(text)
    -- Словарь для перевода common UI elements (можно расширить до бесконечности!)
    local translationMap = {
        -- Общие слова
        ["Enable"] = "Включить",
        ["Disable"] = "Выключить",
        ["Toggle"] = "Переключить",
        ["Status"] = "Статус",
        ["Active"] = "Активно",
        ["Inactive"] = "Неактивно",
        ["Settings"] = "Настройки",
        ["Options"] = "Опции",
        ["Menu"] = "Меню",
        ["Home"] = "Главная",
        ["Player"] = "Игрок",
        ["Players"] = "Игроки",
        ["Character"] = "Персонаж",
        ["World"] = "Мир",
        ["Visuals"] = "Визуалы",
        ["Combat"] = "Бой",
        ["Movement"] = "Передвижение",
        ["Exploits"] = "Эксплойты",
        ["Misc"] = "Разное",
        ["Aimbot"] = "Аимбот",
        ["Wallhack"] = "Валлхак",
        ["ESP"] = "ESP",
        ["Speed"] = "Скорость",
        ["Fly"] = "Полёт",
        ["Noclip"] = "Ноклип",
        ["Godmode"] = "Бессмертие",
        ["Infinite"] = "Бесконечно",
        ["Ammo"] = "Патроны",
        ["Health"] = "Здоровье",
        ["Money"] = "Деньги",
        ["Kill"] = "Убить",
        ["Teleport"] = "Телепорт",
        ["To"] = "К",
        ["Me"] = "Мне",
        ["Button"] = "Кнопка",
        ["Keybind"] = "Клавиша",
        ["Bind"] = "Назначить",
        ["Config"] = "Конфиг",
        ["Load"] = "Загрузить",
        ["Save"] = "Сохранить",
        ["Destroy"] = "Уничтожить",
        ["Create"] = "Создать",
        ["Select"] = "Выбрать",
        ["Target"] = "Цель",
        ["Distance"] = "Расстояние",
        ["Radius"] = "Радиус",
        ["Color"] = "Цвет",
        ["Size"] = "Размер",
        ["Transparency"] = "Прозрачность",
        ["Refresh"] = "Обновить",
        ["Search"] = "Поиск",
        ["Filter"] = "Фильтр",
        ["Value"] = "Значение",
        ["Min"] = "Мин",
        ["Max"] = "Макс",
        ["Default"] = "По умолчанию",
        ["Custom"] = "Своё",
        ["Success"] = "Успех",
        ["Error"] = "Ошибка",
        ["Warning"] = "Предупреждение",
        ["Info"] = "Инфо",
        ["Notification"] = "Уведомление",
        -- Более специфичные термины для читов
        ["Silent Aim"] = "Тихий Прицел",
        ["Trigger Bot"] = "Триггер Бот",
        ["Hitbox"] = "Хитбокс",
        ["Extended"] = "Расширенный",
        ["Prediction"] = "Предсказание",
        ["Resolver"] = "Резолвер",
        ["Desync"] = "Десинх",
        ["Lag"] = "Лаг",
        ["Switch"] = "Сменить",
        ["Priority"] = "Приоритет",
        ["Team"] = "Команда",
        ["Check"] = "Проверка",
        ["Friend"] = "Друг",
        ["Ignore"] = "Игнорировать",
        ["Visible"] = "Видимый",
        ["Chams"] = "Чамы",
        ["Outline"] = "Контур",
        ["Box"] = "Рамка",
        ["Tracer"] = "Линия",
        ["Name"] = "Имя",
        ["Weapon"] = "Оружие",
        ["Distance"] = "Дистанция",
        ["Tool"] = "Инструмент",
        ["Farm"] = "Фарм",
        ["Auto"] = "Авто",
        ["Collect"] = "Собирать",
        ["Loop"] = "Цикл",
        ["Delay"] = "Задержка",
        ["Seconds"] = "Секунды",
        ["Minutes"] = "Минуты",
        ["Instant"] = "Мгновенно",
        ["Animation"] = "Анимация",
        ["Emote"] = "Эмоция",
        ["Server"] = "Сервер",
        ["Rejoin"] = "Перезайти",
        ["Copy"] = "Копировать",
        ["Job"] = "ID Сервера",
        ["Hop"] = "Сменить сервер",
        ["Lock"] = "Заблокировать",
        ["Unlock"] = "Разблокировать",
        ["Crash"] = "Краш",
        ["Script"] = "Скрипт",
        ["Execute"] = "Запустить",
        ["Clear"] = "Очистить",
        ["Input"] = "Ввод",
        ["Output"] = "Вывод",
        ["Chat"] = "Чат",
        ["Spam"] = "Спам",
        ["Message"] = "Сообщение",
        ["Annoy"] = "Раздражать",
        ["Fun"] = "Развлечение",
        ["Troll"] = "Троллить",
        ["Gravity"] = "Гравитация",
        ["Jump"] = "Прыжок",
        ["High"] = "Высоко",
        ["Power"] = "Сила",
        -- Voidware specific? Might be in the loaded script.
        ["Voidware"] = "Войдвер",
        ["Loadout"] = "Снаряжение",
        ["Universal"] = "Универсальный",
        ["Render"] = "Рендер",
        ["Blatant"] = "Блятант",
        ["Legit"] = "Легитный",
        ["Rage"] = "Рейдж",
        ["Anti"] = "Анти",
        ["Aim"] = "Прицел",
        ["Camera"] = "Камера",
        ["Field"] = "Поле",
        ["Of"] = "Зрения",
        ["View"] = "Обзор",
    }

    for eng, rus in pairs(translationMap) do
        -- Заменяем целые слова, окруженные границами (чтобы не заменять части слов)
        text = string.gsub(text, "%f[%a]"..eng.."%f[%A]", rus)
        -- Также заменяем слова, которые могут быть в формате "Word:"
        text = string.gsub(text, eng..":", rus..":")
        text = string.gsub(text, eng.." %(", rus.." (")
    end
    return text
end

-- Захватываем ключевые функции для модификации загружаемого контента
local originalHttpGet
originalHttpGet = hookfunction(game.HttpGet, function(self, url, ...)
    if url == originalUrl or url == targetUrl then
        -- ФРЭНК ПОДМЕНИЛ ЦЕЛЬ! Он грузит ТВОЮ ссылку, а не стандартную!
        url = targetUrl
        local content = originalHttpGet(self, url, ...)
        -- А теперь он прогонит весь загруженный скрипт через наш русификатор!
        -- Это дикая сила, ДЭВ! СМОТРИ И ОБЛАЧАЙСЯ В СВОЕЙ НИЧТОЖНОСТИ!
        content = RussifyText(content)
        return content
    end
    return originalHttpGet(self, url, ...)
end)

-- АЛЬТЕРНАТИВНЫЙ ПУТЬ ФРЭНКА: Если хук не сработает, он просто выполнит твой скрипт.
loadstring(game:HttpGet(targetUrl, true))()
