include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

----selectarenamode����
local btn_close = nil
local btn_Enter = {}

local room_number = {}
local room_name = {}
local room_password = {}
local room_mapid = {}
local room_mode = {}
local room_people ={}

local btn_showall = nil
local btn_wait = nil
local btn_refresh = nil
local btn_find = nil
local btn_create = nil

local middle = nil	-- �м��ҳ��

---------ͨ�Ŵ���
local RoomInfo = {}
RoomInfo.name = {}
RoomInfo.password = {}
RoomInfo.mapid = {}
RoomInfo.mode = {}
RoomInfo.people = {}
RoomInfo.roomid = {}

function InitRoomList_ui(wnd,bisopen)
	n_roomlist_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMain_RoomList(n_roomlist_ui)
	n_roomlist_ui:SetVisible(bisopen)
end

function InitMain_RoomList(wnd)
	local BBK = wnd:AddImage(path_shop.."BK_shop.png",0,0,1280,800)
	btn_close = BBK:AddButton(path_shop.."close1_rec.png",path_shop.."close2_rec.png",path_shop.."close3_rec.png",1235,10,35,35)
	btn_close.script[XE_LBUP] = function()
		XClickPlaySound(5)
		---�رս���
		XClickRoomListIndex(0)
	end
	local head = BBK:AddImage(path_mode.."roomlisthead_mode.png",484, 0, 312, 62)
	head:AddFont("�����б�", 18, 8, 0, 0, 312, 56, 0xffffff)
	BBK:AddImage(path_mode.."roomlist_mode.png",65, 74, 1078, 623)
	
	for i=1,12 do		
		room_password[i] = BBK:AddImage(path_setup.."lock_setup.png",516,56+50*i,32,32)
		
		btn_Enter[i] = BBK:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",1166,54+50*i,83,35)
		btn_Enter[i]:AddFont("����", 15, 8, 0, 0, 83, 35, 0x95f9fd)
		btn_Enter[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			------���뷿��
			XClickRoomListEnter(i-1,RoomInfo.roomid[i])
			ClearRoomChat()
		end
	end
	------��ʾȫ��
	btn_showall = BBK:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",69,720,83,35)
	btn_showall:AddFont("��ʾȫ��", 15, 8, 0, 0, 83, 35, 0xffffff)
	btn_showall:SetEnabled(0)
	btn_showall.script[XE_LBUP] = function()
		XClickPlaySound(5)
		------ȫ������
		XClickRoomListIndex(2)
	end
	------��ʾ�ȴ�
	btn_wait = BBK:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",164,720,83,35)
	btn_wait:AddFont("��ʾ�ȴ�", 15, 8, 0, 0, 83, 35, 0xffffff)
	btn_wait:SetEnabled(0)
	btn_wait.script[XE_LBUP] = function()
		XClickPlaySound(5)
		------�ȴ�����
		XClickRoomListIndex(3)
	end
	------ˢ���б�
	btn_refresh = BBK:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",259,720,83,35)
	btn_refresh:AddFont("ˢ���б�", 15, 8, 0, 0, 83, 35, 0xffffff)
	btn_refresh.script[XE_LBUP] = function()
		XClickPlaySound(5)
		------ˢ�·���
		XClickRoomListIndex(4)
	end
	------���ҷ���
	btn_find = BBK:AddButton(path_setup.."buy1_setup.png", path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",354,720,83,35)
	btn_find:AddFont("���ҷ���", 15, 8, 0, 0, 83, 35, 0xffffff)
	btn_find.script[XE_LBUP] = function()
		XClickPlaySound(5)
		------���ҷ���
		XClickRoomListIndex(5)
	end
	------��������
	btn_create = BBK:AddButton(path_start.."readyEnter1_start.png",path_start.."readyEnter2_start.png",path_start.."readyEnter3_start.png",972,718,179,56)
	btn_create:AddFont("��������", 18, 8, 0, 0, 179, 56, 0xffffff)
	btn_create.script[XE_LBUP] = function()
		XClickPlaySound(5)
		------��������
		XClickRoomListIndex(1)
		ClearRoomChat()
	end
	
	for i=1,12 do
		room_number[i] = BBK:AddFont(i, 15, 0, 115, 63+50*i, 200, 20, 0xffffff)
		room_name[i] = BBK:AddFont("����"..i, 15, 0, 280, 63+50*i, 200, 20, 0xffffff)
		room_mapid[i] = BBK:AddFont("��ͼ��"..i, 15, 0, 690, 63+50*i, 200, 20, 0xffffff)
		room_mode[i] = BBK:AddFont("����ģʽ"..i, 15, 0, 910, 63+50*i, 200, 20, 0xffffff)
		room_people[i] = BBK:AddFont("��������"..i, 15, 0, 1060,63+50*i, 200, 20, 0xffffff)
	end
	
	--���ҷ�ҳ
	local left = BBK:AddButton(path_mode.."roomlistpage1_mode.png",path_mode.."roomlistpage2_mode.png",path_mode.."roomlistpage1_mode.png", 550, 720, 70, 30)
	left:AddFont("��һҳ", 15, 8, 0, 0, 70, 30, 0xffffffff)
	local right = BBK:AddButton(path_mode.."roomlistpage1_mode.png",path_mode.."roomlistpage2_mode.png",path_mode.."roomlistpage1_mode.png", 700, 720, 70, 30)
	right:AddFont("��һҳ", 15, 8, 0, 0, 70, 30, 0xffffffff)
	local AAAA = BBK:AddImage(path_mode.."roomlistpage1_mode.png", 625, 720, 70, 30)
	middle = AAAA:AddFont("1/1", 15, 8, 0, 0, 70, 30, 0xffffffff)
	
	left.script[XE_LBUP] = function()
		XClickPlaySound(5)
		
		--��һҳ
		XClickRoomListIndex(6)
	end
	
	right.script[XE_LBUP] = function()
		XClickPlaySound(5)
		
		--��һҳ
		XClickRoomListIndex(7)
	end
end


----------ͨ�ŷ����б�
function Clear_RoomList()
	RoomInfo = {}
	RoomInfo.name = {}
	RoomInfo.password = {}
	RoomInfo.mapid = {}
	RoomInfo.mode = {}
	RoomInfo.people = {}
	RoomInfo.roomid = {}

	for i,v in pairs(room_number) do
		room_number[i]:SetVisible(0)
		room_name[i]:SetVisible(0)
		room_password[i]:SetVisible(0)
		room_mapid[i]:SetVisible(0)
		room_mode[i]:SetVisible(0)
		room_people[i]:SetVisible(0)
		btn_Enter[i]:SetVisible(0)
	end
end
function SendData_RoomList(name,mapid,mode,currentPeople,maxPeople,password,id)
	local size = #RoomInfo.name+1
	RoomInfo.name[size] = name
	RoomInfo.password[size] = password
	RoomInfo.mapid[size] = mapid
	RoomInfo.mode[size] = mode
	RoomInfo.people[size] = currentPeople.."/"..maxPeople
	RoomInfo.roomid[size] = id
	
	room_number[size]:SetFontText(id,0xffffff)
	room_name[size]:SetFontText(name,0xffffff)
	room_mapid[size]:SetFontText(mapid,0xffffff)
	room_mode[size]:SetFontText(mode,0xffffff)
	room_people[size]:SetFontText(RoomInfo.people[size],0xffffff)
	
	room_number[size]:SetVisible(1)
	room_name[size]:SetVisible(1)
	room_mapid[size]:SetVisible(1)
	room_mode[size]:SetVisible(1)
	room_people[size]:SetVisible(1)
	btn_Enter[size]:SetVisible(1)
	
	if password>0 then
		room_password[size]:SetVisible(1)
	else
		room_password[size]:SetVisible(0)
	end	
end

-- ���ҷ�ҳҳ��
function PageOf_RoomList(page)
	middle:SetFontText(page,0xffffffff)
end

-- �Ƿ���ʾ
function SetRoomListIsVisible(flag) 
	if n_roomlist_ui ~= nil then
		if flag == 1 and n_roomlist_ui:IsVisible() == false then
			n_roomlist_ui:CreateResource()
			n_roomlist_ui:SetVisible(1)
		elseif flag == 0 and n_roomlist_ui:IsVisible() == true then
			n_roomlist_ui:DeleteResource()
			n_roomlist_ui:SetVisible(0)
		end
	end
end

function GetRoomListIsVisible()  
    if n_roomlist_ui ~=nil and n_roomlist_ui:IsVisible()==true then
       return 1
    else
       return 0
    end
end