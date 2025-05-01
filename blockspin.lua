-- Otimizador Gráfico
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Texture") or v:IsA("Decal") then
        v:Destroy()
    end
end
sethiddenproperty(game.Lighting, "Technology", Enum.Technology.Compatibility)

-- Configurações
local farmMode = "ATM" -- mude para "Steak" se quiser farmar na steak house
local speed = 100 -- velocidade do jogador
local autoBuyPlacas = true
local autoBuyFrigideiras = true

-- Anti-Ban básico
pcall(function()
    game:GetService("Players").LocalPlayer.Name = "Player_" .. math.random(100000,999999)
end)

-- Velocidade
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end)
end)

-- Anti-Morte
game:GetService("RunService").Heartbeat:Connect(function()
    local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health < 30 then
        humanoid.Health = 100
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0,100,0)) -- TP de emergência
    end
end)

-- Auto Farm
spawn(function()
    while true do
        wait(1)
        if farmMode == "ATM" then
            -- Farm ATM
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "ATM" and v:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        elseif farmMode == "Steak" then
            -- Farm Steak House
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "SteakGrill" and v:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(v.ProximityPrompt)
                end
            end
        end
    end
end)

-- Compra Automática de Placas para ATM
if autoBuyPlacas then
    spawn(function()
        while true do
            wait(10)
            local event = game:GetService("ReplicatedStorage"):FindFirstChild("BuyPlate")
            if event then
                event:FireServer()
            end
        end
    end)
end

-- Compra remota de frigideiras
if autoBuyFrigideiras then
    spawn(function()
        while true do
            wait(15)
            local shop = game:GetService("ReplicatedStorage"):FindFirstChild("BuyItem")
            if shop then
                shop:FireServer("FryingPan")
            end
        end
    end)
end
