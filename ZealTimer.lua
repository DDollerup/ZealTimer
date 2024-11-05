-- Create a frame to handle events
local zealTimerFrame = CreateFrame("Frame", "zealTimerFrame", UIParent)
zealTimerFrame:RegisterEvent("UNIT_AURA")
zealTimerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
zealTimerFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")

zealTimerFrame:SetWidth(100)
zealTimerFrame:SetHeight(90)
zealTimerFrame:SetPoint("CENTER", UIParent, "CENTER", 145, 15) -- Moved 50 pixels to the right

-- Make the frame draggable
zealTimerFrame:SetMovable(true)
zealTimerFrame:EnableMouse(true)
zealTimerFrame:RegisterForDrag("LeftButton")
zealTimerFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
zealTimerFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

-- Add background with padding and transparency
zealTimerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
zealTimerFrame:SetBackdropColor(0, 0, 0, 0.7) -- Black with 70% transparency


-- Create a font string to display the "Zeal:" label
zealTimerFrame.labelText = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zealTimerFrame.labelText:SetPoint("TOP", zealTimerFrame, "TOP", 0, -20) -- Adjust for padding
zealTimerFrame.labelText:SetText("Zeal:")

-- Create a font string to display the timer below the label
zealTimerFrame.text = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zealTimerFrame.text:SetPoint("TOP", zealTimerFrame.labelText, "BOTTOM", 0, -5)
zealTimerFrame.text:SetText("N/A")

-- Create a font string to display the rank below the timer
zealTimerFrame.rankText = zealTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
zealTimerFrame.rankText:SetPoint("TOP", zealTimerFrame.text, "BOTTOM", 0, -5)
zealTimerFrame.rankText:SetText("(N/A)")

-- Enable dragging with CTRL + Left-Click
zealTimerFrame:SetMovable(true)
zealTimerFrame:EnableMouse(true)
zealTimerFrame:RegisterForDrag("LeftButton")

zealTimerFrame:SetScript("OnMouseDown", function()
    if arg1 == "LeftButton" and IsControlKeyDown() then
        this:StartMoving()
    end
end)

zealTimerFrame:SetScript("OnMouseUp", function()
    if arg1 == "LeftButton" then
        this:StopMovingOrSizing()
    end
end)

-- Known texture path for the Zeal buff icon
local zealTexture = "Interface\\Icons\\INV_Jewelry_Talisman_01"
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

-- Function to display remaining duration
-- local function DisplayZealDuration()
--     if zealStacks > 0 then
--         local elapsedTime = GetTime() - zealStartTime
--         local remainingTime = 30 - elapsedTime
--         if remainingTime > 0 then
--             print("Zeal Buff: " .. zealStacks .. " stacks, " .. string.format("%.1f", remainingTime) .. " seconds remaining.")
--         else
--             zealStacks = 0
--             print("Zeal Buff expired.")
--         end
--     else
--         print("Zeal Buff not active.")
--     end
-- end

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

zealTimerFrame:SetScript("OnUpdate", UpdateZealTimerGUI)

-- Event handler
zealTimerFrame:SetScript("OnEvent", function()
    -- print("arg1: " .. arg1)
    if event == "UNIT_AURA" and arg1 == "player" then
        UpdateZealInfo()
        -- DisplayZealDuration()
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateZealInfo()
        -- DisplayZealDuration()
    elseif event == "CHAT_MSG_SPELL_SELF_DAMAGE"  then
        if (string.find(arg1, "Crusader Strike")) then
            zealStartTime = GetTime()
            -- DisplayZealDuration()
        end 
    end
end)




print("ZealTimer by Dollerp - Loaded")
