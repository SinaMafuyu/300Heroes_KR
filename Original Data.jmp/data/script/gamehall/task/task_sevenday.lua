include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local Click_btn = nil
local Click_dirR = nil

local checkA = nil				-- ��һ��
local checkB = nil				-- �ڶ���
local checkC = nil				-- ������
local checkD = nil				-- ������
local checkE = nil				-- ������
local checkF = nil				-- ������
local checkG = nil				-- ������

local TaskCount = nil			-- ��������

local img_Head = {}				-- ͼƬ����
local img_HeadFrame = {}		-- ��
local img_Icon = {}				-- ͼ��
local str_IconPath = {}			-- ͼƬ·��

local TaskItemList = {}			-- �������б�
TaskItemList.Name = {}			-- ��������
TaskItemList.AllCount = {}		-- �������
TaskItemList.CurCount = {}		-- ��ǰ�����
TaskItemList.Pos_Y = {}			-- Y����
TaskItemList.Pos_X = {}			-- X����
TaskItemList.Info = {}			-- ��������
TaskItemList.IsComplete = {}	-- �Ƿ����
TaskItemList.IsGet = {}			-- �Ƿ���ȡ

local TaskInfo = {}				-- �����������
TaskInfo.TaskName = {}			-- ��������
TaskInfo.TaskInfo = {}			-- �����������
TaskInfo.CompletedSchedule = {}	-- һ�������Ѿ���ɵĽ���
TaskInfo.AllSchedule = {}		-- ���������

local TaskAllCount = 0			-- �����ܸ���
local img_NotComplete = {}		-- δ���
local img_Complete = {}			-- ���
local btn_Get = {}				-- ��ȡ

function InitTask_sevendayUI(wnd, bisopen)
	g_task_sevenday_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainTask_sevenday(g_task_sevenday_ui)
	g_task_sevenday_ui:SetVisible(bisopen)
