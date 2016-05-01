include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-- װ��������Ϣ
local EquipInfo = {}
EquipInfo.strName = {}			-- װ������
EquipInfo.strPictureAdr = {}	-- װ��ͼƬ·��
EquipInfo.strDesc = {}			-- װ������
EquipInfo.leftTime = {}			-- ʣ��ʱ��
EquipInfo.IsCanBuy = {}			-- �Ƿ��ܹ���
EquipInfo.money = {}
EquipInfo.gold = {}
EquipInfo.honour = {}
EquipInfo.contri = {}
EquipInfo.vip = {}
EquipInfo.m_Flag = {}			-- װ����ǩ����ʱ������...��
EquipInfo.m_IsShow = {}			-- �����жϸÿռ��Ƿ���ʾ
EquipInfo.Id = {}
EquipInfo.ItemId = {}
EquipInfo.IsCanFree = {}
EquipInfo.Tip = {}

-- ����ؼ�
local EquipSearchInputEdit = nil
local EquipSearchInput = nil
-- local EquipSearchInputText = nil
local check_herohave = nil
local Many_Equip = 0 		-- �ϴλ�����ťͣ����λ��
local Many = 0
local m_VisibleCount = 0

local ItemList = nil

local Money_btn = nil		-- �������
local Money_N = nil			-- ������
local Money_H = nil			-- ���
local Money_L = nil			-- ���
local Money_index = 0

local Gold_btn = nil		-- �������
local Gold_N = nil			-- ������
local Gold_H = nil			-- ���
local Gold_L = nil			-- ���
local Gold_index = 0

-- ��Ʒ�Ĵ���
local g_item_ui = {}		-- ������
local g_item_posx = {}		-- ����X
local g_item_posy = {}		-- ����Y

local g_item_name = {}		-- ��Ʒ����
local g_item_pic = {}		-- ��ƷͼƬ
local g_item_desc = {}		-- ��Ʒ����
local g_item_Time = {}		-- ��Ʒʣ��ʱ��

local g_item_money = {}		-- ��Ҽ۸�
local g_item_gold = {}		-- ��ʯ�۸�
local g_item_money_font = {}	-- ��Ҽ۸�FONT
local g_item_gold_font = {}		-- ��ʯ�۸�FONT
local g_item_honour = {}		-- ��ѫ�۸�
local g_item_contri = {}		-- �����۸�
local g_item_vip = {}		-- VIP�۸�

local g_item_flag = {}		-- ��Ʒ��ʱ�����۵ȵ�

local g_item_free = {}		-- ���ð�ť
local g_item_freeUnEnable = {}
local g_item_buy = {}		-- ����ť
-- local g_item_buyUnEnable = {} -- ���򲻿ɵ��

-- �����б�
local BTN_showAllBK = {}
local BTN_oftenUseBK = {}
local BTN_showAllFont = {"��ʾȫ��","��ͨװ��","Ӣ��ר��","������װ��","������װ��"}
local BTN_oftenUseFont = {"�ۺ�����","������","����ǿ��","�����ٶ�","��ȴ����","�ƶ��ٶ�","��������","����","��������","��������","���׵���","��������","������Ѫ","������Ѫ","���״�͸","������͸"}

local btn_showAll = nil
local Font_showAll = nil
local showAll_BK = nil

local btn_Oftenuse = nil
local Font_Oftenuse = nil
local Oftenuse_BK = nil
local index_have = 1
local AllCount = 0
local ppx = -50
local ppy = -150
local heroInfo_toggleImg = nil
local heroInfo_togglebtn = nil
local updownCount = 0
local maxUpdown = 0

function IsShop_Sec_EquipInputFocus()
	if EquipSearchInput ~= nil then
		return EquipSearchInput:IsFocus()
	end
	return false
end


