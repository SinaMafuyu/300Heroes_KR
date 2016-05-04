include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local check_A = nil --��
local check_1 =nil --��
local check_2 =nil --��

--check_A--
local eight_Button = {}
local eight_button_font = {"�ȼ�����","��������","ս������","��������","��������","��������","��������","��������"}
local eight_Font = {}
local check_A_RArrow = nil
local buttonExtaimage = nil
--check_1--
local day = 7
local hour = 23
local minute = 59
local second = 59
local countdown_font = "�����ʱ�� "..day.."��"..hour.."Сʱ"..minute.."��"..second.."��"
local countdown_detail_font = "�ٻ�ʦ�ȼ�ǰ100��Ӯ�ý���"
local ranking_count_award = {7,5,5,5,5}
local award_one = {}
local award_two = {}
local award_three = {}
local award_four = {}
local award_five = {}
local award_block = {award_one,award_two,award_three,award_four,award_five}
local promote_button = nil
local name = {"��λ�Դ�","��λ�Դ�","��λ�Դ�","��λ�Դ�","��λ�Դ�"}
local nameword = {"["..name[1].."]","["..name[2].."]","["..name[3].."]","["..name[4].."]","["..name[5].."]"}
local first = {}
local second = {}
local third = {}
local forth = {}
local fifth = {}
local awardPic = {first,second,third,forth,fifth}

--check_2--
local titleFont_1 = "��ѽ��� �����ǻ�����"
local titleFont_2 = "�ٻ�ʦ�ȼ�ǰ100��Ӯ�ý���"
local name = "��������߸���"
local winnerName = {} --�õ����������--
local checkMsgButton = nil









function InitTask_newserverUI(wnd, bisopen)
	g_task_newserver_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainTask_newserver(g_task_newserver_ui)
	g_task_newserver_ui:SetVisible(bisopen)
end
function InitMainTask_newserver(wnd)
	--����check���е�--
	check_A = wnd:AddImage(path_task.."BK_task.png",130,137,1000,584)
	InitCheck_A(check_A)
	--����»���---
	check_1 = CreateWindow(wnd.id, 400, 140, 985, 575)
	newsever_InitCheck_1(check_1)
	check_1:SetVisible(1)
	check_2 = CreateWindow(wnd.id, 400, 140, 985, 575)
	newsever_InitCheck_2(check_2)
	check_2:SetVisible(0)
end
function newsever_InitCheck_1(wnd)
	--�������--
	wnd:AddFont(countdown_font,15, 0, 20, 80, 250, 20, 0x7f94cd)
	wnd:AddFont(countdown_detail_font,15, 0, 20, 105, 200, 20, 0x7f94cd)
	--�������--
	wnd:AddImage(path_task.."rank1_task.png",33,155,128,32)--��һ��
	wnd:AddImage(path_task.."rank2-3_task.png",33,235,128,32)--2-3
	wnd:AddImage(path_task.."rank4-10_task.png",33,315,128,32)--4-10
	wnd:AddImage(path_task.."rank11-50_task.png",33,395,128,32)--11-50
	wnd:AddImage(path_task.."rank51-100_task.png",33,475,128,32)--51-100
	--��ӷ�����--
	for index = 1,6 do
        wnd:AddImage(path_task.."partition_sign.png",40,132+(index-1)*80,621,2)
	end
	--��ӽ�����--
	for y = 1,5 do
	    for x =1,ranking_count_award[y] do
		    awardPic[y][x] = wnd:AddImage(path_equip.."bag_equip.png",205+(x-1)*65,148+(y-1)*80,50,50)
		    award_block[y][x] = wnd:AddImage(path_shop.."iconside_shop.png",205+(x-1)*65-2,148+(y-1)*80-2,54,54)			
		end
	end
	---����---
	wnd:AddImage(path_task.."cup_task.png",485,80,64,64)
	promote_button = wnd:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",550,90,100,32)
	promote_button:AddFont("�ȼ�����",15, 8, 0, 0, 100, 32, 0xbcbcc4)
	for index = 1,5 do
		wnd:AddFont(nameword[index],15,0,45,100+80*index,100,20,0xbcbcc4)
	end
end

