include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local IMG_GeRenChengJiu = nil		-- ���˳ɾ�
local FONT_GeRenChengJiu = nil		-- ���˳ɾ�����
local IMG_ChengJiuZongShu = nil		-- �ɾ�����
local FONT_ChengJiuZongShu = nil	-- �ɾ���������
local IMG_DangQianShiYong = nil		-- ��ǰʹ��
local IMG_DuiHaoDi = {}				-- �Ժŵ�
local IMG_DuiHao = {}				-- �Ժ�
local IMG_HuangGuan = nil			-- �ʹ�
local IMG_XiaoTouXiangDi = nil		-- Сͷ���
local IMG_XiaoTouXiangPic = nil     -- Сͷ��ͼƬ
local IMG_XiaoTouXiangKuang = nil	-- Сͷ���
local FONT_ChengHaoMingCHeng = nil	-- �ƺ�����
local IMG_ChengHaoDi = nil			-- �ƺŵ�
local BTN_DaFenLeiAnNiu = {}		-- ����ఴť
BTN_DaFenLeiAnNiu.name = {}			-- ����ఴť����
BTN_DaFenLeiAnNiu.nameFont = {"��ӵ�гɾ�","���㾺����","����ս��","�ػ��ŵ���","�̳ǳɾ�","Ӣ�۳ɾ�","�����ɾ�"}	        -- ����ఴť����
BTN_DaFenLeiAnNiu.score = {}		-- ����ఴť����
BTN_DaFenLeiAnNiu.ifopen = {}       --�Ƿ񱻵㿪
BTN_DaFenLeiAnNiu.nextLength = {40,171,204,72,171,138,100}
BTN_DaFenLeiAnNiu.SmallWindow = {}
local DaFenLeiAnNiu_POSY = {}	         --����ఴť��Y����

local BTN_XiaoFenLeiAnNiu = {}		-- С���ఴť
BTN_XiaoFenLeiAnNiu.score = {}		-- С���ఴť����
BTN_XiaoFenLeiAnNiu.font = {}       -- С���ఴť��������
BTN_XiaoFenLeiAnNiu.name = {"ս������","ʤ����ʧ��","������װ��","����","ս������","��ɱ������","ʤ����ʧ��","������װ��","����","ս������","ǿ��","��ʯ","Ӣ��","����","����ɾ�","����ɾ�","����","��˵�ɾ�","����"}
BTN_XiaoFenLeiAnNiu.LightPic = {}

local havetAchievementfont = nil

local AchievementInfo = {}--�ɾͿ�--���ڱ������гɾ�
for index = 1,20 do--���һ��Ϊ�Ѿ�ӵ�еĳɾ�
    AchievementInfo[index]={}
	AchievementInfo[index].nID = {} --//! �ƺ�ID
	AchievementInfo[index].nType = {}--//! ����
	AchievementInfo[index].nGroup = {}--//! ���
	AchievementInfo[index].bEnable = {}--//! �Ƿ���
	AchievementInfo[index].strName = {}--//! ����
	AchievementInfo[index].nPoint = {}--//! �ɾ͵���
	AchievementInfo[index].strTip = {}--//! ����˵��
	AchievementInfo[index].strPic = {}--//! ͼƬ�ļ���
	AchievementInfo[index].nParameterType = {}
	AchievementInfo[index].nParameter1 = {}
	AchievementInfo[index].nParameter2 = {}
	AchievementInfo[index].tip = {}
end
local AchievementInfo_current = 0


local AchievementInfo_toggleImg = {}			     -- �»�����
local AchievementInfo_ClickBtn = {}		     -- �»�������



local Last_Remain = 0 		             --�ϴλ�����ťͣ����λ��
local IMG_RightClassifyBottom = {}       --�ұ߷����ͼ
local IMG_RightClassifyfont1 = {}
local IMG_RightClassifyGetWay = {}
local IMG_RightClassifyPoint = {}
local IMG_RightClassifynum = {}

local FONT_ChengHaoMingCHengX = {}	     -- �ƺ�����
local IMG_SmallHeadPortraitBottom= {}    --Сͷ���ͼ
local IMG_SmallHeadPortraitFrame= {}     --Сͷ��׿�
local IMG_HuangGuanX = {}			     -- �ʹ�X
local pos_y = {}
local pos_X = {}

local AllCount = 0

local posx = 0
local posy = -100

local updownCount = 0
local maxUpdown = 0

function InitGame_HeroAchievementUI(wnd, bisopen)
    if g_game_heroAchievement_ui == nil then
		g_game_heroAchievement_ui = CreateWindow(wnd.id, 0, 130, 1280, 800)
		InitMainGame_HeroAchievement(g_game_heroAchievement_ui)
		g_game_heroAchievement_ui:SetVisible(bisopen)
    end	
