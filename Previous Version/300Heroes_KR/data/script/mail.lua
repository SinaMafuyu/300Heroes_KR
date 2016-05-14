include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-- ����������

local img_MailBg = nil			-- ���䱳��
local pullPosX = 100
local pullPosY = 100


local btn_close = nil			-- �رհ�ť
local chk_All = {}				-- ȫ����ť		1,2 - δ���״̬���ѵ��״̬	3,4 - ���ְ���������
local chk_UnRead = {}			-- δ����ť
local chk_Readed = {}			-- �Ѷ���ť
local img_CountFrame = nil		-- ������
local font_CountFont = nil		-- ����
local int_Count = 0				-- �ʼ�δ������
local font_AllCount = nil		-- ����������
local int_AllCount = 99			-- �ʼ�������

local int_ClickType = 0			-- ���� 0 - ȫ��	1 - δ��	2 - �Ѷ�
local btn_CheckFrame = {}		-- ��ѡ��
btn_CheckFrame.Choose = {}		-- ȫѡor��ѡ
local btn_LeftPage = nil		-- ��ҳ
local btn_RightPage = nil		-- �ҷ�ҳ
local img_PageBg = nil			-- ҳ������
local font_Page = nil			-- ҳ��
local int_CurPage = 1			-- ��ǰҳ��
local int_AllPage = 25			-- ��ҳ��

-- �ʼ����ݼ��ؼ��Ķ���
local MailInfo = {}				-- �ʼ�������Ϣ - �ϻ󣺸��Ϲ߼�
MailInfo.Date = {}				-- ����
MailInfo.LastDay = {}			-- ʣ������
MailInfo.IsOpen = {}			-- �Ƿ�򿪹�	1 - �Ѷ�	0 - δ��
MailInfo.IsSel = {}				-- �Ƿ�ѡ��
MailInfo.IsCheck = {}			-- �Ƿ�ѡ
MailInfo.IsHaveItem = {}

local MailInfo_Content = nil	-- ����
local MailInfo_Money = nil		-- �������
local MailInfo_Exp = nil		-- ��������
local MailInfo_Title = nil		-- �ʼ�����
local MailInfo_Time = nil		-- �ʼ�ʣ��ʱ��
local MailInfo_IconPath = {}	-- �ʼ�����ͼƬ��·��
local MailInfo_IconPath1 = {}	-- �ʼ�����ͼƬ��·��1
local MailInfo_IconPath2 = {}	-- �ʼ�����ͼƬ��·��2

local img_SelList = {}			-- ѡ���б�

local MailItemList = {}			-- �ʼ��б�
MailItemList.MailIcon = {}		-- �ʼ�ͼ��
MailItemList.Name = {}			-- �ʼ�����
MailItemList.Date = {}			-- �ʼ�����
MailItemList.LastDay = {}		-- �ʼ�ʣ������
MailItemList.IsHave = {}

local btn_TackAll = nil			-- ȫ����ȡ
local btn_DelMail = nil			-- ɾ���ʼ�

-- �ʼ�����������ؿؼ�
local img_MailInfoBg = nil		-- ���������Ϣ����
local img_MailInfoName = nil	-- ���ⱳ��ͼ
local font_MailInfoName = nil	-- ��������
local font_MailInfoLastDay = nil	-- ʣ�����������
local img_MailInfoBg1 = nil		-- ���ݱ���ͼ
local font_MailInfo = nil		-- ��������
local MailInfoItemLlist = {}	-- �����б�
MailInfoItemLlist.Icon = {}		-- ����ͼ��
MailInfoItemLlist.Head = {}		-- ���߿�
MailInfoItemLlist.CountF = {}	-- ���������ؼ�
MailInfoItemLlist.CountI = {}	-- ��������
local font_Money = nil			-- ���
local font_Exp = nil			-- ��ʯ
local btn_DelMailInfo = nil		-- ɾ���ʼ�
local btn_TackMailInfo = nil	-- ��ȡ����
local btn_CloseInfo = nil			-- �ر�

local mposx = -120
local mposy = -20
function InitMail_UI(wnd, bisopen)
	g_setup_mail_ui = CreateWindow(wnd.id, 1920-655, (1080-532)/2, 372, 532)
	InitMain_Mail(g_setup_mail_ui)
	g_setup_mail_ui:SetVisible(bisopen)
end

