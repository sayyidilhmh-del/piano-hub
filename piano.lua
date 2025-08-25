--// 🎹 CAO Piano AutoPlay Hub (Advanced Edition)
--// Made by CAO

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "CAO Hub",
        Text = "🎶 Piano Hub Advanced Loaded",
        Duration = 5
    })
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CAO_PianoHub"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.Position = UDim2.new(0.3,0,0.3,0)
MainFrame.Size = UDim2.new(0,350,0,360)

local UIScale = Instance.new("UIScale", MainFrame)
UIScale.Scale = 1

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🎹 CAO Piano Hub"
Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

local SongList = Instance.new("ScrollingFrame", MainFrame)
SongList.Position = UDim2.new(0,0,0,40)
SongList.Size = UDim2.new(1,0,1,-120)
SongList.CanvasSize = UDim2.new(0,0,0,0)
SongList.ScrollBarThickness = 6
SongList.BackgroundColor3 = Color3.fromRGB(35,35,35)

local UIListLayout = Instance.new("UIListLayout", SongList)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local NowPlaying = Instance.new("TextLabel", MainFrame)
NowPlaying.Size = UDim2.new(1,0,0,30)
NowPlaying.Position = UDim2.new(0,0,1,-80)
NowPlaying.Text = "🎶 Ready"
NowPlaying.BackgroundColor3 = Color3.fromRGB(30,30,30)
NowPlaying.TextColor3 = Color3.fromRGB(200,200,200)

local TempoSlider = Instance.new("TextBox", MainFrame)
TempoSlider.Size = UDim2.new(0.5, -5, 0, 30)
TempoSlider.Position = UDim2.new(0,5,1,-40)
TempoSlider.PlaceholderText = "Tempo (default 0.25)"
TempoSlider.TextColor3 = Color3.fromRGB(255,255,255)
TempoSlider.BackgroundColor3 = Color3.fromRGB(50,50,50)

local StopBtn = Instance.new("TextButton", MainFrame)
StopBtn.Size = UDim2.new(0.45, -5, 0, 30)
StopBtn.Position = UDim2.new(0.55,0,1,-40)
StopBtn.Text = "⏹ Stop"
StopBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
StopBtn.TextColor3 = Color3.fromRGB(255,255,255)

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0,40,0,40)
ToggleButton.Position = UDim2.new(0,10,0,10)
ToggleButton.Text = "🎹"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)

-- Lagu Default
local Songs = {
    ["Twinkle Twinkle"] = "q q y y t t y",
    ["Golden Hour (JVKE)"] = "q e y t y t q w r"
}

-- Cari Piano
local function findPianoFrame()
    for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v:IsA("TextButton") and string.match(v.Text:lower(), "[qwertyuiopasdfghjklzxcvbnm]") then
            return v.Parent
        end
    end
    return nil
end

-- Main Lagu
local playing = false
local function playSong(name, notes)
    local pianoFrame = findPianoFrame()
    if not pianoFrame then
        warn("⚠ Piano tidak ditemukan!")
        return
    end
    playing = true
    NowPlaying.Text = "🎶 Now Playing: " .. name
    local delayTime = tonumber(TempoSlider.Text) or 0.25
    for note in notes:gmatch("%S+") do
        if not playing then break end
        local keyButton = pianoFrame:FindFirstChild(note)
        if keyButton and keyButton:IsA("TextButton") then
            keyButton:Activate()
        end
        task.wait(delayTime)
    end
    NowPlaying.Text = "🎶 Ready"
end

-- Stop
StopBtn.MouseButton1Click:Connect(function()
    playing = false
    NowPlaying.Text = "⏹ Stopped"
end)

-- Refresh List
local function refreshSongList()
    for _, child in pairs(SongList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for name, notes in pairs(Songs) do
        local SongButton = Instance.new("TextButton")
        SongButton.Parent = SongList
        SongButton.Size = UDim2.new(1, -6, 0, 30)
        SongButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
        SongButton.TextColor3 = Color3.fromRGB(255,255,255)
        SongButton.Text = "▶ " .. name
        SongButton.MouseButton1Click:Connect(function()
            playSong(name, notes)
        end)
    end
    SongList.CanvasSize = UDim2.new(0,0,0,#Songs*35)
end

refreshSongList()

-- Toggle
local visible = true
ToggleButton.MouseButton1Click:Connect(function()
    visible = not visible
    MainFrame.Visible = visible
end)
