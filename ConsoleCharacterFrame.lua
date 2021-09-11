---@diagnostic disable: undefined-global
--------------------------------------------------------------------------------------
-- Console Character Frame
--------------------------------------------------------------------------------------
PAPERDOLLFRAME_RIGHTTOP_INDEX = 1;
PAPERDOLLFRAME_LEFTBOTTOM_INDEX = 2;
PAPERDOLLFRAME_RIGHTBOTTOM_INDEX = 3;

local TopMiddle =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-MiddleTop";
local TopMiddle2 =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-MiddleTop2";
local BottomMiddle =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-MiddleBottom";
local BottomMiddle2 =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-MiddleBottom2";
local LeftTop =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-LeftTop";
local LeftBottom =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-LeftBottom";
local RightTop =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-RightTop";
local RightBottom =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-RightBottom";
local CharacterFrameLeftBottom =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-CharacterFrameLeftBottom";

HasCreatedTextures = false;

local function SetupTexture(TextureName, TextureFile, Point, Xoffset, Yoffset,
                            Width, Height)
    NewTexture = PaperDollFrame:CreateTexture(TextureName, "BORDER");
    NewTexture:SetPoint(Point, Xoffset, Yoffset);
    NewTexture:SetWidth(Width);
    NewTexture:SetHeight(Height);
    NewTexture:SetTexture(TextureFile);
    return NewTexture;
end

local function SkinFrames()
    local shown = PaperDollFrame:IsShown();
    
    if (shown == true) then
        CharacterFrame:SetSize(896, 512);

        -- Adjust title text
        CharacterNameFrame:ClearAllPoints();
        CharacterNameFrame:SetPoint("TOP", CharacterFrame, "TOP", 0, -18);

        if (HasCreatedTextures == false) then
            local kids = {PaperDollFrame:GetRegions()};

            local index = 0;
            for _, child in ipairs(kids) do
                if (index == PAPERDOLLFRAME_RIGHTTOP_INDEX) then
                    child:SetTexture(LeftTop);
                end
                if (index == PAPERDOLLFRAME_LEFTBOTTOM_INDEX) then
                    child:SetTexture(CharacterFrameLeftBottom);
                end
                if (index == PAPERDOLLFRAME_RIGHTBOTTOM_INDEX) then
                    child:SetTexture(LeftBottom);
                end
                index = index + 1;
            end

            SetupTexture("ConsoleInventoryMiddle", TopMiddle, "TOPLEFT", 384, 0,
                         256, 256)

            SetupTexture("ConsoleInventoryMiddle2", TopMiddle2, "TOPLEFT", 640, 0,
                         256, 256)

            SetupTexture("ConsoleInventoryMiddleBottom", BottomMiddle,
                         "BOTTOMLEFT", 384, 0, 256, 256)

            SetupTexture("ConsoleInventoryMiddleBottom2", BottomMiddle2,
                         "BOTTOMLEFT", 640, 0, 256, 256)

            local ConsoleInventoryTopRight = SetupTexture(
                                                 "ConsoleInventoryTopRight",
                                                 RightTop, "TOPRIGHT", 128, 0,
                                                 128, 256);

            ConsoleInventoryTopRight:SetPoint("TOPRIGHT",
                                              ConsoleInventoryMiddle,
                                              "TOPRIGHT", 258, 0);

            local ConsoleInventoryBottomRight = SetupTexture(
                                                    "ConsoleInventoryBottomRight",
                                                    RightBottom, "BOTTOMRIGHT",
                                                    128, 0, 128, 256);

            ConsoleInventoryBottomRight:SetPoint("BOTTOMRIGHT",
                                                 ConsoleInventoryMiddleBottom,
                                                 "BOTTOMRIGHT", 258, 0);
            HasCreatedTextures = true;
        end
    else
        CharacterFrame:SetSize(384, 512);
    end

    ToggleAllBags();
end

local function MoveItemSlots( id )
    local baseSize = GetContainerNumSlots(id);
    local itemButton;

    for i=1, baseSize, 1 do
        itemButton = _G["ContainerFrame"..(id + 1).."Item"..i];
        ContainerFrame = _G["ContainerFrame"..(id + 1)];

        print("ContainerFrame"..(id + 1))
        
        ContainerFrame:SetFrameLevel(1000)
        ContainerFrame:SetParent(PaperDollFrame)
        itemButton:ClearAllPoints()

        if ( i == 1 ) then
                itemButton:SetPoint("CENTER",PaperDollFrame,  "CENTER", -75, (40*id));
        else
                itemButton:SetPoint("CENTER","ContainerFrame"..(id + 1).."Item"..(i-1),  "CENTER", 40, 0);
        end
    end
end

local function egg()
    MoveItemSlots(1);
end

