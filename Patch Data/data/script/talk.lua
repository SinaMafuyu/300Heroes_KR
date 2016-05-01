include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local img_FriendFrameBg = nil			-- ���ѱ�����
local pullPosX = 100
local pullPosY = 100

local friendBtn = nil --��Ӻ��Ѱ���
local blacklistBtn = nil --��Ӻ���������
local talk_change = {}
talk_change.picWord = {}
talk_change.pic = {}
talk_change.id = 1--��ǰѡ�н���,1Ϊ���ѣ�256Ϊ������
talk_change.pointback = {}
talk_change.num = {}
talk_change.pointnum = {}

local btnAddFriend = nil
local btnAddblacklist = nil
--��¼���к��ѵ�����//�������Ѻͺ�����������
local allFriend_relationship = {}
allFriend_relationship.friendindex = {}--���ѵ�id
allFriend_relationship.picpath = {}--���ѵ�·��
allFriend_relationship.name = {}--���ѵ�����
allFriend_relationship.relation = {}--���к��ѵĹ�ϵ
allFriend_relationship.id = {}--����id
allFriend_relationship.ifOnLine = {} --�Ƿ�����
allFriend_relationship.level = {} --��ҵȼ�
allFriend_relationship.orglevel = {}--�ٻ�ʦ�ȼ�
allFriend_relationship.nowMap = {} --��ǰ���ڵ�ͼ
allFriend_relationship.friendship = {} --��Һ��Ѷ�
allFriend_relationship.x = {}
allFriend_relationship.y = {}
allFriend_relationship.w = {}
allFriend_relationship.h = {}

--��ʾ
local friend_ManageShow = {}
friend_ManageShow.back = {}--��ͼ
friend_ManageShow.headPic = {}--ͷ��
friend_ManageShow.namefont = {}--����
friend_ManageShow.battlePlace = {}--��ǰ����
friend_ManageShow.vip = {}--vip��־
friend_ManageShow.talkbtn = {}--�һ�����
friend_ManageShow.Deletebtn = {} --ɾ�����ѱ�־
friend_ManageShow.id = {}--��Ӧ���ѿ��м��id
friend_ManageShow.g_item_posx = {}--������X
friend_ManageShow.g_item_posy = {}--������Y
friend_ManageShow.checkback = {} --ѡ�п�
friend_ManageShow.black = {}  --�û�
--��Ҫһ��window����friend
local check_friend = nil
local check_sliplineback = nil --������
local check_slipline = nil
local Many_Equip = 0

local updownCount = 0
local maxUpdown = 0
--���ڵ�ͼ��ǰ--
local map = {}
map.name = {" ","[����]","[������ͼ]","[׼���������㾺������]","[׼����������ս����]","[׼����������ѵ��Ӫ��]","[׼���������㾺����������]","[׼����������ս��������]","[׼�������ػ��ŵ��ȡ�]",
"[׼�����뽩ʬģʽ��]","[׼���������߶�������]","[׼�������ɽս��[20v20]��]","[׼�������¡ս����]","[׼������������λ����]","[׼������Ӣ�۴��Ҷ���]","[׼������̹�˴�ս��]","[׼����������ս������ģʽ��]",
"[׼��������Ҷ���]","[��ս","[���㾺����[1v1]]","[����ս��[1v1]]","[5V5������]","[���㾺����[10v10]]","[����ս��]","[����ս������ģʽ]","[���㾺����]","[��¡ս��]","[������λ��]","[����Ԫɱ��]",
"[ˢ��]","[�ػ��ŵ���]","[��ʬģʽ]","[���߶�����]","[���߶�����]","[��ɽս��[20v20]]","[���㾺��������]","[����ս������]","[����ѵ��Ӫ]","[����ս��]","[���Ὰ����]","[���Ҷ�]"
}
map.num = {0,1,2,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,88,211,212,250,251,252,253,254,255,256,257,258,260,270,280,281,290,300,301,302,352,354,500}
---����ѡ�п�---window
talk_show_playerinfo_wnd = nil
talk_show_playerinfo_wndBack = nil
talk_show_playerinfo_wndBackX = nil
talk_show_playerinfo_wndBackY = nil
local talk_show_playerinfo = {} --������Ϣ��
talk_show_playerinfo.headPic = nil--���ͷ��
talk_show_playerinfo.namefont = nil--�������
talk_show_playerinfo.name = nil--�������
talk_show_playerinfo.levelfont = nil--�ȼ�
talk_show_playerinfo.festival = nil--�ڲ�
talk_show_playerinfo.id = nil
talk_show_playerinfo.close = nil
local talk_btn_first = nil --��Ϊ���Ѱ���
local talk_btn_second = nil --������Ұ���
local talk_btn_third = nil --ս��solo����
local talk_btn_forth = nil --�ٱ���水��
local talk_btn_fifth = nil --������solo����

