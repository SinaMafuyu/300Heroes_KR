include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local SKIN_LISTL_BTN = {}			-- ͼƬ��ť
local SKIN_LISTL_NAME = {}			-- Ƥ������
local SKIN_LISTL_HAVE = {}			-- Ƥ���Ƿ�ӵ��
local SKIN_LISTL_BUY = {}			-- Ƥ������ť
local SKIN_LISTL_PRICE = {}			-- Ƥ����ʯ�۸�
local skin_heroname = {}

local SKIN_LISTL = {}
SKIN_LISTL.BK = {}

SKIN_LISTL.NAME = {}
SKIN_LISTL.HAVE = {}
SKIN_LISTL.POSXS = { 0, 121, 242}
SKIN_LISTL.PRICE = { 999, 898, 887, 666}
SKIN_LISTL.POSX = { 0, 0, 0, 0}
SKIN_LISTL.POSY = { 0, 0, 0, 0}
SKIN_LISTL.POSW = { 110, 110, 110, 110}
SKIN_LISTL.POSH = { 170, 170, 170, 170}

local IsCanSelSkin = 0				-- �Ƿ��ܹ�����Ƥ��
local SkinId = {}
local heroid_skinframe = 0
local CurSelSkin = {}
local UseDefaultSkin = nil
local SkinMaxCount = 0
local IsHave = {}
local skinimgpath_skinframe = {}
local Skin_LevelImg = {}
local Skin_Level = {}

local LastSelSkinIndex = 0

local LeftPageButton = nil
local RightPageButton = nil
local CurPage = 1					-- ��ǰ
local MinPage = 1
local MaxPage = 4

function InitGame_SkinFrame(wnd, bisopen)
	g_game_SkinFrame_ui = CreateWindow( wnd.id, 845, 194, 128*3, 206)
	InitMainGame_SkinFrame( g_game_SkinFrame_ui)
	g_game_SkinFrame_ui:SetVisible( bisopen)