function InitMain_Mail(wnd)
	img_MailInfoBg = wnd:AddImage(path_setup.."FriendBg_setup.png", -516, -4, 510, 540)
	img_MailInfoBg:SetVisible(0)
	img_MailBg = wnd:AddImage(path_setup.."FriendBg_setup.png",-4, -4, 380, 540)
	
	local img_MailManage = img_MailBg:AddImage(path_setup.."font1_mail.png", 157, 15, 128, 32)
	img_MailManage:SetTouchEnabled(0)
	
	btn_close = img_MailBg:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",336,9,35,35)
	btn_close.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XCloseMailList(1)
	end
	img_MailBg:AddImage(path_setup.."FGT_mail.png", 7, 90, 512, 4)
	
	-- ��ǩ��ť�ĳ�ʼ��
	chk_All[1] = img_MailBg:AddImage(path_setup.."biaoqian1_mail.png", 14, 58, 128, 64)
	chk_All[2] = img_MailBg:AddImage(path_setup.."biaoqian2_mail.png", 14, 58, 128, 64)
	chk_All[3] = chk_All[1]:AddImage(path_setup.."font7_mail.png", 10, 0, 128, 48)
	chk_All[4] = chk_All[2]:AddImage(path_setup.."font6_mail.png", 10, 0, 128, 48)
	chk_All[2]:SetTouchEnabled(1)
	chk_All[3]:SetTouchEnabled(0)
	chk_All[1]:SetVisible(0)
	
	chk_UnRead[1] = img_MailBg:AddImage(path_setup.."biaoqian1_mail.png", 102, 58, 128, 64)
	chk_UnRead[2] = img_MailBg:AddImage(path_setup.."biaoqian2_mail.png", 102, 58, 128, 64)
	chk_UnRead[3] = chk_UnRead[1]:AddImage(path_setup.."font10_mail.png", 10, 0, 128, 48)
	chk_UnRead[4] = chk_UnRead[2]:AddImage(path_setup.."font9_mail.png", 10, 0, 128, 48)
	chk_UnRead[2]:SetVisible(0)
	chk_UnRead[2]:SetTouchEnabled(1)
	chk_UnRead[3]:SetTouchEnabled(0)
	
	chk_Readed[1] = img_MailBg:AddImage(path_setup.."biaoqian1_mail.png", 190, 58, 128, 64)
	chk_Readed[2] = img_MailBg:AddImage(path_setup.."biaoqian2_mail.png", 190, 58, 128, 64)
	chk_Readed[3] = chk_Readed[1]:AddImage(path_setup.."font5_mail.png", 10, 0, 128, 48)
	chk_Readed[4] = chk_Readed[2]:AddImage(path_setup.."font4_mail.png", 10, 0, 128, 48)
	chk_Readed[2]:SetVisible(0)
	chk_Readed[2]:SetTouchEnabled(1)
	chk_Readed[3]:SetTouchEnabled(0)
	
	img_CountFrame = img_MailBg:AddImage(path.."friend4_hall_big.png", 75, 53, 32, 32)
	font_CountFont = img_CountFrame:AddFont(tostring(int_Count), 15, 8, 1, 0, 30, 20, 0xffffffff)
	
	chk_All[1].script[XE_LBUP] = function()
		XClickPlaySound(5)
		int_ClickType = 0
		
		XClickCheckBtnMail(1, int_ClickType)
		
		chk_All[1]:SetVisible(0)
		chk_All[2]:SetVisible(1)
		img_CountFrame:SetPosition(75, 53)
		
		chk_UnRead[1]:SetVisible(1)
		chk_UnRead[2]:SetVisible(0)
		chk_Readed[1]:SetVisible(1)
		chk_Readed[2]:SetVisible(0)
		
		for i = 1, 8 do
			img_SelList[i]:SetVisible(0)
		end
	end
	
	chk_UnRead[1].script[XE_LBUP] = function()
		XClickPlaySound(5)
		int_ClickType = 1
		
		XClickCheckBtnMail(1, int_ClickType)
		
		chk_UnRead[1]:SetVisible(0)
		chk_UnRead[2]:SetVisible(1)
		img_CountFrame:SetPosition(163, 53)
		
		chk_All[1]:SetVisible(1)
		chk_All[2]:SetVisible(0)
		chk_Readed[1]:SetVisible(1)
		chk_Readed[2]:SetVisible(0)
		
		for i = 1, 8 do
			img_SelList[i]:SetVisible(0)
		end
	end
	
	chk_Readed[1].script[XE_LBUP] = function()
		XClickPlaySound(5)
		int_ClickType = 2
		-- log("\nint_ClickType = "..int_ClickType)
		XClickCheckBtnMail(1, int_ClickType)
		
		chk_Readed[1]:SetVisible(0)
		chk_Readed[2]:SetVisible(1)
		img_CountFrame:SetPosition(251, 53)
		
		chk_All[1]:SetVisible(1)
		chk_All[2]:SetVisible(0)
		chk_UnRead[1]:SetVisible(1)
		chk_UnRead[2]:SetVisible(0)
		
		for i = 1, 8 do
			img_SelList[i]:SetVisible(0)
		end
	end
	
	-- ��ѡ��Ĵ���
	img_MailBg:AddFont("��ü", 15, 0, 52, 102, 50, 20, 0xff634792)
	btn_CheckFrame[1] = img_MailBg:AddButton(path_hero.."checkbox_hero.png", path_hero.."checkbox_hero.png", path_hero.."checkbox_hero.png", 19, 97, 32, 32)
	btn_CheckFrame.Choose[1] = btn_CheckFrame[1]:AddImage(path_hero.."checkboxYes_hero.png", 5, -1, 32, 32)
	btn_CheckFrame.Choose[1]:SetTouchEnabled(0)
	btn_CheckFrame.Choose[1]:SetVisible(0)
	
	-- ��ҳ��ؿؼ��Ĵ���
	btn_LeftPage = img_MailBg:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png", 115, 96, 27,36)
	XWindowEnableAlphaTouch(btn_LeftPage.id)
	img_PageBg = img_MailBg:AddImage(path_setup.."yemadiban_mail.png", 142, 105, 92, 18)
	int_AllPage = math.ceil(int_AllCount/4)
	font_Page = img_PageBg:AddFont(int_CurPage.."/"..int_AllPage, 15, 8, 0, 0, 92, 18, 0xffffffff)
	btn_RightPage = img_MailBg:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png", 235, 96, 27,36)
	XWindowEnableAlphaTouch(btn_RightPage.id)
	
	btn_LeftPage.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XMailBackPageClick(1)
	end
	
	btn_RightPage.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XMailNextPageClick(1)
	end
	
	-- img_MailBg:AddFont("�ʼ�����", 15, 0, 277, 102, 100, 20, 0xff634792)
	-- font_AllCount = img_MailBg:AddFont(tostring(int_AllCount), 15, 0, 333, 100, 50, 20, 0xffffffff)
	local AA = img_MailBg:AddFont("�ȳ�:�������Ⱓ�� 7���̸�, ÷�ι�ǰ�� ������ 30���Դϴ�", 11, 0, 15, 460, 400, 12, 0xb27936)
	AA:SetFontSpace(1,1)
	-- �ʼ��б���
	local iX,iY = 12,135
	for i = 1, 8 do
		MailItemList[i] = img_MailBg:AddImage(path_setup.."youjiandiban3_mail.png", iX, iY + (40*(i-1)), 358, 39)
		--MailItemList[i]:SetTouchEnabled(1)
		
		img_SelList[i] = MailItemList[i]:AddImage(path_setup.."youjiandiban4_mail.png", 0, 0, 358, 39)
		img_SelList[i]:SetVisible(0)
		
		MailItemList.MailIcon[i] = MailItemList[i]:AddImage(path_setup.."youjian1_mail.png", 57, 3, 43, 34)
		MailItemList.MailIcon[i]:SetTouchEnabled(0)
		MailItemList.IsHave[i] = MailItemList.MailIcon[i]:AddImage(path_setup.."huixinzhen_mail.png", 18, 0, 15, 26)
		MailItemList.IsHave[i]:SetTouchEnabled(0)
		MailItemList.Name[i] = MailItemList[i]:AddFont("�ϻ󣺸��Ϲ߼�"..i, 12, 8, -107, -10, 125, 20,  0xff87ced4)
		MailItemList.Date[i] = MailItemList[i]:AddFont("2015.8.1"..i, 12, 0, 242, 10, 100, 20,  0xff87ced4)
		MailItemList.LastDay[i] = MailItemList[i]:AddFont(i.."1��", 12, 0, 317, 10, 60, 20,  0xff87ced4)
		
		btn_CheckFrame[1+i] = img_MailBg:AddButton(path_hero.."checkbox_hero.png", path_hero.."checkbox_hero.png", path_hero.."checkbox_hero.png", 19, iY + 5 + (40*(i-1)), 32, 32)
		btn_CheckFrame.Choose[1+i] = btn_CheckFrame[1+i]:AddImage(path_hero.."checkboxYes_hero.png", 5, -1, 32, 32)
		btn_CheckFrame.Choose[1+i]:SetTouchEnabled(0)
		btn_CheckFrame.Choose[1+i]:SetVisible(0)
		
		-- ���
		MailItemList[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			MailInfo.IsSel[i] = 1
			img_SelList[i]:SetVisible(1)
			for j = 1, 8 do
				if (i ~= j) then
					MailInfo.IsSel[j] = 0
					img_SelList[j]:SetVisible(0)
				end
			end
			XMailListIconClick(1, ((int_CurPage-1)*8)+(i-1))
		end
		
		-- ����
		MailItemList[i].script[XE_ONHOVER] = function()
			img_SelList[i]:SetVisible(1)
			for j = 1, 8 do
				if (i ~= j) then
					if (MailInfo.IsSel[j] == 0 or MailInfo.IsSel[j] == nil) then
						img_SelList[j]:SetVisible(0)
					end
				end
			end
		end
		
		-- �뿪
		MailItemList[i].script[XE_ONUNHOVER] = function()
			if (MailInfo.IsSel[i] == 0 or MailInfo.IsSel[i] == nil) then
				img_SelList[i]:SetVisible(0)
			end
		end
	end
	
	-- ��ѡ���߼�
	for i = 1, #btn_CheckFrame do
		btn_CheckFrame[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			if btn_CheckFrame.Choose[i]:IsVisible() then
				if (i == 1) then
					btn_CheckFrame.Choose[i]:SetVisible(0)
					for j = 2, #btn_CheckFrame.Choose do
						btn_CheckFrame.Choose[j]:SetVisible(0)
						MailInfo.IsCheck[j-1] = 0
					end
				else
					btn_CheckFrame.Choose[i]:SetVisible(0)
					MailInfo.IsCheck[i] = 0
				end
			else
				if (i == 1) then
					btn_CheckFrame.Choose[i]:SetVisible(1)
					for j = 2, #btn_CheckFrame.Choose do
						btn_CheckFrame.Choose[j]:SetVisible(1)
						MailInfo.IsCheck[j-1] = 1
					end
				else
					btn_CheckFrame.Choose[i]:SetVisible(1)
					MailInfo.IsCheck[i] = 1
				end
			end
		end
	end
	
	btn_TackAll = img_MailBg:AddButton(path_setup.."btn1_mail.png", path_setup.."btn2_mail.png", path_setup.."btn3_mail.png", 60, 483, 100, 32)
	local Fa = btn_TackAll:AddFont("���ιޱ�", 15, 8, 0, 0, 100, 32, 0xffffff)
	Fa:SetTouchEnabled(0)
	btn_DelMail = img_MailBg:AddButton(path_setup.."btn1_mail.png", path_setup.."btn2_mail.png", path_setup.."btn3_mail.png", 221, 483, 100, 32)
	local Fb = btn_DelMail:AddFont("��ü����", 15, 8, 0, 0, 100, 32, 0xffffff)
	Fb:SetTouchEnabled(0)
	local AM = btn_DelMail:AddFont("÷�ι�ǰ�� �ֽ��ϴ�.",11, 0, -12, 31, 150, 12, 0xb27936)
	AM:SetFontSpace(1,1)
	btn_TackAll.script[XE_LBUP] = function()
		XClickPlaySound(5)
		local MailIndex = {}
		for i = 2, 9 do
			if (btn_CheckFrame.Choose[i]:IsVisible() and i ~= 1) then
				MailIndex[i-1] = ((i-2)+((int_CurPage-1)*8))
			else
				MailIndex[i-1] = -1
			end
		end
		XTackAllMail(1, MailIndex[1], MailIndex[2], MailIndex[3], MailIndex[4], MailIndex[5], MailIndex[6], MailIndex[7], MailIndex[8])
	end
	btn_DelMail.script[XE_LBUP] = function()
		XClickPlaySound(5)
		local MailIndex = {}
		for i = 2, 9 do
			if (btn_CheckFrame.Choose[i]:IsVisible() and i ~= 1) then
				MailIndex[i-1] = ((i-2)+((int_CurPage-1)*8))
			else
				MailIndex[i-1] = -1
			end
		end
		XDelAllMail(1, MailIndex[1], MailIndex[2], MailIndex[3], MailIndex[4], MailIndex[5], MailIndex[6], MailIndex[7], MailIndex[8])
	end
	
	-- ����������ݿؼ��Ĵ���
	img_MailInfoBg:AddImage(path_setup.."font2_mail.png", 232, 16, 64, 32)
	img_MailInfoBg:AddImage(path_setup.."font3_mail.png", 17, 60, 64, 32)
	-- img_MailInfoName = img_MailInfoBg:AddImage(path_setup.."zhutiEdit_mail.png", 68, 65, 512, 32)
	font_MailInfoName = img_MailInfoBg:AddFont("�ϻ󣺸��Ϲ߼�", 15, 0, 69, 70, 300, 20, 0xff87ced4)
	img_MailInfoBg1 = img_MailInfoBg:AddImage(path_setup.."InfoBg_mail.png", 27, 99, 458, 228)
	font_MailInfo = img_MailInfoBg1:AddFont("ĳ���͸� 7����", 15, 0, 10, 10, 440, 200, 0xffffffff)
	font_MailInfoLastDay = img_MailInfoBg1:AddFont("���������Ⱓ��XX��", 11, 0, 330, 205, 120, 11, 0xc23452)
	font_MailInfoLastDay:SetFontSpace(1,1)
	for i = 1, 6 do
		MailInfoItemLlist[i] = img_MailInfoBg:AddImage(path_info.."skill0_info.png", 62+(62*(i-1)), 355, 64, 64)
		MailInfoItemLlist.Icon[i] = MailInfoItemLlist[i]:AddImageMultiple(path_equip.."bag_equip.png", "", "", 10, 10, 45, 45)
		MailInfoItemLlist.Head[i] = MailInfoItemLlist[i]:AddImage(path_info.."skill1_info.png", 0, 0, 64, 64)
		MailInfoItemLlist.CountF[i] = MailInfoItemLlist[i]:AddFont( "0", 12, 6, -42, -38, 100, 17, 0xFFFFFF)
		MailInfoItemLlist.CountF[i]:SetFontBackground()
	end
	img_MailInfoBg:AddImage(path_shop.."money_shop.png", 98, 445, 64, 64)
	img_MailInfoBg:AddImage(path_setup.."exp_mail.png", 303, 453, 64, 32)
	font_Money = img_MailInfoBg:AddFont("12345", 15, 0, 135, 453, 100, 15, 0xfff0e18e)
	font_Exp = img_MailInfoBg:AddFont("54321", 15, 0, 343, 453, 100, 15, 0xff53e787)
	btn_DelMailInfo = img_MailInfoBg:AddButton(path_setup.."btn1_mail.png", path_setup.."btn2_mail.png", path_setup.."btn3_mail.png", 95, 483, 100, 32)
	local Fa = btn_DelMailInfo:AddFont("���ϻ���", 15, 8, 0, 0, 100, 32, 0xffffff)
	Fa:SetTouchEnabled(0)
	btn_TackMailInfo = img_MailInfoBg:AddButton(path_setup.."btn1_mail.png", path_setup.."btn2_mail.png", path_setup.."btn3_mail.png", 300, 483, 100, 32)
	local Fb = btn_TackMailInfo:AddFont("��ǰ�ޱ�", 15, 8, 0, 0, 100, 32, 0xffffff)
	Fb:SetTouchEnabled(0)
	btn_DelMailInfo.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XDeleteMail(1)
	end
	
	btn_TackMailInfo.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XTackItem(1)
	end
	btn_CloseInfo = img_MailInfoBg:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",465,7,35,35)
	btn_CloseInfo.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XCloseMailContent(1)
	end
	
	g_setup_mail_ui:ToggleBehaviour(XE_ONUPDATE, 1)	-- �����Ϣ
	
    img_MailBg.script[XE_LBDOWN] = function()
	    g_setup_mail_ui:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
		local L,T = g_setup_mail_ui:GetPosition()
		pullPosX = XGetCursorPosX()-L
		pullPosY = XGetCursorPosY()-T
	end
	img_MailBg.script[XE_LBUP] = function()
	    g_setup_mail_ui:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
	end	
	g_setup_mail_ui.script[XE_ONUPDATE] = function()--������ƶ�ʱ --��Ӧ��ק
		if(g_setup_mail_ui:IsVisible()) then
		    local x = XGetCursorPosX()
			local y = XGetCursorPosY()
			local w,h = img_MailBg:GetWH()
			local PosX
			local PosY
            PosX = x- pullPosX
			if(PosX < 0) then
			    PosX = 0
			elseif(PosX > windowswidth-w)	then
			    PosX = windowswidth - w
			end
			PosY = y- pullPosY
			if(PosY < 0) then
			    PosY = 0
			elseif(PosY > windowsheight - h)	then
			    PosY = windowsheight - h
			end			
		    g_setup_mail_ui:SetAbsolutePosition(PosX,PosY)
		else
	        g_setup_mail_ui:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
		end
	end
	
end


-- ��գ���ʼ���ʼ�����
function InitMailInfo()
	if (#MailInfo > 0) then
		MailInfo = {}
		MailInfo.Date = {}
		MailInfo.LastDay = {}
		MailInfo.IsOpen = {}
		MailInfo.IsSel = {}
		MailInfo.IsCheck = {}
		MailInfo.IsHaveItem = {}
	end
	
	int_CurPage = 1
	int_AllCount = 0
	int_AllPage = 1
	int_Count = 0
	
	for i = 1, 9 do
		btn_CheckFrame.Choose[i]:SetVisible(0)
	end
end

-- ����ʼ���ϸ��Ϣ
function ClearMailInfo()
	MailInfo_Title = ""
	MailInfo_Content = ""
	MailInfo_Time = ""
	MailInfo_Money = 0
	MailInfo_Exp = 0
	for i = 1, 6 do
		MailInfo_IconPath[i] = ""
		MailInfo_IconPath1[i] = ""
		MailInfo_IconPath2[i] = ""
		MailInfoItemLlist[i]:SetVisible(0)
	end
end

-- ��C�л�ȡ�ʼ���Ϣ�����˺���ǰ�������ձ�������
function GetMailInfoFromC( cTitle, cDate, cLastDay, cIsNew, index, cIsHaveItem)
	local i = index
	MailInfo[i] = cTitle
	MailInfo.Date[i] = cDate
	MailInfo.LastDay[i] = cLastDay
	MailInfo.IsOpen[i] = cIsNew

	MailInfo.IsCheck[i] = 0
	MailInfo.IsSel[i] = 0
	MailInfo.IsHaveItem[i] = cIsHaveItem
end

-- �õ��ʼ���ϸ����
function GetMailInfo(cTitle, cContent, cTime, cMoney, cExp, cCount1, cCount2, cCount3, cCount4, cCount5, cCount6)
	MailInfo_Title = cTitle
	MailInfo_Content = cContent
	MailInfo_Time = cTime
	MailInfo_Money = cMoney
	MailInfo_Exp = cExp
	MailInfoItemLlist.CountI[1] = cCount1
	MailInfoItemLlist.CountI[2] = cCount2
	MailInfoItemLlist.CountI[3] = cCount3
	MailInfoItemLlist.CountI[4] = cCount4
	MailInfoItemLlist.CountI[5] = cCount5
	MailInfoItemLlist.CountI[6] = cCount6
	return ReFreshInfo()
end

function SetMailIconPathData( path1, path2, path3, cindex)
	MailInfo_IconPath[cindex] = path1
	MailInfo_IconPath1[cindex] = path2
	MailInfo_IconPath2[cindex] = path3
end

-- �õ��ʼ��������
function GetMailCount( cAllCount, cCount)
	int_AllCount = cAllCount
	int_Count = cCount
	if int_ClickType == 0 or int_ClickType == 1 then
		--log("\nint_ClickType = "..int_ClickType)
		SendMailNumToLua(cCount)
	end
end

-- �ػ�
function ReFresh()
	local iCount = 0
	font_CountFont:SetFontText(int_AllCount, 0xffffffff)
	
	for i = 1, 8 do
		if (MailInfo[i] == nil) then
			btn_CheckFrame[i+1]:SetVisible(0)
			MailItemList[i]:SetVisible(0)
		else
			btn_CheckFrame[i+1]:SetVisible(1)
			MailItemList[i]:SetVisible(1)
			iCount = iCount + 1
		end
	end
	
	font_Page:SetFontText(int_CurPage.."/"..int_AllPage, 0xffffffff)
	-- font_AllCount:SetFontText(int_AllCount, 0xffffffff)
	-- if int_ClickType == 0 or int_ClickType == 1 then
	-- end
	
	if (iCount == 0) then
		return
	end
	
	for i = 1, iCount do
		MailItemList.Name[i]:SetFontText(MailInfo[i], 0xff87ced4)
		MailItemList.Date[i]:SetFontText(MailInfo.Date[i], 0xff87ced4)
		MailItemList.LastDay[i]:SetFontText(MailInfo.LastDay[i].."��", 0xff87ced4)
		if (MailInfo.IsOpen[i] == 0) then
			MailItemList.MailIcon[i].changeimage(path_setup.."youjian2_mail.png")
		else
			MailItemList.MailIcon[i].changeimage(path_setup.."youjian1_mail.png")
		end
		
		if MailInfo.IsHaveItem[i]>0 then
			MailItemList.IsHave[i]:SetVisible(1)
		else
			MailItemList.IsHave[i]:SetVisible(0)
		end
	end
end

function ReFreshInfo()
	font_MailInfoName:SetFontText(MailInfo_Title, 0xff87ced4)
	font_MailInfo:SetFontText(MailInfo_Content, 0xffffffff)
	font_MailInfoLastDay:SetFontText(MailInfo_Time, 0xc23452)
	font_Money:SetFontText(tostring(MailInfo_Money), 0xfff0e18e)
	font_Exp:SetFontText(tostring(MailInfo_Exp), 0xff53e787)
	for i = 1, 6 do
		if MailInfo_IconPath[i] == "" then
			break
		end
		MailInfoItemLlist[i]:SetVisible(1)
		MailInfoItemLlist.Icon[i].changeimageMultiple( "..\\" .. MailInfo_IconPath[i], "..\\" .. MailInfo_IconPath1[i], "..\\" .. MailInfo_IconPath2[i])
		MailInfoItemLlist.CountF[i]:SetFontText(tostring(MailInfoItemLlist.CountI[i]), 0xffffffff)
	end
end

function SetMailContentTipInfo(ctip, cindex)
	XSetImageTip(MailInfoItemLlist.Icon[cindex+1].id, ctip)
end

function ClearCheckBtn()
	for i = 1, 9 do
		btn_CheckFrame.Choose[i]:SetVisible(0)
	end
	for i = 1, 8 do
		img_SelList[i]:SetVisible(0)
	end
end

function SetPageCount(index, count)
	int_CurPage = index
	int_AllPage = count
	if int_CurPage==1 then
		btn_LeftPage:SetEnabled(0)
	else
		btn_LeftPage:SetEnabled(1)
	end
	if int_CurPage==int_AllPage then
		btn_RightPage:SetEnabled(0)
	else
		btn_RightPage:SetEnabled(1)
	end
end

function SetMailInfoVisible(cVisible)
	img_MailInfoBg:SetVisible(cVisible)
end

function VisibleAllMailList()
	for i = 1, 8 do
		MailInfo[i]:SetVisible(0)
	end
end

-------------������ʾ
function SetMailIsVisible(flag) 
	if g_setup_mail_ui ~= nil then
		if flag == 1 and g_setup_mail_ui:IsVisible() == false then
			g_setup_mail_ui:CreateResource()
			img_CountFrame:SetPosition(75, 53)
			int_ClickType = 0
			XClickCheckBtnMail(1, int_ClickType)
			chk_All[1]:SetVisible(0)
			chk_All[2]:SetVisible(1)
			chk_UnRead[1]:SetVisible(1)
			chk_UnRead[2]:SetVisible(0)
			chk_Readed[1]:SetVisible(1)
			chk_Readed[2]:SetVisible(0)
			for i = 1, 8 do
				img_SelList[i]:SetVisible(0)
			end
			
			g_setup_mail_ui:SetVisible(1)
			XGetMailUiIsVisible(1, 1)
			if img_MailInfoBg:IsVisible()==true then
				img_MailInfoBg:SetVisible(0)
			end
		elseif flag == 0 and g_setup_mail_ui:IsVisible() == true then
			g_setup_mail_ui:DeleteResource()
			g_setup_mail_ui:SetVisible(0)
			XGetMailUiIsVisible(1, 0)
		end
	end
end

function GetMailIsVisible()  
    if(g_setup_mail_ui:IsVisible()) then
       XMailIsOpen(1)
    else
       XMailIsOpen(0)
    end
end