--����Ի���--window
local talk_talkBack = nil


function InitTalk_UI(wnd, bisopen)
	g_setup_talk_ui = CreateWindow(wnd.id, 1920-655, (1080-532)/2, 372, 532)
	InitMain_Talk(g_setup_talk_ui)
	g_setup_talk_ui:SetVisible(bisopen)
end

function InitMain_Talk(wnd)
	img_FriendFrameBg = wnd:AddImage(path_setup.."FriendBg_setup.png", -4, -4, 380, 540)
	local btn_close = wnd:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",332,5,35,35)
	btn_close.script[XE_LBUP] = function()
		XClickPlaySound(5)
		SetTalkIsVisible(0)
	end
	local img_friendManage = wnd:AddImage(path_setup.."font9_talk.png",145,11,128,32)
	img_friendManage:SetTouchEnabled(0)
	wnd:AddImage(path_setup.."font10_talk.png",3,86,512,4)
	----�����ĸ��л�----
    Init_talk_change(wnd)
	
	btnAddFriend = wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",55,479,100,32)
	btnAddFriend:AddFont("��Ӻ���",15, 8, 0, 0, 100, 32, 0xffffff)
	btnAddFriend.script[XE_LBUP] = function()
	    XLwantAddAFriend()
	end
    btnAddblacklist = wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",217,479,100,32)
	btnAddblacklist:AddFont("��Ӻ�����",15, 8, 0, 0, 100, 32, 0xffffff)	
	btnAddblacklist.script[XE_LBUP] = function()
	    XLwantAddABlack()
	end
	local AM = wnd:AddFont("��ʾ���һ���ɫͷ��ɽ��и���Ļ�������",11, 0, 60, 512, 500, 15, 0xb27936)
	AM:SetFontSpace(1,1)
	Init_talk_Check_Friend(wnd)	
	Init_talk_talkplace(wnd)
	Init_talk_show_playerinfo_wnd(G_login_ui)
	
	g_setup_talk_ui:ToggleBehaviour(XE_ONUPDATE, 1)	-- �����Ϣ
	
    img_FriendFrameBg.script[XE_LBDOWN] = function()
	    g_setup_talk_ui:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
		local L,T = g_setup_talk_ui:GetPosition()
		pullPosX = XGetCursorPosX()-L
		pullPosY = XGetCursorPosY()-T
	end
	img_FriendFrameBg.script[XE_LBUP] = function()
	    g_setup_talk_ui:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
	end	
	g_setup_talk_ui.script[XE_ONUPDATE] = function()--������ƶ�ʱ --��Ӧ��ק
		if(g_setup_talk_ui:IsVisible()) then
			local x = XGetCursorPosX()
			local y = XGetCursorPosY()
			local w,h = img_FriendFrameBg:GetWH()
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
		    g_setup_talk_ui:SetAbsolutePosition(PosX,PosY)
		else
	        g_setup_talk_ui:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
		end
	end
	
end

function Init_talk_talkplace(wnd)
    
    talk_talkBack = CreateWindow(wnd.id, -510, 0, 508, 531)
	talk_talkBack:SetVisible(0)
	talk_talkBack:AddImage(path_setup.."talkback_setup.png",-4,-4,516,539)
	talk_talkBack:AddImage(path_setup.."font11_talk.png",229,20,128,32)
	talk_talkBack:AddFont("���������н�,�������ٹ����Ϣ,�����˺��������Ϣ͸¶������",15, 0, 54, 48, 500, 59, 0xff3d5e)	

end

