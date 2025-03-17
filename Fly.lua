-- Создаем ScreenGui
local FlyscreenGui = Instance.new("ScreenGui")
FlyscreenGui.Name = "FlyGui"
FlyscreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем главное окно
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(0, 200, 0, 100)
mainWindow.Position = UDim2.new(0.4, 0, 0.35, 0)
mainWindow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainWindow.BackgroundTransparency = 0.4
mainWindow.Active = true
mainWindow.Draggable = true
mainWindow.Parent = FlyscreenGui

-- Добавляем обводку к главному окну
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Parent = mainWindow

-- Закругление окна
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 3)
uiCorner.Parent = mainWindow

-- Создаем первую кнопку
local PCbutton = Instance.new("TextButton")
PCbutton.Name = "Button1"
PCbutton.Size = UDim2.new(0, 170, 0, 30)
PCbutton.Position = UDim2.new(0.07, 0, 0.1, 0)
PCbutton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PCbutton.TextColor3 = Color3.fromRGB(255, 255, 255)
PCbutton.Text = "PC"
PCbutton.Parent = mainWindow

-- Закругление первой кнопки
local PCbuttonCorner = Instance.new("UICorner")
PCbuttonCorner.CornerRadius = UDim.new(0, 3)
PCbuttonCorner.Parent = PCbutton

-- Синий свечение
PCbutton.MouseEnter:Connect(function()
    PCbutton.BackgroundColor3 = Color3.fromRGB(0, 0, 255) 
end)
    
PCbutton.MouseLeave:Connect(function()
    PCbutton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
end)

PCbutton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/PCfly.lua"))()
    FlyscreenGui:Destroy()
end)


-- Создаем вторую кнопку
local TPbutton = Instance.new("TextButton")
TPbutton.Name = "Button2"
TPbutton.Size = UDim2.new(0, 170, 0, 30)
TPbutton.Position = UDim2.new(0.07, 0, 0.5, 0)
TPbutton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TPbutton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPbutton.Text = "TP"
TPbutton.Parent = mainWindow

-- Закругление второй кнопки
local TPbuttonCorner = Instance.new("UICorner")
TPbuttonCorner.CornerRadius = UDim.new(0, 3)
TPbuttonCorner.Parent = TPbutton

-- Синий свечение
TPbutton.MouseEnter:Connect(function()
    TPbutton.BackgroundColor3 = Color3.fromRGB(0, 0, 255) 
end)
    
TPbutton.MouseLeave:Connect(function()
    TPbutton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) 
end)

TPbutton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/iqoksz95-debug/IqokczHub/refs/heads/main/TPfly.lua"))()
    FlyscreenGui:Destroy()
end)