end
function InitMainGame_HeroAchievement(wnd)
	-- ���˳ɾ����Ϸ�һ��UI
	IMG_HuangGuan = wnd:AddImage(path_info.."HuangGuan_info.png", 81 , 134+posy, 64, 64)
	IMG_GeRenChengJiu = wnd:AddFont("���˳ɾ͵��� : ", 15, 0, 137, 130+posy, 200, 20, 0x6fe0fc)
	FONT_GeRenChengJiu = IMG_GeRenChengJiu:AddFont("999999", 15, 0, 110, 0, 200, 20, 0xff798AC0)
	IMG_ChengJiuZongShu = wnd:AddFont("���гɾ͵��� : ", 15, 0, 137, 152+posy, 200, 20, 0x6fe0fc)
	FONT_ChengJiuZongShu = IMG_ChengJiuZongShu:AddFont("999999", 15, 0, 110, 0, 200, 20, 0xff798AC0)
	
	
	
	IMG_DangQianShiYong = wnd:AddFont("��ǰ�ƺ� : ", 15, 0, 350, 137+posy, 200, 20, 0x6fe0fc)
	IMG_XiaoTouXiangDi = wnd:AddImage(path_equip.."bag_equip.png", 439, 121+posy, 50, 50)
	IMG_XiaoTouXiangPic = IMG_XiaoTouXiangDi:AddImage(path_equip.."bag_equip.png", 0, 0, 50, 50)
	IMG_XiaoTouXiangPic:SetVisible(0)
	IMG_XiaoTouXiangKuang = IMG_XiaoTouXiangDi:AddImage(path_shop.."iconside_shop.png", -2, -2, 54,54)
	IMG_ChengHaoDi = wnd:AddImage(path_info.."call_info.png", 512, 133+posy, 256, 32)
	FONT_ChengHaoMingCHeng = IMG_ChengHaoDi:AddFont("�ƺ�����", 15, 8, 29, -5, 200, 20, 0x798AC0)

	
	
	IMG_DuiHaoDi[1] = wnd:AddImage(path_info.."checkbox_info.png", 750, 133+posy, 32, 32)
	IMG_DuiHaoDi[1]:SetTouchEnabled(1)
	IMG_DuiHaoDi[1]:AddFont("�Ƿ���ʾ�ƺ�", 15, 0, 40, 4, 165, 20, 0x798AC0)
	IMG_DuiHaoDi[2] = wnd:AddImage(path_info.."checkbox_info.png", 932, 133+posy, 32, 32)
	IMG_DuiHaoDi[2]:SetTouchEnabled(1)
	IMG_DuiHaoDi[2]:AddFont("ֻ��ʾ���гƺ�", 15, 0, 40, 4, 165, 20, 0x798AC0)
	IMG_DuiHao[1] = IMG_DuiHaoDi[1]:AddImage(path_hero.."checkboxYes_hero.png", 4, 0, 32, 32)
	IMG_DuiHao[1]:SetTouchEnabled(0)
	IMG_DuiHao[2] = IMG_DuiHaoDi[2]:AddImage(path_hero.."checkboxYes_hero.png", 4, 0, 32, 32)
	IMG_DuiHao[2]:SetTouchEnabled(0)
	local Attention = wnd:AddFont("��ʾ:˫�����гƺſ�װ�����滻", 11, 0, 977, 190+posy, 500, 15, 0x8295cf)
	Attention:SetFontSpace(1,1)
	
	IMG_DuiHaoDi[1].script[XE_LBUP] = function()
		if (IMG_DuiHao[1]:IsVisible()) then
			IMG_DuiHao[1]:SetVisible(0)
			XAchievementSetShow(0)
		else
			IMG_DuiHao[1]:SetVisible(1)
			XAchievementSetShow(1)
		end
	end
	
	IMG_DuiHaoDi[2].script[XE_LBUP] = function()
		if (IMG_DuiHao[2]:IsVisible()) then
			IMG_DuiHao[2]:SetVisible(0)
		else
			IMG_DuiHao[2]:SetVisible(1)
		end
		AchievementInfo_change(wnd)
	end
	
	-- ��߷��ఴť�Ĵ���
	
	wnd:AddImage(path_info.."line_info.png", 85, 185+posy, 1060, 2)

	Init_Achievement_Btn(wnd)


	-- �ұߵĻ�����
	AchievementInfo_toggleImg = wnd:AddImage(path.."toggleBK_main.png", 1151, 228+posy, 16, 388)
	AchievementInfo_ClickBtn = AchievementInfo_toggleImg:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = AchievementInfo_toggleImg:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = AchievementInfo_toggleImg:AddImage(path.."TD1_main.png",0,388,16,16)
	
	XSetWindowFlag(AchievementInfo_ClickBtn.id,1,1,0,338)
	
	AchievementInfo_ClickBtn:ToggleBehaviour(XE_ONUPDATE, 1)
	AchievementInfo_ClickBtn:ToggleEvent(XE_ONUPDATE, 1)
	AchievementInfo_ClickBtn.script[XE_ONUPDATE] = function()
		-- �˴���д�������߼�
		if(AllCount<=9 or AchievementInfo_toggleImg:IsVisible() == false) then
		    return
		end	
		if AchievementInfo_ClickBtn._T == nil then
			AchievementInfo_ClickBtn._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(AchievementInfo_ClickBtn.id)
		if AchievementInfo_ClickBtn._T ~= T then 
			local length = 0
			if AllCount <=9 then
				length = 338
			else
				length= 338/math.ceil((AllCount/3)-3)
			end
			local Many = math.floor(T/length)	
			updownCount = Many
			
			if Last_Remain ~= Many then
				for i,value in pairs(IMG_RightClassifyBottom) do
					local Li = pos_X[i]
					local Ti = pos_y[i]-Many*148
					IMG_RightClassifyBottom[i]:SetPosition(Li, Ti)
					
					if Ti >500 or Ti <100 then
						IMG_RightClassifyBottom[i]:SetVisible(0)
					else
					    if (i <= AllCount) then
							IMG_RightClassifyBottom[i]:SetVisible(1)
						end
					end
				end				
				Last_Remain = Many
			end
			AchievementInfo_ClickBtn._T = T
		end		
	end
	
	XWindowEnableAlphaTouch(g_game_heroAchievement_ui.id)
	g_game_heroAchievement_ui:EnableEvent(XE_MOUSEWHEEL)
	g_game_heroAchievement_ui.script[XE_MOUSEWHEEL] = function()
		local updown  = XGetMsgParam0()
		local length = 0
		if AllCount >9 then
			maxUpdown = math.ceil((AllCount/3)-3)
			length = 338/maxUpdown
		else
			maxUpdown = 0
			length = 338
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
		
		AchievementInfo_ClickBtn:SetPosition(0,btn_pos)
		AchievementInfo_ClickBtn._T = btn_pos
		
		if updownCount >= 0 and updownCount <= maxUpdown then
			for i,value in pairs(IMG_RightClassifyBottom) do
				local Li = pos_X[i]
				local Ti = pos_y[i]-updownCount*148
				
				IMG_RightClassifyBottom[i]:SetPosition(Li, Ti)
					
				if Ti >500 or Ti <100 then
					IMG_RightClassifyBottom[i]:SetVisible(0)
				else
					if (i <= AllCount) then
					    IMG_RightClassifyBottom[i]:SetVisible(1)
					end
				end
			end
		end
	end
	havetAchievementfont = wnd:AddFont("�㻹δװ���κγƺ�",15,0,450,135+posy,300,20,0x6fe0fc)