function Init_talk_show_playerinfo_wnd(wnd)
    talk_show_playerinfo_wnd = CreateWindow(wnd.id, (1920-732)/2, (1080-280)/2, 335, 225)
	talk_show_playerinfo_wndBack = talk_show_playerinfo_wnd:AddImage(path_setup.."safeBK_setup.png",-4,-4,363,233)
    talk_show_playerinfo_wnd:AddFont("�����Ϣ",15, 0, 140, 10, 100, 20, 0x8BDBE4)	
	talk_show_playerinfo.namefont = talk_show_playerinfo_wnd:AddFont("��������߸���",15, 0, 160, 54, 200, 18, 0x8BDBE4)	
	talk_show_playerinfo.headPic = talk_show_playerinfo_wnd:AddImage(path.."friend4_hall.png",90,56,50,50)	--ͼƬ·��--����ͷ��
	talk_show_playerinfo.headPic:AddImage(path.."headSide1_hall.png",0,0,50,50)
	talk_show_playerinfo.headPic:SetTouchEnabled(0)
	talk_show_playerinfo_wnd:AddFont("�ȼ���",15, 0, 160, 79, 100, 18, 0x8BDBE4)
	talk_show_playerinfo_wnd:AddFont("�ڲ٣�",15, 0, 160, 104, 100, 18, 0x8BDBE4)
	talk_show_playerinfo.levelfont = talk_show_playerinfo_wnd:AddFontEx("12345", 15, 0, 205, 79, 100, 16, 0xFFFFFF)
	talk_show_playerinfo.festival = talk_show_playerinfo_wnd:AddFontEx("12345", 15, 0, 205, 104, 100, 16, 0xFFFFFF)
	
	talk_btn_first = talk_show_playerinfo_wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",20,143,100,32)
	talk_btn_first:AddFont("��Ϊ����",15, 8, 0, 0, 100, 32, 0xffffff)
	talk_btn_first.script[XE_LBUP] = function()
	    XFriendHim(talk_show_playerinfo.name)
	end
	
	
	
	talk_show_playerinfo.close = talk_show_playerinfo_wnd:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",320,-2,35,35)
	talk_show_playerinfo.close.script[XE_LBUP] = function()
	    talk_Check_SetTalkVisible(0)
		XCloseHim()
	end
	

	talk_btn_second = talk_show_playerinfo_wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",120,143,100,32)
	talk_btn_second:AddFont("�������",15, 8, 0, 0, 100, 32, 0xffffff)
	talk_btn_second.script[XE_LBUP] = function()
	    XBlackHim(talk_show_playerinfo.name)
	end
	
	talk_btn_third = talk_show_playerinfo_wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",220,143,100,32)
	talk_btn_third:AddFont("ս��SOLO",15, 8, 0, 0, 100, 32, 0xffffff)
	talk_btn_third.script[XE_LBUP] = function()
		XLwantsoloWithHim(1,talk_show_playerinfo.name)
	end
		
	talk_btn_forth = talk_show_playerinfo_wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",120,175,100,32)
	talk_btn_forth:AddFont("�ٱ����",15, 8, 0, 0, 100, 32, 0xffffff)
	talk_btn_forth.script[XE_LBUP] = function()
	    XLwantReportHim(1,allFriend_relationship.friendindex[talk_show_playerinfo.id])
	end
	
	
	talk_btn_fifth = talk_show_playerinfo_wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",220,175,100,32)
	talk_btn_fifth:AddFont("������SOLO",15, 8, 0, 0, 100, 32, 0xffffff)
	talk_btn_fifth.script[XE_LBUP] = function()
		XLwantsoloWithHim(2,talk_show_playerinfo.name)
	end
	talk_show_playerinfo_wnd:SetVisible(0)
	
	talk_show_playerinfo_wnd:ToggleBehaviour(XE_ONUPDATE, 1)	-- �����Ϣ
	
    talk_show_playerinfo_wndBack.script[XE_DRAG] = function()
	    talk_show_playerinfo_wnd:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
		local L,T = talk_show_playerinfo_wnd:GetPosition()
		talk_show_playerinfo_wndBackX = XGetCursorPosX()-L
		talk_show_playerinfo_wndBackY = XGetCursorPosY()-T
	end
	talk_show_playerinfo_wndBack.script[XE_LBUP] = function()
	    talk_show_playerinfo_wnd:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
	end	
	talk_show_playerinfo_wnd.script[XE_ONUPDATE] = function()--������ƶ�ʱ --��Ӧ��ק
		if(talk_show_playerinfo_wnd:IsVisible()) then
			local x = XGetCursorPosX()
			local y = XGetCursorPosY()
			local w,h = talk_show_playerinfo_wndBack:GetWH()
			local PosX
			local PosY
            PosX = x- talk_show_playerinfo_wndBackX
			if(PosX < 0) then
			    PosX = 0
			elseif(PosX > windowswidth-w)	then
			    PosX = windowswidth - w
			end
			PosY = y- talk_show_playerinfo_wndBackY
			if(PosY < 0) then
			    PosY = 0
			elseif(PosY > windowsheight - h)	then
			    PosY = windowsheight - h
			end	
		    talk_show_playerinfo_wnd:SetAbsolutePosition(PosX,PosY)
		else
	        talk_show_playerinfo_wnd:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
		end
	end