end
function InitMainGame_SkinFrame(wnd)
	for i=1, 3 do
		SKIN_LISTL_BTN[i] = wnd:AddImage( path_hero.."ffffff_hero.png", 0, 0, 1280,800)
		XWindowEnableAlphaTouch(SKIN_LISTL_BTN[i].id)
		
		SKIN_LISTL_BTN[i]:SetVisible(0)
		CurSelSkin[i] = SKIN_LISTL_BTN[i]:AddImage( path_task.."SignIned_sign.png", 20, 40, 64, 64)
		CurSelSkin[i]:SetVisible(0)
		XSetAddImageRect( SKIN_LISTL_BTN[i].id, 0, 0, 110, 170, SKIN_LISTL.POSXS[i] , 0, 110, 170)
		SKIN_LISTL_BTN[i]:SetTouchEnabled(1)
		
		SKIN_LISTL_BTN[i]:AddImage(path_hero.."skinbg_hero.png", -33, -40, 168, 38)
		SKIN_LISTL_NAME[i] = SKIN_LISTL_BTN[i]:AddFont( "NULL", 11,8,45,22,200, 0, 0xa0a0ff)
		local A = SKIN_LISTL_BTN[i]:AddImage( path_hero.."skinside_hero.png", 0,0,112,173)
		A:SetTouchEnabled(0)
		local B = A:AddImage( path_hero.."skinhave_hero.png", 3,146,105,23)
		B:SetTouchEnabled(0)

		SKIN_LISTL_HAVE[i] = B:AddFont( "Error", 12, 8, 0, 0, 105, 23, 0xeeeef2)

		-- Ƥ����ť
		SKIN_LISTL_BTN[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			-- log("\nClickSkinIndex = "..i)
			LastSelSkinIndex = i
			-- log("\nIsCanSelSkin = "..IsCanSelSkin)
			if IsCanSelSkin==1 then
				XSelSkinEnterGame_skinframe(i+CurPage-1)
			end
			SetWndBgImg_gamestart(skinimgpath_skinframe[i], Skin_Level[i])
			SetWndBgImg_choosehero(skinimgpath_skinframe[i], Skin_Level[i])
		end
		
		-- Ƥ������
		SKIN_LISTL_BUY[i] =  SKIN_LISTL_BTN[i]:AddButton(path_hero.."buySkin1_hero.png",path_hero.."buySkin2_hero.png",path_hero.."buySkin3_hero.png", 0, 175, 128, 32)
		local temppic = SKIN_LISTL_BUY[i]:AddImage( path_shop.."gold_shop.png", 10, 0, 64, 64)
		temppic:SetTouchEnabled(0)
		SKIN_LISTL_PRICE[i] = SKIN_LISTL_BUY[i]:AddFont( "NULL", 12, 8, 0, 0, 112, 32, 0xffffff)
		
		SKIN_LISTL_BUY[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			-- SetShopItemBuyNameInfo(skin_heroname[i])
			XClickBuyHeroSkinButton_Lua( heroid_skinframe, i+CurPage-2)
			-- log("\nheroid = "..heroid_skinframe)
			-- log("\nskinid = "..i)
		end
	end
	
	UseDefaultSkin = wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png", 30, 200, 100, 32)
	UseDefaultSkin:SetVisible(0)
	UseDefaultSkin.script[XE_LBUP] = function()
		XClickPlaySound(5)
		LastSelSkinIndex = 0
		SetWndBgImg_gamestartEx()
		XCliskUsDefaultSkin_skinframe()
	end
	UseDefaultSkin:AddFont( "�⺻��Ų���", 12, 8, 1, 1, 100, 32, 0xffffff)
	
	LeftPageButton = wnd:AddButton( path_info.."L1_info.png", path_info.."L2_info.png", path_info.."L3_info.png", -23, 43, 54, 72)
	RightPageButton = wnd:AddButton( path_info.."R1_info.png", path_info.."R2_info.png", path_info.."R3_info.png", 422, 43, 54, 72)
	LeftPageButton:SetVisible(0)
	RightPageButton:SetVisible(0)
	XWindowEnableAlphaTouch(LeftPageButton.id)
	XWindowEnableAlphaTouch(RightPageButton.id)
	
	LeftPageButton.script[XE_LBUP] = function()
		-- ��ҳ
		-- log("\nCurPage = "..CurPage)
		-- log("\nMaxPage = "..MaxPage)
		if CurPage > MinPage then
			CurPage = CurPage - 1
			XClickPageButton_SkinFrame(CurPage)
		end
	end
	
	RightPageButton.script[XE_LBUP] = function()
		-- �ҷ�ҳ
		-- log("\nCurPage = "..CurPage)
		-- log("\nMaxPage = "..MaxPage)
		if CurPage < MaxPage then -- and MaxPage > 3
			CurPage = CurPage + 1
			XClickPageButton_SkinFrame(CurPage)
		end
	end
end

function SetGameSkinFrameIsVisible(flag) 
	if g_game_SkinFrame_ui ~= nil then
		if flag == 1 and g_game_SkinFrame_ui:IsVisible() == false then
			g_game_SkinFrame_ui:SetVisible(1)
		elseif flag == 0 and g_game_SkinFrame_ui:IsVisible() == true then
			g_game_SkinFrame_ui:SetVisible(0)
			SetSkinPageButtonVisible_skinframe(0)
		end
	end
end

function GetGameSkinFrameIsVisible()
	if g_game_SkinFrame_ui:IsVisible() then
		XSetGameSkinFrameIsVisible(1)
	else
		XSetGameSkinFrameIsVisible(0)
	end
end

-- ���ݲ�ͬ��������λ��
function SetSkinWindowPos( state)
	if state==0 then
		-- ��һ������
		g_game_SkinFrame_ui:SetPosition( 790, 194-OffsetY1)
	else
		-- �ڶ�������
		g_game_SkinFrame_ui:SetPosition( 30, 533-OffsetY1)
	end
end

-- �����Ƿ��ܹ�ѡ��Ƥ�������ش���ʱ���÷񣬵��ȷ��ʱ������
function IsCanSelSkin_skinframe( cIsCan)
	IsCanSelSkin = cIsCan
	if IsCanSelSkin == 1 then
		-- ���ȷ��֮�����ѡ��ʹ��Ƥ��
		for i=1, 3 do
			SKIN_LISTL_BUY[i]:SetVisible(0)
		end
	else
		-- δ��ȷ��ֻ��ѡ����Ƥ��
		for i=1, 3 do
			SKIN_LISTL_BUY[i]:SetVisible(1)
		end
	end
end


-- ����Ƥ������
function SetSkinSizeAndInfo_skinframe( cPath, cXB, cYB, cWid, cHei, cIsHave, cSkinName, cGold, cSkinID, cindex, cCount, cheroid, cskinlv)
	-- log("\nIsCanSelSkin = "..IsCanSelSkin)
	if IsCanSelSkin == 0 then
		if cCount==1 and cindex==1 then
			SKIN_LISTL.POSXS[1] = 121
		elseif cCount == 2 then
			if cindex == 2 then
				SKIN_LISTL.POSXS[2] = 212
			else
				SKIN_LISTL.POSXS[1] = 30
			end
		else
			SKIN_LISTL.POSXS[1] = 30
			SKIN_LISTL.POSXS[2] = 170
			SKIN_LISTL.POSXS[3] = 310
		end
		SkinMaxCount = cCount
		MaxPage = cCount
	else
		SKIN_LISTL.POSXS[1] = 30
		SKIN_LISTL.POSXS[2] = 170
		SKIN_LISTL.POSXS[3] = 310
		UseDefaultSkin:SetVisible(1)
		-- log("\nCoungnrioasnh")
	end
	
	if SkinMaxCount > 3 then
		SkinMaxCount = 3
	end

	heroid_skinframe = cheroid
	SKIN_LISTL_BTN[cindex]:SetVisible(1)
	SKIN_LISTL_BTN[cindex].changeimage( ".."..cPath)
	skinimgpath_skinframe[cindex] = ".."..cPath
	XSetAddImageRect( SKIN_LISTL_BTN[cindex].id, cXB, cYB, cWid, cHei, SKIN_LISTL.POSXS[cindex], 0, 110, 170)
	SKIN_LISTL_NAME[cindex]:SetFontText( cSkinName, 0xffffff)
	skin_heroname[cindex] = cSkinName
	IsHave[cindex] = cIsHave
	Skin_Level[cindex] = cskinlv
	-- if cskinlv==0 then
		-- Skin_LevelImg[cindex]:SetVisible(0)
	-- else
		-- Skin_LevelImg[cindex]:SetVisible(1)
		-- Skin_LevelImg[cindex].changeimage( path_hero.."skinlv_"..cskinlv..".png")
	-- end
	if IsCanSelSkin==0 then
		if cIsHave == 1 then
			-- SKIN_LISTL_HAVE[cindex]:SetFontText( "��ӵ��", 0xffffff)
			SKIN_LISTL_BUY[cindex]:SetVisible(0)
		else
			-- SKIN_LISTL_HAVE[cindex]:SetFontText( "δӵ��", 0xff0000)
			SKIN_LISTL_BUY[cindex]:SetVisible(1)
		end
	end
	
	if cIsHave == 1 then
		SKIN_LISTL_HAVE[cindex]:SetFontText( "������", 0x00ff00)
	else
		SKIN_LISTL_HAVE[cindex]:SetFontText( "�̺���", 0xff0000)
	end
	
	if tonumber(cGold) == 999 then
		SKIN_LISTL_BUY[cindex]:SetVisible(0)
	end
	SKIN_LISTL_PRICE[cindex]:SetFontText( cGold, 0xffffff)
end

-- clear
function ClearAll_skinframe()
	SkinId = {}
	skinimgpath_skinframe = {}
	UseDefaultSkin:SetVisible(0)
	for i=1, 3 do
		SKIN_LISTL_BTN[i]:SetVisible(0)
		CurSelSkin[i]:SetVisible(0)
	end
end

-- ѡ��Ƥ��
function SetCurSelSkin_skinframe(cindex, cIsbuy)
	for i=1, 3 do
		-- ��ȫ������
		CurSelSkin[i]:SetVisible(0)
	end
	if cindex ~= 0 and IsCanSelSkin == 1 and cIsbuy == 1 then
		if IsHave[cindex] == 1 then
			-- ���õ�ǰʹ�õ�Ƥ��
			CurSelSkin[cindex]:SetVisible(1)
			SetWndBgImg_gamestart(skinimgpath_skinframe[cindex], Skin_Level[cindex])
			SetWndBgImg_choosehero(skinimgpath_skinframe[cindex], Skin_Level[cindex])
		end
	end
end

function SetClientSelSkinIndex_skinframe(index)
	LastSelSkinIndex = index
end

function GetClientSelSkinIndex_skinframe(index)
	return LastSelSkinIndex
end

-- ��ʼ��LOLHERO����ͼ
function InitLOLHeroUiBg_skinframe()
	SetWndBgImg_gamestart(path_hero.."ffffff_hero.png", 0)
	SetWndBgImg_choosehero(path_hero.."ffffff_hero.png", 0)
end

function BuySuccessRefeshSkinState_skinframe( cCurSelIndex)
	if cCurSelIndex>0 then
		if CurPage>1 then
			SKIN_LISTL_HAVE[cCurSelIndex-(CurPage-1)]:SetFontText( "������", 0x00ff00)
			SKIN_LISTL_BUY[cCurSelIndex-(CurPage-1)]:SetVisible(0)
		else
			SKIN_LISTL_HAVE[cCurSelIndex]:SetFontText( "������", 0x00ff00)
			SKIN_LISTL_BUY[cCurSelIndex]:SetVisible(0)
		end
	end
end

function ClearPageIndex_skinframe()
	CurPage = 1
end

function SetSkinPageButtonVisible_skinframe( cVisible)
	LeftPageButton:SetVisible( cVisible)
	RightPageButton:SetVisible( cVisible)
end