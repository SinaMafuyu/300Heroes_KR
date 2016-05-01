include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local checkA = nil							-- �����ۼ�
local checkB = nil							-- ���ۼ�
local checkC = nil							-- ����ǩ��

local TotalSignIn = {}						-- �����ۼƵ�½�������ۼư�ť��

local Click_btn = nil	
local TotalSignInDay = 23					-- �����ۼƵ�½����			

-- �����ۼƵ�����
local TotalSignInReward = {}				-- �����ۼƽ���
local ID = 1								-- ��ť�ı��
TotalSignInReward.Frame = {}				-- �����Ŀ�
TotalSignInReward.BK = {}					-- ��������
TotalSignInReward.Pic = {}					-- ����ͼƬ
TotalSignInReward.Posx = {}					-- ����X����
TotalSignInReward.getBTN = {}				-- ��ȡ��ť
TotalSignInReward.getBTNFont = {}			-- ����ȡ��ť��
TotalSignInReward.Notice = {}				-- ��ʾ

local GrandTotle = {}						-- ���ۼƵ�½�����ۼ�������ť��

local Click_btnB = nil
local GrandTotleDay = 200					-- ���ۼ�����

-- ���ۼƵ�����
local GrandTotleReward = {}					-- ���ۼƽ���
local ID2 = 1								-- ��ť�ı��
GrandTotleReward.Frame = {}					-- �����Ŀ�
GrandTotleReward.BK = {}					-- ��������
GrandTotleReward.Pic = {}					-- ����ͼƬ
GrandTotleReward.Posx = {}					-- ����X����
GrandTotleReward.Notice = {}				-- ��ʾ

local ContinueSignIn = {}					-- ������½������������ť��
local Click_btnC = nil
local ContinueSignInDay = 230				-- ������½����

-- ���ۼƵ�����
local ContinueReward = {}					-- ������½����
local ID3 = 1								-- ��ť�ı��
ContinueReward.Frame = {}					-- �����Ŀ�
ContinueReward.BK = {}						-- ��������
ContinueReward.Pic = {}						-- ����ͼƬ
ContinueReward.Posx = {}					-- ����X����
ContinueReward.Notice = {}					-- ��ʾ


function InitTask_signinUI(wnd, bisopen)
	g_task_signin_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	--InitMainTask_signin(g_task_signin_ui)
	InitMainTask_signinNew(g_task_signin_ui)
	g_task_signin_ui:SetVisible(bisopen)
end

-- �´���UI
local SignYear = nil
local SignMonth = nil
local SignDay = {}		-- �ܼ�
local SignFlag = {}		-- �Ƿ�ǩ��
local SignDate = {}  	-- ����
local SignToday = nil	-- ����
local SignHover = nil	-- ����
local SignLeft = nil	-- ��һ����
local SignRight = nil	-- ��һ����

local DayInfo = {}
DayInfo.flag = {} 
DayInfo.date = {}
DayInfo.tip = {}

-- �Ҳ�
local SignTaskCheck = {}
local SignTaskCheckYes = {}

local SignTaskUnFinished = nil
local SignTaskUnFinishedYes = nil

-- �����
local Task_posx = {}
local Task_posy = {}
local SignTask = {}
local SignTaskName = {}
local SignTaskState = {}	-- ����״̬���ٷֱ�
local SignTaskComplete = {}	-- �����Ƿ����
local TaskBK = nil
local TaskBtn = nil
local signContinue = nil
local signCount = nil

-- ͨ��
local TaskInfo = {}
TaskInfo.name = {}
TaskInfo.state = {}
TaskInfo.complete= {}
TaskInfo.tip= {}

-- ���ڹ���
local updownCount = 0
local maxUpdown = 0
local sign_BK = nil

