--// 🎹 CAO Piano AutoPlay Hub (Local Request Edition)
--// Made by CAO

-- Notification
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "CAO Hub",
        Text = "🎶 Piano AutoPlay Loaded",
        Duration = 5
    })
end)

-- GUI UTAMA
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SongList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")
local RequestButton = Instance.new("TextButton")

ScreenGui.Name = "CAO_PianoHub"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 320)

Title.Name = "Title"
Title.Parent = MainFrame
Title.Text = "🎹 CAO Piano Hub"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

SongList.Name = "SongList"
SongList.Parent = MainFrame
SongList.Position = UDim2.new(0, 0, 0, 40)
SongList.Size = UDim2.new(1, 0, 1, -80)
SongList.CanvasSize = UDim2.new(0, 0, 0, 0)
SongList.ScrollBarThickness = 6
SongList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

UIListLayout.Parent = SongList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

RequestButton.Name = "RequestButton"
RequestButton.Parent = MainFrame
RequestButton.Size = UDim2.new(1, 0, 0, 40)
RequestButton.Position = UDim2.new(0, 0, 1, -40)
RequestButton.Text = "➕ Request New Song"
RequestButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
RequestButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 120, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "🎹 Show / Hide"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local visible = true
ToggleButton.MouseButton1Click:Connect(function()
    visible = not visible
    MainFrame.Visible = visible
end)

-- TABLE LAGU DEFAULT
local Songs = {
    ["Twinkle Twinkle"] = "q q y y t t y",
    ["Golden Hour (JVKE)"] = "q e y t y t q w r"
}

-- Cari piano GUI
local function findPianoFrame()
    for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
        if v:IsA("TextButton") and string.match(v.Text:lower(), "[qwertyuiopasdfghjklzxcvbnm]") then
            return v.Parent
        end
    end
    return nil
end

-- Fungsi main lagu
local function playSong(song)
    local pianoFrame = findPianoFrame()
    if not pianoFrame then
        warn("⚠ Piano tidak ditemukan di layar!")
        return
    end
    for note in song:gmatch("%S+") do
        local keyButton = pianoFrame:FindFirstChild(note)
        if keyButton and keyButton:IsA("TextButton") then
            keyButton:Activate()
        end
        task.wait(0.25)
    end
end

-- Tambah button lagu
local function refreshSongList()
    for _, child in pairs(SongList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for name, notes in pairs(Songs) do
        local SongButton = Instance.new("TextButton")
        SongButton.Parent = SongList
        SongButton.Size = UDim2.new(1, -6, 0, 30)
        SongButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        SongButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        SongButton.Text = "▶ " .. name
        SongButton.MouseButton1Click:Connect(function()
            playSong(notes)
        end)
    end
    SongList.CanvasSize = UDim2.new(0,0,0,#Songs*35)
end

refreshSongList()

-- GUI Request Lagu
RequestButton.MouseButton1Click:Connect(function()
    local RequestFrame = Instance.new("Frame", ScreenGui)
    RequestFrame.Size = UDim2.new(0, 300, 0, 160)
    RequestFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
    RequestFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    local Title = Instance.new("TextLabel", RequestFrame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "➕ Add New Song"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local SongNameBox = Instance.new("TextBox", RequestFrame)
    SongNameBox.Size = UDim2.new(1, -10, 0, 30)
    SongNameBox.Position = UDim2.new(0, 5, 0, 40)
    SongNameBox.PlaceholderText = "Song Name..."
    SongNameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SongNameBox.TextColor3 = Color3.fromRGB(255,255,255)

    local SongNotesBox = Instance.new("TextBox", RequestFrame)
    SongNotesBox.Size = UDim2.new(1, -10, 0, 50)
    SongNotesBox.Position = UDim2.new(0, 5, 0, 80)
    SongNotesBox.PlaceholderText = "Notes (ex: q w e r t)"
    SongNotesBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SongNotesBox.TextColor3 = Color3.fromRGB(255,255,255)
    SongNotesBox.TextWrapped = true
    SongNotesBox.ClearTextOnFocus = false

    local AddBtn = Instance.new("TextButton", RequestFrame)
    AddBtn.Size = UDim2.new(1, -10, 0, 30)
    AddBtn.Position = UDim2.new(0, 5, 0, 135)
    AddBtn.Text = "Add Song"
    AddBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    AddBtn.TextColor3 = Color3.fromRGB(255,255,255)

    AddBtn.MouseButton1Click:Connect(function()
        local name = SongNameBox.Text
        local notes = SongNotesBox.Text
        if name ~= "" and notes ~= "" then
            Songs[name] = notes
            refreshSongList()
            RequestFrame:Destroy()
        end
    end)
end)
