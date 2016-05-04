include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")


-- ��Ʒ�Ĵ���
local g_item_ui = {}			-- ������
local g_item_posx = {}			-- ����X
local g_item_posy = {}			-- ����Y

local g_item_name = {}			-- ��Ʒ����
local g_item_pic = {}			-- ��ƷͼƬ
local g_item_desc = {}			-- ��Ʒ����
local g_item_Time = {}			-- ��Ʒʣ��ʱ��
local g_item_IsHaveHero = {}	-- �Ƿ�ӵ��Ӣ���ı���
local g_item_HavedHero = {}		-- ��ӵ��

local g_item_money = {}			-- ��Ҽ۸�
local g_item_gold = {}			-- ��ʯ�۸�
local g_item_money_font = {}	-- ��Ҽ۸�FONT
local g_item_gold_font = {}		-- ��ʯ�۸�FONT
local g_item_honour = {}		-- ��ѫ�۸�
local g_item_contri = {}		-- �����۸�
local g_item_vip = {}			-- VIP�۸�
local g_item_flag = {}			-- ��Ʒ��ʱ�����۵ȵ�
local g_item_buy = {}			-- ����ť
-- local g_item_buyUnEnable = {}	-- ���򲻿ɵ��

local Gold_btn = nil			-- �������
local Gold_N = nil				-- ������
local Gold_H = nil				-- ���
local Gold_L = nil				-- ���
local Gold_index = 0



-- ����ؼ�
local EquipHeroSkinSearchInputEdit = nil
local EquipHeroSkinSearchInput = nil
-- local EquipHeroSkinSearchInputText = nil
local check_herohave = nil
local Many_Equip = 0 		-- �ϴλ�����ťͣ����λ��
local Many = 0
local heroInfo_togglebtn = nil


-- �����б�
local BTN_oftenUseBK = {}
local BTN_oftenUseFont = {"�����ϼ�","����Ӣ��","δӵ��Ӣ��","��ĸ����","�ҵ��","��ʱƤ��","����Ƥ��","����Ʒ��","ʷʫƷ��"}

local btn_Oftenuse = nil
local Font_Oftenuse = nil
local Oftenuse_BK = nil

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
EquipInfo.beginX = {}
EquipInfo.beginY = {}
EquipInfo.Width = {}
EquipInfo.Height = {}
EquipInfo.Tip = {}
EquipInfo.IsHaveHero = {}

local AllCount = 0				-- ��Item����
local ppx = -50
local ppy = -150
local heroInfo_toggleImg = nil
local heroInfo_togglebtn = nil
local index_have = 1
local updownCount = 0
local maxUpdown = 0

function IsShop_Sec_HeroSkinInputFocus()
	if EquipHeroSkinSearchInput ~= nil then
		return EquipHeroSkinSearchInput:IsFocus()
	end
	return false
end

function InitShop_Sec_HeroSkinUI(wnd, bisopen)
	g_shop_Sec_heroSkin_ui = CreateWindow(wnd.id, 50, 150, 900, 600)
	InitMainShop_Sec_HeroSkin(g_shop_Sec_heroSkin_ui)
	g_shop_Sec_heroSkin_ui:SetVisible(bisopen)