function InitMainTask_signinNew(wnd)
	-- ���
	sign_BK = wnd:AddImage(path_task.."BK2_sign.png",27,125,1222,635)
	sign_BK:AddImage(path_task.."BK_sign.png",12,82,610,523)
	sign_BK:AddImage(path_task.."date_sign.png",256,16,256,32)
	sign_BK:AddImage(path_task.."tasklist_sign.png",889,16,87,22)
	
	local DayList = {path_task.."1_sign.png",path_task.."2_sign.png",path_task.."3_sign.png",path_task.."4_sign.png",path_task.."5_sign.png",path_task.."6_sign.png",path_task.."7_sign.png"}
	for i=1,7 do
		local posx = 87*i-54
		local posy = 58
		sign_BK:AddImage(DayList[i],posx,posy,64,32)
	end
	SignYear = sign_BK:AddFont("2015",15,0,205,17,200,30,0x7ed4e5)
	SignMonth = sign_BK:AddFont("08",15,0,285,17,200,30,0x7ed4e5)
	-- ���Ҽ�
	SignLeft = sign_BK:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png",149,10,27,36)
	SignLeft.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XCliclSignDateLeft(1)
	end
	SignRight =  sign_BK:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png",448,10,27,36)
	XWindowEnableAlphaTouch(SignLeft.id)
	XWindowEnableAlphaTouch(SignRight.id)	
	SignRight.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XCliclSignDateRight(1)
	end
	local MM = sign_BK:AddFont("��ʾ��ÿ���½��Ϸ���Զ�ǩ����ǩ�����������ʼ���ʽ���ͣ�",11,0,158,611,400,13,0xb27936)
	MM:SetFontSpace(1,1)
	for i = 1,42 do
		local week_posx = 87*((i-1)%7+1)-73
		local week_posy = 87*math.ceil(i/7)-2
		
		SignDay[i] = sign_BK:AddImage(path_task.."deep_sign.png",week_posx,week_posy,88,88)
		SignDay[i]:SetTransparent(0)
		SignFlag[i] = SignDay[i]:AddImage(path_task.."flag_sign.png",5,8,71,67)
		SignFlag[i]:SetTouchEnabled(0)
		SignDate[i] = SignDay[i]:AddFontEx("12",18,8,0,0,80,80,0x7f94cd)
		SignDay[i].script[XE_ONHOVER] = function()
			local L,T = SignDay[i]:GetPosition()
			SignHover:SetAbsolutePosition(L-2,T-2)
			SignHover:SetVisible(1)
		end
		SignDay[i].script[XE_ONUNHOVER] = function()
			SignHover:SetVisible(0)
		end
	end
	SignHover = sign_BK:AddImage(path_task.."hover_sign.png",0,0,88,88)
	SignHover:SetTouchEnabled(0)
	SignHover:SetVisible(0)
	
	SignToday = sign_BK:AddImage(path_task.."today_signin.png",0,0,88,88)
	SignToday:SetTouchEnabled(0)
	SignToday:SetVisible(0)
	
	-- �Ҳ�
	local TaskList = {"ÿ��","����","��ֵ","����","�Ծ�"}
	for i=1,5 do
		local c_posx = 110*i+570
		local c_posy = 95
		
		SignTaskCheck[i] = sign_BK:AddImage(path_task.."taskcheck_sign.png",c_posx,c_posy,21,21)
		SignTaskCheck[i]:AddFontEx(TaskList[i],18,0,25,-2,100,20,0x7f94cd)
		SignTaskCheckYes[i] = SignTaskCheck[i]:AddImage(path_task.."taskcheckyes_sign.png",0,0,21,21)
		
		SignTaskCheckYes[i]:SetTouchEnabled(0)
		SignTaskCheckYes[i]:SetVisible(0)
	
		SignTaskCheck[i].script[XE_LBUP] = function()
			if (SignTaskCheckYes[i]:IsVisible()) then
				SignTaskCheckYes[i]:SetVisible(0)
				XClickSignTaskCheckIndex(i,0)
			else
				SignTaskCheckYes[i]:SetVisible(1)
				XClickSignTaskCheckIndex(i,1)
			end
		end
	end

	-- ����ʾδ��ɵ�����
	SignTaskUnFinished = sign_BK:AddImage(path_task.."taskcheck_sign.png",1025,565,21,21)
	SignTaskUnFinished:AddFontEx("����ʾδ��ɵ�����",15,0,25,0,150,20,0x7f94cd)
	SignTaskUnFinishedYes = SignTaskUnFinished:AddImage(path_task.."taskcheckyes_sign.png",0,0,21,21)
	
	SignTaskUnFinishedYes:SetTouchEnabled(0)
	SignTaskUnFinishedYes:SetVisible(0)

	SignTaskUnFinished.script[XE_LBUP] = function()
		if (SignTaskUnFinishedYes:IsVisible()) then
			SignTaskUnFinishedYes:SetVisible(0)
			XClickSignTaskCheckIndex(6,0)
		else
			SignTaskUnFinishedYes:SetVisible(1)
			XClickSignTaskCheckIndex(6,1)
		end
	end

	for i=1,6 do
	
		Task_posx[i] = 678
		Task_posy[i] = 81+66*i
		
		SignTask[i] = sign_BK:AddImage(path_task.."taskBK_sign.png",Task_posx[i],Task_posy[i],497,58)
		SignTaskName[i] = SignTask[i]:AddFontEx("δ��ɵ�����"..i,18,0,20,16,200,20,0x7f94fd)
		SignTaskState[i] = SignTask[i]:AddFontEx("[1/"..i*50,18,1,0,16,460,20,0x7f94fd)
		SignTaskComplete[i] = SignTask[i]:AddImage(path_task.."taskcheckyes_sign.png",430,16,21,21)
		SignTaskComplete[i]:SetTouchEnabled(0)
		
		SignTask[i].script[XE_ONHOVER] = function()
			SignTask[i].changeimage(path_task.."taskhover_sign.png")
		end
		SignTask[i].script[XE_ONUNHOVER] = function()
			SignTask[i].changeimage(path_task.."taskBK_sign.png")
		end
		
	end
	
	-- �ұ߹�����
	TaskBK = sign_BK:AddImage(path.."toggleBK_main.png",1184,167,16,346)
	TaskBtn = TaskBK:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = TaskBK:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = TaskBK:AddImage(path.."TD1_main.png",0,346,16,16)
	
	XSetWindowFlag(TaskBtn.id,1,1,0,296)
	
	TaskBtn:ToggleBehaviour(XE_ONUPDATE, 1)
	TaskBtn:ToggleEvent(XE_ONUPDATE, 1)
	TaskBtn.script[XE_ONUPDATE] = function()
		if TaskBtn._T == nil then
			TaskBtn._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(TaskBtn.id)
		if TaskBtn._T ~= T then
			if #TaskInfo.name <=6 then
				length = 296
			else
				length = 296/math.ceil(#TaskInfo.name-6)
			end
			local Many = math.floor(T/length)
			updownCount = Many
			
			for i=1,#TaskInfo.name do
				if i > updownCount and i <= updownCount+6 then
					SignTask[i-updownCount]:SetImageTip(TaskInfo.tip[i])
					SignTask[i-updownCount]:SetVisible(1)
					
					SignTaskName[i-updownCount]:SetFontText(TaskInfo.name[i],0x7f94fd)
					SignTaskState[i-updownCount]:SetFontText(TaskInfo.state[i],0x7f94fd)
					if TaskInfo.complete[i] ==1 then
						SignTaskComplete[i-updownCount]:SetVisible(1)
						SignTaskState[i-updownCount]:SetVisible(0)
					else
						SignTaskComplete[i-updownCount]:SetVisible(0)
						SignTaskState[i-updownCount]:SetVisible(1)
					end
				end
			end
			TaskBtn._T = T
		end
	end
	
	-- ���ý�����Ի���
	XWindowEnableAlphaTouch(g_task_signin_ui.id)
	g_task_signin_ui:EnableEvent(XE_MOUSEWHEEL)
	g_task_signin_ui.script[XE_MOUSEWHEEL] = function()
		local updown  = XGetMsgParam0()
		if updown>0 then
			XMouseMoveSignIn(1)
		else
			XMouseMoveSignIn(0)
		end
	end
	
	wnd:AddFontEx("����ǩ��",15,0,725,690,150,20,0x95f9fd)
	signContinue = wnd:AddFontEx("2000",15,0,815,690,150,20,0xffffff)
	wnd:AddFontEx("�ۼ�ǩ��",15,0,875,690,150,20,0x95f9fd)
	signCount = wnd:AddFontEx("2000",15,0,965,690,150,20,0xffffff)
end

-- ǩ������ͨ��
function SendData_signCountAndContinue(continue,count)
	signContinue:SetFontText(continue,0xffffff)
	signCount:SetFontText(count,0xffffff)
end

function Clear_SignDate()	
	for i,v in pairs(SignDay) do
		SignDay[i]:SetVisible(0)
	end
end

function SendData_SignDate(index,day,flag,tip)
	SignDay[index]:SetImageTip(tip)
	if g_task_signin_ui:IsVisible() then
		SignDay[index]:SetVisible(1)
	end
	SignDate[index]:SetFontText(day,0x7f94cd)
	SignFlag[index]:SetVisible(flag)
end

-- �������Ҽ�
function SetSignLeftEnabled(flag)
	SignLeft:SetEnabled(flag)
end

function SetSignRightEnabled(flag)
	SignRight:SetEnabled(flag)
end

-- ��������
function SetSignYearMonth(year,month)
	SignYear:SetFontText(year,0x7ed4e5)
	SignMonth:SetFontText(month,0x7ed4e5)
end

-- ���õ���������
function Clear_SignToday()
	SignToday:SetVisible(0)
end
function SetSignToday(index)
	local L,T = SignDay[index]:GetPosition()
	SignToday:SetAbsolutePosition(L-2,T-2)
	SignToday:SetVisible(1)
end

-- ������Ϣ
function Clear_TaskInfo()
	TaskInfo = {}
	TaskInfo.name = {}
	TaskInfo.state = {}
	TaskInfo.complete= {}
	TaskInfo.tip= {}
	
	for i,v in pairs(SignTask) do
		SignTask[i]:SetVisible(0)
	end
	
	updownCount = 0
	maxUpdown = 0
	TaskBtn:SetPosition(0,0)
	TaskBtn._T = 0
end

function SendData_TaskInfo(name,state,complete,tip)
	local size = #TaskInfo.name+1
	TaskInfo.name[size] = name 
	TaskInfo.state[size] = state
	TaskInfo.complete[size] = complete
	TaskInfo.tip[size] = tip
	
	if size > updownCount and size <= updownCount+6 then
		SignTask[size]:SetImageTip(tip)
		SignTask[size]:SetVisible(1)
		
		SignTaskName[size]:SetFontText(name,0x7f94fd)
		SignTaskState[size]:SetFontText(state,0x7f94fd)
		if complete ==1 then
			SignTaskComplete[size]:SetVisible(1)
			SignTaskState[size]:SetVisible(0)
		else
			SignTaskComplete[size]:SetVisible(0)
			SignTaskState[size]:SetVisible(1)
		end
	end
end

function SendData_TaskInfoOver()
	if #TaskInfo.name <=6 then
		TaskBK:SetVisible(0)
	else
		TaskBK:SetVisible(1)
	end
end

-- ����checkBox�Ƿ�ѡ
function SetSignTask_CheckBox(check1,check2,check3,check4,check5,check6)
	SignTaskCheckYes[1]:SetVisible(check1)
	SignTaskCheckYes[2]:SetVisible(check2)
	SignTaskCheckYes[3]:SetVisible(check3)
	SignTaskCheckYes[4]:SetVisible(check4)
	SignTaskCheckYes[5]:SetVisible(check5)
	SignTaskUnFinishedYes:SetVisible(check6)
end

function SetTask_signinIsVisible(flag) 
	if g_task_signin_ui ~= nil then
		if flag == 1 and g_task_signin_ui:IsVisible() == false then
			g_task_signin_ui:SetVisible(1)		--log("\nSetTask_signinIsVisible   MMMM     1")
			XClickSignInTask(1)					--log("\nSetTask_signinIsVisible   MMMM     2")
		elseif flag == 0 and g_task_signin_ui:IsVisible() == true then
			g_task_signin_ui:SetVisible(0)		--log("\nSetTask_signinIsVisible   MMMM     3")
		end
	end
end

function GetTask_signinIsVisible()  
    if g_task_signin_ui ~= nil and g_task_signin_ui:IsVisible()  then
       return 1
    else
       return 0
    end
end