function newsever_InitCheck_2(wnd)
    --��ӱ���--
   	wnd:AddFont(titleFont_1,15, 0, 20, 80, 200, 20, 0x7f94cd)
	wnd:AddFont(titleFont_2,15, 0, 20, 105, 200, 20, 0x7f94cd)
	--�������--
	wnd:AddImage(path_task.."A1_task.png",125,140,128,64)--��1��
	wnd:AddImage(path_task.."A2_task.png",317,140,128,64)--��2��
	wnd:AddImage(path_task.."A3_task.png",520,140,128,64)--��3��
	wnd:AddImage(path_task.."A4_task.png",33,220,64,16)--��4��
	wnd:AddImage(path_task.."A5_task.png",133,220,64,16)--��5��
	wnd:AddImage(path_task.."A6_task.png",233,220,64,16)--��6��
	wnd:AddImage(path_task.."A7_task.png",333,220,64,16)--��7��
	wnd:AddImage(path_task.."A8_task.png",433,220,64,16)--��8��
	wnd:AddImage(path_task.."A9_task.png",533,220,64,16)--��9��
	wnd:AddImage(path_task.."A10_task.png",633,220,64,16)--��10��
	wnd:AddImage(path_task.."A11_task.png",315,290,128,16)--��11-50��
	wnd:AddImage(path_task.."A12_task.png",315,408,128,16)--��51-100��
	--���÷�����--
	wnd:AddImage(path_task.."lightlineshort_task.png",165,134,512,2)
	wnd:AddImage(path_task.."lightlineshort_task.png",165,202,512,2)
	wnd:AddImage(path_task.."lightlineshort_task.png",165,273,512,2)
	wnd:AddImage(path_task.."lightlineshort_task.png",165,390,512,2)
	
	for index = 1,3 do
	    winnerName[index] = wnd:AddFont(name,15,0,105+(index-1)*202,172,150,20,0xbcbcc4)
	end
	for index = 4,10 do
	    winnerName[index] = wnd:AddFont(name,12,0,10+(index-4)*101,244,100,15,0xbcbcc4)
	end
	for index = 11,50 do --װ��
	    local PosX = (index-11)%8*87+10
		local PosY = math.floor((index-11)/8)
		PosY = PosY*17+303
	    winnerName[index] = wnd:AddFont(name,12,0,PosX,PosY,100,15,0xbcbcc4)
	end	
	for index = 51,100 do --װ��
	    local PosX = (index-51)%8*87+10
		local PosY = math.floor((index-51)/8)
		PosY = PosY*17+420
	    winnerName[index] = wnd:AddFont(name,12,0,PosX,PosY,100,15,0xbcbcc4)
	end	
	--��Ӱ���
	checkMsgButton = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",555,90,128,32)
	checkMsgButton:AddFont("�鿴�ʼ�",15, 0, 22, 3, 100, 20, 0xbcbcc4)
end
function InitCheck_A(wnd)
	--��ӱ����--
	wnd:AddImage(path_task.."newServer_task.png",455,28,128,32)--�·����
	wnd:AddImage(path_task.."allhappy_task.png",520,90,256,32)--�·���� ȫ���
	check_A_RArrow = wnd:AddImage(path_info.."R2_info.png",240,76,27,36)
	
    --���8��button
    for index = 1,8 do
	    local x = 66 + (index-1)*57
	    eight_Button[index] = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",33,x,256,64)
		eight_Button[index].script[XE_LBUP] = function()
		    XClickPlaySound(5)
		    check_A_RArrow:SetPosition(240,76+(index-1)*57)
			buttonExtaimage:SetPosition(33,x)
		end
	end
	buttonExtaimage = wnd:AddImage(path_equip.."check3_equip.png",33,66,256,64)
	for index = 1,8 do
	    local x = 87 + (index-1)*57
	    eight_Font[index] = wnd:AddFont(eight_button_font[index],15, 0, 95, x, 100, 20, 0xbcbcc4)
	end
end



function SetTask_newserverIsVisible(flag) 
	if g_task_newserver_ui ~= nil then
		if flag == 1 and g_task_newserver_ui:IsVisible() == false then
			g_task_newserver_ui:SetVisible(1)
			
			check_A_RArrow:SetPosition(240,76)
			buttonExtaimage:SetPosition(33,66)
		elseif flag == 0 and g_task_newserver_ui:IsVisible() == true then
			g_task_newserver_ui:SetVisible(0)
		end
	end
end

function GetTask_newserverIsVisible()  
    if g_task_newserver_ui ~= nil and g_task_newserver_ui:IsVisible()  then
       return 1
    else
       return 0
    end
end