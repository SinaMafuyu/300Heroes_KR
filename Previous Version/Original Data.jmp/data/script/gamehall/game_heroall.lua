include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-- ����һ����ת��װ������ı�־
JumpToEquip = 0

local BTN_showAllBK = {}
local BTN_showAllFont = {"��ʾȫ��","�̿�","սʿ","̹��","����","��ʦ","����"}
local index_showAll = 1

local BTN_oftenUseBK = {}
local BTN_oftenUseFont = {"����Ӣ��","��ʱ����","��������","�ҵ��","�����ս","ʤ�����"}
local index_oftenUse = 1
local index_have = 1

-- Ϊ�˸�ԭ��ʼ��
local hero_HIDE = {}		-- ��ͼ���ֵ����ť
local hero_CLICK = {}		-- �������
local hero_SIDE = {}		-- �߿�
local hero_HEAD = {}		-- Ӣ��ͼ��
local hero_FAVOR = {}		-- �ҵ��

local hero_ICONNAME = {}
local ICON_X = {}
local ICON_Y = {}

local showAll_BK = nil
local Oftenuse_BK = nil
local btn_showAll = nil
local Font_showAll = nil
local btn_Oftenuse = nil
local Font_Oftenuse = nil
local check_herohave = nil
local heronameInput = nil
local hero_toggleImg = nil
local hero_togglebtn = nil

-- 38�������Ӣ����Ϣ��strPictureName��strName��strHeroDesc��qwernͼƬ·����qwern��������ȫ����str
local HeroInfo = {}
HeroInfo.strPictureName = {}	-- Ӣ��ͷ��·��
HeroInfo.strName = {}			-- Ӣ������

-- 42������ 8��str��34��double
HeroInfo.SkinAdressA = {}	-- Ӣ�۵�һ��Ƥ��·��
HeroInfo.SkinAdressB = {}		
HeroInfo.SkinAdressC = {}		
HeroInfo.SkinAdressD = {}		
HeroInfo.SkinNameA = {}		-- Ӣ�۵�һ��Ƥ������
HeroInfo.SkinNameB = {}			
HeroInfo.SkinNameC = {}			
HeroInfo.SkinNameD = {}			

HeroInfo.SkinPosxA = {}		-- СƤ���Ľ�ȡ��ʼλ��X
HeroInfo.SkinPosxB = {}		
HeroInfo.SkinPosxC = {}		
HeroInfo.SkinPosxD = {}		
HeroInfo.SkinPosyA = {}		-- СƤ���Ľ�ȡ��ʼλ��y
HeroInfo.SkinPosyB = {}		
HeroInfo.SkinPosyC = {}		
HeroInfo.SkinPosyD = {}	
HeroInfo.SkinPoswA = {}		-- СƤ���Ľ�ȡ���w
HeroInfo.SkinPoswB = {}		
HeroInfo.SkinPoswC = {}		
HeroInfo.SkinPoswD = {}		
HeroInfo.SkinPoshA = {}		-- СƤ���Ľ�ȡ�߶�h
HeroInfo.SkinPoshB = {}		
HeroInfo.SkinPoshC = {}		
HeroInfo.SkinPoshD = {}		
HeroInfo.SkinHaveA = {}		-- �Ƿ�ӵ��Ƥ��
HeroInfo.SkinHaveB = {}		
HeroInfo.SkinHaveC = {}		
HeroInfo.SkinHaveD = {}		
HeroInfo.SkinPriceA = {}	-- Ƥ���۸�
HeroInfo.SkinPriceB = {}		
HeroInfo.SkinPriceC = {}		
HeroInfo.SkinPriceD = {}	
HeroInfo.SkinLvA = {}		-- Ƥ���ȼ�
HeroInfo.SkinLvB = {}
HeroInfo.SkinLvC = {}
HeroInfo.SkinLvD = {}
HeroInfo.SkinRealID1 = {}
HeroInfo.SkinRealID2 = {}
HeroInfo.SkinRealID3 = {}
HeroInfo.SkinRealID4 = {}
	
HeroInfo.getHero = {}		-- �Ƿ�ӵ��
HeroInfo.IsFavorite = {}	-- �Ƿ��
HeroInfo.heroMoney = {}		-- Ӣ�۽�Ǯ�۸�
HeroInfo.heroGold = {}		-- Ӣ����ʯ�۸�
HeroInfo.heroDiscount = {}	-- ��ʯ�ۿ�

