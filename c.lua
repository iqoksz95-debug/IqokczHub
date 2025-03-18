-- Создаем ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем главное окно (уменьшаем ширину до 200)
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(0, 200, 0, 250)
mainWindow.Position = UDim2.new(0.4, 0, 0.35, 0)
mainWindow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainWindow.BackgroundTransparency = 0.4
mainWindow.Active = true
mainWindow.Draggable = true
mainWindow.Parent = screenGui

-- Добавляем обводку к главному окну
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Parent = mainWindow

-- Создаем заголовок
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0.02, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "IqokczHub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainWindow

-- Создаем линию
local line = Instance.new("Frame")
line.Name = "Line"
line.Size = UDim2.new(0.8, 0, 0, 1)
line.Position = UDim2.new(0.1, 0, 0.15, 0)
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BorderSizePixel = 0
line.Parent = mainWindow

-- Закругление окна
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 6)
uiCorner.Parent = mainWindow

-- Создаем контейнер для вкладок с горизонтальной прокруткой
local tabsContainer = Instance.new("ScrollingFrame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Size = UDim2.new(0.9, 0, 0, 30)
tabsContainer.Position = UDim2.new(0.05, 0, 0.2, 0)
tabsContainer.BackgroundTransparency = 1
tabsContainer.ScrollBarThickness = 0
tabsContainer.CanvasSize = UDim2.new(2, 0, 0, 0)
tabsContainer.ScrollingDirection = Enum.ScrollingDirection.X 
tabsContainer.Parent = mainWindow

-- Создаем вкладки
local tabs = {}
local tabNames = {"Player", "Misc", "Tool", "Settings"}

for i, tabName in ipairs(tabNames) do
    local tab = Instance.new("TextButton")
    tab.Name = "Tab" .. i
    tab.Size = UDim2.new(0.2, 0, 1, 0)
    tab.Position = UDim2.new((i - 1) * (0.2 + 0.02), 0, 0, 0)
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Text = tabName
    tab.Font = Enum.Font.SourceSansBold
    tab.TextSize = 16
    tab.Parent = tabsContainer

    -- Закругление углов вкладок
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 4)
    tabCorner.Parent = tab

    -- Подсветка при наведении
    tab.MouseEnter:Connect(function()
        tab.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    end)

    tab.MouseLeave:Connect(function()
        tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    table.insert(tabs, tab)
end

-- Создаем контейнеры для содержимого вкладок
local tabContents = {}
for i = 1, #tabNames do
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = "TabContent" .. i
    tabContent.Size = UDim2.new(0.8, 0, 0, 150)
    tabContent.Position = UDim2.new(0.1, 0, 0.35, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 0
    tabContent.Visible = i == 1
    tabContent.Parent = mainWindow
    table.insert(tabContents, tabContent)
end

-- Функция для переключения видимости кнопок вкладки
local function toggleTabVisibility(tabContent)
    tabContent.Visible = not tabContent.Visible
end

-- Функция для переключения вкладок
local function switchTab(tabIndex)
    for i, tabContent in ipairs(tabContents) do
        if i == tabIndex then
            toggleTabVisibility(tabContent)
        else
            tabContent.Visible = false
        end
    end
end

-- Подключаем переключение вкладок к кнопкам
for i, tab in ipairs(tabs) do
    tab.MouseButton1Click:Connect(function() switchTab(i) end)
end

-- Добавляем возможность прокрутки мышью
local UserInputService = game:GetService("UserInputService")

local function handleScroll(input)
    if input.UserInputType == Enum.UserInputType.MouseWheel then
        local currentCanvasPosition = tabsContainer.CanvasPosition
        local newX = currentCanvasPosition.X - input.Position.Z * 15
        tabsContainer.CanvasPosition = Vector2.new(math.clamp(newX, 0, tabsContainer.CanvasSize.X.Offset - tabsContainer.AbsoluteWindowSize.X), 0)
    end
end

UserInputService.InputChanged:Connect(handleScroll)

-- Добавляем кнопки в первую вкладку
local function createButton(name, position, text, callback, parent)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0.8, 0, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    return button
end

-- Основа под кнопки
local function loadExternalScript(url)
    local success, result = pcall(function()
        local response = game:HttpGet(url, true) 
        return loadstring(response)()
    end)
    
    if success then
        print("Script loaded successfully")
    else
        warn("Failed to load script: " .. result)
    end
end

-- Кнопки в первый таб
createButton("SpeedButton", UDim2.new(0.1, 0, 0, 10), "Speed", function()
    loadExternalScript("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/Speed.lua")
end, tabContents[1])

createButton("NoclipButton", UDim2.new(0.1, 0, 0, 50), "Noclip", function()
    loadExternalScript("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/Noclip.lua")
end, tabContents[1])

createButton("EspButton", UDim2.new(0.1, 0, 0, 90), "Esp", function()
    loadExternalScript("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/Esp.lua")
end, tabContents[1])

createButton("FlyButton", UDim2.new(0.1, 0, 0, 130), "Fly", function()
    loadExternalScript("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/Fly.lua")
end, tabContents[1])

createButton("TeleportButton", UDim2.new(0.1, 0, 0, 170), "Teleport", function() 
    loadExternalScript("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/Teleport.lua") 
end, tabContents[1])

-- Кнопки во второй таб
createButton("InfiniteYieldButton", UDim2.new(0.1, 0, 0, 10), "InfiniteYield", function() 
    loadExternalScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source") 
end, tabContents[2])

createButton("DexButton", UDim2.new(0.1, 0, 0, 50), "Dex", function() 
    loadExternalScript("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua") 
end, tabContents[2])

-- Кнопки в третий таб (Tools)
createButton("Tool1Button", UDim2.new(0.1, 0, 0, 10), "Tool 1", function() 
    print("Tool 1 activated")
end, tabContents[3])

createButton("Tool2Button", UDim2.new(0.1, 0, 0, 50), "Tool 2", function() 
    print("Tool 2 activated")
end, tabContents[3])

-- Кнопки в четвертый таб (Settings)
createButton("Setting1Button", UDim2.new(0.1, 0, 0, 10), "Setting 1", function() 
    print("Setting 1 activated")
end, tabContents[4])

createButton("Setting2Button", UDim2.new(0.1, 0, 0, 50), "Setting 2", function() 
    print("Setting 2 activated")
end, tabContents[4])




-- Создаем ScreenGui
local MiniScreenGui = Instance.new("ScreenGui")
MiniScreenGui.Name = "MiniMenuGui"
MiniScreenGui.ResetOnSpawn = false
MiniScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем маленькое меню
local miniMenu = Instance.new("Frame")
miniMenu.Name = "MiniMenu"
miniMenu.Size = UDim2.new(0, 100, 0, 50)
miniMenu.Position = UDim2.new(0, 20, 0.5, -75)
miniMenu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
miniMenu.BackgroundTransparency = 0.4
miniMenu.Active = true
miniMenu.Draggable = true
miniMenu.Parent = MiniScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 4)
MiniCorner.Parent = miniMenu

-- Добавляем обводку к маленькому меню
local uiStrokeMini = Instance.new("UIStroke")
uiStrokeMini.Thickness = 1 
uiStrokeMini.Color = Color3.fromRGB(255, 255, 255)
uiStrokeMini.Parent = miniMenu

-- Водяной знак "IqokczHub"
local watermark = Instance.new("TextLabel")
watermark.Name = "Watermark"
watermark.Size = UDim2.new(1, 0, 0, 20)
watermark.Position = UDim2.new(0, 0, 0, 5)
watermark.BackgroundTransparency = 1
watermark.Text = "IqokczHub"
watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
watermark.Font = Enum.Font.SourceSansBold
watermark.TextSize = 18
watermark.TextXAlignment = Enum.TextXAlignment.Center
watermark.Parent = miniMenu

-- Белая линия 1 см
local miniline = Instance.new("Frame")
miniline.Name = "Line"
miniline.Size = UDim2.new(0.8, 0, 0, 1) 
miniline.Position = UDim2.new(0.1, 0, 0.5, 0) 
miniline.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
miniline.BorderSizePixel = 0
miniline.Parent = miniMenu

-- Кнопка "+"
local plusButton = Instance.new("TextButton")
plusButton.Name = "PlusButton"
plusButton.Size = UDim2.new(0.5, 0, 0, 20) 
plusButton.Position = UDim2.new(0.25, 0, 0.55, 0) 
plusButton.BackgroundTransparency = 1 
plusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
plusButton.Text = "+"
plusButton.Font = Enum.Font.SourceSansBold
plusButton.TextSize = 20
plusButton.Parent = miniMenu

-- Функция для переключения видимости главного меню
local function toggleMainMenu()
    mainWindow.Visible = not mainWindow.Visible
end

-- Обработчик нажатия на кнопку "+"
plusButton.MouseButton1Click:Connect(toggleMainMenu)

-- Изначально маленькое меню видимо, главное меню скрыто
miniMenu.Visible = true
mainWindow.Visible = false

-- Бинд на клавишу "H"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.H and not gameProcessed then
        toggleMainMenu()
    end
end)
