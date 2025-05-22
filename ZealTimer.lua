function print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[ZealTimer by Dollerp]:|r " .. tostring(msg))
    end
end

-- Create a frame to handle events
local zealTimerFrame = CreateFrame("Frame", "zealTimerFrame", UIParent)
zealTimerFrame:RegisterEvent("UNIT_AURA")
zealTimerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
zealTimerFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

local _width = 58
local _height = 50 + (_width - 10)

-- Set size and default start location
zealTimerFrame:SetWidth(_width)
zealTimerFrame:SetHeight(_height)
zealTimerFrame:SetPoint("CENTER", UIParent, "CENTER", 145, 15) -- Moved 50 pixels to the right

-- Add background with padding and transparency
zealTimerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 14,
    edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
zealTimerFrame:SetBackdropColor(0, 0, 0, 0.7) -- Black with 70% transparency

-- Enable dragging with CTRL + Left-Click
zealTimerFrame.isMoving = false
zealTimerFrame.isMouseEnabled = true
zealTimerFrame:SetMovable(true)
zealTimerFrame:EnableMouse(true)
zealTimerFrame:RegisterForDrag("LeftButton")

zealTimerFrame:SetScript("OnMouseDown", function()
    if arg1 == "LeftButton" and IsControlKeyDown() then
        this:StartMoving()
        this.isMoving = true
    end
end)

zealTimerFrame:SetScript("OnMouseUp", function()
    if this.isMoving then
        this:StopMovingOrSizing()
        this.isMoving = false
    end
end)

zealTimerFrame:SetScript("OnEnter", function()
    if not IsControlKeyDown() then
        this:EnableMouse(false)
        this.isMouseEnabled = false
    else
        this:EnableMouse(true)
        this.isMouseEnabled = true
    end
end)

zealTimerFrame:SetScript("OnLeave", function()
    this:EnableMouse(true) -- Re-enable mouse after leaving to avoid getting "stuck"
end)

-- Add Zeal buff icon
zealTimerFrame.icon = zealTimerFrame:CreateTexture(nil, "ARTWORK")
zealTimerFrame.icon:SetWidth(_width - 10)
zealTimerFrame.icon:SetHeight(_width - 10)
zealTimerFrame.icon:SetPoint("TOP", zealTimerFrame, "TOP", 0, -5) -- Position it at the top
zealTimerFrame.icon:SetTexture("Interface\\Icons\\Spell_Holy_CrusaderStrike") -- Path to Zeal buff icon

-- Create a font string to display the "Zeal:" label
-- zealTimerFrame.labelText = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
-- zealTimerFrame.labelText:SetPoint("TOP", zealTimerFrame.icon, "BOTTOM", 0, -5) -- Adjust for padding
-- zealTimerFrame.labelText:SetText("Zeal:")

-- Create a font string to display the timer below the label
zealTimerFrame.text = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zealTimerFrame.text:SetPoint("TOP", zealTimerFrame.icon, "BOTTOM", 0, -5)
zealTimerFrame.text:SetText("N/A")

-- Create a font string to display the rank below the timer
zealTimerFrame.rankText = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zealTimerFrame.rankText:SetPoint("TOP", zealTimerFrame.text, "BOTTOM", 0, -5)
zealTimerFrame.rankText:SetText("(N/A)")

-- Known texture path for the Zeal buff icon
local zealTexture = "Interface\\Icons\\Spell_Holy_CrusaderStrike"
-- Variables to track Zeal buff
local zealStartTime = 0
local zealStacks = 0

-- Function to update Zeal buff information
local function UpdateZealInfo()
    local found = false
    for i = 1, 64 do
        local texture, applications = UnitBuff("player", i)
        if texture and texture == zealTexture then
            if zealStacks ~= applications then
                zealStartTime = GetTime()
                zealStacks = applications
            end
            found = true
            break
        end
    end
    if not found then
        zealStartTime = 0
        zealStacks = 0
    end
end

local function UpdateZealTimerGUI()
    local elapsedTime = GetTime() - zealStartTime
    local remainingTime = 30 - elapsedTime
    if (remainingTime <= 0) then
        zealTimerFrame.text:SetText("N/A")
    else
        zealTimerFrame.text:SetText(math.floor(remainingTime))
    end
    zealTimerFrame.rankText:SetText("(".. zealStacks ..")")
end 

zealTimerFrame:SetScript("OnUpdate", function() 
    UpdateZealTimerGUI()
    if not this.isMoving and not this.isMouseEnabled then
        this:EnableMouse(true)
        this.isMouseEnabled = true
    end 
end)

-- Event handler
zealTimerFrame:SetScript("OnEvent", function()
    if event == "UNIT_AURA" and arg1 == "player" then
        UpdateZealInfo()
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateZealInfo()
    elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE"  then
        if (string.find(arg1, "Crusader Strike")) then
            zealStartTime = GetTime()
        end 
    end
end)

print("Loaded")