end

--���������߼�
function AchievementChangeInfo(updownCount)
    
end


function Achievement_SetShow(ibool)
    if (IMG_DuiHao[1]:IsVisible() and ibool == 0 and g_game_heroAchievement_ui ~=nil) then
	    IMG_DuiHao[1]:SetVisible(0)
	elseif(IMG_DuiHao[1]:IsVisible() == false and ibool == 1 and g_game_heroAchievement_ui ~=nil) then
		IMG_DuiHao[1]:SetVisible(1)
	end
end
--�������д�С����
function Init_Achievement_Btn(wnd)
    for index=1,7 do
		DaFenLeiAnNiu_POSY[index] = 172+40*index+posy
		BTN_DaFenLeiAnNiu[index] = wnd:AddImage(path_info.."biglist1_info.png", 85, DaFenLeiAnNiu_POSY[index], 256, 64)
		BTN_DaFenLeiAnNiu.score[index] = BTN_DaFenLeiAnNiu[index]:AddFont("0/0", 12, 6, 40, -12, 105, 13, 0xffffffff)
		BTN_DaFenLeiAnNiu.name[index] = BTN_DaFenLeiAnNiu[index]:AddFont(BTN_DaFenLeiAnNiu.nameFont[index], 12, 0, 5, 10, 113, 13, 0xffffffff)
		BTN_DaFenLeiAnNiu.ifopen[index] = false
		BTN_DaFenLeiAnNiu[index].script[XE_LBUP] = function()
		    if(BTN_DaFenLeiAnNiu.ifopen[index] == false) then
			    Achievement_SetAllDaButtonIntoUnCheck()
		        BTN_DaFenLeiAnNiu[index].changeimage(path_info.."biglist2_info.png")
				BTN_DaFenLeiAnNiu.ifopen[index] = true
				setCorresSmallButtonVisible(index,1)
				if(index == 1) then
				    AchievementInfo_ReleaseAll()
				    AchievementInfo_CreateRight(20,wnd)
					Achievement_SetAllLightClose()
				end
			else
                BTN_DaFenLeiAnNiu[index].changeimage(path_info.."biglist1_info.png")
				BTN_DaFenLeiAnNiu.ifopen[index] = false	
				setCorresSmallButtonVisible(index,0)
				if(index == 1) then
				    AchievementInfo_ReleaseAll()
					Achievement_SetAllLightClose()
				end
            end	
            Achievement_SetbtnPostion()			
		end
	end
	--����6��window���ڿ���С�İ���
	--1
		for i = 1,4 do
		    local index = i
		    BTN_XiaoFenLeiAnNiu[i] =  BTN_DaFenLeiAnNiu[2]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, (index-1)*33+33, 128, 64) 
		end
	--2
		for i = 5,9 do
		    local index = i-4
		    BTN_XiaoFenLeiAnNiu[i] = BTN_DaFenLeiAnNiu[3]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, (index-1)*33+33, 128, 64) 
		end
	--3
	    BTN_XiaoFenLeiAnNiu[10] = BTN_DaFenLeiAnNiu[4]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, 33, 128, 64)

	--4
		for i = 11,14 do
		    local index = i-10
		    BTN_XiaoFenLeiAnNiu[i] = BTN_DaFenLeiAnNiu[5]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, (index-1)*33+33, 128, 64) 
		end
	--5	
		for i = 15,17 do
		    local index = i-14
		    BTN_XiaoFenLeiAnNiu[i] = BTN_DaFenLeiAnNiu[6]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, (index-1)*33+33, 128, 64) 
		end
	--6	
		for i = 18,19 do
		    local index = i-17
		    BTN_XiaoFenLeiAnNiu[i] = BTN_DaFenLeiAnNiu[7]:AddButton(path_info.."smalllist1_info.png", path_info.."smalllist2_info.png", path_info.."smalllist3_info.png", 32, (index-1)*33+33, 128, 64) 
		end
		
		for i =1,19 do
		    BTN_XiaoFenLeiAnNiu.LightPic[i] =  BTN_XiaoFenLeiAnNiu[i]:AddImage(path_info.."smalllist2_info.png",0,0,128,64)
			BTN_XiaoFenLeiAnNiu.LightPic[i]:SetVisible(0)
		end
		
		for i = 1,19 do
		    BTN_XiaoFenLeiAnNiu.font[i] = BTN_XiaoFenLeiAnNiu[i]:AddFont(BTN_XiaoFenLeiAnNiu.name[i], 12, 0, 8, 13, 113, 13, 0xffffffff)
		    BTN_XiaoFenLeiAnNiu.score[i] = BTN_XiaoFenLeiAnNiu[i]:AddFont("0/10", 12, 6, 15, -14, 100, 13, 0xffffffff)
		end
		for i = 1,19 do
		    BTN_XiaoFenLeiAnNiu[i].script[XE_LBUP] = function()
			    AchievementInfo_ReleaseAll()
				AchievementInfo_CreateRight(i,wnd)
				Achievement_SetAllLightClose()
				BTN_XiaoFenLeiAnNiu.LightPic[i]:SetVisible(1)
		    end
		end
		setAllSmallButtonVisible(0)