HeroInfo.HeroId = {}		-- Ӣ��ID
HeroInfo.HeroTips = {}		-- Ӣ��TIPS

HeroInfo.HeroWinCount = {}	-- ������ʤ��
HeroInfo.HeroAllCount = {}	-- �������ܳ�


local btn_HeroAll = nil
local btn_HeroSkin = nil
local btn_ListBK = nil

-- ���ڹ���
local updownCount = 0
local maxUpdown = 0
local bgImg = nil

local Many = 0	

function InitGame_HeroAllUI(wnd, bisopen)
	g_game_heroAll_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainGame_HeroAll(g_game_heroAll_ui)	
	g_game_heroAll_ui:SetVisible(bisopen)
end
function InitMainGame_HeroAll(wnd)
	--��ͼ����
	bgImg = wnd:AddImage(path_shop.."BK_shop.png",0,0,1280,800)
		
	--�ϱ���
	wnd:AddImage(path.."upBK_hall.png",0,0,1280,54)
	wnd:AddImage(path.."upLine2_hall.png",0,54,1280,35)
	--wnd:AddImage(path.."linecut_hall.png",273,60,2,32)	
	btn_ListBK = wnd:AddImage(path_start.."ListBK_start.png",135,53,256,38)
	
	--Ӣ������
	btn_HeroAll = wnd:AddImage(path_hero.."indexA3_hero.png",165,53,110,33)
	
	--Ӣ��װ��
	btn_HeroSkin = wnd:AddCheckButton(path_hero.."indexB1_hero.png",path_hero.."indexB2_hero.png",path_hero.."indexB3_hero.png",275,53,110,33)
	btn_HeroSkin:SetVisible(0)
	XWindowEnableAlphaTouch(btn_HeroSkin.id)
	btn_HeroSkin.script[XE_LBDOWN] = function()
		XClickPlaySound(5)
		SetGameHeroAllIsVisible(0)
		SetGameHeroSkinIsVisible(1)
	end
	
	--Ӣ������
	local btn_heroSearch = wnd:AddImage(path_start.."sortbk_start.png",60,150,128,32)
	btn_heroSearch:AddFont("Ӣ������",12,0,22,6,100,15,0xbeb5ee)	
	local heroSearchInputEdit = CreateWindow(wnd.id, 168,150, 290, 30)
	heronameInput = heroSearchInputEdit:AddEdit(path_hero.."herocardSearch_hero.png","","HeroCard_OnSearchEnter","",13,5,5,290,25,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(heronameInput.id,20)
	--heronameInput:SetDefaultFontText("������Enter��ȷ��", 0xff303b4a)
	
	--Ӣ�۶�λ
	local btn_heroBelong = wnd:AddImage(path_start.."sortbk_start.png",495,150,128,32)
	btn_heroBelong:AddFont("Ӣ�۶�λ",12,0,22,6,100,15,0xbeb5ee)
	btn_showAll = wnd:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",600,150,128,32)
	Font_showAll = btn_showAll:AddFont("��ʾȫ��",12,0,18,6,100,15,0xbeb5ee)
	
	
	--ʹ��ϰ��
	local btn_heroLove = wnd:AddImage(path_start.."sortbk_start.png",710,150,128,32)
	btn_heroLove:AddFont("ʹ��ϰ��",12,0,22,6,100,15,0xbeb5ee)
	btn_Oftenuse = wnd:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",815,150,128,32)
	Font_Oftenuse = btn_Oftenuse:AddFont("����Ӣ��",12,0,18,6,100,15,0xbeb5ee)
	
	
	--ӵ��Ӣ��
	local btn_heroHave = wnd:AddImage(path_start.."sortbk_start.png",1000,150,128,32)
	btn_heroHave:AddFont("ӵ��Ӣ��",12,0,22,6,100,15,0xbeb5ee)
	
	local check_heroBK = wnd:AddImage(path_hero.."checkbox_hero.png",1115,150,32,32)
	check_heroBK:SetTouchEnabled(1)
	check_herohave = check_heroBK:AddImage(path_hero.."checkboxYes_hero.png",5,-1,32,32)
	check_herohave:SetTouchEnabled(0)
	check_herohave:SetVisible(0)
	check_heroBK.script[XE_LBUP] = function()
		if (check_herohave:IsVisible()) then
			check_herohave:SetVisible(0)
			index_have = 1
		else
			check_herohave:SetVisible(1)
			index_have = 2
		end
		
		HeroCard_OnSearchEnter()
	end
	
	
	-- ��ʼ��Ӣ��Сͷ��
	for index = 1,45 do 
		ICON_X[index] = ((index-1)%15)*75 + 50+10
		ICON_Y[index] = 180*math.ceil(index/15)+10
		-- ͷ��
		hero_HEAD[index] = wnd:AddImage(path_start.."herohead_start.png",ICON_X[index],ICON_Y[index],64,148)		-- ԭ����256����ʱ�޸ĳ�148
				
		-- ����
		hero_HIDE[index] = hero_HEAD[index]:AddImage(path_start.."icon5_start.png",-10,-10,86,170)
		hero_HIDE[index]:SetTouchEnabled(0)
		hero_HIDE[index]:SetVisible(0)
		
		-- �
		hero_FAVOR[index] = hero_HEAD[index]:AddImage(path_hero.."LOVE2_hero.png",3,120,32,32)
		hero_FAVOR[index]:SetTouchEnabled(0)
		hero_FAVOR[index]:SetVisible(0)
		
		-- �߿�
		hero_SIDE[index] = hero_HEAD[index]:AddImage(path_start.."icon7_start.png",-10,-10,86,170)
		hero_SIDE[index]:SetTouchEnabled(0)		
		-- Ӣ������
		hero_ICONNAME[index] = hero_HEAD[index]:AddFont("�����ʥ",12,8,0,0,66,330,0xbeb5ee)
		
		if ICON_Y[index] >600 or ICON_Y[index] <100 then
			hero_HEAD[index]:SetVisible(0) 
		else
			hero_HEAD[index]:SetVisible(1)
		end
		hero_HEAD[index].script[XE_LBUP] = function()
			if JumpToEquip ==1 then
				XRefreshEquipBagValue(HeroInfo.HeroId[index+Many*15],GetBagHeroBagNow())--�ϴ�Ӣ��id �� ��ǰ��װid
				SetifjumpFromhero(1)
				Set_JumpToEquip()		-- ��ת��װ������
			else				
				SetShowType(1)
				-- ��ʼ���ӽ���
				if HeroInfo.HeroId[index+Many*15] == 151 or HeroInfo.HeroId[index+Many*15] == 188 or HeroInfo.HeroId[index+Many*15] == 135 or HeroInfo.HeroId[index+Many*15] == 100 then
					-- VIP����Ӣ�۰ѽ�Ҹĳ�VIP
					ChangeBuyImage_HeroDetail(2)
				else
					ChangeBuyImage_HeroDetail(1)
				end
				Change_HeroDetail(g_game_hero_ui,
				HeroInfo.strPictureName[index+Many*15],
				HeroInfo.strName[index+Many*15],
				
				HeroInfo.SkinAdressA[index+Many*15],	-- Ӣ�۵�һ��Ƥ��·��
				HeroInfo.SkinAdressB[index+Many*15],
				HeroInfo.SkinAdressC[index+Many*15],
				HeroInfo.SkinAdressD[index+Many*15],
				HeroInfo.SkinNameA[index+Many*15],		-- Ӣ�۵�һ��Ƥ������
				HeroInfo.SkinNameB[index+Many*15],
				HeroInfo.SkinNameC[index+Many*15],
				HeroInfo.SkinNameD[index+Many*15],

				HeroInfo.SkinPosxA[index+Many*15],		-- СƤ���Ľ�ȡ��ʼλ��X
				HeroInfo.SkinPosxB[index+Many*15],
				HeroInfo.SkinPosxC[index+Many*15],
				HeroInfo.SkinPosxD[index+Many*15],
				HeroInfo.SkinPosyA[index+Many*15],		-- СƤ���Ľ�ȡ��ʼλ��y
				HeroInfo.SkinPosyB[index+Many*15],
				HeroInfo.SkinPosyC[index+Many*15],
				HeroInfo.SkinPosyD[index+Many*15],
				HeroInfo.SkinPoswA[index+Many*15],		-- СƤ���Ľ�ȡW
				HeroInfo.SkinPoswB[index+Many*15],
				HeroInfo.SkinPoswC[index+Many*15],
				HeroInfo.SkinPoswD[index+Many*15],
				HeroInfo.SkinPoshA[index+Many*15],		-- СƤ���Ľ�ȡH
				HeroInfo.SkinPoshB[index+Many*15],
				HeroInfo.SkinPoshC[index+Many*15],
				HeroInfo.SkinPoshD[index+Many*15],
				HeroInfo.SkinHaveA[index+Many*15],		-- �Ƿ�ӵ��Ƥ��
				HeroInfo.SkinHaveB[index+Many*15],
				HeroInfo.SkinHaveC[index+Many*15],
				HeroInfo.SkinHaveD[index+Many*15],
				HeroInfo.SkinPriceA[index+Many*15],		-- Ƥ����ʯ�۸�
				HeroInfo.SkinPriceB[index+Many*15],
				HeroInfo.SkinPriceC[index+Many*15],
				HeroInfo.SkinPriceD[index+Many*15],
				HeroInfo.SkinLvA[index+Many*15],
				HeroInfo.SkinLvB[index+Many*15],
				HeroInfo.SkinLvC[index+Many*15],
				HeroInfo.SkinLvD[index+Many*15],
				HeroInfo.SkinRealID1[index+Many*15],
				HeroInfo.SkinRealID2[index+Many*15],
				HeroInfo.SkinRealID3[index+Many*15],
				HeroInfo.SkinRealID4[index+Many*15],

				HeroInfo.getHero[index+Many*15],
				HeroInfo.IsFavorite[index+Many*15],
				HeroInfo.heroMoney[index+Many*15],
				HeroInfo.heroGold[index+Many*15],
				HeroInfo.heroDiscount[index+Many*15],
				
				HeroInfo.HeroId[index+Many*15],
				HeroInfo.HeroTips[index+Many*15],
				
				HeroInfo.HeroWinCount[index+Many*15],
				HeroInfo.HeroAllCount[index+Many*15]
				)
			end
		end
		-- ��tips����
		hero_HEAD[index].script[XE_ONHOVER] = function()
			local Lh,Th = hero_HIDE[index]:GetPosition()
			hero_CLICK:SetAbsolutePosition(Lh,Th)
			hero_CLICK:SetVisible(1)
		end
		hero_HEAD[index].script[XE_ONUNHOVER] = function()
			hero_CLICK:SetVisible(0)
		end
		
	end
	-- ��ɫ����(ֻ��һ�����ƶ�λ��)
	hero_CLICK = wnd:AddImage(path_start.."icon2_start.png",0,0,86,170)
	hero_CLICK:SetTouchEnabled(0)
	hero_CLICK:SetVisible(0)
		
	-- ��ʾȫ������������
	showAll_BK = wnd:AddImage(path_hero.."listBK1_hero.png",600,180,128,256)
	showAll_BK:SetVisible(0)
	
	for dis = 1,7 do
		BTN_showAllBK[dis] = wnd:AddImage(path_hero.."listhover_hero.png",600,151+dis*29,128,32)
		showAll_BK:AddFont(BTN_showAllFont[dis],12,0,18,dis*29-23,128,32,0xbeb5ee)
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
			Font_showAll:SetFontText(BTN_showAllFont[dis],0xbeb5ee)
			index_showAll = dis
						
			HeroCard_OnSearchEnter()
			btn_showAll:SetButtonFrame(0)
			showAll_BK:SetVisible(0)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(0)
			end
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
	Oftenuse_BK = wnd:AddImage(path_hero.."listBK2_hero.png",815,180,128,256)
	Oftenuse_BK:SetVisible(0)
	
	for dis = 1,6 do
		BTN_oftenUseBK[dis] = wnd:AddImage(path_hero.."listhover_hero.png",815,151+dis*29,128,32)
		Oftenuse_BK:AddFont(BTN_oftenUseFont[dis],12,0,18,dis*29-23,128,32,0xbeb5ee)
		BTN_oftenUseBK[dis]:SetTransparent(0)
		BTN_oftenUseBK[dis]:SetTouchEnabled(0)
		
		-- ��껬��
		BTN_oftenUseBK[dis].script[XE_ONHOVER] = function()
			if Oftenuse_BK:IsVisible() == true then
				BTN_oftenUseBK[dis]:SetTransparent(1)
			end
		end
		BTN_oftenUseBK[dis].script[XE_ONUNHOVER] = function()
			if Oftenuse_BK:IsVisible() == true then
				BTN_oftenUseBK[dis]:SetTransparent(0)
			end
		end
		
		BTN_oftenUseBK[dis].script[XE_LBUP] = function()
			Font_Oftenuse:SetFontText(BTN_oftenUseFont[dis],0xbeb5ee)
			index_oftenUse = dis			
			
			HeroCard_OnSearchEnter()
			btn_Oftenuse:SetButtonFrame(0)
			Oftenuse_BK:SetVisible(0)
			for index,value in pairs(BTN_oftenUseBK) do
				BTN_oftenUseBK[index]:SetTransparent(0)
				BTN_oftenUseBK[index]:SetTouchEnabled(0)
			end
		end
	end
	
	btn_Oftenuse.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if Oftenuse_BK:IsVisible() then
			Oftenuse_BK:SetVisible(0)
			for index,value in pairs(BTN_oftenUseBK) do
				BTN_oftenUseBK[index]:SetTransparent(0)
				BTN_oftenUseBK[index]:SetTouchEnabled(0)
			end
		else
			Oftenuse_BK:SetVisible(1)
			for index,value in pairs(BTN_oftenUseBK) do
				BTN_oftenUseBK[index]:SetTransparent(0)
				BTN_oftenUseBK[index]:SetTouchEnabled(1)
			end
		end
	end	
		
	-- ��ʾ������
	hero_toggleImg = wnd:AddImage(path.."toggleBK_main.png",1190,202,16,494)
	hero_togglebtn = hero_toggleImg:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = hero_toggleImg:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = hero_toggleImg:AddImage(path.."TD1_main.png",0,494,16,16)
	
	XSetWindowFlag(hero_togglebtn.id,1,1,0,444)
	
	hero_togglebtn:ToggleBehaviour(XE_ONUPDATE, 1)
	hero_togglebtn:ToggleEvent(XE_ONUPDATE, 1)
	hero_togglebtn.script[XE_ONUPDATE] = function()
		if hero_togglebtn._T == nil then
			hero_togglebtn._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(hero_togglebtn.id)
		if hero_togglebtn._T ~= T then
			local length = 0
			if #HeroInfo.strName <=45 then
				length = 444
			else
				length = 444/math.ceil((#HeroInfo.strName/15)-3)
			end
			Many = math.floor(T/length)
			updownCount = Many
			
			ReDraw_HeroAll()
			
			hero_togglebtn._T = T
		end
	end
	-- ���ý�����Ի���
	XWindowEnableAlphaTouch(g_game_heroAll_ui.id)
	g_game_heroAll_ui:EnableEvent(XE_MOUSEWHEEL)
	g_game_heroAll_ui.script[XE_MOUSEWHEEL] = function()
		local updown  = XGetMsgParam0()
		local length = 0
		if #HeroInfo.strName >45 then
			maxUpdown = math.ceil((#HeroInfo.strName/15)-3)
			length = 444/maxUpdown
		else
			maxUpdown = 0
			length = 444
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
		
		btn_pos = length*updownCount
		Many = updownCount
		
		hero_togglebtn:SetPosition(0,btn_pos)
		hero_togglebtn._T = btn_pos
		
		if updownCount >= 0 and updownCount <= maxUpdown then
			ReDraw_HeroAll()
		end		
	end
end
-- ����Ӣ�����Ʒ��ͺ�����C++
function HeroCard_OnSearchEnter()
	InitHero_HidePosition()
	-- ����4�����ݵ�c++,������Ӣ�����ơ���λ1-7��ϰ��1-6���Ƿ�ӵ��1-2
	XSearchHeroCardName(heronameInput:GetEdit(),index_showAll,index_oftenUse,index_have)	
end

-- �����UI
function ClearHeroInfo()
	HeroInfo = {}					-- �������������Ϣ
	HeroInfo.strPictureName = {}	-- Ӣ��ͷ��·��
	HeroInfo.strName = {}			-- Ӣ������
	
	HeroInfo.SkinAdressA = {}		-- Ӣ�۵�һ��Ƥ��·��
	HeroInfo.SkinAdressB = {}		
	HeroInfo.SkinAdressC = {}		
	HeroInfo.SkinAdressD = {}		
	HeroInfo.SkinNameA = {}		-- Ӣ�۵�һ��Ƥ������
	HeroInfo.SkinNameB = {}			
	HeroInfo.SkinNameC = {}			
	HeroInfo.SkinNameD = {}			

	HeroInfo.SkinPosxA = {}		-- СƤ���Ľ�ȡ��ʼλ��X
	HeroInfo.SkinPosxB = {}		
	HeroInfo.SkinPosxC = {}		
	HeroInfo.SkinPosxD = {}		
	HeroInfo.SkinPosyA = {}		-- СƤ���Ľ�ȡ��ʼλ��y
	HeroInfo.SkinPosyB = {}		
	HeroInfo.SkinPosyC = {}		
	HeroInfo.SkinPosyD = {}
	HeroInfo.SkinPoswA = {}		-- СƤ���Ľ�ȡ���w
	HeroInfo.SkinPoswB = {}		
	HeroInfo.SkinPoswC = {}		
	HeroInfo.SkinPoswD = {}		
	HeroInfo.SkinPoshA = {}		-- СƤ���Ľ�ȡ�߶�h
	HeroInfo.SkinPoshB = {}		
	HeroInfo.SkinPoshC = {}		
	HeroInfo.SkinPoshD = {}	
	HeroInfo.SkinHaveA = {}		-- �Ƿ�ӵ��Ƥ��
	HeroInfo.SkinHaveB = {}		
	HeroInfo.SkinHaveC = {}		
	HeroInfo.SkinHaveD = {}		
	HeroInfo.SkinPriceA = {}	-- Ƥ���۸�
	HeroInfo.SkinPriceB = {}		
	HeroInfo.SkinPriceC = {}		
	HeroInfo.SkinPriceD = {}	
	HeroInfo.SkinLvA = {}
	HeroInfo.SkinLvB = {}
	HeroInfo.SkinLvC = {}
	HeroInfo.SkinLvD = {}
	HeroInfo.SkinRealID1 = {}
	HeroInfo.SkinRealID2 = {}
	HeroInfo.SkinRealID3 = {}
	HeroInfo.SkinRealID4 = {}
		
	HeroInfo.getHero = {}		-- �Ƿ�ӵ��
	HeroInfo.IsFavorite = {}    -- �Ƿ��
	HeroInfo.heroMoney = {}		-- Ӣ�۽�Ǯ�۸�
	HeroInfo.heroGold = {}		-- Ӣ����ʯ�۸�
	HeroInfo.heroDiscount = {}	-- ��ʯ�ۿ�
	
	HeroInfo.HeroId = {}
	HeroInfo.HeroTips = {}
	
	HeroInfo.HeroWinCount = {}
	HeroInfo.HeroAllCount = {}
	
	for index=1,#hero_HEAD do
		hero_HEAD[index]:SetVisible(0)
	end
end	
-- ��ȡC++����������
function SendHeroInfoDataToLua(strPictureName,strName,
SkinAdressA,
SkinAdressB,
SkinAdressC,
SkinAdressD,
SkinNameA,
SkinNameB,
SkinNameC,
SkinNameD,
SkinPosxA,SkinPosxB,SkinPosxC,SkinPosxD,
SkinPosyA,SkinPosyB,SkinPosyC,SkinPosyD,
SkinPoswA,SkinPoswB,SkinPoswC,SkinPoswD,
SkinPoshA,SkinPoshB,SkinPoshC,SkinPoshD,
SkinHaveA,SkinHaveB,SkinHaveC,SkinHaveD,
SkinPriceA,SkinPriceB,SkinPriceC,SkinPriceD,
skinLvA,skinLvB,skinLvC,skinLvD,
skinRealId1,skinRealId2,skinRealId3,skinRealId4,
getHero,IsFavorite,
heroMoney,heroGold,heroDiscount,
cHeroID,tip,
cHeroWinCount,cHeroAllCount
)
	-- �������
	local size = #HeroInfo.strName+1
	HeroInfo.strPictureName[size] = "..\\"..strPictureName					-- 1
	HeroInfo.strName[size] = strName										-- 2
	
	-- Ӣ�۵�һ��Ƥ��·��
	HeroInfo.SkinAdressA[size] = SkinAdressA	
	HeroInfo.SkinAdressB[size] = SkinAdressB		
	HeroInfo.SkinAdressC[size] = SkinAdressC		
	HeroInfo.SkinAdressD[size] = SkinAdressD		
	HeroInfo.SkinNameA[size] = SkinNameA		-- Ӣ�۵�һ��Ƥ������
	HeroInfo.SkinNameB[size] = SkinNameB			
	HeroInfo.SkinNameC[size] = SkinNameC			
	HeroInfo.SkinNameD[size] = SkinNameD			

	HeroInfo.SkinPosxA[size] = SkinPosxA		-- СƤ���Ľ�ȡ��ʼλ��X
	HeroInfo.SkinPosxB[size] = SkinPosxB		
	HeroInfo.SkinPosxC[size] = SkinPosxC		
	HeroInfo.SkinPosxD[size] = SkinPosxD		
	HeroInfo.SkinPosyA[size] = SkinPosyA		-- СƤ���Ľ�ȡ��ʼλ��y
	HeroInfo.SkinPosyB[size] = SkinPosyB		
	HeroInfo.SkinPosyC[size] = SkinPosyC		
	HeroInfo.SkinPosyD[size] = SkinPosyD
	HeroInfo.SkinPoswA[size] = SkinPoswA		-- СƤ���Ľ�ȡ���w
	HeroInfo.SkinPoswB[size] = SkinPoswB		
	HeroInfo.SkinPoswC[size] = SkinPoswC		
	HeroInfo.SkinPoswD[size] = SkinPoswD		
	HeroInfo.SkinPoshA[size] = SkinPoshA		-- СƤ���Ľ�ȡ�߶�h
	HeroInfo.SkinPoshB[size] = SkinPoshB		
	HeroInfo.SkinPoshC[size] = SkinPoshC		
	HeroInfo.SkinPoshD[size] = SkinPoshD	
	HeroInfo.SkinHaveA[size] = SkinHaveA		-- �Ƿ�ӵ��Ƥ��
	HeroInfo.SkinHaveB[size] = SkinHaveB
	HeroInfo.SkinHaveC[size] = SkinHaveC
	HeroInfo.SkinHaveD[size] = SkinHaveD
	HeroInfo.SkinPriceA[size] = SkinPriceA		-- Ƥ���۸�
	HeroInfo.SkinPriceB[size] = SkinPriceB
	HeroInfo.SkinPriceC[size] = SkinPriceC
	HeroInfo.SkinPriceD[size] = SkinPriceD
	HeroInfo.SkinLvA[size] = skinLvA
	HeroInfo.SkinLvB[size] = skinLvB
	HeroInfo.SkinLvC[size] = skinLvC
	HeroInfo.SkinLvD[size] = skinLvD
	HeroInfo.SkinRealID1[size] = skinRealId1
	HeroInfo.SkinRealID2[size] = skinRealId2
	HeroInfo.SkinRealID3[size] = skinRealId3
	HeroInfo.SkinRealID4[size] = skinRealId4
		
	HeroInfo.getHero[size] = getHero			-- �Ƿ�ӵ��
	HeroInfo.IsFavorite[size] = IsFavorite			-- �Ƿ�ӵ��
	HeroInfo.heroMoney[size] = heroMoney		-- Ӣ�۽�Ǯ�۸�
	HeroInfo.heroGold[size] = heroGold			-- Ӣ����ʯ�۸�
	HeroInfo.heroDiscount[size] = heroDiscount	-- ��ʯ�ۿ�

	HeroInfo.HeroId[size] = cHeroID
	HeroInfo.HeroTips[size] = tip
	
	HeroInfo.HeroWinCount[Size] = cHeroWinCount
	HeroInfo.HeroAllCount[Size] = cHeroAllCount
end
function SendHeroInfoDataOver()
	if #HeroInfo.strName <=45 then
		hero_toggleImg:SetVisible(0)
	else
		hero_toggleImg:SetVisible(1)
	end
	ReDraw_HeroAll()
end
-- ��ԭӢ�۶�λ��ɸѡ������
function RecoverHeroInfo()
	-- 2��������ָ�
	Font_showAll:SetFontText(BTN_showAllFont[1],0xbeb5ee)
	btn_showAll:SetButtonFrame(0)
	showAll_BK:SetVisible(0)
	Font_Oftenuse:SetFontText(BTN_oftenUseFont[1],0xbeb5ee)
	btn_Oftenuse:SetButtonFrame(0)
	Oftenuse_BK:SetVisible(0)
	
	for index,value in pairs(BTN_showAllBK) do
		BTN_showAllBK[index]:SetTransparent(0)
	end
	for index,value in pairs(BTN_oftenUseBK) do
		BTN_oftenUseBK[index]:SetTransparent(0)
	end
		
	-- checkBOX�ָ�	�����������ָ�
	check_herohave:SetVisible(0)
	heronameInput:SetEdit("")
	
	index_showAll = 1
	index_oftenUse = 1
	index_have = 1
		
	InitHero_HidePosition()

end
-- 1����������ָ� �����ָֻ���
function InitHero_HidePosition()

	-- �������ָ�
	updownCount = 0
	maxUpdown = 0
	Many = 0
	hero_togglebtn:SetPosition(0,0)
	hero_togglebtn._T = 0
	
	-- for i,value in pairs(hero_HEAD) do
		-- local Li, Ti = ICON_X[i],ICON_Y[i]		
		-- hero_HEAD[i]:SetPosition(Li, Ti)
		
		-- if Ti >600 or Ti <100 then
			-- hero_HEAD[i]:SetVisible(0)
		-- else
			-- hero_HEAD[i]:SetVisible(1)
		-- end
	-- end	
	
	ReDraw_HeroAll()
	
end


function IsFocusOn_HeroAll()
	if (g_game_heroAll_ui:IsVisible() == true) then
		local flagA = showAll_BK:IsVisible() == true and btn_showAll:IsFocus() == false and BTN_showAllBK[1]:IsFocus() == false and BTN_showAllBK[2]:IsFocus() == false
		and BTN_showAllBK[3]:IsFocus() == false and BTN_showAllBK[4]:IsFocus() == false and BTN_showAllBK[5]:IsFocus() == false and BTN_showAllBK[6]:IsFocus() == false
		and BTN_showAllBK[7]:IsFocus() == false

		if(flagA == true) then
			btn_showAll:SetButtonFrame(0)
			showAll_BK:SetVisible(0)
			for index,value in pairs(BTN_showAllBK) do
				BTN_showAllBK[index]:SetTransparent(0)
				BTN_showAllBK[index]:SetTouchEnabled(0)
			end
		end
		
		local flagB = Oftenuse_BK:IsVisible() == true and btn_Oftenuse:IsFocus() == false and BTN_oftenUseBK[1]:IsFocus() == false and BTN_oftenUseBK[2]:IsFocus() == false
		and BTN_oftenUseBK[3]:IsFocus() == false and BTN_oftenUseBK[4]:IsFocus() == false and BTN_oftenUseBK[5]:IsFocus() == false and BTN_oftenUseBK[6]:IsFocus() == false

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

-- ����������ת��Ӣ�ۼ��������ҳ��
function EventToHeroDetail(heroid)
	for i = 1, #HeroInfo.HeroId do
		if HeroInfo.HeroId[i] == heroid then
			hero_HEAD[i]:TriggerBehaviour(XE_LBUP)
		end
	end	
end
-- ������ʾ
function SetGameHeroAllIsVisible(flag) 
	if g_game_heroAll_ui ~= nil then
		if flag == 1 and g_game_heroAll_ui:IsVisible() == false then
			g_game_heroAll_ui:SetVisible(1)
			XShopUiIsClick(1)
			btn_HeroSkin:SetCheckButtonClicked(0)
			SetFourpartUIVisiable(4)
		elseif flag == 0 and g_game_heroAll_ui:IsVisible() == true then
			g_game_heroAll_ui:SetVisible(0)
		end
	end
end

function GetGameHeroAllIsVisible()  
    if g_game_heroAll_ui ~= nil and g_game_heroAll_ui:IsVisible()==true then
        return 1
    else
        return 0
    end
end

-- ���Ӣ������		RecoverHeroInfo��ClearHeroInfo��SendHeroInfoDataToLua��DrawHeroInfo��SetGameHeroAllIsVisible
-- ���ӵ��Ӣ��֮��	onSearchEnter��InitHero_HidePosition��ClearHeroInfo��SendHeroInfoDataToLua��DrawHeroInfo

function ReDraw_HeroAll()
	for i=1, 45 do
		if i+Many*15 > #HeroInfo.strPictureName then
			hero_HEAD[i]:SetVisible(0)
			local Lh,Th = hero_HIDE[i]:GetPosition()
			local Lh1,Th1 = hero_CLICK:GetPosition()
			if Lh==Lh1 and Th==Th1 then
				hero_CLICK:SetVisible(0)
			end
		else
			hero_HEAD[i]:SetVisible(1)
			hero_HEAD[i].changeimage(HeroInfo.strPictureName[i+Many*15])
			hero_HEAD[i]:SetImageTip(HeroInfo.HeroTips[i+Many*15])
			hero_ICONNAME[i]:SetFontText(HeroInfo.strName[i+Many*15],0xbeb5ee)
			
			-- �Ƿ�ӵ��Ӣ��
			if HeroInfo.getHero[i+Many*15] <= 0 then
				hero_HIDE[i]:SetVisible(1)
			else
				hero_HIDE[i]:SetVisible(0)
			end
			-- �ҵ��
			if HeroInfo.IsFavorite[i+Many*15] <= 0 then
				hero_FAVOR[i]:SetVisible(0)
			else
				hero_FAVOR[i]:SetVisible(1)
			end
		end
	end
end