end


function talk_change_showPlayerinfo(name,orglevel,level)
    talk_Check_SetTalkVisible(1)
    talk_show_playerinfo.namefont:SetFontText(name) 	
	talk_show_playerinfo.levelfont:SetFontText(orglevel)
	talk_show_playerinfo.festival:SetFontText(level)
	talk_show_playerinfo.name = name
end
function talk_change_showPlayerHeadPic(pictureName)
    talk_show_playerinfo.headPic.changeimage("..\\"..pictureName)
end




----�����ĸ��л�----
function Init_talk_change(wnd)
    --����
    talk_change.pic[1] = wnd:AddImage(path_setup.."biaoqian2_mail.png",10,54,128,64)
    talk_change.picWord[1] = talk_change.pic[1]:AddImage(path_setup.."font8_talk.png",3,0,128,64)
	talk_change.picWord[1]:SetTouchEnabled(0)
	talk_change.pointback[1] = talk_change.pic[1]:AddImage(path.."friend4_hall.png",70,0,32,32)
	talk_change.num[1] = 0
	talk_change.pointnum[1] = talk_change.pointback[1]:AddFont("0",15, 0, 0, 0, 20, 20, 0xFFFFFF)
	talk_change.pic[1].script[XE_LBUP] = function()
	    if talk_change.id ==1 then
		   return
		end   
	    Initalize_talk_change()
        talk_change.pic[1].changeimage(path_setup.."biaoqian2_mail.png")
        talk_change.picWord[1].changeimage(path_setup.."font8_talk.png")	
		talk_change.id = 1	
		XTalk_rebuild_friend(1)	
	end
	--ս��
	talk_change.pic[2] = wnd:AddImage(path_setup.."biaoqian1_mail.png",97,54,128,64)
    talk_change.picWord[2] = talk_change.pic[2]:AddImage(path_setup.."font5_talk.png",3,0,128,64)
	talk_change.picWord[2]:SetTouchEnabled(0)
	talk_change.pointback[2] = talk_change.pic[2]:AddImage(path.."friend4_hall.png",70,0,32,32)
	talk_change.num[2] = 0
	talk_change.pointnum[2] = talk_change.pointback[2]:AddFont("0",15, 0, 0, 0, 20, 20, 0xFFFFFF)
	talk_change.pic[2].script[XE_LBUP] = function()
	    if talk_change.id ==2 then
		   return
		end   
	    Initalize_talk_change()
        talk_change.pic[2].changeimage(path_setup.."biaoqian2_mail.png")
        talk_change.picWord[2].changeimage(path_setup.."font6_talk.png")	
		talk_change.id = 2	
		XTalk_rebuild_friend(2)	
	end
	talk_change.pointback[2]:SetVisible(0)
	--İ����
	talk_change.pic[3] = wnd:AddImage(path_setup.."biaoqian1_mail.png",184,54,128,64)
    talk_change.picWord[3] = talk_change.pic[3]:AddImage(path_setup.."font3_talk.png",3,0,128,64)
	talk_change.picWord[3]:SetTouchEnabled(0)
	talk_change.pointback[3] = talk_change.pic[3]:AddImage(path.."friend4_hall.png",70,0,32,32)
	talk_change.num[3]=0
	talk_change.pointnum[3] = talk_change.pointback[3]:AddFont("0",15, 0, 0, 0, 20, 20, 0xFFFFFF)
	talk_change.pic[3].script[XE_LBUP] = function()
	    if talk_change.id ==512 then
		    return
		end  
	    Initalize_talk_change()
        talk_change.pic[3].changeimage(path_setup.."biaoqian2_mail.png")
        talk_change.picWord[3].changeimage(path_setup.."font4_talk.png")	
		talk_change.id = 512	
        Talk_cleanfriend_ManageShowAll()
	end
	--������
	talk_change.pic[4] = wnd:AddImage(path_setup.."biaoqian1_mail.png",271,54,128,64)
    talk_change.picWord[4] = talk_change.pic[4]:AddImage(path_setup.."font1_talk.png",3,0,128,64)
	talk_change.picWord[4]:SetTouchEnabled(0)
	talk_change.pointback[4] = talk_change.pic[4]:AddImage(path.."friend4_hall.png",70,0,32,32)
	talk_change.num[4]=0
	talk_change.pointnum[4] = talk_change.pointback[4]:AddFont("0",15, 0, 0, 0, 20, 20, 0xFFFFFF)
	talk_change.pic[4].script[XE_LBUP] = function()
	    if talk_change.id ==256 then
		    return
		end  
	    Initalize_talk_change()
        talk_change.pic[4].changeimage(path_setup.."biaoqian2_mail.png")
        talk_change.picWord[4].changeimage(path_setup.."font2_talk.png")
        talk_change.id = 256	
        XTalk_rebuild_friend(4)		
	end
	talk_change.id = 1