end
--����С������ʾ������

function Achievement_SetAllLightClose()
    if g_game_heroAchievement_ui == nil then
	    return
	end	
	for i =1,19 do
		BTN_XiaoFenLeiAnNiu.LightPic[i]:SetVisible(0)
	end
end

function Achievement_SetAllDaButtonIntoUnCheck()
    for index = 1,7 do
	    BTN_DaFenLeiAnNiu[index].changeimage(path_info.."biglist1_info.png")
		BTN_DaFenLeiAnNiu.ifopen[index] = false	
	end
	setAllSmallButtonVisible(0)
	Achievement_SetbtnPostion()
	
end

function setAllSmallButtonVisible(ifclose)
    for index = 1,19 do
	    BTN_XiaoFenLeiAnNiu[index]:SetVisible(ifclose)
	end
end
function setCorresSmallButtonVisible(index,ifclose)
    if(index == 2) then
	    for i = 1,4 do
		    BTN_XiaoFenLeiAnNiu[i]:SetVisible(ifclose)
		end
	elseif(index == 3) then
	    for i = 5,9 do
		    BTN_XiaoFenLeiAnNiu[i]:SetVisible(ifclose)
		end
	elseif(index == 4) then
		    BTN_XiaoFenLeiAnNiu[10]:SetVisible(ifclose)
	elseif(index == 5) then
	    for i = 11,14 do
		    BTN_XiaoFenLeiAnNiu[i]:SetVisible(ifclose)
		end
	elseif(index == 6) then
	    for i = 15,17 do
		    BTN_XiaoFenLeiAnNiu[i]:SetVisible(ifclose)
		end
	elseif(index == 7) then
	    for i = 18,19 do
		    BTN_XiaoFenLeiAnNiu[i]:SetVisible(ifclose)
		end
	end
end

