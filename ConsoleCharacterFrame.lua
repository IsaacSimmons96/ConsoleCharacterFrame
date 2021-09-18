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
local QuestBorder =
    "Interface\\AddOns\\ConsoleCharacterFrame\\Textures\\UI-Icon-QuestBorder";

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


COLUMNMAX = 12

local function MoveItemSlots2()

    local bags = 5;
    local itemButton;
    local colCounter = 0;
    local rowCounter = 1;

    local slotArray = {GetContainerNumSlots(0),GetContainerNumSlots(1),GetContainerNumSlots(2),GetContainerNumSlots(3),GetContainerNumSlots(4)}

    for bagIndex = 1, bags, 1 do  
        for i=1, slotArray[bagIndex], 1 do

            local hasAdded = false;
            itemButton = _G["ContainerFrame"..(bagIndex).."Item"..i];
            ContainerFrame = _G["ContainerFrame"..(bagIndex)];
            
            ContainerFrame:SetFrameLevel(1000);
            ContainerFrame:SetParent(PaperDollFrame);
            itemButton:ClearAllPoints();

            if( bagIndex == 1 and i == 1 ) then
                    itemButton:SetPoint("CENTER",PaperDollFrame,  "CENTER", -70, 155);
                    hasAdded = true
                    else
                        if ( colCounter % COLUMNMAX == 0 and hasAdded == false ) then
                            itemButton:SetPoint("CENTER",PaperDollFrame,  "CENTER", -70, 155 - (41*rowCounter));                 
                            rowCounter = rowCounter + 1;         
                            hasAdded = true;        
                       else if( i == 1 ) then
                            itemButton:SetPoint("CENTER","ContainerFrame"..(bagIndex-1).."Item"..(slotArray[bagIndex-1]),  "CENTER", 41, 0);
                            hasAdded = true;
                       else
                           itemButton:SetPoint("CENTER","ContainerFrame"..(bagIndex).."Item"..(i-1),  "CENTER", 41, 0);
                           end
                       end
            end

            local NewTexture = itemButton:CreateTexture("ContainerFrame"..(bagIndex).."Item"..i.."Highlight", "OVERLAY");
            NewTexture:SetPoint("CENTER");
            NewTexture:SetWidth(40);
            NewTexture:SetHeight(40);
            NewTexture:SetTexture(QuestBorder);
            NewTexture:Hide()

            colCounter = colCounter + 1;
        end                            
    end
end

local function highlightItemButtons(bagID)
   local slots = GetContainerNumSlots(bagID);
    for i=1, slots, 1 do 
        local highlightTexture = _G["ContainerFrame"..(bagID+1).."Item"..i.."Highlight"];
        highlightTexture:Show();
    end
end

local function unhighlightItemButtons(bagID)
   local slots = GetContainerNumSlots(bagID);
    for i=1, slots, 1 do
        local highlightTexture = _G["ContainerFrame"..(bagID+1).."Item"..i.."Highlight"];
        highlightTexture:Hide();
    end
end

local function highlightItemsInBag0 ()
    highlightItemButtons(0);
end
local function unhighlightItemsInBag0 ()
    unhighlightItemButtons(0);
end

local function highlightItemsInBag1 ()
    highlightItemButtons(1);
end
local function unhighlightItemsInBag1 ()
    unhighlightItemButtons(1);
end

local function highlightItemsInBag2 ()
    highlightItemButtons(2);
end
local function unhighlightItemsInBag2 ()
    unhighlightItemButtons(2);
end

local function highlightItemsInBag3 ()
    highlightItemButtons(3);
end
local function unhighlightItemsInBag3 ()
    unhighlightItemButtons(3);
end

local function highlightItemsInBag4 ()
    highlightItemButtons(4);
end
local function unhighlightItemsInBag4 ()
    unhighlightItemButtons(4);
end


local function MoveFrame()
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

    ContainerFrame2Name:Hide();
    ContainerFrame2BackgroundTop:Hide();
    ContainerFrame2BackgroundMiddle1:Hide();
    ContainerFrame2BackgroundMiddle2:Hide();
    ContainerFrame2BackgroundBottom:Hide();
    ContainerFrame2PortraitButton:Hide();
    ContainerFrame2Portrait:Hide();

    ContainerFrame3Name:Hide();
    ContainerFrame3BackgroundTop:Hide();
    ContainerFrame3BackgroundMiddle1:Hide();
    ContainerFrame3BackgroundMiddle2:Hide();
    ContainerFrame3BackgroundBottom:Hide();
    ContainerFrame3PortraitButton:Hide();
    ContainerFrame3Portrait:Hide();

    ContainerFrame4Name:Hide();
    ContainerFrame4BackgroundTop:Hide();
    ContainerFrame4BackgroundMiddle1:Hide();
    ContainerFrame4BackgroundMiddle2:Hide();
    ContainerFrame4BackgroundBottom:Hide();
    ContainerFrame4PortraitButton:Hide();
    ContainerFrame4Portrait:Hide();

    ContainerFrame5Name:Hide();
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

    MoveItemSlots2();
end

PaperDollFrame:HookScript('OnShow', SkinFrames)
PaperDollFrame:HookScript('OnShow', MoveFrame)
PaperDollFrame:HookScript('OnHide', SkinFrames)

MainMenuBarBackpackButton:HookScript('OnEnter', highlightItemsInBag0)
MainMenuBarBackpackButton:HookScript('OnLeave', unhighlightItemsInBag0)

CharacterBag0Slot:HookScript('OnEnter', highlightItemsInBag1)
CharacterBag0Slot:HookScript('OnLeave', unhighlightItemsInBag1)

CharacterBag1Slot:HookScript('OnEnter', highlightItemsInBag2)
CharacterBag1Slot:HookScript('OnLeave', unhighlightItemsInBag2)

CharacterBag2Slot:HookScript('OnEnter', highlightItemsInBag3)
CharacterBag2Slot:HookScript('OnLeave', unhighlightItemsInBag3)

CharacterBag3Slot:HookScript('OnEnter', highlightItemsInBag4)
CharacterBag3Slot:HookScript('OnLeave', unhighlightItemsInBag4)