function InitShop_Sec_EquipUI(wnd, bisopen)
	g_shop_Sec_Equip_ui = CreateWindow(wnd.id, 50, 150, 900, 600)
	InitMainShop_Sec_Equip(g_shop_Sec_Equip_ui)
	g_shop_Sec_Equip_ui:SetVisible(bisopen)
end
function InitMainShop_Sec_Equip(wnd)
	-- װ������
	local hero_type = wnd:AddImage(path_start.."sortbk_start.png",470+ppx,120+ppy,128,32)
	-- ��������
	-- local hero_use = wnd:AddImage(path_start.."sortbk_start.png",710+ppx,120+ppy,128,32)
	-- hero_use:AddFont("��������",12,0,22,6,100,15,0xbeb5ee)

	-- װ������
	EquipSearchInputEdit = CreateWindow(wnd.id, 950+ppx,165+ppy, 256, 32)
	EquipSearchInput = EquipSearchInputEdit:AddEdit(path_shop.."InputEdit_shop.png","","onSec_EquipSearch_Enter","",13,5,5,230,25,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(EquipSearchInput.id,60)
	EquipSearchInput:SetDefaultFontText("������Enter��ȷ��", 0xff303b4a)
	local FindButton = EquipSearchInputEdit:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png", 235, -3, 83, 35)
	FindButton:SetVisible(0)
	FindButton.script[XE_LBUP] = function()
		XEnterFindInput(1, EquipSearchInput.id, 1)
		ResetSecEquipScrollList()
	end
	
	-- δӵ��װ��
	-- local NotHave = wnd:AddImage(path_start.."sortbk_start.png",1030+ppx,215+ppy,128,32)
	-- NotHave:AddFont("δӵ��װ��", 15, 0, 15, 5, 100, 20, 0xc7bcf6)
	
	-- local check_heroBK = wnd:AddImage(path_hero.."checkbox_hero.png",1146+ppx,215+ppy,32,32)
	-- check_heroBK:SetTouchEnabled(1)
	-- check_herohave = check_heroBK:AddImage(path_hero.."checkboxYes_hero.png",4,-2,32,32)
	-- check_herohave:SetTouchEnabled(0)
	-- check_herohave:SetVisible(0)
	-- check_heroBK.script[XE_LBUP] = function()
		-- if (check_herohave:IsVisible()) then
			-- check_herohave:SetVisible(0)
			-- index_have = 1
		-- else
			-- check_herohave:SetVisible(1)
			-- index_have = 2
		-- end
		
		-- ----onSearchEnter()
	-- end
	
	-- ��Ҽ۸�����
	Money_btn = wnd:AddButton(path_shop.."money0_shop.png",path_shop.."money0_shop.png",path_shop.."money0_shop.png",1030+ppx,380+ppy,256,32)	
	Money_N = wnd:AddImage(path_shop.."money0_shop.png",1030+ppx,380+ppy,256,32)
	Money_H = wnd:AddImage(path_shop.."moneyH_shop.png",1030+ppx,380+ppy,256,32)
	Money_L = wnd:AddImage(path_shop.."moneyL_shop.png",1030+ppx,380+ppy,256,32)
	Money_N:SetTouchEnabled(0)
	Money_H:SetTouchEnabled(0)
	Money_L:SetTouchEnabled(0)
		
	Money_N:SetVisible(1)
	Money_H:SetVisible(0)
	Money_L:SetVisible(0)
	Money_btn.script[XE_LBUP] = function()
		XClickPlaySound(5)
		--EquipSearchInput:SetEdit("")
		Money_index = Money_index + 1
		Money_index = Money_index%3
		if Money_index == 1 then
			Money_N:SetVisible(0)
			Money_H:SetVisible(1)
			Money_L:SetVisible(0)
		elseif Money_index == 2 then
			Money_N:SetVisible(0)
			Money_H:SetVisible(0)
			Money_L:SetVisible(1)
		else
			Money_N:SetVisible(1)
			Money_H:SetVisible(0)
			Money_L:SetVisible(0)
		end
		-- �ָ���ʯ����ΪĬ��
		Gold_index = 0
		Gold_N:SetVisible(1)
		Gold_H:SetVisible(0)
		Gold_L:SetVisible(0)
		
		--ResetSecEquipScrollList()
		XShopSrotHeroCheckMoney(1, Money_index)
	end
	
	-- ��ʯ�۸�����
	Gold_btn = wnd:AddButton(path_shop.."gold0_shop.png",path_shop.."gold0_shop.png",path_shop.."gold0_shop.png",1030+ppx,415+ppy,256,32)	
	Gold_N = wnd:AddImage(path_shop.."gold0_shop.png",1030+ppx,415+ppy,256,32)
	Gold_H = wnd:AddImage(path_shop.."goldH_shop.png",1030+ppx,415+ppy,256,32)
	Gold_L = wnd:AddImage(path_shop.."goldL_shop.png",1030+ppx,415+ppy,256,32)
	Gold_N:SetTouchEnabled(0)
	Gold_H:SetTouchEnabled(0)
	Gold_L:SetTouchEnabled(0)
		
	Gold_N:SetVisible(1)
	Gold_H:SetVisible(0)
	Gold_L:SetVisible(0)
	Gold_btn.script[XE_LBUP] = function()
		XClickPlaySound(5)
		--EquipSearchInput:SetEdit("")
		Gold_index = Gold_index + 1
		Gold_index = Gold_index%3
		if Gold_index == 1 then
			Gold_N:SetVisible(0)
			Gold_H:SetVisible(1)
			Gold_L:SetVisible(0)
		elseif Gold_index == 2 then
			Gold_N:SetVisible(0)
			Gold_H:SetVisible(0)
			Gold_L:SetVisible(1)
		else
			Gold_N:SetVisible(1)
			Gold_H:SetVisible(0)
			Gold_L:SetVisible(0)
		end
		-- �ָ��������ΪĬ��
		Money_index = 0
		Money_N:SetVisible(1)
		Money_H:SetVisible(0)
		Money_L:SetVisible(0)
		
		--ResetSecEquipScrollList()
		XShopSrotHeroCheckGold(1, Gold_index)
	end
	
	-- ������
	heroInfo_toggleImg = wnd:AddImage(path.."toggleBK_main.png",918+ppx,180+ppy,16,540)
	heroInfo_togglebtn = heroInfo_toggleImg:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = heroInfo_toggleImg:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = heroInfo_toggleImg:AddImage(path.."TD1_main.png",0,540,16,16)
	
	XSetWindowFlag(heroInfo_togglebtn.id,1,1,0,490)
	
	heroInfo_togglebtn:ToggleBehaviour(XE_ONUPDATE, 1)
	heroInfo_togglebtn:ToggleEvent(XE_ONUPDATE, 1)
	
	heroInfo_togglebtn.script[XE_ONUPDATE] = function()
		if (AllCount > 12) then
			if heroInfo_togglebtn._T == nil then
				heroInfo_togglebtn._T = 0
			end
			local L,T,R,B = XGetWindowClientPosition(heroInfo_togglebtn.id)
			if heroInfo_togglebtn._T ~= T then
				local length = 490/math.ceil((AllCount/4)-3)
				Many = math.floor(T/length)
				updownCount = Many
				-- log("\nMany = " .. Many)
				if Many_Equip ~= Many then
					SecEquip_RedrawUI()
					Many_Equip = Many
				end		
			
				heroInfo_togglebtn._T = T
			end
		end
	end
	
	-- ���ý�����Ի���
	XWindowEnableAlphaTouch(wnd.id)
	wnd:EnableEvent(XE_MOUSEWHEEL)
	wnd.script[XE_MOUSEWHEEL] = function()
		local updown  = 0
		local length =0
		if #EquipInfo.strName >12 then
			updown  = XGetMsgParam0()
			maxUpdown = math.ceil((#EquipInfo.strName/4)-3)
			length = 490/maxUpdown			
		end
		if updown>0 then
			updownCount = updownCount-1
			if updownCount<0 then
				updownCount=0
			end
		else
			updownCount = updownCount+1
			if updownCount>maxUpdown then
				updownCount=maxUpdown
			end
		end
		Many = updownCount
		local btn_pos = length*updownCount

		heroInfo_togglebtn:SetPosition(0,btn_pos)
		heroInfo_togglebtn._T = btn_pos
		-- log("\nupdownCount = " .. updownCount)
		if updownCount >= 0 and updownCount <= maxUpdown then
			SecEquip_RedrawUI()
		end
	end
	
	ItemList = wnd:AddImage(path_hero.."checkbox_hero.png",0,0,0,0)
	ItemList:SetTransparent(0)
	
	-- ��ʾȫ������������
	btn_showAll = wnd:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",575+ppx,120+ppy,128,32)
	showAll_BK = wnd:AddImage(path_shop.."listBK1_shop.png",575+ppx,150+ppy,128,512)
	wnd:SetAddImageRect(showAll_BK.id,0,0,128,145,575+ppx,150+ppy,128,145)
	
	showAll_BK:SetVisible(0)
	
	for dis = 1,5 do
		BTN_showAllBK[dis] = wnd:AddImage(path_hero.."listhover_hero.png",575+ppx,121+dis*29+ppy,128,32)
		showAll_BK:AddFont(BTN_showAllFont[dis],12,0,10,dis*29-23,128,32,0xbeb5ee)
		BTN_showAllBK[dis]:SetTransparent(0)
		BTN_showAllBK[dis]:SetTouchEnabled(0)
		
		-- ��껬��
		BTN_showAllBK[dis].script[XE_ONHOVER] = function()
			if showAll_BK:IsVisible() == true then
				BTN_showAllBK[dis]:SetTransparent(1)
			end
		end
		BTN_showAllBK[dis].script[XE_ONUNHOVER] = function()
			if showAll_BK:IsVisible() == true then
				BTN_showAllBK[dis]:SetTransparent(0)
			end
		end
		BTN_showAllBK[dis].script[XE_LBUP] = function()
			EquipSearchInput:SetEdit("")
			Font_showAll:SetFontText(BTN_showAllFont[dis],0xbeb5ee)
			index_showAll = dis
			
			--onSearchEnter()
			btn_showAll:SetButtonFrame(0)
			showAll_BK:SetVisible(0)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(0)
			end
			
			ResetSecEquipScrollList()
			XClickEquipTypeCheckButton(dis-1)
		end
		
	end
	
	btn_showAll.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if showAll_BK:IsVisible() then
			showAll_BK:SetVisible(0)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(0)
			end
		else
			showAll_BK:SetVisible(1)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(1)
			end
		end
	end
	-- ������������������
	-- btn_Oftenuse = wnd:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",815+ppx,120+ppy,128,32)
	-- Font_Oftenuse = btn_Oftenuse:AddFont(BTN_oftenUseFont[1],12,0,18,6,100,15,0xbeb5ee)
	
	-- Oftenuse_BK = wnd:AddImage(path_shop.."listBK1_shop.png",815+ppx,150+ppy,128,512)
	-- wnd:SetAddImageRect(Oftenuse_BK.id,0,0,128,465,815+ppx,150+ppy,128,465)
	-- Oftenuse_BK:SetVisible(0)
	
	-- for dis = 1,16 do
		-- BTN_oftenUseBK[dis] = wnd:AddImage(path_hero.."listhover_hero.png",815+ppx,121+dis*29+ppy,128,32)
		-- Oftenuse_BK:AddFont(BTN_oftenUseFont[dis],12,0,18,dis*29-23,128,32,0xbeb5ee)
		-- BTN_oftenUseBK[dis]:SetTransparent(0)
		-- BTN_oftenUseBK[dis]:SetTouchEnabled(0)
		-- -----------��껬��
		-- BTN_oftenUseBK[dis].script[XE_ONHOVER] = function()
			-- if Oftenuse_BK:IsVisible() == true then
				-- BTN_oftenUseBK[dis]:SetVisible(1)
				-- BTN_oftenUseBK[dis]:SetTransparent(1)
			-- end
		-- end
		-- BTN_oftenUseBK[dis].script[XE_ONUNHOVER] = function()
			-- if Oftenuse_BK:IsVisible() == true then
				-- BTN_oftenUseBK[dis]:SetTransparent(0)
			-- end
		-- end
		-- BTN_oftenUseBK[dis].script[XE_LBUP] = function()
			-- Font_Oftenuse:SetFontText(BTN_oftenUseFont[dis],0xbeb5ee)
			-- index_oftenUse = dis
			
			-- --onSearchEnter()
			-- btn_Oftenuse:SetButtonFrame(0)
			-- Oftenuse_BK:SetVisible(0)
			-- for index,value in pairs(BTN_oftenUseBK) do
				-- BTN_oftenUseBK[index]:SetTransparent(0)
				-- BTN_oftenUseBK[index]:SetTouchEnabled(0)
			-- end
		-- end
	-- end
	
	-- btn_Oftenuse.script[XE_LBUP] = function()
		-- XClickPlaySound(5)
		-- if Oftenuse_BK:IsVisible() then
			-- Oftenuse_BK:SetVisible(0)
			-- for index,value in pairs(BTN_oftenUseBK) do
				-- BTN_oftenUseBK[index]:SetTransparent(0)
				-- BTN_oftenUseBK[index]:SetTouchEnabled(0)
			-- end
		-- else
			-- Oftenuse_BK:SetVisible(1)
			-- for index,value in pairs(BTN_oftenUseBK) do
				-- BTN_oftenUseBK[index]:SetTransparent(0)
				-- BTN_oftenUseBK[index]:SetTouchEnabled(1)
			-- end
		-- end
	-- end
	
	for i=1, 12 do
		g_item_posx[i] = 213*((i-1)%4+1)-150+ppx
		g_item_posy[i] = 193*math.ceil(i/4)-33+ppy
		
		g_item_ui[i] = ItemList:AddImage(path_shop.."ITEMBK_shop.png",g_item_posx[i],g_item_posy[i],212,195)
		g_item_flag[i] = g_item_ui[i]:AddImage(path_shop.."flag1_shop.png",0,42,128,32)
		g_item_pic[i] = g_item_ui[i]:AddImage(path_equip.."bag_equip.png",74,44,64,64)
		g_item_ui[i]:AddImage(path_shop.."itemside_shop.png",68,38,76,76)
		
		g_item_money[i] = g_item_ui[i]:AddImage(path_shop.."money_shop.png",10,110,64,64)
		g_item_gold[i] = g_item_ui[i]:AddImage(path_shop.."gold_shop.png",103,110,64,64)
		
		g_item_free[i] = g_item_ui[i]:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",15,145,83,35)
		g_item_free[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			XClickFreeBtnAtBuyItemUi(1, EquipInfo.Id[i+Many*4], EquipInfo.IsCanFree[i+Many*4])
		end
		
		g_item_freeUnEnable[i] = g_item_ui[i]:AddImage(path_setup.."buy0_setup.png", 15, 145, 83, 35)

		g_item_buy[i] = g_item_ui[i]:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",115,145,83,35)
		g_item_buy[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			--SetShopItemBuyNameInfo(EquipInfo.strName[i])
			XShopBuyItemIndexForLua(i+Many*4-1)
			XShopClickBuyItem(1, EquipInfo.Id[i+Many*4], EquipInfo.ItemId[i+Many*4])
		end
		
		g_item_name[i] = g_item_ui[i]:AddFont("װ�������������", 15, 8, -7, -18, 200, 20, 0x83d1e7)
		g_item_gold_font[i] = g_item_gold[i]:AddFontEx("1", 15, 0, 33, 8, 100, 20, 0xff83d1e7)
		g_item_gold_font[i]:SetFontSpace(1, 0)
		g_item_money_font[i] = g_item_money[i]:AddFontEx("1", 15, 0, 33, 8, 100, 20, 0xffe4e18b)
		g_item_money_font[i]:SetFontSpace(1, 0)
		g_item_free[i]:AddFont("����", 15, 0, 22, 7, 100, 30, 0xc7bcf6)
		g_item_freeUnEnable[i]:AddFont("����", 15, 0, 22, 7, 100, 20, 0xc7bcf6)
		g_item_buy[i]:AddFont("����", 15, 0, 22, 7, 100, 30, 0xc7bcf6)
	end
	
	hero_type:AddFont("װ������",12,0,22,6,100,15,0xbeb5ee)
	FindButton:AddFont("����", 18, 0, 15, 2, 100, 20, 0xffffff)
	Font_showAll = btn_showAll:AddFont(BTN_showAllFont[1],12,0,10,6,100,15,0xbeb5ee)
end

-- װ������
function IsFocusOn_SecEquipSearch()
	if (g_shop_Sec_Equip_ui:IsVisible() == true) then
		-- �������
		local Input_Focus = EquipSearchInput:IsFocus()
		
		if Input_Focus == true then
		
		elseif Input_Focus == false then
			-- EquipSearchInput:SetEdit("")
		end

		-- ����ѡ���
		local flagA = (showAll_BK:IsVisible() == true and btn_showAll:IsFocus() == false and BTN_showAllBK[1]:IsFocus() == false and BTN_showAllBK[2]:IsFocus() == false
		and BTN_showAllBK[3]:IsFocus() == false and BTN_showAllBK[4]:IsFocus() == false and BTN_showAllBK[5]:IsFocus() == false)

		if(flagA == true) then
			btn_showAll:SetButtonFrame(0)
			showAll_BK:SetVisible(0)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(0)
			end
		end

		local flagB = (Oftenuse_BK:IsVisible() == true and btn_Oftenuse:IsFocus() == false and BTN_oftenUseBK[1]:IsFocus() == false and BTN_oftenUseBK[2]:IsFocus() == false
		and BTN_oftenUseBK[3]:IsFocus() == false and BTN_oftenUseBK[4]:IsFocus() == false and BTN_oftenUseBK[5]:IsFocus() == false and BTN_oftenUseBK[6]:IsFocus() == false 
		and BTN_oftenUseBK[7]:IsFocus() == false and BTN_oftenUseBK[8]:IsFocus() == false	and BTN_oftenUseBK[9]:IsFocus() == false and BTN_oftenUseBK[10]:IsFocus() == false
		and BTN_oftenUseBK[11]:IsFocus() == false and BTN_oftenUseBK[12]:IsFocus() == false and BTN_oftenUseBK[13]:IsFocus() == false and BTN_oftenUseBK[14]:IsFocus() == false
		and BTN_oftenUseBK[15]:IsFocus() == false and BTN_oftenUseBK[16]:IsFocus() == false) 

		if(flagB == true) then
			btn_Oftenuse:SetButtonFrame(0)
			Oftenuse_BK:SetVisible(0)
			
			for index,value in pairs(BTN_oftenUseBK) do
				--BTN_oftenUseBK[index]:SetTransparent(0)
				BTN_oftenUseBK[index]:SetVisible(0)
			end
		end
	end
end

function onSec_EquipSearch_Enter()
	XEnterFindInput(1, EquipSearchInput.id, 0)
	ResetSecEquipScrollList()
end

function SetShop_Sec_EquipIsVisible(flag) 
	if g_shop_Sec_Equip_ui ~= nil then
		if flag == 1 and g_shop_Sec_Equip_ui:IsVisible() == false then
			g_shop_Sec_Equip_ui:SetVisible(1)
			XSetShopSecEquipUiVisible(1)
			XClickShopSecEquipUi(1)
		elseif flag == 0 and g_shop_Sec_Equip_ui:IsVisible() == true then
			g_shop_Sec_Equip_ui:SetVisible(0)
			XSetShopSecEquipUiVisible(0)
			EquipSearchInput:SetEdit("")
			Gold_N:SetVisible(1)
			Gold_H:SetVisible(0)
			Gold_L:SetVisible(0)
			Money_N:SetVisible(1)
			Money_H:SetVisible(0)
			Money_L:SetVisible(0)
			Money_index = 0
			Gold_index = 0
			Font_showAll:SetFontText(BTN_showAllFont[1],0xbeb5ee)
		end
	end
end

function GetShop_Sec_EquipIsVisible()  
    if(g_shop_Sec_Equip_ui:IsVisible()) then
       -- XGameHeroSkinIsOpen(1)
    else
       -- XGameHeroSkinIsOpen(0)
    end
end

-- ���ù�����
function ResetSecEquipScrollList()
	-- �ÿؼ��͹���������һ��
	Many = 0
	Many_Equip = Many
	-- end		
	updownCount = 0
	maxUpdown = 0
	heroInfo_togglebtn:SetPosition(0,0)
	heroInfo_togglebtn._T = 0
	SecEquip_RedrawUI()
end

-- ����Item
function CreateItemFrame_SecEquip()
	return SecEquip_RedrawUI()
end

-- ����Item
function SecEquip_RedrawUI()
	-- log("\nMany = "..Many)
	for i=1, #g_item_ui do
		if ((i+Many*4) > AllCount) then
			g_item_ui[i]:SetVisible(0)
		else
			if (EquipInfo.strPictureAdr[i+Many*4] == "" or EquipInfo.strPictureAdr[i+Many*4] == nil) then
				-- ���ͼƬ·��Ϊ���򷵻�
				log("\nErrorIconPathFrom [shop_Sec_equip]")
			else
				g_item_ui[i]:SetVisible(1)
				g_item_name[i]:SetFontText(EquipInfo.strName[i+Many*4],0x83d1e7)
				g_item_pic[i].changeimage("..\\"..EquipInfo.strPictureAdr[i+Many*4])
				XSetImageTip(g_item_pic[i].id, EquipInfo.Tip[i+Many*4])
				
				if (EquipInfo.m_Flag[i+Many*4] == "0") then
					g_item_flag[i]:SetVisible(0)
				else
					g_item_flag[i]:SetVisible(1)
					g_item_flag[i].changeimage(path_shop.."flag"..EquipInfo.m_Flag[i+Many*4].."_shop.png")
				end
				
				if (EquipInfo.gold[i+Many*4] == "" or EquipInfo.gold[i+Many*4] == nil) then
					g_item_gold[i]:SetVisible(0)
				else
					g_item_gold[i]:SetVisible(1)
					g_item_gold_font[i]:SetFontText(EquipInfo.gold[i+Many*4], 0xff83d1e7)
				end
				
				if (EquipInfo.money[i+Many*4] == "" or EquipInfo.money[i+Many*4] == nil) then
					g_item_money[i]:SetVisible(0)
				else
					g_item_money[i]:SetVisible(1)
					g_item_money_font[i]:SetFontText(EquipInfo.money[i+Many*4], 0xffe4e18b)
				end
				
				if g_item_money[i]:IsVisible()==true and g_item_gold[i]:IsVisible()==false then
					g_item_money[i]:SetPosition(72, 110)
				elseif g_item_money[i]:IsVisible()==false and g_item_gold[i]:IsVisible()==true then
					g_item_gold[i]:SetPosition(72, 110)
				else
					g_item_money[i]:SetPosition(20, 110)
					g_item_gold[i]:SetPosition(113, 110)
				end
				
				-- �ж��Ƿ�ӵ���Թ���
				if (EquipInfo.IsCanBuy[i+Many*4] == tostring(0)) then
					g_item_buy[i]:SetEnabled(0)
					--g_item_buyUnEnable[i]:SetVisible(1)
				else
					g_item_buy[i]:SetEnabled(1)
					--g_item_buyUnEnable[i]:SetVisible(0)
				end
				
				-- �Ƿ��������
				if (EquipInfo.IsCanFree[i+Many*4] == tostring(0)) then
					g_item_free[i]:SetVisible(0)
					g_item_freeUnEnable[i]:SetVisible(1)
				else
					g_item_free[i]:SetVisible(1)
					g_item_freeUnEnable[i]:SetVisible(0)
				end
			end
		end
	end
end

-- �õ�Item�ܸ��������ô�������
function GetItemCount_SecEquip(ItemCount)
	AllCount = ItemCount
	if AllCount < 13 then
		heroInfo_togglebtn:SetVisible(0)
		heroInfo_toggleImg:SetVisible(0)
	else
		heroInfo_togglebtn:SetVisible(1)
		heroInfo_toggleImg:SetVisible(1)
	end
	return CreateItemFrame_SecEquip()
end

-- ��C++�л�ȡItem��Ϣ
function SecEqiup_ReceiveEquipInfo(strName,strPictureAdr,strDesc,leftTime,money,gold,honour,contri,vip,m_Flag,IsCanBuy,Id,ItemId, IsCanFree, cTip)
	local size = #EquipInfo.strName+1
	EquipInfo.strName[size] = strName
	EquipInfo.strPictureAdr[size] = strPictureAdr
	EquipInfo.strDesc[size] = strDesc
	EquipInfo.leftTime[size] = leftTime
	EquipInfo.IsCanBuy[size] = IsCanBuy
	EquipInfo.money[size] = money
	EquipInfo.gold[size] = gold
	EquipInfo.honour[size] = honour
	EquipInfo.contri[size] = contri
	EquipInfo.vip[size] = vip
	EquipInfo.m_Flag[size] = m_Flag
	EquipInfo.Id[size] = Id
	EquipInfo.ItemId[size] = ItemId
	EquipInfo.IsCanFree[size] = IsCanFree
	EquipInfo.Tip[size] = cTip
end

function SecEquip_clearItemInfo()
	-- ResetSecEquipScrollList()
	if (#EquipInfo.strName > 0) then
		EquipInfo = {}
		EquipInfo.strName = {}			----װ������
		EquipInfo.strPictureAdr = {}	----װ��ͼƬ·��
		EquipInfo.strDesc = {}			----װ������
		EquipInfo.leftTime = {}			----ʣ��ʱ��
	
		EquipInfo.money = {}
		EquipInfo.gold = {}
		EquipInfo.honour = {}
		EquipInfo.contri = {}
		EquipInfo.vip = {}
		EquipInfo.m_Flag = {}
		
		EquipInfo.IsCanBuy = {}
		EquipInfo.m_IsShow = {}
		
		EquipInfo.Id = {}
		EquipInfo.ItemId = {}
		EquipInfo.IsCanFree = {}
		
		EquipInfo.Tip = {}
	end
	for i=1,#g_item_ui do
		g_item_ui[i]:SetVisible(0)
	end
	-- for i=(1+(Many*4)), (1+(Many*4)+11) do
		-- g_item_ui[i]:SetVisible(1)
	-- end
end


function GetFindInputChar_equip()
	if g_shop_Sec_Equip_ui:IsVisible()==true then
		XTellCInputChar(EquipSearchInput.id)
	end
end

function ReSetItemPosAndVisible_Secequip()
	SecEquip_RedrawUI()
end