function  Achievement_SetAchievementShowFirst()
    BTN_DaFenLeiAnNiu[1]:TriggerBehaviour(XE_LBUP)--ģ����
end




function Achievement_SetbtnPostion()
    for index = 2,7 do
	    local PosX,PosY = BTN_DaFenLeiAnNiu[index-1]:GetPosition()
	    if(BTN_DaFenLeiAnNiu.ifopen[index-1] == true) then
			PosY = PosY + BTN_DaFenLeiAnNiu.nextLength[index-1]
		else
            PosY = PosY + 40
        end			
		BTN_DaFenLeiAnNiu[index]:SetAbsolutePosition(PosX,PosY)	
    end
end
---������������
function AchievementRanking(ctype,cgroup)--��������
    if(ctype ==1) then
	    return 0+cgroup
	elseif(ctype ==2) then
	    return 4+cgroup
	elseif(ctype ==3) then
	    return 9+cgroup
	elseif(ctype ==4) then
	    return 10+cgroup
	elseif(ctype ==5) then
	    return 14+cgroup
	elseif(ctype ==6) then
	    return 17+cgroup
	end
end
--��c++�õ����гɾ���Ϣ
function AchievementInfo_Setdata(nID,nType,nGroup,bEnable,strName,strTip,nPoint,strPic1,nParameterType,nParameter1,nParameter2,tip)
    local index = AchievementRanking(nType,nGroup)
	local ranking = #AchievementInfo[index].nID+1
	
	AchievementInfo[index].nID[ranking] = nID --//! �ƺ�ID
	AchievementInfo[index].nType[ranking]  = nType--//! ����
	AchievementInfo[index].nGroup[ranking]  = nGroup--//! ���
	AchievementInfo[index].bEnable[ranking]  = bEnable--//! �Ƿ���
	AchievementInfo[index].strName[ranking]  = strName--//! ����
	AchievementInfo[index].nPoint[ranking]  = nPoint--//! �ɾ͵���
	AchievementInfo[index].strTip[ranking]  = strTip--//! ����˵��
	AchievementInfo[index].strPic[ranking]  = "..\\"..strPic1	--//! ͼƬ�ļ���
	AchievementInfo[index].nParameterType[ranking]  = nParameterType
	AchievementInfo[index].nParameter1[ranking]  = nParameter1
	AchievementInfo[index].nParameter2[ranking]  = nParameter2
	AchievementInfo[index].tip[ranking] = tip
	if(bEnable == 1) then
	    local ranking_2 = #AchievementInfo[20].nID+1
	    AchievementInfo[20].nID[ranking_2] = nID --//! �ƺ�ID
	    AchievementInfo[20].nType[ranking_2]  = nType--//! ����
	    AchievementInfo[20].nGroup[ranking_2]  = nGroup--//! ���
	    AchievementInfo[20].bEnable[ranking_2]  = bEnable--//! �Ƿ���
	    AchievementInfo[20].strName[ranking_2]  = strName--//! ����
	    AchievementInfo[20].nPoint[ranking_2]  = nPoint--//! �ɾ͵���
	    AchievementInfo[20].strTip[ranking_2]  = strTip--//! ����˵��
	    AchievementInfo[20].strPic[ranking_2]  = "..\\"..strPic1	--//! ͼƬ�ļ���
	    AchievementInfo[20].nParameterType[ranking_2]  = nParameterType
	    AchievementInfo[20].nParameter1[ranking_2]  = nParameter1
	    AchievementInfo[20].nParameter2[ranking_2]  = nParameter2
	    AchievementInfo[20].tip[ranking_2] = tip
	end