end
function InitMainShop_Sec_HeroSkin(wnd)
	
	-- Ƥ������
	-- local hero_use = wnd:AddImage(path_start.."sortbk_start.png",710+ppx,120+ppy,128,32)
	-- hero_use:AddFont("Ƥ������",12,0,22,6,100,15,0xbeb5ee)
	
	-- ������
	heroInfo_toggleImg = wnd:AddImage(path.."toggleBK_main.png",918+ppx,180+ppy,16,540)
	heroInfo_togglebtn = heroInfo_toggleImg:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = heroInfo_toggleImg:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = heroInfo_toggleImg:AddImage(path.."TD1_main.png",0,540,16,16)
	
	XSetWindowFlag(heroInfo_togglebtn.id,1,1,0,490)
	
	heroInfo_togglebtn:ToggleBehaviour(XE_ONUPDATE, 1)
	heroInfo_togglebtn:ToggleEvent(XE_ONUPDATE, 1)
	
	heroInfo_togglebtn.script[XE_ONUPDATE] = function()
		if heroInfo_togglebtn._T == nil then
			heroInfo_togglebtn._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(heroInfo_togglebtn.id)
		if heroInfo_togglebtn._T ~= T then
		
			local length = 490/math.ceil((AllCount/4)-3)
			Many = math.floor(T/length)
			updownCount = Many
			
			if Many_Equip ~= Many then
				SecHeroSkin_RedrawUI()
				Many_Equip = Many
			end				
			heroInfo_togglebtn._T = T
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
			SecHeroSkin_RedrawUI()
			Many_Equip = Many
		end
	end
	-- �������Ʒ��Ϣ
	-- for i=1,120 do
		-- g_item_posx[i] = 213*((i-1)%4+1)-150+ppx
		-- g_item_posy[i] = 193*math.ceil(i/4)-33+ppy
		
		-- g_item_ui[i] = wnd:AddImage(path_shop.."ITEMBK_shop.png",g_item_posx[i],g_item_posy[i],212,195)
		-- g_item_name[i] = g_item_ui[i]:AddFont("װ�������������", 15, 0, 55, 17, 200, 30, 0x83d1e7)
		-- g_item_Time[i] = g_item_ui[i]:AddImage(path_shop.."flag1_shop.png",0,42,128,32)
		
		-- g_item_money[i] = g_item_ui[i]:AddImage(path_shop.."money_shop.png",7,110,64,64)
		-- g_item_gold[i] = g_item_ui[i]:AddImage(path_shop.."gold_shop.png",100,110,64,64)
		
		-- g_item_buy[i] = g_item_ui[i]:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",65,145,83,35)
		-- g_item_buy[i]:AddFont("����"..i, 15, 0, 22, 7, 100, 20, 0xc7bcf6)
		
		
		-- if g_item_posy[i] >700+ppy or g_item_posy[i] <100+ppy then
			-- g_item_ui[i]:SetVisible(0)
		-- else
			-- g_item_ui[i]:SetVisible(1)
		-- end
		
	-- end
	
	-- ������������������
	-- btn_Oftenuse = wnd:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",815+ppx,120+ppy,128,32)
	-- Font_Oftenuse = btn_Oftenuse:AddFont(BTN_oftenUseFont[1],12,0,18,6,100,15,0xbeb5ee)
	
	-- Oftenuse_BK = wnd:AddImage(path_shop.."listBK1_shop.png",815+ppx,150+ppy,128,512)
	-- wnd:SetAddImageRect(Oftenuse_BK.id,0,0,128,260,815+ppx,150+ppy,128,260)
	-- Oftenuse_BK:SetVisible(0)
	
	-- for dis = 1,9 do
		-- BTN_oftenUseBK[dis] = wnd:AddImage(path_hero.."listhover_hero.png",815+ppx,121+dis*29+ppy,128,32)
		-- Oftenuse_BK:AddFont(BTN_oftenUseFont[dis],12,0,18,dis*29-23,128,32,0xbeb5ee)
		-- BTN_oftenUseBK[dis]:SetTransparent(0)
		-- BTN_oftenUseBK[dis]:SetTouchEnabled(0)
		-- ��껬��
		-- BTN_oftenUseBK[dis].script[XE_ONHOVER] = function()
			-- if Oftenuse_BK:IsVisible() == true then
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
	
	-- Ƥ������
	EquipHeroSkinSearchInputEdit = CreateWindow(wnd.id, 950+ppx,165+ppy, 256, 32)
	EquipHeroSkinSearchInput = EquipHeroSkinSearchInputEdit:AddEdit(path_shop.."InputEdit_shop.png","","onHeroSkinSearch_Enter","",13,5,5,230,25,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(EquipHeroSkinSearchInput.id,60)
	EquipHeroSkinSearchInput:SetDefaultFontText("������Enter��ȷ��",0xff303b4a)
	
	local FindButton = EquipHeroSkinSearchInputEdit:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png", 235, -3, 83, 35)
	FindButton:SetVisible(0)
	FindButton.script[XE_LBUP] = function()
		XEnterFindInput(1, EquipHeroSkinSearchInput.id, 1)
		ResetScrollList_SecHeroSkin()
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
		
		-- EquipHeroSkinSearchInput:SetEdit("")
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
		
		XShopSrotHeroCheckGold(1, Gold_index)
		-- ResetScrollList_SecHeroSkin()
	end
	
	-- δӵ��Ƥ��
	local NotHave = wnd:AddImage(path_start.."sortbk_start.png",1030+ppx,215+ppy,128,32)
	local check_heroBK = wnd:AddImage(path_hero.."checkbox_hero.png",1146+ppx,215+ppy,32,32)
	check_heroBK:SetTouchEnabled(1)
	check_herohave = check_heroBK:AddImage(path_hero.."checkboxYes_hero.png",4,-2,32,32)
	check_herohave:SetTouchEnabled(0)
	check_herohave:SetVisible(0)
	check_heroBK.script[XE_LBUP] = function()
		EquipHeroSkinSearchInput:SetEdit("")
		Gold_index = 0
		Gold_N:SetVisible(1)
		Gold_H:SetVisible(0)
		Gold_L:SetVisible(0)
		
		if (check_herohave:IsVisible()) then
			check_herohave:SetVisible(0)
			index_have = 1
			for i = 1, #g_item_ui do
				if i<13 then
					g_item_ui[i]:SetVisible(1)
				end
			end
		else
			check_herohave:SetVisible(1)
			index_have = 2
		end
		
		ResetScrollList_SecHeroSkin()
		
		XShopIsHaveHeroCheck(1, index_have-1)
		-- onSearchEnter()
	end
	
	for i=1, 12 do
		g_item_posx[i] = 213*((i -1)%4+1)-150+ppx
		g_item_posy[i] = 193*math.ceil((i)/4)-33+ppy
		g_item_ui[i] = g_shop_Sec_heroSkin_ui:AddImage(path_shop.."ITEMBK_shop.png",g_item_posx[i],g_item_posy[i],212,195)
		g_item_flag[i] = g_item_ui[i]:AddImage(path_shop.."flag1_shop.png",0,42,128,32)
		g_item_flag[i]:SetVisible(0)
		g_item_pic[i] = g_item_ui[i]:AddImage(path_equip.."bag_equip.png",74,44,64,64)
		g_item_ui[i]:AddImage(path_shop.."itemside_shop.png",68,38,76,76)
		XWindowEnableAlphaTouch(g_item_pic[i].id)
				
		g_item_money[i] = g_item_ui[i]:AddImage(path_shop.."money_shop.png",10,110,64,64)
		g_item_gold[i] = g_item_ui[i]:AddImage(path_shop.."gold_shop.png",103,110,64,64)
		
		g_item_buy[i] = g_item_ui[i]:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",65,145,83,35)
		g_item_buy[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			-- SetShopItemBuyNameInfo(EquipInfo.strName[i])
			-- log("\nSaveCnt = "..EquipInfo.IsHaveHero[i])
			-- log("\nItemId = "..EquipInfo.IsCanBuy[i])
			if EquipInfo.IsHaveHero[i+Many*4]==1 and EquipInfo.IsCanBuy[i+Many*4]=="1" then
			XShopBuyItemIndexForLua(i+Many*4-1)
			XShopClickBuyItem(1, EquipInfo.Id[i+Many*4], EquipInfo.ItemId[i+Many*4])
			elseif EquipInfo.IsHaveHero[i+Many*4]==0 and EquipInfo.IsCanBuy[i+Many*4]=="1" then
			XShopBuyItemIndexForLua(i+Many*4-1)
			XShopClickBuyItem_Skin(EquipInfo.ItemId[i+Many*4])
			end
		end
		
		g_item_name[i] = g_item_ui[i]:AddFont("Ӣ��"..i, 15, 8, 43, -18, 300, 20, 0x83d1e7)
		g_item_Time[i] = g_item_ui[i]:AddFont("99��\n20Сʱ", 11, 0, 155, 57, 50, 50, 0xbeb5ee)
		g_item_Time[i]:SetVisible(0)
		-- g_item_HavedHero[i] = g_item_pic[i]:AddFont("��ӵ��", 15, 8, 125, -40, 300, 50, 0xffffff)
		-- g_item_IsHaveHero[i] = g_item_pic[i]:AddFont("��δӵ�и�Ӣ��", 15, 8, 125, -40, 300, 50, 0xf99700)
		g_item_gold_font[i] = g_item_gold[i]:AddFontEx("1", 15, 0, 33, 8, 100, 20, 0xff83d1e7)
		g_item_gold_font[i]:SetFontSpace(1, 0)
		g_item_money_font[i] = g_item_money[i]:AddFontEx("1", 15, 0, 33, 8, 100, 20, 0xffe4e18b)
		g_item_money_font[i]:SetFontSpace(1, 0)
		g_item_HavedHero[i] = g_item_buy[i]:AddFont("����", 15, 8, 0, 0, 83, 35, 0xc7bcf6)
	end
	
	FindButton:AddFont("����", 18, 0, 15, 2, 100, 20, 0xffffff)
	NotHave:AddFont("δӵ��Ƥ��", 15, 0, 15, 5, 100, 20, 0xc7bcf6)
end

-- Ƥ������
function IsFocusOn_EquipSearchHeroSkin()
	if (g_shop_Sec_heroSkin_ui:IsVisible() == true) then
		-- �������
		local Input_Focus = EquipHeroSkinSearchInput:IsFocus()
		
		if Input_Focus == true then
		
		elseif Input_Focus == false then
			-- EquipHeroSkinSearchInput:SetEdit("")
			-- EquipHeroSkinSearchInputText:SetVisible(1)
		end

		-- ����ѡ���
		local flagB = Oftenuse_BK:IsVisible() == true and btn_Oftenuse:IsFocus() == false and BTN_oftenUseBK[1]:IsFocus() == false and BTN_oftenUseBK[2]:IsFocus() == false
		and BTN_oftenUseBK[3]:IsFocus() == false and BTN_oftenUseBK[4]:IsFocus() == false and BTN_oftenUseBK[5]:IsFocus() == false and BTN_oftenUseBK[6]:IsFocus() == false 
		and BTN_oftenUseBK[7]:IsFocus() == false and BTN_oftenUseBK[8]:IsFocus() == false and BTN_oftenUseBK[9]:IsFocus() == false 

		if(flagB == true) then
			btn_Oftenuse:SetButtonFrame(0)
			Oftenuse_BK:SetVisible(0)
			for index,value in pairs(BTN_oftenUseBK) do
				BTN_oftenUseBK[index]:SetTransparent(0)
				BTN_oftenUseBK[index]:SetTouchEnabled(0)
			end
		end
	end
end

function onHeroSkinSearch_Enter()
	XEnterFindInput(1, EquipHeroSkinSearchInput.id, 0)
	ResetScrollList_SecHeroSkin()
end

function ReSetContrnlState_heroskin()
	XResetShopHaveHeroCheckButtonState()
	Gold_N:SetVisible(1)
	Gold_H:SetVisible(0)
	Gold_L:SetVisible(0)
	check_herohave:SetVisible(0)
	index_have = 1
	Gold_index = 0
	EquipHeroSkinSearchInput:SetEdit("")
end

function SetShop_Sec_HeroSkinIsVisible(flag) 
	if g_shop_Sec_heroSkin_ui ~= nil then
		if flag == 1 and g_shop_Sec_heroSkin_ui:IsVisible() == false then
			XShopSecSkinClick(1)
			g_shop_Sec_heroSkin_ui:SetVisible(1)
		elseif flag == 0 and g_shop_Sec_heroSkin_ui:IsVisible() == true then
			ReSetContrnlState_heroskin()
			XShopSecSkinClick(0)
			g_shop_Sec_heroSkin_ui:SetVisible(0)
		end
	end
end

function GetShop_Sec_HeroSkinIsVisible()
    if(g_shop_Sec_heroSkin_ui:IsVisible()) then
       -- XGameHeroSkinIsOpen(1)
    else
       -- XGameHeroSkinIsOpen(0)
    end
end

function CreateItemFrame_SecHeroSkin()
	return SecHeroSkin_RedrawUI()
end

function SecHeroSkin_RedrawUI()
	for i=1, #g_item_ui do
		if ((i+Many*4) > AllCount) then
			g_item_ui[i]:SetVisible(0)
		else
			if (EquipInfo.strPictureAdr[i+Many*4] == ""  or EquipInfo.strPictureAdr[i+Many*4] == nil) then
				-- ���ͼƬ·��Ϊ���򷵻�
				log("\nErrorIconPathFrom [shop_Sec_heroSkin]")
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
				
				-- if EquipInfo.IsHaveHero[i]==0 then
					-- g_item_IsHaveHero[i]:SetVisible(1)
				-- else
					-- g_item_IsHaveHero[i]:SetVisible(0)
				-- end
				
				-- �ж��Ƿ���Թ���
				if EquipInfo.IsCanBuy[i+Many*4]==tostring(0) then
					g_item_buy[i]:SetEnabled(0)
					g_item_HavedHero[i]:SetFontText("��ӵ��", 0xc7bcf6)
					-- g_item_buyUnEnable[i]:SetVisible(1)
				else
					g_item_buy[i]:SetEnabled(1)
					g_item_HavedHero[i]:SetFontText("����", 0xc7bcf6)
					-- g_item_HavedHero[i]:SetVisible(0)
					-- g_item_buyUnEnable[i]:SetVisible(0)
				end
			end
		end
	end
end

function SecHeroSkin_ClearItemInfo()
	if (#EquipInfo.strName > 0) then
		EquipInfo = {}
		EquipInfo.strName = {}			-- װ������
		EquipInfo.strPictureAdr = {}	-- װ��ͼƬ·��
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
		
		EquipInfo.beginX = {}
		EquipInfo.beginY = {}
		EquipInfo.Width = {}
		EquipInfo.Height = {}
		EquipInfo.Tip = {}
		EquipInfo.IsHaveHero = {}
	end
	for i=1,#g_item_ui do
		g_item_ui[i]:SetVisible(0)
	end
	-- for i=(1+(Many*4)), (1+(Many*4)+11) do
		-- g_item_ui[i]:SetVisible(1)
	-- end
end

function SecHeroSkin_ReceiveItemInfo(strName,strPictureAdr,strDesc,leftTime,money,gold,honour,contri,vip,m_Flag,IsCanBuy,Id,ItemId, cbeginX, cbeginY, cWidth, cHeight, ctip, cIsHaveHero)
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
	
	EquipInfo.beginX[size] = cbeginX
	EquipInfo.beginY[size] = cbeginY
	EquipInfo.Width[size] = cWidth
	EquipInfo.Height[size] = cHeight
	EquipInfo.Tip[size] = ctip
	EquipInfo.IsHaveHero[size] = cIsHaveHero
	
end

-- �õ���Ʒ����
function GetItemCount_SecHeroSkin(ItemCount)
	AllCount = ItemCount
	if AllCount < 13 then
		heroInfo_togglebtn:SetVisible(0)
		heroInfo_toggleImg:SetVisible(0)
	else
		heroInfo_togglebtn:SetVisible(1)
		heroInfo_toggleImg:SetVisible(1)
	end
	return CreateItemFrame_SecHeroSkin()
end

function ResetScrollList_SecHeroSkin()
	-- �ÿؼ��͹���������һ��
	-- if Many_Equip ~= Many then
	Many = 0
	Many_Equip = Many
	updownCount = 0
	maxUpdown = 0
	heroInfo_togglebtn:SetPosition(0,0)
	heroInfo_togglebtn._T = 0
	SecHeroSkin_RedrawUI()
end

function GetFindInputChar_skin()
	if g_shop_Sec_heroSkin_ui:IsVisible()==true then
		XTellCInputChar(EquipHeroSkinSearchInput.id)
	end
end

function SetButtonState_secheroskin(cindex)
	if g_item_buy[cindex-Many*4]~= nil and g_item_HavedHero[cindex-Many*4] ~= nil then
		EquipInfo.IsCanBuy[cindex] = "0"
		g_item_buy[cindex-Many*4]:SetEnabled(0)
		g_item_HavedHero[cindex-Many*4]:SetVisible(1)
	end
end

function SetButtonStateCanBuy_secheroskin(cindex, cIsHavehero)
	if g_item_buy[cindex-Many*4]~= nil and g_item_HavedHero[cindex-Many*4] ~= nil then
		-- g_item_IsHaveHero[cindex]:SetVisible(0)
		
		EquipInfo.IsHaveHero[cindex] = cIsHavehero
	end
end

function ClearInputFont_heroskin()
	EquipHeroSkinSearchInput:SetEdit("")
end

function ReSetItemPosAndVisible()
	SecHeroSkin_RedrawUI()
end