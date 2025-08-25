-- CAO Piano Hub (VirtualUser Version)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Songs Table
local songs = {
    ["Golden Hour (JVKE)"] = {"q","w","e","r","t","y","u","i","o","p"},
    ["Twinkle Twinkle"] = {"q","q","w","w","e","e","w"}
}

-- Press Key Function
local function pressKey(key)
    VirtualUser:SendKeyEvent(true, key, false, game)
    task.wait(0.15)
    VirtualUser:SendKeyEvent(false, key, false, game)
end

-- Play Song Function
local function playSong(song)
    for _, key in ipairs(song) do
        pressKey(key)
        task.wait(0.25)
    end
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "CAO_PianoHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,300,0,200)
Frame.Position = UDim2.new(0.35,0,0.3,0)
Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Padding = UDim.new(0,5)

for songName, notes in pairs(songs) do
    local btn = Instance.new("TextButton", Frame)
    btn.Text = songName
    btn.Size = UDim2.new(1,-10,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function()
        playSong(notes)
    end)
end