end
function InitMainTask_sevenday(wnd)
	wnd:AddImage(path_task.."BK_task.png",130,137,1000,584)
	wnd:AddImage(path_task.."Title_task.png",585,165,128,32)
	
	

	checkA = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,203,256,64)
	checkA.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,203)
		Click_dirR:SetPosition(370,213)
		
		SetTaskIsComplete()
	end
	
	checkB = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,260,256,64)
	checkB.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,260)
		Click_dirR:SetPosition(370,270)
	end
	
	checkC = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,317,256,64)
	checkC.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,317)
		Click_dirR:SetPosition(370,327)
	end
	
	checkD = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,374,256,64)
	checkD.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,374)
		Click_dirR:SetPosition(370,384)
	end
	
	checkE = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,431,256,64)
	checkE.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,431)
		Click_dirR:SetPosition(370,441)
	end
	
	checkF = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,488,256,64)
	checkF.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,488)
		Click_dirR:SetPosition(370,498)
	end
	
	checkG = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,545,256,64)
	checkG.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,545)
		Click_dirR:SetPosition(370,555)
	end
	Click_btn = wnd:AddImage(path_equip.."check3_equip.png",163,203,256,64)
	Click_dirR = wnd:AddImage(path_info.."R2_info.png",370,213,27,36)
	
	wnd:AddFont("��һ��",15, 0, 225, 224, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 224, 100, 20, 0xbcbcc4)
	wnd:AddFont("�ڶ���",15, 0, 225, 281, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 281, 100, 20, 0xbcbcc4)
	wnd:AddFont("������",15, 0, 225, 338, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 338, 100, 20, 0xbcbcc4)
	wnd:AddFont("������",15, 0, 225, 395, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 395, 100, 20, 0xbcbcc4)
	wnd:AddFont("������",15, 0, 225, 452, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 452, 100, 20, 0xbcbcc4)
	wnd:AddFont("������",15, 0, 225, 509, 100, 20, 0xbcbcc4)
	wnd:AddFont("0/11",15, 0, 297, 509, 100, 20, 0xbcbcc4)
	wnd:AddFont("������",15, 0, 225, 566, 100, 20, 0xbcbcc4)
    wnd:AddFont("0/11",15, 0, 297, 566, 100, 20, 0xbcbcc4)
	
	--��һ��
	for i=1,11 do
		TaskItemList.Pos_Y[i] = -70+i*120
		TaskItemList[i] = wnd:AddImage(path_equip.."bag_equip.png", 432, TaskItemList.Pos_Y[i] + 200, 50,50)
		TaskItemList[i]:SetTransparent(0)
		TaskItemList.Name[i] = TaskItemList[i]:AddFont("��â��¶"..i, 15, 0, 0, -41, 200, 20, 0xff7f94cd)
		TaskItemList.CurCount[i] = TaskItemList[i]:AddFont("1000", 15, 6, 84, 41, 200, 20, 0xff6dfefb)
		TaskItemList[i]:AddFont("/", 15, 0, 280, -43, 200, 20, 0xff7f94cd)
		TaskItemList.AllCount[i] = TaskItemList[i]:AddFont("1", 15, 0, 288, -42, 200, 20, 0xff7f94cd)
		TaskItemList.Info[i] = TaskItemList[i]:AddFont("��������"..i, 15, 0, 0, -19, 200, 20, 0xff7f94cd)
		TaskItemList[i]:AddFont("������", 15, 0, 8, 20, 200, 20, 0xff7f94cd)
		TaskItemList[i]:AddImage(path_task.."partition_sign.png", 0, 64, 621, 2)
		img_NotComplete[i] = TaskItemList[i]:AddImage(path_setup.."btn1_mail.png",476,-41,100,32)
		img_NotComplete[i]:AddFont("δ���", 15, 8, 0, 0, 100, 32, 0xff7f94cd)
		img_Complete[i] = TaskItemList[i]:AddImage(path_hero.."buySkin2_hero.png",476,-41,128,32)
		img_Complete[i]:AddImage(path_task.."SignIned_sign.png", 25, 30, 64, 64)
		img_Complete[i]:AddFont("�����", 15, 0, 15, 3, 150, 15, 0xff7f94cd)
		img_Complete[i]:SetVisible(0)
		btn_Get[i] = TaskItemList[i]:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",476,-41,100,32)
		btn_Get[i]:SetVisible(0)
		btn_Get[i]:AddFont("��ȡ����", 15, 8, 0, 0, 100, 32, 0xff7f94cd)
		
		btn_Get[i].script[XE_LBUP] = function()
			--log("\nClickBtnIndex = "..i)
		end
		
		-- �����������ͼƬ�ĳ�ʼ��
		for j=1,5 do
		    img_Head[j+((i-1)*10)] = TaskItemList[i]:AddImage(path_equip.."bag_equip.png", 63+69*j, 0, 50,50)
			img_HeadFrame[j+((i-1)*10)] = TaskItemList[i]:AddImage(path_shop.."iconside_shop.png", 63+69*j-2, -2, 54, 54)
			img_Icon[j+((i-1)*10)] = img_Head[j+((i-1)*10)]:AddImage(path_equip.."bag_equip.png", 1, 1, 50, 50)
		end

		if TaskItemList.Pos_Y[i] > 450 or TaskItemList.Pos_Y[i] < 0 then
			TaskItemList[i]:SetVisible(0)
		else
			TaskItemList[i]:SetVisible(1)
		end
	end
	
	
	--�ұ߹�����
	local C_ToggleBK = wnd:AddImage(path.."toggleBK_main.png",1080,216,16,438)
	C_ToggleBTN = C_ToggleBK:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = C_ToggleBK:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = C_ToggleBK:AddImage(path.."TD1_main.png",0,438,16,16)
	
	XSetWindowFlag(C_ToggleBTN.id,1,1,0,388)
	C_ToggleBTN:ToggleBehaviour(XE_ONUPDATE, 1)
	C_ToggleBTN:ToggleEvent(XE_ONUPDATE, 1)
	C_ToggleBTN.script[XE_ONUPDATE] = function()
		if C_ToggleBTN._T == nil then
			C_ToggleBTN._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(C_ToggleBTN.id)
		if C_ToggleBTN._T ~= T then
		
			local Many = math.floor(T/50)
			
			if Many_Charge ~= Many then
				for i = 1,#TaskItemList do
					local Ti = TaskItemList.Pos_Y[i]+200-Many*120
					TaskItemList[i]:SetPosition(432, Ti)
					
					if Ti >650 or Ti <200 then
						TaskItemList[i]:SetVisible(0)
					else
						TaskItemList[i]:SetVisible(1)
					end
				end
				
				Many_Charge = Many
			end
			C_ToggleBTN._T = T
		end
	end
	--wnd:AddFont("ÿ��UI�·�Ԥ����һС�����ֵĿռ䣬��Ϊ��Ҫ�������ѵı���", 11, 0, 600, 685, 400, 20, 0x7f94cd)
end

function SetTaskIsComplete()
	for i = 1,#TaskItemList do
		if img_NotComplete[i]:IsVisible() then
			img_NotComplete[i]:SetVisible(0)
			img_Complete[i]:SetVisible(0)
			btn_Get[i]:SetVisible(1)
		elseif img_Complete[i]:IsVisible() then
			img_NotComplete[i]:SetVisible(1)
			img_Complete[i]:SetVisible(0)
			btn_Get[i]:SetVisible(0)
		elseif btn_Get[i]:IsVisible() then
			img_NotComplete[i]:SetVisible(0)
			img_Complete[i]:SetVisible(1)
			btn_Get[i]:SetVisible(0)
		end
	end
end


function SetTask_sevendayIsVisible(flag) 
	if g_task_sevenday_ui ~= nil then
		if flag == 1 and g_task_sevenday_ui:IsVisible() == false then
			g_task_sevenday_ui:SetVisible(1)
			
			Click_btn:SetPosition(163,203)
			Click_dirR:SetPosition(370,213)
		elseif flag == 0 and g_task_sevenday_ui:IsVisible() == true then
			g_task_sevenday_ui:SetVisible(0)
		end
	end
end

function GetTask_sevendayIsVisible()  
    if g_task_sevenday_ui ~= nil and g_task_sevenday_ui:IsVisible()  then
       return 1
    else
       return 0
    end
end
