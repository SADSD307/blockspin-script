-- Criação da GUI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "BlockSpinMenu"

-- Frame principal
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Título
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "BlockSpin Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1

-- Botão Auto Farm
local autoFarmButton = Instance.new("TextButton", mainFrame)
autoFarmButton.Position = UDim2.new(0, 10, 0, 50)
autoFarmButton.Size = UDim2.new(0, 180, 0, 30)
autoFarmButton.Text = "Auto Farm: OFF"
autoFarmButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoFarmEnabled = false
local farmMode = "ATM"

autoFarmButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    autoFarmButton.Text = "Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF")
    if autoFarmEnabled then
        spawn(startAutoFarm) -- Inicia o Auto Farm
    end
end)

-- Função de Auto Farm
local function startAutoFarm()
    while autoFarmEnabled do
        if farmMode == "ATM" then
            local atm = workspace:FindFirstChild("ATM")
            if atm then
                -- Lógica para interagir com o ATM (adapte conforme o jogo)
            end
        elseif farmMode == "Steak" then
            local steakHouse = workspace:FindFirstChild("SteakHouse")
            if steakHouse then
                -- Lógica para interagir com a Steak House (adapte conforme o jogo)
            end
        end
        wait(1)
    end
end

-- Botão Modo de Farm (ATM ou Steak)
local farmModeButton = Instance.new("TextButton", mainFrame)
farmModeButton.Position = UDim2.new(0, 10, 0, 90)
farmModeButton.Size = UDim2.new(0, 180, 0, 30)
farmModeButton.Text = "Farm Mode: ATM"
farmModeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
farmModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

farmModeButton.MouseButton1Click:Connect(function()
    farmMode = (farmMode == "ATM") and "Steak" or "ATM"
    farmModeButton.Text = "Farm Mode: " .. farmMode
end)

-- Slider de Velocidade
local speedSlider = Instance.new("TextBox", mainFrame)
speedSlider.Position = UDim2.new(0, 10, 0, 130)
speedSlider.Size = UDim2.new(0, 180, 0, 30)
speedSlider.PlaceholderText = "Speed: 50"
speedSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)

speedSlider.FocusLost:Connect(function()
    local speed = tonumber(speedSlider.Text)
    if speed and speed > 0 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    else
        speedSlider.Text = "50"
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
end)

-- Botão Anti-Morte
local antiDeathButton = Instance.new("TextButton", mainFrame)
antiDeathButton.Position = UDim2.new(0, 10, 0, 170)
antiDeathButton.Size = UDim2.new(0, 180, 0, 30)
antiDeathButton.Text = "Anti Death: OFF"
antiDeathButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
antiDeathButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local antiDeathEnabled = false

antiDeathButton.MouseButton1Click:Connect(function()
    antiDeathEnabled = not antiDeathEnabled
    antiDeathButton.Text = "Anti Death: " .. (antiDeathEnabled and "ON" or "OFF")
    if antiDeathEnabled then
        spawn(antiDeath) -- Começa a monitorar a saúde do personagem
    end
end)

-- Função Anti-Morte
local function antiDeath()
    while antiDeathEnabled do
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health < 30 then
            humanoid.Health = 100
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, 100, 0)) -- Teleporta para um ponto seguro
        end
        wait(1)
    end
end

-- Botão Compra Automática de Frigideiras
local autoBuyFriesButton = Instance.new("TextButton", mainFrame)
autoBuyFriesButton.Position = UDim2.new(0, 10, 0, 210)
autoBuyFriesButton.Size = UDim2.new(0, 180, 0, 30)
autoBuyFriesButton.Text = "Auto Buy Frying Pan: OFF"
autoBuyFriesButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
autoBuyFriesButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoBuyFriesEnabled = false

autoBuyFriesButton.MouseButton1Click:Connect(function()
    autoBuyFriesEnabled = not autoBuyFriesEnabled
    autoBuyFriesButton.Text = "Auto Buy Frying Pan: " .. (autoBuyFriesEnabled and "ON" or "OFF")
    if autoBuyFriesEnabled then
        spawn(autoBuyFryingPans) -- Começa a comprar automaticamente
    end
end)

-- Função de Compra Automática de Frigideiras
local function autoBuyFryingPans()
    while autoBuyFriesEnabled do
        wait(10)
        local shop = game:GetService("ReplicatedStorage"):FindFirstChild("BuyItem")
        if shop then
            shop:FireServer("FryingPan")
        end
    end
end

-- Botão Compra Automática de Placas
local autoBuyPlatesButton = Instance.new("TextButton", mainFrame)
autoBuyPlatesButton.Position = UDim2.new(0, 10, 0, 250)
autoBuyPlatesButton.Size = UDim2.new(0, 180, 0, 30)
autoBuyPlatesButton.Text = "Auto Buy Plates: OFF"
autoBuyPlatesButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
autoBuyPlatesButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoBuyPlatesEnabled = false

autoBuyPlatesButton.MouseButton1Click:Connect(function()
    autoBuyPlatesEnabled = not autoBuyPlatesEnabled
    autoBuyPlatesButton.Text = "Auto Buy Plates: " .. (autoBuyPlatesEnabled and "ON" or "OFF")
    if autoBuyPlatesEnabled then
        spawn(autoBuyPlates) -- Começa a comprar automaticamente
    end
end)

-- Função de Compra Automática de Placas
local function autoBuyPlates()
    while autoBuyPlatesEnabled do
        wait(10)
        local event = game:GetService("ReplicatedStorage"):FindFirstChild("BuyPlate")
        if event then
            event:FireServer()
        end
    end
end
