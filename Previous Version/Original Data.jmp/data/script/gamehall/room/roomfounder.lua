include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

----selectarenamode����

local RoomHost = nil
local RoomID = nil
local RoomName = nil
local EnterBK = {}
local EnterSideBK = {}
local playerHead = {}
local playerKick = {}

local playerName = {}
local playerLevel = {}
local playerWinPercent = {}
local watcher = {}
local watcherName = {}

local btn_watchgame = nil
local btn_changeside,font_changeside = nil
local btn_start = nil
local btn_close = nil

-- ����ģʽ   1������  0��������
local RandomSide,RandomSideFont = nil
local RandomSideFontList = {"����ģʽ","����ģʽ"}
local RandomMode = 0

function InitRoomFounder_ui(wnd,bisopen)
	n_roomfounder_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMain_RoomFounder(n_roomfounder_ui)
	n_roomfounder_ui:SetVisible(bisopen)
end

function InitMain_RoomFounder(wnd)
	local BBK = wnd:AddImage(path_shop.."BK_shop.png",0,0,1280,800)
	local AA = BBK:AddImage(path_mode.."roomlisthead_mode.png",484, 0, 312, 62)
	RoomID = AA:AddFont("11", 15, 8, 0, 0, 312, 30, 0xffffff)
	RoomName = AA:AddFont("���˼ҵķ���", 18, 8, 0, 0, 312, 70, 0xffffff)
	
	for i=1,14 do
		local k = (i-1)%7+1
		local posx = 40
		if i>7 then
			posx = 948 
		end
		
		EnterBK[i] = wnd:AddImage(path_mode.."roomEnterBK_mode.png",posx,95*k-20,292,90)
		
		playerHead[i] = EnterBK[i]:AddImage(path_equip.."bag_equip.png",10,11,70,70)
		EnterSideBK[i] = EnterBK[i]:AddImage(path_mode.."EnterSide_mode.png",10,11,70,70)
		playerKick[i] = EnterBK[i]:AddButton(path_mode.."addfriend1_hero.png",path_mode.."addfriend2_hero.png",path_mode.."addfriend3_hero.png",220,10,64,32)

		playerKick[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			
			XClickRoomFounderKickIndex(i-1)		
		end
	end
	------�۲���
	for i=1,4 do
		watcher[i] = wnd:AddImage(path_equip.."bag_equip.png",263+130*i,100,100,100)
		watcherName[i] = watcher[i]:AddFont("�۲��߶���", 15, 8, 0, 70, 100, 100, 0x7f94fd)
		watcher[i]:AddImage(path_info.."sumside1_info.png",-3,-3,106,106)
	end
	
	-- ����ģʽ
	RandomSide = BBK:AddButton(path_mode.."addAllFriend1_mode.png",path_mode.."addAllFriend2_mode.png",path_mode.."addAllFriend1_mode.png",570,200,144,39)
	RandomSideFont = RandomSide:AddFont("����ģʽ", 12, 8, 0, 0, 144, 39, 0xffffff)
	RandomSide.script[XE_LBUP] = function()
		XClickPlaySound(5)
		RandomMode = RandomMode+1
		RandomSideFont:SetFontText(RandomSideFontList[RandomMode%2+1],0xffffff)
		XClickRoomFounderRandomMode(RandomMode%2)		
	end
	-- �۲�ģʽ
	btn_watchgame = BBK:AddButton(path_mode.."addAllFriend1_mode.png",path_mode.."addAllFriend2_mode.png",path_mode.."addAllFriend3_mode.png",570,240,144,39)
	btn_watchgame:AddFont("�۲�ģʽ", 12, 8, 0, 0, 144, 39, 0xffffff)
	btn_watchgame.script[XE_LBUP] = function()
		XClickPlaySound(5)
		---XClickRoomFounderIndex(2)		
	end
	-- ������Ӫ
	btn_changeside = BBK:AddButton(path_mode.."addAllFriend1_mode.png",path_mode.."addAllFriend2_mode.png",path_mode.."addAllFriend3_mode.png",570,280,144,39)
	btn_changeside:AddFont("������Ӫ", 12, 8, 0, 0, 144, 39, 0xffffff)
	btn_changeside.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XClickRoomFounderIndex(2)		
	end
	------��ʼ
	btn_start = BBK:AddButton(path_start.."readyEnter1_start.png",path_start.."readyEnter2_start.png",path_start.."readyEnter3_start.png",708,350,179,56)
	btn_start:AddFont("��ʼ", 18, 8, 0, 0, 179, 56, 0xffffff)
	btn_start.script[XE_LBUP] = function()
		XClickPlaySound(5)		
		XClickRoomFounderIndex(1)
		ClearRoomChat()
	end
	------�ر�
	btn_close = BBK:AddButton(path.."button1_hall.png",path.."button2_hall.png",path.."button3_hall.png",400,350,179,56)
	btn_close:AddFont("�ر�", 18, 8, 0, 0, 179, 56, 0xffffff)
	btn_close.script[XE_LBUP] = function()
		XClickPlaySound(5)	
		XClickRoomFounderIndex(0)
		ClearRoomChat()
	end
	for i=1,14 do
		local k = (i-1)%7+1
		local posx = 140
		if i>7 then
			posx = 1048 
		end
		playerName[i] = wnd:AddFont("�������", 15, 0, posx, 95*k-10, 200, 20, 0x7f94fd)
		playerLevel[i] = playerName[i]:AddFont("�ȼ���40", 15, 0, 0, 25, 200, 20, 0x7f94fd)
		playerWinPercent[i] = playerName[i]:AddFont("ʤ����15/40", 15, 0, 0, 50, 200, 20, 0x7f94fd)
		playerKick[i]:AddFont("�߳�", 15, 8, 0, 0, 64, 28, 0xffffff)
	end
	
	RoomHost = wnd:AddImage(path_mode.."roomFounder_mode.png",0,0,49,73)
	
	InitRoomChat(wnd)
end


--��ʼ��ť�ɼ����
function StartVisible_RoonFounder(flag)
	btn_start:SetEnabled(flag)
	RandomSide:SetEnabled(flag)
end
-- �߳���ť
function PlayerKick_RoonFounder(index,flag)
	playerKick[index]:SetVisible(flag)
end

--������־
function RoomFounder_host(index)
	if index>6 then 
		posx = 1178
	else
		posx = 270
	end
	RoomHost:SetPosition(posx,95*(index%7)+70)
end
--�Լ���λ��
function RoomFounder_Myself(index)
	for i,v in pairs(EnterBK) do
		if i ~= index then
			EnterBK[i].changeimage(path_mode.."roomEnterBK_mode.png")
			EnterSideBK[i].changeimage(path_mode.."EnterSide_mode.png")
		else
			EnterBK[i].changeimage(path_mode.."roomEnterBKMe_mode.png")
			EnterSideBK[i].changeimage(path_mode.."EnterSideMe_mode.png")
		end
	end	
end

--��������Ա
function ClearIndex_RoomFounder(index)
	playerHead[index+1]:SetVisible(0)
	playerName[index+1]:SetVisible(0)
end
--����ķ����Ա
function SendData_RoomFounder(index,strPictureName,strName,level,winPercent)
	playerHead[index+1].changeimage("..\\"..strPictureName)
	playerName[index+1]:SetFontText(strName,0x7f94fd)
	playerLevel[index+1]:SetFontText("�ȼ���"..level,0x7f94fd)
	playerWinPercent[index+1]:SetFontText("ʤ����"..winPercent,0x7f94fd)
	
	playerHead[index+1]:SetVisible(1)
	playerName[index+1]:SetVisible(1)
end

----��������
function RoomName_Founder(ID,name)
	RoomName:SetFontText(name,0xffffff)
	RoomID:SetFontText("�����ţ�" .. ID,0xffffff)
end








function SetRoomFounderIsVisible(flag) 
	if n_roomfounder_ui ~= nil then
		if flag == 1 and n_roomfounder_ui:IsVisible() == false then
			n_roomfounder_ui:CreateResource()
			n_roomfounder_ui:SetVisible(1)
		elseif flag == 0 and n_roomfounder_ui:IsVisible() == true then
			n_roomfounder_ui:DeleteResource()
			n_roomfounder_ui:SetVisible(0)
		end
	end
end

function GetRoomFounderIsVisible()  
    if n_roomfounder_ui ~=nil and n_roomfounder_ui:IsVisible()==true then
		return 1
    else
        return 0
    end
end