end

function talk_Check_SetTalkVisible(ibool)
    if(ibool == 1 and talk_show_playerinfo_wnd:IsVisible()==false)then
	     talk_show_playerinfo_wnd:CreateResource()
         talk_show_playerinfo_wnd:SetVisible(1)
    elseif(ibool == 0 and talk_show_playerinfo_wnd:IsVisible()==true) then
         talk_show_playerinfo_wnd:SetVisible(0)
		 talk_show_playerinfo_wnd:DeleteResource()
    end	
end


function Initalize_talk_change()
    talk_change.pic[1].changeimage(path_setup.."biaoqian1_mail.png")
    talk_change.picWord[1].changeimage(path_setup.."font7_talk.png")
	talk_change.pic[2].changeimage(path_setup.."biaoqian1_mail.png")
    talk_change.picWord[2].changeimage(path_setup.."font5_talk.png")
	talk_change.pic[3].changeimage(path_setup.."biaoqian1_mail.png")
    talk_change.picWord[3].changeimage(path_setup.."font3_talk.png")
	talk_change.pic[4].changeimage(path_setup.."biaoqian1_mail.png")
    talk_change.picWord[4].changeimage(path_setup.."font1_talk.png")
end

function Init_talk_Check_Friend(wnd)
    check_friend = CreateWindow(wnd.id, 6, 128, 364, 339)
	check_friend:SetTouchEnabled(1)
	
    	-----��ʾ������
	check_sliplineback = check_friend:AddImage(path.."toggleBK_main.png",346,18,16,268)
	check_slipline = check_sliplineback:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = check_sliplineback:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = check_sliplineback:AddImage(path.."TD1_main.png",0,268,16,16)
	XSetWindowFlag(check_slipline.id,1,1,0,218)
	
	check_slipline:ToggleBehaviour(XE_ONUPDATE, 1)
	check_slipline:ToggleEvent(XE_ONUPDATE, 1)
	
	check_slipline.script[XE_ONUPDATE] = function()
	    if(#friend_ManageShow.namefont<= 8) then
		    return
		end	
		if check_slipline._T == nil then
			check_slipline._T = 0
		end
		---���ƻ�����ֻ������ֵ
		local L,T,R,B = XGetWindowClientPosition(check_slipline.id)
		if check_slipline._T ~= T then
			local length = 218/math.ceil((#friend_ManageShow.namefont/1)-8)
			local Many = math.floor(T/length)
			if Many_Equip ~= Many then
				for i,value in pairs(friend_ManageShow.namefont) do					
					local Li = friend_ManageShow.g_item_posx[i]
					local Ti = friend_ManageShow.g_item_posy[i]- Many*40
					friend_ManageShow.back[i]:SetPosition(Li, Ti )
					
					if Ti >300 or Ti <1 then
						friend_ManageShow.back[i]:SetVisible(0)
					else
						friend_ManageShow.back[i]:SetVisible(1)
					end
				end
				Many_Equip = Many
			end		
			check_slipline._T = T
		end
	end
	
	XWindowEnableAlphaTouch(g_setup_talk_ui.id)
	g_setup_talk_ui:EnableEvent(XE_MOUSEWHEEL)
	g_setup_talk_ui.script[XE_MOUSEWHEEL] = function()
		local updown  = XGetMsgParam0()
		local length = 0
		if #friend_ManageShow.namefont >8 then
			maxUpdown = math.ceil((#friend_ManageShow.namefont/1)-8)
			length = 218/maxUpdown
		else
			maxUpdown = 0
			length = 218
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
		local btn_pos = length*updownCount

		check_slipline:SetPosition(0,btn_pos)
		check_slipline._T = btn_pos
		
		if updownCount >= 0 and updownCount <= maxUpdown then
            for i,value in pairs(friend_ManageShow.namefont) do					
				local Li = friend_ManageShow.g_item_posx[i]
				local Ti = friend_ManageShow.g_item_posy[i]- updownCount*40
				friend_ManageShow.back[i]:SetPosition(Li, Ti )
					
				if Ti >300 or Ti <1 then
					friend_ManageShow.back[i]:SetVisible(0)
				else
					friend_ManageShow.back[i]:SetVisible(1)
				end
			end	
		end
	end
	
end


function XGetFriendinfoFromLuaOnline(name,strPic,friendindex,relation,Serverline,nowMap,x,y,w,h)
    local i = #allFriend_relationship.friendindex+1
	if(strPic == nil or strPic == "") then
	    allFriend_relationship.picpath[i] = nil--���ѵ�·��
	else
        allFriend_relationship.picpath[i] = "..\\"..strPic
	end 
	allFriend_relationship.friendindex[i] = friendindex--���ѵ�id
    allFriend_relationship.name[i] = name--���ѵ�����
    allFriend_relationship.relation[i] = relation--���к��ѵĹ�ϵ
    allFriend_relationship.id[i] = i--����id
	allFriend_relationship.ifOnLine[i] = 1 --�Ƿ�����
	allFriend_relationship.nowMap[i] = nowMap --��ǰ���ڵ�ͼ
    allFriend_relationship.x[i] = x
    allFriend_relationship.y[i] = y
    allFriend_relationship.w[i] = w
    allFriend_relationship.h[i] = h
end

---�˺������ڵ�����������
function XGetFriendinfoFromLua(name,strPic,friendindex,relation,Serverline,nowMap)
    local i = #allFriend_relationship.friendindex+1
	if(strPic == nil or strPic == "") then
	    allFriend_relationship.picpath[i] = "../UI/Head/summoner/zhugeliang.dds"--���ѵ�·��
	else
        allFriend_relationship.picpath[i] = "..\\"..strPic	
	end 
	allFriend_relationship.friendindex[i] = friendindex--���ѵ�id
    allFriend_relationship.name[i] = name--���ѵ�����
    allFriend_relationship.relation[i] = relation--���к��ѵĹ�ϵ
    allFriend_relationship.id[i] = i--����id
	allFriend_relationship.ifOnLine[i] = Serverline --�Ƿ�����
	allFriend_relationship.nowMap[i] = nowMap --��ǰ���ڵ�ͼ
end
---��������--
function SetTalk_Friend_Num(relation)
    if(relation == 1) then--��ϵΪ���� ��ǰ����Ϊ����
	    talk_change.num[1] = talk_change.num[1]+1
	end
	if(relation == 512) then--��ϵΪİ���� ��ǰ����Ϊİ����
	    talk_change.num[2] = talk_change.num[2]+1
	end
	if(relation == 256) then--��ϵΪ������ ��ǰ����Ϊ������
	    talk_change.num[4] = talk_change.num[4]+1
	end
end

function SetTalk_Friend_fontNum(i,j,k)
    talk_change.pointnum[1]:SetFontText(i)
	if(i == 0 and talk_change.pointback[1]:IsVisible()) then
	    talk_change.pointback[1]:SetVisible(0)
	elseif(i > 0 and talk_change.pointback[1]:IsVisible() == false) then
        talk_change.pointback[1]:SetVisible(1)	
	end
	talk_change.pointnum[2]:SetFontText(j)
	if(j == 0 and talk_change.pointback[2]:IsVisible()) then
	    talk_change.pointback[2]:SetVisible(0)
	elseif(j > 0 and talk_change.pointback[2]:IsVisible() == false) then
        talk_change.pointback[2]:SetVisible(1)	
	end
    talk_change.pointback[3]:SetVisible(0)	
	talk_change.pointnum[4]:SetFontText(k)
	if(k == 0 and talk_change.pointback[4]:IsVisible()) then
	    talk_change.pointback[4]:SetVisible(0)
	elseif(k > 0 and talk_change.pointback[4]:IsVisible() == false) then
        talk_change.pointback[4]:SetVisible(1)	
	end
end

--����һ��������ʾ--
function Talk_create_one_Friend(relation,id)
    local index = #friend_ManageShow.namefont+1
	friend_ManageShow.g_item_posx[index] = 5
    friend_ManageShow.g_item_posy[index] = 5+(index-1)*40
	if(friend_ManageShow.back[index]~=nil or friend_ManageShow.back[index]~=nil or friend_ManageShow.back[index]~=nil) then
	    return
	end	  
	---�ȴ�����ͼ--
	friend_ManageShow.back[index] = check_friend:AddImage(path_setup.."youjiandiban3_mail.png",5,5+(index-1)*40,334,39)--��ͼ
	if(index>8) then
	    friend_ManageShow.back[index]:SetVisible(0)
	end
	---������������---
	friend_ManageShow.namefont[index] = friend_ManageShow.back[index]:AddFont(allFriend_relationship.name[id],12, 0, 70, 3, 200, 20, 0x82d2e6)--��������
	friend_ManageShow.headPic[index] = friend_ManageShow.back[index]:AddImage(allFriend_relationship.picpath[id],21,2,35,35)	--ͼƬ·��--����ͷ��
	friend_ManageShow.headPic[index]:SetTouchEnabled(0)
	local headBlock = friend_ManageShow.headPic[index]:AddImage(path.."headSide1_hall.png",0,0,35,35)
	headBlock:SetTouchEnabled(0)
	local friendAtMap = Talk_getLocalMap(id)--ͨ��id�ҵ���ǰ��������ڵ�ͼ�ĵ���ֵ
	friend_ManageShow.battlePlace[index] = friend_ManageShow.back[index]:AddFont(map.name[friendAtMap],12, 0, 70, 20, 200, 20, 0x82d2e6)
	friend_ManageShow.id[index] = id
	friend_ManageShow.checkback[index] = friend_ManageShow.back[index]:AddImage(path_setup.."youjiandiban4_mail.png",0,0,334,39)--ѡ�п�
	friend_ManageShow.checkback[index]:SetVisible(0)
	
	friend_ManageShow.talkbtn[index] = friend_ManageShow.back[index]:AddButton(path_setup.."popback1_setup.png",path_setup.."popback2_setup.png",path_setup.."popback1_setup.png",230,3,32,32)
	friend_ManageShow.black[index] = friend_ManageShow.back[index]:AddImage(path_setup.."youjiandibanblack_mail.png",0,0,334,39)
	if(allFriend_relationship.ifOnLine[index] == 1 and allFriend_relationship.relation[index] ~= 256 ) then
	    friend_ManageShow.talkbtn[index].script[XE_LBUP] = function()
			XID_BUTTON_ChatHim(index)
			if XGetMapId()==1 then
				ReturnToGameHall()
			end
        end	
	else
	    friend_ManageShow.talkbtn[index]:SetTouchEnabled(0)
	end
	
	if(allFriend_relationship.ifOnLine[index] == 1) then
	    friend_ManageShow.black[index]:SetVisible(0)
	end
	
	
	friend_ManageShow.Deletebtn[index] = friend_ManageShow.back[index]:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",280,2,35,35)
	friend_ManageShow.Deletebtn[index].script[XE_LBUP] = function()
		XID_BUTTON_DeleteHim(index)
    end	
	
	
	friend_ManageShow.back[index].script[XE_RBUP] = function()
	    if(allFriend_relationship.ifOnLine[index] == 1 and allFriend_relationship.relation[index] ~= 256 ) then
			XID_BUTTON_infoClick(index)
        end	
	end
	
	friend_ManageShow.back[index].script[XE_ONHOVER] = function()
		if friend_ManageShow.checkback[index]:IsVisible() == false then
		    talk_cleanAll_check_back()
			friend_ManageShow.checkback[index]:SetVisible(1)
		end
	end
	
	friend_ManageShow.back[index].script[XE_ONUNHOVER] = function()
		if friend_ManageShow.checkback[index]:IsVisible() == true then
			friend_ManageShow.checkback[index]:SetVisible(0)
		end
	end
end

---������ѡ�п�����--
function talk_cleanAll_check_back()
    for index,value in pairs(friend_ManageShow.checkback) do
        friend_ManageShow.checkback[index]:SetVisible(0)
	end	
end





---��պ�����ʾ--
function Talk_cleanfriend_ManageShowAll()
    friend_ManageShow.ifvip = {}
    friend_ManageShow.id = {}
    friend_ManageShow.g_item_posx = {}
    friend_ManageShow.g_item_posy = {}
	local index = #friend_ManageShow.back
	if(index<1) then
	   return
	end
	local mendex = 1	
	while(friend_ManageShow.back[mendex]~=nil) do
	    friend_ManageShow.namefont[mendex]:Release()
		friend_ManageShow.headPic[mendex]:Release()
		friend_ManageShow.battlePlace[mendex]:Release()
		friend_ManageShow.checkback[mendex]:Release()
		friend_ManageShow.talkbtn[mendex]:Release()
		friend_ManageShow.back[mendex]:Release()
		friend_ManageShow.black[mendex]:Release()
		mendex = mendex+1
	end	
	friend_ManageShow.namefont = {}
    friend_ManageShow.headPic = {}
	friend_ManageShow.back = {}
	friend_ManageShow.battlePlace = {}
	friend_ManageShow.checkback = {}
	friend_ManageShow.talkbtn = {}
	friend_ManageShow.black = {}
	talk_Check_SetTalkVisible(0)
	
end
--��������ϵ��--
function Talk_cleanAll()
    allFriend_relationship.friendindex = {}--���ѵ�id
    allFriend_relationship.picpath = {}--���ѵ�·��
    allFriend_relationship.name = {}--���ѵ�����
    allFriend_relationship.relation = {}--���к��ѵĹ�ϵ
    allFriend_relationship.id = {}--����id
    allFriend_relationship.ifOnLine = {} --�Ƿ�����
    allFriend_relationship.level = {} --��ҵȼ�
	allFriend_relationship.orglevel = {}
    allFriend_relationship.nowMap = {} --��ǰ���ڵ�ͼ
    allFriend_relationship.friendship = {} --��Һ��Ѷ�
	allFriend_relationship.x = {}
    allFriend_relationship.y = {}
    allFriend_relationship.w = {}
    allFriend_relationship.h = {}
end

--������ʱ��պ�����Ϣ�����µ���Ϣ---
function Talk_rebuild_friend_ManageShow()
    Talk_cleanfriend_ManageShowAll()
	talk_change.num[1] = 0
	talk_change.num[2] = 0
	talk_change.num[3] = 0
	talk_change.num[4] = 0
    for index,value in pairs(allFriend_relationship.friendindex) do
	    Talk_create_one_Friend(allFriend_relationship.relation[index],index)
	end
	if(#friend_ManageShow.namefont> 8) then
	    check_sliplineback:SetVisible(1)
	else
	    check_sliplineback:SetVisible(0)
	end
end

function Talk_getLocalMap(index)
    for i,value in pairs(map.name) do--��ǰ������ڵ�ͼ��map���ܱ��ҵ�
	    if(allFriend_relationship.nowMap[index] == map.num[i]) then
		    return i
		end		
    end
	return 1
end
--�����������--
function talk_cleanEveryThing()
    Talk_cleanfriend_ManageShowAll()
	Talk_cleanAll()
	talk_Check_SetTalkVisible(0)
	for index =1,4 do
	    talk_change.num[index] = 0
	    talk_change.pointnum[index]:SetFontText(""..talk_change.num[index])
	end
end


function SetTalkIsVisible(flag) 
	if g_setup_talk_ui ~= nil then
		if flag == 1 and g_setup_talk_ui:IsVisible() == false then
			g_setup_talk_ui:CreateResource()
			g_setup_talk_ui:SetVisible(1)
			Initalize_talk_change()
            talk_change.pic[1].changeimage(path_setup.."biaoqian2_mail.png")
            talk_change.picWord[1].changeimage(path_setup.."font8_talk.png")	
	    	talk_change.id = 1	
		    XlneedAllFriendInfo(1)
		    talk_Check_SetTalkVisible(0)	
		elseif flag == 0 and g_setup_talk_ui:IsVisible() == true then
			g_setup_talk_ui:DeleteResource()
			g_setup_talk_ui:SetVisible(0)		
            XlneedAllFriendInfo(0)	
			updownCount = 0
			maxUpdown = 0
            check_slipline:SetPosition(0,0)
			check_slipline._T = 0			
            talk_Check_SetTalkVisible(0)			
		end
	end
end

function GetTalkIsVisible()  
    if(g_setup_talk_ui:IsVisible()) then
       XTalkIsOpen(1)
    else
       XTalkIsOpen(0)
    end
end