end
--��c++�õ����гɾ;�������
function AchievementInfo_SetNumdata(number1,number2, number3, number4,number5, number6, number7, number8, number9,
           number10, number11, number12, number13, number14,number15, number16, number17, number18, number19,
		   number20, number21, number22, number23, number24,number25, number26, number27, number28, number29,
		   number30, number31, number32, number33, number34,number35, number36, number37, number38, number39,
		   number40, number41, number42, number43, number44,number45, number46, number47, number48, number49,
		   number50, number51, number52)
	 BTN_XiaoFenLeiAnNiu.score[1]:SetFontText(number1.."/"..number2)   
	 BTN_XiaoFenLeiAnNiu.score[2]:SetFontText(number3.."/"..number4)
	 BTN_XiaoFenLeiAnNiu.score[3]:SetFontText(number5.."/"..number6)
	 BTN_XiaoFenLeiAnNiu.score[4]:SetFontText(number7.."/"..number8)
	 BTN_XiaoFenLeiAnNiu.score[5]:SetFontText(number9.."/"..number10)
	 BTN_XiaoFenLeiAnNiu.score[6]:SetFontText(number11.."/"..number12)
	 BTN_XiaoFenLeiAnNiu.score[7]:SetFontText(number13.."/"..number14)
	 BTN_XiaoFenLeiAnNiu.score[8]:SetFontText(number15.."/"..number16)
	 BTN_XiaoFenLeiAnNiu.score[9]:SetFontText(number17.."/"..number18)
	 BTN_XiaoFenLeiAnNiu.score[10]:SetFontText(number19.."/"..number20)
	 BTN_XiaoFenLeiAnNiu.score[11]:SetFontText(number21.."/"..number22)
	 BTN_XiaoFenLeiAnNiu.score[12]:SetFontText(number23.."/"..number24)
	 BTN_XiaoFenLeiAnNiu.score[13]:SetFontText(number25.."/"..number26)
	 BTN_XiaoFenLeiAnNiu.score[14]:SetFontText(number27.."/"..number28)
	 BTN_XiaoFenLeiAnNiu.score[15]:SetFontText(number29.."/"..number30)
	 BTN_XiaoFenLeiAnNiu.score[16]:SetFontText(number31.."/"..number32)
	 BTN_XiaoFenLeiAnNiu.score[17]:SetFontText(number33.."/"..number34)
	 BTN_XiaoFenLeiAnNiu.score[18]:SetFontText(number35.."/"..number36)
	 BTN_XiaoFenLeiAnNiu.score[19]:SetFontText(number37.."/"..number38)
	 BTN_DaFenLeiAnNiu.score[2]:SetFontText(number39.."/"..number40)
	 BTN_DaFenLeiAnNiu.score[3]:SetFontText(number41.."/"..number42)
	 BTN_DaFenLeiAnNiu.score[4]:SetFontText(number43.."/"..number44)
	 BTN_DaFenLeiAnNiu.score[5]:SetFontText(number45.."/"..number46)
	 BTN_DaFenLeiAnNiu.score[6]:SetFontText(number47.."/"..number48)
	 BTN_DaFenLeiAnNiu.score[7]:SetFontText(number49.."/"..number50)
	 BTN_DaFenLeiAnNiu.score[1]:SetFontText(number51.."/"..number52)
end

function AchievementInfo_SetAchievepoint(number1,number2)--�������óɾ͵���
    FONT_GeRenChengJiu:SetFontText(""..number1)
	FONT_ChengJiuZongShu:SetFontText(""..number2)
end
function AchievementInfo_SetTitle(strPic,name,tip)
    if(cPicPath ==  "" or name ==  "") then
	    AchievementInfo_SetAchieveVisible(false)
	    return
	end	
	AchievementInfo_SetAchieveVisible(true)
	IMG_XiaoTouXiangPic.changeimage("..\\"..strPic)
	IMG_XiaoTouXiangPic:SetVisible(1)
	IMG_XiaoTouXiangPic:SetImageTip(tip)
	FONT_ChengHaoMingCHeng:SetFontText(name)
end


function AchievementInfo_SetAchieveVisible(ibool)
    if ibool == true then
       IMG_DangQianShiYong:SetVisible(1)
	   IMG_XiaoTouXiangDi:SetVisible(1)
	   IMG_ChengHaoDi:SetVisible(1)
	   havetAchievementfont:SetVisible(0)
	else
       IMG_DangQianShiYong:SetVisible(0)
	   IMG_XiaoTouXiangDi:SetVisible(0)
	   IMG_ChengHaoDi:SetVisible(0)
	   havetAchievementfont:SetVisible(1)
    end	
end




