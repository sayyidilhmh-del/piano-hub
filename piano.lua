-- CAO Piano Hub
-- AutoPlay with VirtualInputManager (Mobile & PC Friendly)

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "CaoPianoHub"

-- Songs Table
local songs = {
    ["Golden Hour (JVKE)"] = {"q","w","e","r","t","y","u","i","o","p"},
    ["Twinkle Twinkle"] = {"q","q","w","w","e","e","w","q","q","w","w","e","e","w"}
}

-- pressKey function
local function pressKey(key)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

-- playSong function
local function playSong(song)
    for _, note in ipairs(song) do
        pressKey(note)
        task.wait(0.25) -- tempo (atur sesuai kebutuhan)
    end
end

-- GUI Setup
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "🎹 CAO Piano Hub"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(50,50,50)

local listFrame = Instance.new("ScrollingFrame", frame)
listFrame.Size = UDim2.new(1,0,1,-30)
listFrame.Position = UDim2.new(0,0,0,30)
listFrame.CanvasSize = UDim2.new(0,0,0,0)
listFrame.ScrollBarThickness = 6

-- Add Song Buttons
local y = 0
for name, song in pairs(songs) do
    local btn = Instance.new("TextButton", listFrame)
    btn.Size = UDim2.new(1,-10,0,30)
    btn.Position = UDim2.new(0,5,0,y)
    btn.Text = "▶ "..name
    btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        playSong(song)
    end)
    y = y + 35
end

listFrame.CanvasSize = UDim2.new(0,0,0,y)
