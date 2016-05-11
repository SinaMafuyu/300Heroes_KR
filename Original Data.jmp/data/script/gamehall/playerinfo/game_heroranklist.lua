include("../Data/Script/Common/include.lua")

-- Member
local RankListBackGround = nil -- �װ�
local RankListLeftFont = { "�ɾ�����", "����������", "ս������", "��λ����", "SOLO����", "��������", "����������", "ȭͷ������", "VIP����", "ǩ������"}  -----, "ǿ������", "��ʯ����"}
local RankListLeftTypeTemp = {513,514,515,516,517,518,519,520,521,522}
local RankListLeftFontList = {}	-- ����List
local RankListLeftSelImage = {}	-- ѡ��ͼƬ
local RankListLeftMoveImage = {} -- MouseMoveͼƬ
local RankListLeftType = 1

-- RankFont
local Font_No = nil -- ����
local Font_Name = nil -- ����
local Font_Server = nil -- ����
local Font_Font1 = nil -- ����1
local Font_Font2 = nil -- ����2
local Font_Font3 = nil -- ����3
local Font_Font4 = nil -- ����4

-- RankListTitle
local Font_Font1_Title = {"�ɾ͵�","ʤ����","ʤ����","ʤ����","ʤ����","�ܽ���"    ,"�ܶ���"    ,"��ȭ��"    ,"VIP�ȼ�","��ǩ����"  }
local Font_Font2_Title = {""      ,"ʤ��"  ,"ʤ��"  ,"ʤ��"  ,"ʤ��"  ,"����������","����������","������ȭ��",""       ,"����ǩ����"}
local Font_Font3_Title = {""	  ,"�ܳ���","�ܳ���","�ܳ���","�ܳ���","ս������"  ,"ս������"  ,"ս��ȭ��"  ,""       ,""          }
local Font_Font4_Title = {""	  ,""	   ,""	    ,""	     ,""	  ,"��λ����"  ,"��λ����"  ,"��λȭ��"  ,""       ,""          }

-- RankFontList
local RankList_InfoFontList_No = {} -- ����
local RankList_InfoFontList_Name = {} -- ����
local RankList_InfoFontList_Server = {} -- ����
local RankList_InfoFontList_Font1 = {} -- ����1
local RankList_InfoFontList_Font2 = {} -- ����2
local RankList_InfoFontList_Font3 = {} -- ����3
local RankList_InfoFontList_Font4 = {} -- ����4

-- �洢���а���������
local RankList_InfoFontList_No_temp = {} -- ����
local RankList_InfoFontList_Name_temp = {} -- ����
local RankList_InfoFontList_Server_temp = {} -- ����
local RankList_InfoFontList_Font1_temp = {} -- ����1
local RankList_InfoFontList_Font2_temp = {} -- ����2
local RankList_InfoFontList_Font3_temp = {} -- ����3
local RankList_InfoFontList_Font4_temp = {} -- ����4

-- CheckButton ѡ��
local ChoseServer_CheckButton = nil -- ѡ�������
local ChoseServer_Font = nil -- ��ǰѡ������
local ChoseServer_BackFround = nil
local ChoseServer_SelListImage = {}
local ChoseServer_SelListFont = {}
local CHoseServer_ListFont = {"��ǰ����", "ȫ��"}
local MaxCount = 1

-- FindMySelf
local MySelf_Name = {}
local FindMySelf_Button = nil
local FindMySelf_Mine = nil
local FindMySelf_IsChange = 0

-- Page
local Page_FirstButton = nil
local Page_LeftButton = nil
local Page_RightButton = nil
local Page_LastButton = nil
local Page_PageShow = nil
local Page_PageShowFont = nil
--local MinPage = 0
local MaxPage = 10
local CurPage = 1
local CurServerType = 1

-- FindInput
local FindInput_TargetName = {}
local FindInputEdit = nil
local FindInput = nil
local FindButton = nil

-- RankBestImage
local BestPlayerImage = {}
local IsFinded = false

local SelPlayerImage = {}				-- ������Һ��ѡ��״̬ͼƬ