local function MoveFrame()
    ContainerFrame1:SetPoint("BOTTOMRIGHT", ConsoleInventoryMiddle, "BOTTOMRIGHT", -112, -14);
    ContainerFrame1BackgroundTop:SetTexture("Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\CCF-Bag");

    ContainerFrame1:EnableMouse(false);
    ContainerFrame2:EnableMouse(false);
    ContainerFrame3:EnableMouse(false);
    ContainerFrame4:EnableMouse(false);
    ContainerFrame5:EnableMouse(false);
   

    ContainerFrame1Name:Hide();
    ContainerFrame1BackgroundTop:Hide();
    ContainerFrame1BackgroundMiddle1:Hide();
    ContainerFrame1BackgroundMiddle2:Hide();
    ContainerFrame1BackgroundBottom:Hide();
    ContainerFrame1AddSlotsButton:Hide();
    ContainerFrame1PortraitButton:Hide();
    ContainerFrame1Portrait:Hide();

    ContainerFrame2:SetPoint("BOTTOMRIGHT", ConsoleInventoryMiddle, "BOTTOMRIGHT", 56, 9);
    ContainerFrame2Name:Hide();
    ContainerFrame2BackgroundTop:Hide();
    ContainerFrame2BackgroundMiddle1:Hide();
    ContainerFrame2BackgroundMiddle2:Hide();
    ContainerFrame2BackgroundBottom:Hide();
    ContainerFrame2PortraitButton:Hide();
    ContainerFrame2Portrait:Hide();

    ContainerFrame3Name:Hide();
    ContainerFrame3:SetPoint("BOTTOMRIGHT", ConsoleInventoryMiddle, "BOTTOMRIGHT", -112, -155);
    ContainerFrame3BackgroundTop:Hide();
    ContainerFrame3BackgroundMiddle1:Hide();
    ContainerFrame3BackgroundMiddle2:Hide();
    ContainerFrame3BackgroundBottom:Hide();
    ContainerFrame3PortraitButton:Hide();
    ContainerFrame3Portrait:Hide();

    ContainerFrame4Name:Hide();
    ContainerFrame4:SetPoint("BOTTOMRIGHT", ConsoleInventoryMiddle, "BOTTOMRIGHT", 56, -155);
    ContainerFrame4BackgroundTop:Hide();
    ContainerFrame4BackgroundMiddle1:Hide();
    ContainerFrame4BackgroundMiddle2:Hide();
    ContainerFrame4BackgroundBottom:Hide();
    ContainerFrame4PortraitButton:Hide();
    ContainerFrame4Portrait:Hide();

    ContainerFrame5Name:Hide();
    ContainerFrame5:SetPoint("BOTTOMRIGHT", ConsoleInventoryMiddle, "BOTTOMRIGHT", 224, 9);
    ContainerFrame5BackgroundTop:Hide();
    ContainerFrame5BackgroundMiddle1:Hide();
    ContainerFrame5BackgroundMiddle2:Hide();
    ContainerFrame5BackgroundBottom:Hide();
    ContainerFrame5PortraitButton:Hide();
    ContainerFrame5Portrait:Hide();

    ContainerFrame1MoneyFrame:SetPoint("TOPRIGHT",
    ConsoleInventoryTopRight, "TOPRIGHT", -30, -45);

    ContainerFrame1CloseButton:Hide();
    ContainerFrame2CloseButton:Hide();
    ContainerFrame3CloseButton:Hide();
    ContainerFrame4CloseButton:Hide();
    ContainerFrame5CloseButton:Hide();

--     local f = CreateFrame("Frame","Egg",PaperDollFrame)
--     f:SetWidth(1000)
--     f:SetHeight(500)

--     local t = f:CreateTexture(nil,"BACKGROUND")
--     t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-Charace-Factions.blp")
--     t:SetAllPoints(f)
--     f.texture = t

-- f:SetPoint("CENTER",0,0)
-- f:Show()

    MoveItemSlots(0);
    MoveItemSlots(1);
    MoveItemSlots(2);
    MoveItemSlots(3);
    MoveItemSlots(4);
end

PaperDollFrame:HookScript('OnShow', SkinFrames)
PaperDollFrame:HookScript('OnHide', SkinFrames)
ContainerFrame1:HookScript('OnShow', MoveFrame)
ContainerFrame2:HookScript('OnShow', MoveFrame)
ContainerFrame3:HookScript('OnShow', MoveFrame)
ContainerFrame4:HookScript('OnShow', MoveFrame)
ContainerFrame5:HookScript('OnShow', MoveFrame)



    
--     itemButton:Show();
-- end
-- if (id == 0 and secured and not IsTutorialFlagged(TUTORIAL_BAG_SLOTS_AUTHENTICATOR)) then
--     TriggerTutorial(TUTORIAL_BAG_SLOTS_AUTHENTICATOR);
-- end
-- end
-- for i=size + 1, MAX_CONTAINER_ITEMS, 1 do
-- _G[name.."Item"..i]:Hide();
-- end