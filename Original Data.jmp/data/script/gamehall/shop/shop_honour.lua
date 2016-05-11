include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-- װ��������Ϣ
local EquipInfo = {}
EquipInfo.strName = {}			-- װ������
EquipInfo.strPictureAdr = {}	-- װ��ͼƬ·��
EquipInfo.strPictureAdr1 = {}	-- װ��ͼƬ·��
EquipInfo.strPictureAdr2 = {}	-- װ��ͼƬ·��
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
EquipInfo.Tip = {}

-- ����ؼ�
local HonourSearchInputEdit = nil
local HonourSearchInput = nil
local check_ADhave = nil
local check_APhave = nil
local Many_Equip = 0 		-- �ϴλ�����ťͣ����λ��
local Many = 0
local m_VisibleCount = 0

local honour_btn = nil		-- �������
local honour_N = nil			-- ������
local honour_H = nil			-- ���
local honour_L = nil			-- ���
local honour_index = 0

local contri_btn = nil		--- �������
local contri_N = nil			-- ������
local contri_H = nil			-- ���
local contri_L = nil			-- ���
local contri_index = 0

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

local g_item_buy = {}		-- ����ť
--local g_item_buyUnEnable = {} -- ���򲻿ɵ��

local index_have = 1
local ppx = -50
local ppy = -150

local AllCount = 0

local heroInfo_toggleImg = nil
local heroInfo_togglebtn = nil

local updownCount = 0
local maxUpdown = 0

function InitShop_HonourUI(wnd, bisopen)
	g_shop_honour_ui = CreateWindow(wnd.id, 50, 150, 900, 600)
	InitMainShop_Honour(g_shop_honour_ui)
	g_shop_honour_ui:SetVisible(bisopen)