-- InitUI
function InitGame_HeroRankListUI( wnd, bisopen)
	g_game_heroRankList_ui = CreateWindow( wnd.id, 0, 0, 1280, 800)
	InitMainGame_HeroRankList( g_game_heroRankList_ui)
	g_game_heroRankList_ui:SetVisible( bisopen)
end

-- Init
function InitMainGame_HeroRankList( wnd)
	-- BK
	RankListBackGround = wnd:AddImage( path_info_ranklist.."BackGround.png", 75, 127, 1114, 602)
	
	SelPlayerImage[1] = RankListBackGround:AddImage( path_info_ranklist .. "MySelf.png", 193, 70, 918, 44)
	SelPlayerImage[1]:SetVisible(0)
	SelPlayerImage[2] = RankListBackGround:AddImage( path_info_ranklist .. "Target.png", 193, 70+45, 918, 44)
	SelPlayerImage[2]:SetVisible(0)
	
	RankListLeftType = 1
	--���UI�ĳ�ʼ��
	for i=1, #RankListLeftTypeTemp do
		-- ѡ��״̬
		RankListLeftSelImage[i] = RankListBackGround:AddImage(path_info_ranklist.."PageSel.png", 7, 42+((i-1)*46), 181, 46)
		RankListLeftSelImage[i]:SetTransparent(0)
		-- RankListLeftSelImage[i]:SetTouchEnabled(0)
		-- ����
		RankListLeftFontList[i] = RankListBackGround:AddFont(RankListLeftFont[i], 15, 8, -7, -(42+((i-1)*46)), 181, 46, 0xbeb5ee)
		-- �������״̬
		RankListLeftMoveImage[i] = RankListBackGround:AddImage(path_info_ranklist.."Move.png", 7, 42+((i-1)*46), 181, 46)
		RankListLeftMoveImage[i]:SetVisible(0)
		RankListLeftMoveImage[i]:SetTouchEnabled(0)
		
		-- ���
		RankListLeftSelImage[i].script[XE_LBUP] = function()
			for k=1, #RankListLeftSelImage do
				RankListLeftSelImage[k]:SetTransparent(0)
			end
			CurPage = 1
			RankListLeftSelImage[i]:SetTransparent(1)
			RankListLeftType = i	
			RankList_GetTopFont(Font_Font1_Title[i],Font_Font2_Title[i],Font_Font3_Title[i],Font_Font4_Title[i])
			RankList_ClearData()
			RankList_Refresh()
			XReqRankList(RankListLeftTypeTemp[RankListLeftType],CurServerType)
		end
		
		-- Hover
		RankListLeftSelImage[i].script[XE_ONHOVER] = function()
			RankListLeftMoveImage[i]:SetVisible(1)
		end
		
		-- UnHover
		RankListLeftSelImage[i].script[XE_ONUNHOVER] = function()
			RankListLeftMoveImage[i]:SetVisible(0)
		end
	end
	
	RankListLeftSelImage[1]:SetTransparent(1)
	
	-- ����
	Font_No = RankListBackGround:AddFont("����", 15, 8, -157, -45, 130, 27, 0xffffff)
	-- ����
	Font_Name = RankListBackGround:AddFont("����", 15, 8, -292, -45, 130, 27, 0xffffff)
	-- ����
	Font_Server = RankListBackGround:AddFont("����", 15, 8, -427, -45, 130, 27, 0xffffff)
	-- 1
	Font_Font1 = RankListBackGround:AddFont("�ɾ͵�", 15, 8, -562, -45, 130, 27, 0xffffff)
	-- 2
	Font_Font2 = RankListBackGround:AddFont("", 15, 8, -697, -45, 130, 27, 0xffffff)
	-- 3
	Font_Font3 = RankListBackGround:AddFont("", 15, 8, -832, -45, 130, 27, 0xffffff)
	-- 4
	Font_Font4 = RankListBackGround:AddFont("", 15, 8, -967, -45, 130, 27, 0xffffff)
	
	-- ������Ϣ
	for i=1, 10 do
		RankList_InfoFontList_No[i] = RankListBackGround:AddFont(i, 15, 8, -157, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Name[i] = RankListBackGround:AddFont("", 15, 8, -292, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Server[i] = RankListBackGround:AddFont("", 15, 8, -427, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Font1[i] = RankListBackGround:AddFont("", 15, 8, -562, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Font2[i] = RankListBackGround:AddFont("", 15, 8, -697, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Font3[i] = RankListBackGround:AddFont("", 15, 8, -832, -(71+((i-1)*45)), 130, 45, 0xffffff)
		RankList_InfoFontList_Font4[i] = RankListBackGround:AddFont("", 15, 8, -967, -(71+((i-1)*45)), 130, 45, 0xffffff)
	end
	
	-- ����ѡ��ť
	ChoseServer_CheckButton = RankListBackGround:AddTwoButton( path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png", 947, 8, 128, 32)
	ChoseServer_Font = ChoseServer_CheckButton:AddFont( "��ǰ����", 12, 0, 3, 6, 100, 15, 0xbeb5ee)
	
	-- ѡ��������
	ChoseServer_BackFround = ChoseServer_CheckButton:AddImage( path_hero.."listBK2_hero.png", 0, 30, 128, 512)
	XSetAddImageRect( ChoseServer_BackFround.id, 0, 0, 128, 64, 0, 30, 128, 64)
	ChoseServer_BackFround:SetVisible(0)
	
	-- ListFont
	for i=1, 2 do
		ChoseServer_SelListImage[i] = ChoseServer_BackFround:AddImage( path_hero.."listhover_hero.png", 0, i*26-23, 128, 32)
		ChoseServer_SelListFont[i] = ChoseServer_BackFround:AddFont( CHoseServer_ListFont[i], 12, 0, 3, i*29-23, 128, 32, 0xbeb5ee)
		ChoseServer_SelListImage[i]:SetTransparent(0)
		
		-- ONHOVER
		ChoseServer_SelListImage[i].script[XE_ONHOVER] = function()
			-- if i <= MaxCount then
				ChoseServer_SelListImage[i]:SetTransparent(1)
			-- end
		end
		
		-- ONUNHOVER
		ChoseServer_SelListImage[i].script[XE_ONUNHOVER] = function()
			-- if i <= MaxCount then
				ChoseServer_SelListImage[i]:SetTransparent(0)
			-- end
		end
		
		-- LBUP
		ChoseServer_SelListImage[i].script[XE_LBUP] = function()
			-- if i <= MaxCount then
				ChoseServer_BackFround:SetVisible(0)
				ChoseServer_Font:SetFontText( CHoseServer_ListFont[i], 0xbeb5ee)
				CurServerType = 2-i
				XReqRankList(RankListLeftTypeTemp[RankListLeftType],CurServerType)
				RankList_ClearData()
				CurPage = 1
				RankList_Refresh()
			-- end
		end
	end
	
	-- ���
	ChoseServer_CheckButton.script[XE_LBDOWN] = function()
		if ChoseServer_BackFround:IsVisible() then
			ChoseServer_BackFround:SetVisible(0)
		else
			ChoseServer_BackFround:SetVisible(1)
		end
	end
	
	-- FindMySelf
	FindMySelf_Button = RankListBackGround:AddButton( path_setup.."buy1_setup.png", path_setup.."buy2_setup.png", path_setup.."buy3_setup.png", 197, 546, 83, 35)
	FindMySelf_Button:AddFont( "��ѯ�Լ�", 15, 8, 0, 0, 83, 35, 0xffffff)
	FindMySelf_Button:AddFont( "��������", 15, 0, 95, 7, 83, 35, 0xbeb5ee)
	FindMySelf_Mine = FindMySelf_Button:AddFont( "��", 15, 0, 165, 7, 50, 32, 0xff0000)
	
	-- LBDOWN
	FindMySelf_Button.script[XE_LBDOWN] = function ()
		if #RankList_InfoFontList_Name_temp ~= 0 then
			IsFinded = false
			for i=1,#RankList_InfoFontList_Name_temp do
				if MySelf_Name == RankList_InfoFontList_Name_temp[i] then
					CurPage = (math.floor((i-1)/10)+1)
					RankList_Refresh()
					IsFinded = true
				end
			end
		end	
		
		if IsFinded==false then
			XShowMessageBoxFormLua("��δ�ϰ�")
		end
	end
	
	-- Page
	Page_FirstButton = RankListBackGround:AddButton( path_info_ranklist.."PageBackGround.png", path_info_ranklist.."PageMove.png", path_info_ranklist.."PageBackGround.png", 402, 550, 70, 30)
	Page_LeftButton = RankListBackGround:AddButton( path_info_ranklist.."PageBackGround.png", path_info_ranklist.."PageMove.png", path_info_ranklist.."PageBackGround.png", 477, 550, 70, 30)
	Page_PageShow = RankListBackGround:AddImage( path_info_ranklist.."PageBackGround.png", 552, 550, 70, 30)
	Page_RightButton = RankListBackGround:AddButton( path_info_ranklist.."PageBackGround.png", path_info_ranklist.."PageMove.png", path_info_ranklist.."PageBackGround.png", 627, 550, 70, 30)
	Page_LastButton = RankListBackGround:AddButton( path_info_ranklist.."PageBackGround.png", path_info_ranklist.."PageMove.png", path_info_ranklist.."PageBackGround.png", 702, 550, 70, 30)
	
	Page_FirstButton:AddFont( "��ҳ", 15, 8, 0, 0, 70, 30, 0xbeb5ee)
	Page_LeftButton:AddFont( "��һҳ", 15, 8, 0, 0, 70, 30, 0xbeb5ee)
	Page_RightButton:AddFont( "��һҳ", 15, 8, 0, 0, 70, 30, 0xbeb5ee)
	Page_LastButton:AddFont( "ĩҳ", 15, 8, 0, 0, 70, 30, 0xbeb5ee)
	Page_PageShowFont = Page_PageShow:AddFont( CurPage .. "/" .. MaxPage, 15, 8, 0, 0, 70, 30, 0xbeb5ee)
	
	Page_FirstButton.script[XE_LBUP] = function()
	    CurPage = 1
		RankList_Refresh()
	end
	
	Page_LeftButton.script[XE_LBUP] = function()
		if CurPage ~= 1 then
			CurPage = CurPage - 1
			RankList_Refresh()
		end	
	end
	
	Page_RightButton.script[XE_LBUP] = function()
		if CurPage ~= MaxPage then
			CurPage = CurPage + 1
			RankList_Refresh()
		end	
	end
	
	Page_LastButton.script[XE_LBUP] = function()
		CurPage = 10
		RankList_Refresh()
	end
	
	-- FindInput
	FindInputEdit = CreateWindow( RankListBackGround.id, 810, 552, 216, 30)
	FindInput = FindInputEdit:AddEdit( path_shop.."InputEdit_shop.png", "", "ONFINDINPUT_Enter", "", 13, 5, 5, 206, 30, 0xffffffff, 0xff000000, 0, "")
	XEditSetMaxByteLength( FindInput.id, 14)
	FindInput:SetDefaultFontText("������Enter��ȷ��", 0xff303b4a)
	FindButton = RankListBackGround:AddButton( path_setup.."buy1_setup.png", path_setup.."buy2_setup.png", path_setup.."buy3_setup.png", 1018, 548, 83, 35)
	FindButton.script[XE_LBUP] = function()
		ONFINDINPUT_Enter()
	end
	FindButton:AddFont( "����", 15, 8, 0, 0, 83, 35, 0xffffff)
	
	-- BestPlayerImage
	BestPlayerImage[1] = RankListBackGround:AddImage( path_info_ranklist .. "1.png", 193, 71, 63, 41)
	BestPlayerImage[2] = RankListBackGround:AddImage( path_info_ranklist .. "2.png", 193, 71+45, 63, 41)
	BestPlayerImage[3] = RankListBackGround:AddImage( path_info_ranklist .. "3.png", 193, 71+45+45, 63, 41)
	
	
end

-- SetVisible
function SetGameHeroRankListIsVisible( flag) 
	if g_game_heroRankList_ui ~= nil then
		if flag==1 and g_game_heroRankList_ui:IsVisible()==false then		
			g_game_heroRankList_ui:SetVisible(1)
			-- RankListLeftSelImage[1]:SetVisible(1)
			-- for i=2, #RankListLeftFont do
				-- RankListLeftSelImage[i]:SetVisible(0)
			-- end
		elseif flag==0 and g_game_heroRankList_ui:IsVisible() then
			RankListLeftType = 1
			CurPage = 1
			CurServerType = 1
			ChoseServer_Font:SetFontText( CHoseServer_ListFont[1], 0xbeb5ee)
			for i=1, #RankListLeftTypeTemp do
				RankListLeftSelImage[i]:SetTransparent(0)
			end
			RankList_GetTopFont(Font_Font1_Title[RankListLeftType],Font_Font2_Title[RankListLeftType],Font_Font3_Title[RankListLeftType],Font_Font4_Title[RankListLeftType])
			RankListLeftSelImage[1]:SetTransparent(1)
			RankList_ClearData()
			RankList_Refresh()
			g_game_heroRankList_ui:SetVisible(0)
			-- for i=1, #RankListLeftFont do
				-- RankListLeftSelImage[i]:SetVisible(0)
			-- end
		end
	end
end

-- GetVisible
function GetRankListIsVisible()
	return g_game_heroRankList_ui:IsVisible()
end

-- ��������س�
function ONFINDINPUT_Enter()
	IsFinded = false
	FindInput_TargetName = FindInput:GetEdit()
	if #RankList_InfoFontList_Name_temp ~= 0 then
		for i=1,#RankList_InfoFontList_Name_temp do
			if FindInput_TargetName == RankList_InfoFontList_Name_temp[i] then
				CurPage =(math.floor((i-1)/10)+1)
				RankList_Refresh()
				local CurIndex = (i-1)%10
				SelPlayerImage[2]:SetPosition(193,71+CurIndex*45)
				SelPlayerImage[2]:SetVisible(1)
				IsFinded = true
			end
		end
	end
	
	if IsFinded==false then
		XShowMessageBoxFormLua("����ҵ���Ҳ����ڻ���δ�ϰ�!")
	end
end

-- �õ����п�ѡ��Ĵ���
-- function RankList_GetAllServer( cName, cIndex, cIsOver)
	-- -- ��2��ʼ,1Ϊȫ��
	-- -- ���ݴ�������ñ�����С
	-- if cIsOver==0 then
		-- CHoseServer_ListFont[cIndex] = cName
		-- MaxCount = MaxCount+1
	-- else
		-- for i=1, #ChoseServer_SelListFont do
			-- ChoseServer_SelListFont[i]:SetFontText( CHoseServer_ListFont[i], 0xbeb5ee)
		-- end
		-- XSetAddImageRect( ChoseServer_BackFround.id, 0, 0, 128, 32+((MaxCount-1)*32), 0, 30, 128, 32+((MaxCount-1)*32))
	-- end
-- end

--�õ��Լ�����
function GetMyname(name)
	MySelf_Name = name
end

-- �õ��Լ�����
function RankList_GetMySelfRank()
	if #RankList_InfoFontList_Name_temp ~= 0 then
		for i=1,#RankList_InfoFontList_Name_temp do
			if MySelf_Name == RankList_InfoFontList_Name_temp[i] then
				FindMySelf_Mine:SetFontText(i,0x3be2ea)
				if	CurPage == math.floor((i-1)/10)+1 then
					local CurIndex = (i-1)%10
					SelPlayerImage[1]:SetPosition(193,71+CurIndex*45)
					SelPlayerImage[1]:SetVisible(1)
				else
					SelPlayerImage[1]:SetVisible(0)
				end	
			end
		end
	else
		FindMySelf_Mine:SetFontText("��",0x3be2ea)
		SelPlayerImage[1]:SetVisible(0)
	end	
end

-- �õ����а����
function RankList_GetTopFont( cFont1, cFont2, cFont3, cFont4)
	Font_Font1:SetFontText( cFont1, 0xffffff)
	Font_Font2:SetFontText( cFont2, 0xffffff)
	Font_Font3:SetFontText( cFont3, 0xffffff)
	Font_Font4:SetFontText( cFont4, 0xffffff)
end

--ClearData
function RankList_ClearData()
	RankList_InfoFontList_Name_temp = {}
	RankList_InfoFontList_Server_temp = {}
	RankList_InfoFontList_Font1_temp = {}
	RankList_InfoFontList_Font2_temp = {}
	RankList_InfoFontList_Font3_temp = {}
	RankList_InfoFontList_Font4_temp = {}
end

function RankList_Recive(index,name,server,font1,font2,font3,font4)
	RankList_InfoFontList_Name_temp[index] = name	
	RankList_InfoFontList_Server_temp[index] = server
	RankList_InfoFontList_Font1_temp[index] = font1
	RankList_InfoFontList_Font2_temp[index] = font2
	RankList_InfoFontList_Font3_temp[index] = font3
	RankList_InfoFontList_Font4_temp[index] = font4
end

function RankList_ClearRankListLeftType()
	RankListLeftFont = {}
	RankListLeftTypeTemp = {}
	Font_Font1_Title = {}
	Font_Font2_Title = {}
	Font_Font3_Title = {}
	Font_Font4_Title = {}
end

--
function RankList_GetRankListLeftType(index,rankname,ranktype,fonttitle1,fonttitle2,fonttitle3,fonttitle4)
	RankListLeftFont[index] = rankname
	RankListLeftTypeTemp[index] = ranktype
	Font_Font1_Title[index] = fonttitle1
	Font_Font2_Title[index] = fonttitle2
	Font_Font3_Title[index] = fonttitle3
	Font_Font4_Title[index] = fonttitle4	
end

function RankList_ResetRankListType()
	for i=1, #RankListLeftFont do
		RankListLeftFontList[i]:SetFontText(RankListLeftFont[i], 0xbeb5ee)	
		RankListLeftSelImage[i]:SetVisible(1)
	end
	for i = #RankListLeftTypeTemp+1 ,  10 do
		RankListLeftFontList[i]:SetFontText("", 0xbeb5ee)	
		RankListLeftSelImage[i]:SetVisible(0)
	end
	
	RankList_Refresh()
end

function RankList_GetFirstRank()
	RankList_ClearRankListLeftType()
	XReqResetRankList()
end

function RankList_Refresh()
	RankList_GetMySelfRank()
	
	SelPlayerImage[2]:SetVisible(0)
	
	Page_PageShowFont:SetFontText(CurPage .. "/" .. MaxPage,0xbeb5ee)
	if CurPage == 1 then
		BestPlayerImage[1]:SetVisible(1)
		BestPlayerImage[2]:SetVisible(1)
		BestPlayerImage[3]:SetVisible(1)
	else
		BestPlayerImage[1]:SetVisible(0)
		BestPlayerImage[2]:SetVisible(0)
		BestPlayerImage[3]:SetVisible(0)
    end
	
	for i = 1,10 do
		local index = i+(CurPage-1)*10
		local color = 0xffffff
		if index == 1 then
			color = 0xe8b502
		elseif index == 2 then
			color = 0xb4acff
		elseif index == 3 then
			color = 0xda7b65
		else
			color = 0xffffff
		end
		RankList_InfoFontList_No[i]:SetFontText(index,color)
		RankList_InfoFontList_Name[i]:SetFontText(RankList_InfoFontList_Name_temp[index], color)	
		RankList_InfoFontList_Server[i]:SetFontText(RankList_InfoFontList_Server_temp[index], color)	
		RankList_InfoFontList_Font1[i]:SetFontText(RankList_InfoFontList_Font1_temp[index], color)	
		RankList_InfoFontList_Font2[i]:SetFontText(RankList_InfoFontList_Font2_temp[index], color)	
		RankList_InfoFontList_Font3[i]:SetFontText(RankList_InfoFontList_Font3_temp[index], color)	
		RankList_InfoFontList_Font4[i]:SetFontText(RankList_InfoFontList_Font4_temp[index], color)	
	end
end