--����ұ����гɾ��б�
function AchievementInfo_ReleaseAll()
    if(#IMG_RightClassifyBottom==0) then
	    return
	end	
	local mendex = 1	
	while(IMG_RightClassifyBottom[mendex]~=nil) do
	    IMG_RightClassifyfont1[mendex]:Release()
		IMG_RightClassifyGetWay[mendex]:Release()
		IMG_RightClassifyPoint[mendex]:Release()
		IMG_RightClassifynum[mendex]:Release()
		FONT_ChengHaoMingCHengX[mendex]:Release()
		IMG_SmallHeadPortraitBottom[mendex]:SetImageTip(0)
		IMG_SmallHeadPortraitBottom[mendex]:Release()
		IMG_SmallHeadPortraitFrame[mendex]:Release()
		IMG_HuangGuanX[mendex]:Release()
		IMG_RightClassifyBottom[mendex]:Release()
		mendex = mendex+1
	end	
	IMG_RightClassifyfont1 = {}
	IMG_RightClassifyGetWay = {}
	IMG_RightClassifyPoint = {}
	IMG_RightClassifynum = {}
	FONT_ChengHaoMingCHengX = {}
	IMG_SmallHeadPortraitBottom = {}
	IMG_SmallHeadPortraitFrame = {}
	IMG_HuangGuanX = {}
	IMG_RightClassifyBottom = {}
	pos_y = {}
    pos_X = {}
	AchievementInfo_current = 0
end

--������ǰ�ɾ��б�
function AchievementInfo_CreateRight(index,wnd)
    --�ұ߷���׵Ĵ���
	updownCount = 0
	maxUpdown = 0
	AchievementInfo_ClickBtn:SetPosition(0,0)
	AchievementInfo_ClickBtn._T = 0
	AchievementInfo_current = index--���ڶ�Ӧ��ѡ��
	AllCount = 0
	local num = #AchievementInfo[index].nID
	if(num<1) then
	    AchievementInfo_toggleImg:SetVisible(0)
	    return
	end
	if(IMG_DuiHao[2]:IsVisible() == false) then --������ɺ�δ��ɶ���ʾ
	    for	i,value in pairs(AchievementInfo[index].nID) do	
            AllCount = AllCount+1		
		    pos_X[i]=286*((i-1)%3+1)
		    pos_y[i]=64+148*math.ceil(i/3)+posy
		    IMG_RightClassifyBottom[i] = wnd:AddImage(path_info.."AchievementBK_info.png",pos_X[i],pos_y[i],283,137)
		    IMG_SmallHeadPortraitBottom[i] = IMG_RightClassifyBottom[i]:AddImage(AchievementInfo[index].strPic[i], 13, 10, 50, 50)
			IMG_SmallHeadPortraitBottom[i]:SetImageTip(AchievementInfo[index].tip[i])
		    IMG_SmallHeadPortraitFrame[i] = IMG_RightClassifyBottom[i]:AddImage(path_shop.."iconside_shop.png", 11, 8, 54,54)
		    IMG_HuangGuanX[i] = IMG_RightClassifyBottom[i]:AddImage(path_info.."HuangGuan_info.png", 220 , 15, 64, 64)		
	    end
	    for	i,value in pairs(AchievementInfo[index].nID) do	
		    FONT_ChengHaoMingCHengX[i] = IMG_RightClassifyBottom[i]:AddFont(AchievementInfo[index].strName[i], 15, 0, 60, 25, 220, 57, 0xff798AC0)
		    IMG_RightClassifyfont1[i] = IMG_RightClassifyBottom[i]:AddFont(--[["��÷�ʽ��"--]]"��÷�ʽ:", 12, 0, 6, 67, 90, 15, 0xff798AC0)
		    IMG_RightClassifyGetWay[i] = IMG_RightClassifyBottom[i]:AddFont("                  "..AchievementInfo[index].strTip[i], 12, 0, 6, 67, 192, 140, 0xffffffff)
		    IMG_RightClassifyPoint[i] = IMG_RightClassifyBottom[i]:AddFont(""..AchievementInfo[index].nPoint[i], 12, 8, -190, -48, 100, 15, 0xf55af0)
		    IMG_RightClassifynum[i] = IMG_RightClassifyBottom[i]:AddFont(AchievementInfo[index].nParameter1[i].."/"..AchievementInfo[index].nParameter2[i], 12, 8, -190, -90, 100, 15, 0xff77C2D5)
			if(AchievementInfo[index].nParameter2[i] == 0) then
                IMG_RightClassifynum[i]:SetVisible(0)
            end		
			IMG_HuangGuanX[i]:SetTouchEnabled(0)
		    if pos_y[i] >500 or pos_y[i] <100 then
			    IMG_RightClassifyBottom[i]:SetVisible(0)
		    else
			    IMG_RightClassifyBottom[i]:SetVisible(1)
		    end
			if(AchievementInfo[index].bEnable[i] == 1) then
			    IMG_RightClassifyBottom[i].script[XE_LBDBCLICK] = function()
                    XClickComboBoxListByID(AchievementInfo[index].nID[i])			
				end
				IMG_SmallHeadPortraitBottom[i].script[XE_LBDBCLICK] = function()
                    XClickComboBoxListByID(AchievementInfo[index].nID[i])			
				end
			else
			    IMG_RightClassifyBottom[i]:SetEnabled(0)
			end
		end
    elseif(IMG_DuiHao[2]:IsVisible()) then
	    local j = 0
	    for	i,value in pairs(AchievementInfo[index].nID) do		
            if(AchievementInfo[index].bEnable[i] == 1) then 
			    AllCount = AllCount+1
			    j=j+1
                pos_X[j]=286*((j-1)%3+1)
		        pos_y[j]=64+148*math.ceil(j/3)+posy	
		        IMG_RightClassifyBottom[j] = wnd:AddImage(path_info.."AchievementBK_info.png",pos_X[j],pos_y[j],283,137)
		        IMG_SmallHeadPortraitBottom[j] = IMG_RightClassifyBottom[j]:AddImage(AchievementInfo[index].strPic[i], 13, 10, 50, 50)
				IMG_SmallHeadPortraitBottom[j]:SetImageTip(AchievementInfo[index].tip[i])
		        IMG_SmallHeadPortraitFrame[j] = IMG_RightClassifyBottom[j]:AddImage(path_shop.."iconside_shop.png", 11, 8, 54,54)
		        IMG_HuangGuanX[j] = IMG_RightClassifyBottom[j]:AddImage(path_info.."HuangGuan_info.png", 220 , 15, 64, 64)
		        FONT_ChengHaoMingCHengX[j] = IMG_RightClassifyBottom[j]:AddFont(AchievementInfo[index].strName[i], 15, 0, 60, 25, 220, 57, 0xff798AC0)
		        IMG_RightClassifyfont1[j] = IMG_RightClassifyBottom[j]:AddFont("��÷�ʽ:", 12, 0, 5, 67, 90, 15, 0xff798AC0)
		        IMG_RightClassifyGetWay[j] = IMG_RightClassifyBottom[j]:AddFont("                  "..AchievementInfo[index].strTip[i], 12, 0, 5, 67, 192, 140, 0xffffffff)
		        IMG_RightClassifyPoint[j] = IMG_RightClassifyBottom[j]:AddFont(""..AchievementInfo[index].nPoint[i], 12, 8, -190, -48, 100, 15, 0xf55af0)
		        IMG_RightClassifynum[j] = IMG_RightClassifyBottom[j]:AddFont(AchievementInfo[index].nParameter1[i].."/"..AchievementInfo[index].nParameter2[i], 12, 8, -190, -90, 100, 15, 0xff77C2D5)
                if(AchievementInfo[index].nParameter2[i] == 0) then
                    IMG_RightClassifynum[j]:SetVisible(0)
                end					
				
			    IMG_HuangGuanX[j]:SetTouchEnabled(0)
		        if pos_y[j] >500 or pos_y[j] <100 then
			        IMG_RightClassifyBottom[j]:SetVisible(0)
		        else
			        IMG_RightClassifyBottom[j]:SetVisible(1)
		        end
				IMG_RightClassifyBottom[j].script[XE_LBDBCLICK] = function()
                    XClickComboBoxListByID(AchievementInfo[index].nID[i])				
				end
				IMG_SmallHeadPortraitBottom[j].script[XE_LBDBCLICK] = function()
                    XClickComboBoxListByID(AchievementInfo[index].nID[i])			
				end
            end			
	    end
    end
	if(AllCount <= 9) then
	   AchievementInfo_toggleImg:SetVisible(0)
	else
       AchievementInfo_toggleImg:SetVisible(1)
    end	
end



--���ı乴ѡ��ʱ��Ҫ�ı�ɾ�����
function AchievementInfo_change(wnd)
    local mende = AchievementInfo_current
	if(mende<1 or mende>20) then
	    return
	end	
	AchievementInfo_ReleaseAll()
	AchievementInfo_CreateRight(mende,wnd)
end
--������гɾ����ݿ�
function AchievementInfo_CleanAllInfo()
    for index = 1,20 do
	    AchievementInfo[index].nID = {} --//! �ƺ�ID
	    AchievementInfo[index].nType = {}--//! ����
	    AchievementInfo[index].nGroup = {}--//! ���
	    AchievementInfo[index].bEnable = {}--//! �Ƿ���
	    AchievementInfo[index].strName = {}--//! ����
	    AchievementInfo[index].nPoint = {}--//! �ɾ͵���
	    AchievementInfo[index].strTip = {}--//! ����˵��
	    AchievementInfo[index].strPic = {}--//! ͼƬ�ļ���
    	AchievementInfo[index].nParameterType = {}
    	AchievementInfo[index].nParameter1 = {}
    	AchievementInfo[index].nParameter2 = {}
    end  
end
function AchievementInfo_GetAchieveIsVisible()
    if g_game_heroAchievement_ui:IsVisible() then
	    return true
	else
	    return false
	end
end

function SetGameHeroAchievementIsVisible(flag) 
	if g_game_heroAchievement_ui ~= nil then
		if flag == 1 and g_game_heroAchievement_ui:IsVisible() == false then
			g_game_heroAchievement_ui:SetVisible(1)
			XLneedAchievementInfo(1,1)
			IMG_DuiHao[2]:SetVisible(0)
		elseif flag == 0 and g_game_heroAchievement_ui:IsVisible() == true then
			g_game_heroAchievement_ui:SetVisible(0)
			AchievementInfo_ReleaseAll()
			AchievementInfo_CleanAllInfo()
			updownCount = 0
			maxUpdown = 0
			AchievementInfo_ClickBtn:SetPosition(0,0)
			AchievementInfo_ClickBtn._T = 0
            Achievement_SetAllDaButtonIntoUnCheck()
			Achievement_SetAllLightClose()
		end
	end
end

function GetGameHeroAchievementIsVisible()  
    if(g_game_heroAchievement_ui:IsVisible()) then
       -- XGameHeroSkinIsOpen(1)
    else
       -- XGameHeroSkinIsOpen(0)
    end
end