end
function InitMainShop_Honour(wnd)
	
	-- �����͹�ѫ����
	HonourSearchInputEdit = CreateWindow(wnd.id, 950+ppx,165+ppy, 256, 32)
	HonourSearchInput = HonourSearchInputEdit:AddEdit(path_shop.."InputEdit_shop.png","","onSec_HonourSearch_Enter","",13,5,5,230,25,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(HonourSearchInput.id,60)
	HonourSearchInput:SetDefaultFontText("������Enter��ȷ��", 0xff303b4a)
	local FindButton = HonourSearchInputEdit:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png", 235, -3, 83, 35)
	FindButton:SetVisible(0)
	FindButton.script[XE_LBUP] = function()
		XEnterFindInput(HonourSearchInput.id, 1)
		ResetSecHonourScrollList()
	end
	
	-- ��ѫ�һ�
	-- local ADHave = wnd:AddImage(path_start.."sortbk_start.png",1030+ppx,215+ppy,128,32)
	-- ADHave:AddFont("��ѫ�һ�", 15, 0, 20, 5, 100, 20, 0xc7bcf6)
	
	-- local check_ADBK = wnd:AddImage(path_hero.."checkbox_hero.png",1146+ppx,215+ppy,32,32)
	-- check_ADBK:SetTouchEnabled(1)
	-- check_ADhave = check_ADBK:AddImage(path_hero.."checkboxYes_hero.png",4,-2,32,32)
	-- check_ADhave:SetTouchEnabled(0)
	-- check_ADhave:SetVisible(0)
	-- check_ADBK.script[XE_LBUP] = function()
		-- if (check_ADhave:IsVisible()) then
			-- check_ADhave:SetVisible(0)
		-- else
			-- check_ADhave:SetVisible(1)
		-- end
		
		-- ----onSearchEnter()
	-- end
	-- �����һ�
	-- local APHave = wnd:AddImage(path_start.."sortbk_start.png",1030+ppx,260+ppy,128,32)
	-- APHave:AddFont("�����һ�", 15, 0, 20, 5, 100, 20, 0xc7bcf6)
	
	-- local check_APBK = wnd:AddImage(path_hero.."checkbox_hero.png",1146+ppx,260+ppy,32,32)
	-- check_APBK:SetTouchEnabled(1)
	-- check_APhave = check_APBK:AddImage(path_hero.."checkboxYes_hero.png",4,-2,32,32)
	-- check_APhave:SetTouchEnabled(0)
	-- check_APhave:SetVisible(0)
	-- check_APBK.script[XE_LBUP] = function()
		-- if (check_APhave:IsVisible()) then
			-- check_APhave:SetVisible(0)
		-- else
			-- check_APhave:SetVisible(1)
		-- end
		
		-- ----onSearchEnter()
	-- end
	
	-- ��ѫ�۸�����
	honour_btn = wnd:AddButton(path_shop.."honour0_shop.png",path_shop.."honour0_shop.png",path_shop.."honour0_shop.png",1030+ppx,380+ppy,256,32)	
	honour_N = wnd:AddImage(path_shop.."honour0_shop.png",1030+ppx,380+ppy,256,32)
	honour_H = wnd:AddImage(path_shop.."honourH_shop.png",1030+ppx,380+ppy,256,32)
	honour_L = wnd:AddImage(path_shop.."honourL_shop.png",1030+ppx,380+ppy,256,32)
	honour_N:SetTouchEnabled(0)
	honour_H:SetTouchEnabled(0)
	honour_L:SetTouchEnabled(0)
		
	honour_N:SetVisible(1)
	honour_H:SetVisible(0)
	honour_L:SetVisible(0)
	honour_btn.script[XE_LBUP] = function()
		XClickPlaySound(5)
		HonourSearchInput:SetEdit("")
		honour_index = honour_index + 1
		honour_index = honour_index%3
		if honour_index == 1 then
			honour_N:SetVisible(0)
			honour_H:SetVisible(1)
			honour_L:SetVisible(0)
		elseif honour_index == 2 then
			honour_N:SetVisible(0)
			honour_H:SetVisible(0)
			honour_L:SetVisible(1)
		else
			honour_N:SetVisible(1)
			honour_H:SetVisible(0)
			honour_L:SetVisible(0)
		end
		XShopSrotHeroCheckGold(honour_index)
		-- �ָ���ʯ����ΪĬ��
		contri_index = 0
		contri_N:SetVisible(1)
		contri_H:SetVisible(0)
		contri_L:SetVisible(0)
	end
	
	contri_btn = wnd:AddButton(path_shop.."contri0_shop.png",path_shop.."contri0_shop.png",path_shop.."contri0_shop.png",1030+ppx,415+ppy,256,32)	
	contri_N = wnd:AddImage(path_shop.."contri0_shop.png",1030+ppx,415+ppy,256,32)
	contri_H = wnd:AddImage(path_shop.."contriH_shop.png",1030+ppx,415+ppy,256,32)
	contri_L = wnd:AddImage(path_shop.."contriL_shop.png",1030+ppx,415+ppy,256,32)
	contri_N:SetTouchEnabled(0)
	contri_H:SetTouchEnabled(0)
	contri_L:SetTouchEnabled(0)
		
	contri_N:SetVisible(1)
	contri_H:SetVisible(0)
	contri_L:SetVisible(0)
	contri_btn.script[XE_LBUP] = function()
		XClickPlaySound(5)
		HonourSearchInput:SetEdit("")
		contri_index = contri_index + 1
		contri_index = contri_index%3
		if contri_index == 1 then
			contri_N:SetVisible(0)
			contri_H:SetVisible(1)
			contri_L:SetVisible(0)
		elseif contri_index == 2 then
			contri_N:SetVisible(0)
			contri_H:SetVisible(0)
			contri_L:SetVisible(1)
		else
			contri_N:SetVisible(1)
			contri_H:SetVisible(0)
			contri_L:SetVisible(0)
		end
		XShopSrotHeroCheckMoney(contri_index)
		-- �ָ��������ΪĬ��
		honour_index = 0
		honour_N:SetVisible(1)
		honour_H:SetVisible(0)
		honour_L:SetVisible(0)
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
				if Many_Equip ~= Many then
					SecHonour_RedrawUI()
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
		
		if updownCount >= 0 and updownCount <= maxUpdown then
			for i,value in pairs(g_item_ui) do
				SecHonour_RedrawUI()
			end
		end
	end
	
	-- �������Ʒ��Ϣ
	for i=1, 12 do
		g_item_posx[i] = 213*((i -1)%4+1)-150+ppx
		g_item_posy[i] = 193*math.ceil((i)/4)-33+ppy
		g_item_ui[i] = g_shop_honour_ui:AddImage(path_shop.."ITEMBK_shop.png",g_item_posx[i],g_item_posy[i],212,195)
		g_item_flag[i] = g_item_ui[i]:AddImage(path_shop.."flag1_shop.png",0,42,128,32)
		g_item_flag[i]:SetVisible(0)
		
		g_item_pic[i] = g_item_ui[i]:AddImageMultiple(path_equip.."bag_equip.png", "", "",74,44,64,64)
		g_item_ui[i]:AddImage(path_shop.."itemside_shop.png",68,38,76,76)
		
		g_item_gold[i] = g_item_ui[i]:AddImage(path_shop.."exploit_shop.png",10,110,64,64)
		g_item_money[i] = g_item_ui[i]:AddImage(path_shop.."honour_shop.png",103,110,64,64)
		
		g_item_buy[i] = g_item_ui[i]:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",65,145,83,35)
		g_item_buy[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			--SetShopItemBuyNameInfo(EquipInfo.strName[i])
			XShopBuyItemIndexForLua(i+Many*4-1)
			XShopClickBuyItem(EquipInfo.Id[i+Many*4], EquipInfo.ItemId[i+Many*4])
		end
		
		g_item_name[i] = g_item_ui[i]:AddFont("Ӣ��"..i, 15, 8, -7, -18, 200, 15, 0x83d1e7)
		g_item_Time[i] = g_item_ui[i]:AddFont("99��\n20Сʱ", 11, 0, 155, 57, 50, 50, 0xbeb5ee)
		g_item_Time[i]:SetVisible(0)
		g_item_gold_font[i] = g_item_gold[i]:AddFontEx("1", 15, 0, 33, 8, 100, 15, 0xff83d1e7)
		g_item_gold_font[i]:SetFontSpace(1, 0)
		g_item_money_font[i] = g_item_money[i]:AddFontEx("1", 15, 0, 33, 8, 100, 15, 0xffe4e18b)
		g_item_money_font[i]:SetFontSpace(1, 0)
		g_item_buy[i]:AddFont("����", 15, 0, 22, 7, 100, 20, 0xc7bcf6)
	end
	
	FindButton:AddFont("����", 18, 0, 15, 2, 100, 20, 0xffffff)
end

-- �����͹�ѫ����
function IsFocusOn_HonourSearch()
	if (g_shop_honour_ui:IsVisible() == true) then
		-- �������
		local Input_Focus = HonourSearchInput:IsFocus()
		
		if Input_Focus == true then
		
		elseif Input_Focus == false then
			-- HonourSearchInput:SetEdit("")
		end
	end
end

function onSec_HonourSearch_Enter()
	XEnterFindInput(HonourSearchInput.id, 0)
	ResetSecHonourScrollList()
end

function SetShop_HonourIsVisible(flag) 
	if g_shop_honour_ui ~= nil then
		if flag == 1 and g_shop_honour_ui:IsVisible() == false then
			g_shop_honour_ui:SetVisible(1)
			XSetShopSecHonourUiVisible(1)
			XClickShopSecHonourUi(0)
		elseif flag == 0 and g_shop_honour_ui:IsVisible() == true then
			g_shop_honour_ui:SetVisible(0)
			XSetShopSecHonourUiVisible(0)
			HonourSearchInput:SetEdit("")
			contri_index = 0
			honour_N:SetVisible(1)
			honour_H:SetVisible(0)
			honour_L:SetVisible(0)
			contri_N:SetVisible(1)
			contri_H:SetVisible(0)
			contri_L:SetVisible(0)
			contri_index = 0
		end
	end
end

function GetShop_HonourIsVisible()  
    if(g_shop_honour_ui:IsVisible()) then
       -- XGameHeroSkinIsOpen(1)
    else
       -- XGameHeroSkinIsOpen(0)
    end
end

function ResetSecHonourScrollList()
	-- �ÿؼ��͹���������һ��
	Many = 0
	Many_Equip = Many
	
	updownCount = 0
	maxUpdown = 0
	heroInfo_togglebtn:SetPosition(0,0)
	heroInfo_togglebtn._T = 0
	SecHonour_RedrawUI()
end

-- �������ݴ���Item
function CreateItemFrame_SecHonour()
	return SecHonour_RedrawUI()
end

-- �õ���Ʒ����
function GetItemCount_SecHonour(ItemCount)
	AllCount = ItemCount
	if AllCount < 13 then
		heroInfo_togglebtn:SetVisible(0)
		heroInfo_toggleImg:SetVisible(0)
	else
		heroInfo_togglebtn:SetVisible(1)
		heroInfo_toggleImg:SetVisible(1)
	end
	return CreateItemFrame_SecHonour()
end

-- ������Ʒ��Ϣ����
function SecHonour_RedrawUI()
	for i=1, #g_item_ui do
		if ((i+Many*4) > AllCount) then
			g_item_ui[i]:SetVisible(0)
		else
			if (EquipInfo.strPictureAdr[i+Many*4] == "" or EquipInfo.strPictureAdr[i+Many*4] == "NULL") then
				-- ���ͼƬ·��Ϊ���򷵻�
				return
			end
			g_item_ui[i]:SetVisible(1)
			g_item_name[i]:SetFontText(EquipInfo.strName[i+Many*4],0x83d1e7)
			g_item_pic[i].changeimageMultiple("..\\"..EquipInfo.strPictureAdr[i+Many*4],"..\\"..EquipInfo.strPictureAdr1[i+Many*4],"..\\"..EquipInfo.strPictureAdr2[i+Many*4])
			XSetImageTip(g_item_pic[i].id, EquipInfo.Tip[i+Many*4])
			
			if (EquipInfo.m_Flag[i+Many*4] == "0") then
				g_item_flag[i]:SetVisible(0)
			else
				g_item_flag[i]:SetVisible(1)
				g_item_flag[i].changeimage(path_shop.."flag"..EquipInfo.m_Flag[i+Many*4].."_shop.png")
			end
			
			if (EquipInfo.gold[i+Many*4] == "" or EquipInfo.gold[i+Many*4] == nil or EquipInfo.gold[i+Many*4] == "NULL") then
				g_item_gold[i]:SetVisible(0)
			else
				g_item_gold[i]:SetVisible(1)
				g_item_gold_font[i]:SetFontText(EquipInfo.gold[i+Many*4], 0xff83d1e7)
			end
			
			if (EquipInfo.money[i+Many*4] == "" or EquipInfo.money[i+Many*4] == nil or EquipInfo.money[i+Many*4] == "NULL") then
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
			
			-- �ж��Ƿ�ӵ�и�Ӣ��
			if (EquipInfo.IsCanBuy[i+Many*4] == tostring(0)) then
				g_item_buy[i]:SetEnabled(0)
				--g_item_buyUnEnable[i]:SetVisible(1)
			else
				g_item_buy[i]:SetEnabled(1)
				--g_item_buyUnEnable[i]:SetVisible(0)
			end
		end
	end
end

-- ����C++��������Ʒ��Ϣ
function SecHonour_ReceiveEquipInfo(strName,strPictureAdr,strPictureAdr1,strPictureAdr2,money,gold,honour,contri,vip,m_Flag,IsCanBuy,Id,ItemId, ctip)
	local size = #EquipInfo.strName+1
	EquipInfo.strName[size] = strName
	EquipInfo.strPictureAdr[size] = strPictureAdr
	EquipInfo.strPictureAdr1[size] = strPictureAdr1
	EquipInfo.strPictureAdr2[size] = strPictureAdr2
	EquipInfo.strDesc[size] = ""
	EquipInfo.leftTime[size] = ""
	EquipInfo.IsCanBuy[size] = IsCanBuy

	EquipInfo.money[size] = money
	EquipInfo.gold[size] = gold
	EquipInfo.honour[size] = honour
	EquipInfo.contri[size] = contri
	EquipInfo.vip[size] = vip
	EquipInfo.m_Flag[size] = m_Flag
	EquipInfo.Id[size] = Id
	EquipInfo.ItemId[size] = ItemId
	EquipInfo.Tip[size] = ctip
end

-- �����Ʒ��Ϣ��
function SecHonour_clearEquipInfo()
	if (#EquipInfo.strName > 0) then
		EquipInfo = {}
		EquipInfo.strName = {}			-- װ������
		EquipInfo.strPictureAdr = {}	-- װ��ͼƬ·��
		EquipInfo.strPictureAdr1 = {}	-- װ��ͼƬ·��
		EquipInfo.strPictureAdr2 = {}	-- װ��ͼƬ·��
		EquipInfo.strDesc = {}			-- װ������
		EquipInfo.leftTime = {}			-- ʣ��ʱ��
	
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
		
		EquipInfo.Tip = {}
	end
	for i=1,#g_item_ui do
		g_item_ui[i]:SetVisible(0)
	end
end

function GetFindInputChar_honour()
	if g_shop_honour_ui:IsVisible()==true then
		XTellCInputChar(HonourSearchInput.id)
	end
end

function ReSetItemPosAndVisible_Sechonour()
	SecHonour_RedrawUI()
end