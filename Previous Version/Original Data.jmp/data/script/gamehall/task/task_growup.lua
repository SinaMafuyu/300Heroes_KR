include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local Click_btn = nil
local Click_dirR = nil

local checkA = nil
local checkB = nil
local checkC = nil
local checkD = nil
local checkE = nil

local checkA_ui = nil
local checkB_ui = nil
local checkC_ui = nil
local checkD_ui = nil
local checkE_ui = nil

local growupC_index = nil	-------��ǰѡ�еİ�ť

local lv = {2,3,5,10,20,25,30,35,40}
local growupFont = {}    -----�ɳ������ı���
local growupImage = {}    -------�ɳ���������ƷͼƬ
local growupframeImage = {}   ------�ɳ�������ƷͼƬ��
local GrowupN_POSY = {}	-------�ɳ�������Y����

local battle = {"��¶��â"}   -----ս����������
local battledescribe = {"��ڼ���һ��ս������ʤ"}    -----ս����������
local battleIsFinishCont = {"0"}    ------ս�������Ƿ���ɵļ���
local battleFont = {}    -----ս�������ı���
local battleImage = {}    -------ս����������ƷͼƬ
local battleframeImage = {}   ------ս��������ƷͼƬ��
local BattleN_POSY = {}	-------ս��������Y����

local task = {"��¶��â"}   -----ÿ����������
local taskdescribe = {"��ڼ���һ��ս������ʤ"}    -----ÿ����������
local taskIsFinishCont = {"0"}    ------ÿ�������Ƿ���ɵļ���
local taskFont = {}    -----ÿ������ı���
local taskImage = {}    -------ÿ���������ƷͼƬ
local taskframeImage = {}   ------ÿ��������ƷͼƬ��
local TaskN_POSY = {}	-------ÿ�������Y����

local onlineTimeCount = {}     ------���߽�����ʱ
local onlineTime = {5,10,30,60,120,180,240,300,5,10,30,60,120,180,240,300,5,10,30,60,120,180,240,300,5,10,30,60,120,180,240,300,5,10,30,60,120,180,240,300}          ------����ʱ��ﵽX
local onlinerewardFont = {}      -------���߽�������
local onlinerewardImage = {}    -------���߽�������ƷͼƬ
local onlinerewardframeImage = {}   ------���߽�����ƷͼƬ��
local OnlinerewardN_POSY = {}	-------���߽�����Y����

local CDKeyExchangeInput = nil         ------����һ�

function InitTask_growupUI(wnd, bisopen)
	g_task_growup_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainTask_growup(g_task_growup_ui)
	g_task_growup_ui:SetVisible(bisopen)
end

function InitMainTask_growup(wnd)

	wnd:AddImage(path_task.."BK_task.png",130,137,1000,584)
	wnd:AddImage(path_task.."font1_task.png",585,165,128,32)
	
	-------��ʼλ���ڵ�һ��	
	checkA = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,203,256,64)
	checkA.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,203)
		Click_dirR:SetPosition(370,213)
		
		checkA_ui:SetVisible(1)
		checkB_ui:SetVisible(0)
		checkC_ui:SetVisible(0)
		checkD_ui:SetVisible(0)
		checkE_ui:SetVisible(0)
	end
	checkB = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,260,256,64)
	checkB.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,260)
		Click_dirR:SetPosition(370,270)
		
		checkA_ui:SetVisible(0)
		checkB_ui:SetVisible(1)
		checkC_ui:SetVisible(0)
		checkD_ui:SetVisible(0)
		checkE_ui:SetVisible(0)
	end
	checkC = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,317,256,64)
	checkC.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,317)
		Click_dirR:SetPosition(370,327)
		
		checkA_ui:SetVisible(0)
		checkB_ui:SetVisible(0)
		checkC_ui:SetVisible(1)
		checkD_ui:SetVisible(0)
		checkE_ui:SetVisible(0)
	end
	checkD = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,374,256,64)
	checkD.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,374)
		Click_dirR:SetPosition(370,384)
		
		checkA_ui:SetVisible(0)
		checkB_ui:SetVisible(0)
		checkC_ui:SetVisible(0)
		checkD_ui:SetVisible(1)
		checkE_ui:SetVisible(0)
	end
	checkE = wnd:AddButton(path_equip.."check1_equip.png",path_equip.."check2_equip.png",path_equip.."check3_equip.png",163,431,256,64)
	checkE.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Click_btn:SetPosition(163,431)
		Click_dirR:SetPosition(370,441)
		
		checkA_ui:SetVisible(0)
		checkB_ui:SetVisible(0)
		checkC_ui:SetVisible(0)
		checkD_ui:SetVisible(0)
		checkE_ui:SetVisible(1)
	end
	
	Click_btn = wnd:AddImage(path_equip.."check3_equip.png",163,203,256,64)
	Click_dirR = wnd:AddImage(path_info.."R2_info.png",370,213,27,36)
	
	wnd:AddFont("�ȼ����",15, 0, 225, 224, 100, 20, 0xbcbcc4)
	wnd:AddFont("ս������",15, 0, 225, 281, 100, 20, 0xbcbcc4)
	wnd:AddFont("ÿ������",15, 0, 225, 338, 100, 20, 0xbcbcc4)
	wnd:AddFont("���߽���",15, 0, 225, 395, 100, 20, 0xbcbcc4)
	wnd:AddFont("����һ�",15, 0, 225, 452, 100, 20, 0xbcbcc4)
		
	
	----------�ȼ����
	checkA_ui = CreateWindow(wnd.id, 400, 200, 720, 510)
    for i=1,9 do
		local fontA = "�ٻ�ʦ�ﵽ"..lv[i].."��"
		GrowupN_POSY[i] = 28+(i-1)*80
		growupFont[i] = checkA_ui:AddImage(path_equip.."bag_equip.png", 33, GrowupN_POSY[i], 52, 52)
		growupFont[i]:SetTransparent(0)
		growupFont[i]:AddFont(fontA, 15, 0, 10, 0, 200, 20, 0x7f94cd)
		growupFont[i]:AddImage(path_task.."partition_sign.png", 0, 48, 621, 2)
		local growupisgetImage = growupFont[i]:AddImage(path_task.."SignIned_sign.png", 570, -18, 64, 64)
		growupisgetImage:SetVisible(0)

		for j=1,5 do
		    growupFont[i]:AddImage(path_equip.."bag_equip.png", 127+69*j, -18, 50, 50)
			growupFont[i]:AddImage(path_shop.."iconside_shop.png", 125+69*j, -20, 54, 54)
		end

		if GrowupN_POSY[i] >450 or GrowupN_POSY[i] <0 then
			growupFont[i]:SetVisible(0)
		else
			growupFont[i]:SetVisible(1)
		end
	end
	
	---�ұ߹�����
	local A_ToggleBK = checkA_ui:AddImage(path.."toggleBK_main.png",680,16,16,438)
	A_ToggleBTN = A_ToggleBK:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = A_ToggleBK:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = A_ToggleBK:AddImage(path.."TD1_main.png",0,438,16,16)
	
	XSetWindowFlag(A_ToggleBTN.id,1,1,0,388)
	
	A_ToggleBTN:ToggleBehaviour(XE_ONUPDATE, 1)
	A_ToggleBTN:ToggleEvent(XE_ONUPDATE, 1)
	A_ToggleBTN.script[XE_ONUPDATE] = function()
		if A_ToggleBTN._T == nil then
			A_ToggleBTN._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(A_ToggleBTN.id)
		if A_ToggleBTN._T ~= T then
		
			local Many = math.floor(T/50)
			
			if Many_Charge ~= Many then
				for i,value in pairs(growupFont) do
					local Ti = GrowupN_POSY[i]-Many*80
					
					growupFont[i]:SetPosition(33, Ti)
					
					if Ti >450 or Ti <0 then
						growupFont[i]:SetVisible(0)
					else
						growupFont[i]:SetVisible(1)
					end
				end
				
				Many_Charge = Many
			end
			A_ToggleBTN._T = T
		end
	end
	--checkA_ui:AddFont("ÿ��UI�·�Ԥ����һС�����ֵĿռ䣬��Ϊ��Ҫ�������ѵı���", 11, 0, 200, 485, 400, 20, 0x7f94cd)

	----------ս������
	checkB_ui = CreateWindow(wnd.id, 400, 200, 720, 510)
	for i=1,9 do
		local fontB = battle[i]
		local fontBDescribe = battledescribe[i]
		local fontBIsFinishCont = battleIsFinishCont[i]
		BattleN_POSY[i] = -70+i*120
		battleFont[i] = checkB_ui:AddImage(path_equip.."bag_equip.png", 32, BattleN_POSY[i], 52, 52)
		battleFont[i]:SetTransparent(0)
		battleFont[i]:AddFont(fontB, 15, 0, 0, -41, 200, 20, 0x7f94cd)
		battleFont[i]:AddFont(fontBIsFinishCont, 15, 0, 268, -41, 200, 20, 0x7f94cd)
		battleFont[i]:AddFont("/1", 15, 0, 281, -41, 200, 20, 0x7f94cd)
		battleFont[i]:AddFont(fontBDescribe, 15, 0, 0, -19, 200, 20, 0x7f94cd)
		battleFont[i]:AddFont("������", 15, 0, 8, 20, 200, 20, 0x7f94cd)
		battleFont[i]:AddImage(path_task.."partition_sign.png", 0, 64, 621, 2)
		local battleisgetImage = battleFont[i]:AddImage(path_task.."SignIned_sign.png", 508, 0, 64, 64)
		battleisgetImage:SetVisible(1)
		local battleIsDoneImage = battleFont[i]:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",476,-41,100,32)
		if battleisgetImage:IsVisible() == true then
			battleFont[i]:AddFont("�����", 15, 8, 0, 0, 100, 32, 0x7f94cd)
		else
			battleFont[i]:AddFont("ǰ�����", 15, 8, 500, 0, 100, 32, 0x7f94cd)
		end
		
		for j=1,5 do
		    battleFont[i]:AddImage(path_equip.."bag_equip.png", 63+69*j, 0, 50, 50)
			battleFont[i]:AddImage(path_shop.."iconside_shop.png", 63+69*j-2, -2, 54, 54)
		end

		if BattleN_POSY[i] >450 or BattleN_POSY[i] <0 then
			battleFont[i]:SetVisible(0)
		else
			battleFont[i]:SetVisible(1)
		end
	end
	
	---�ұ߹�����
	local B_ToggleBK = checkB_ui:AddImage(path.."toggleBK_main.png",680,16,16,438)
	B_ToggleBTN = B_ToggleBK:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = B_ToggleBK:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = B_ToggleBK:AddImage(path.."TD1_main.png",0,438,16,16)
	
	XSetWindowFlag(B_ToggleBTN.id,1,1,0,388)
	
	B_ToggleBTN:ToggleBehaviour(XE_ONUPDATE, 1)
	B_ToggleBTN:ToggleEvent(XE_ONUPDATE, 1)
	B_ToggleBTN.script[XE_ONUPDATE] = function()
		if B_ToggleBTN._T == nil then
			B_ToggleBTN._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(B_ToggleBTN.id)
		if B_ToggleBTN._T ~= T then
		
			local Many = math.floor(T/50)
			
			if Many_Charge ~= Many then
				for i,value in pairs(battleFont) do
					local Ti = BattleN_POSY[i]-Many*120
					
					battleFont[i]:SetPosition(32, Ti)
					
					if Ti >450 or Ti <0 then
						battleFont[i]:SetVisible(0)
					else
						battleFont[i]:SetVisible(1)
					end
				end
				
				Many_Charge = Many
			end
			B_ToggleBTN._T = T
		end
	end
	--checkB_ui:AddFont("ÿ��UI�·�Ԥ����һС�����ֵĿռ䣬��Ϊ��Ҫ�������ѵı���", 11, 0, 200, 485, 400, 20, 0x7f94cd)
	
	----------ÿ������
	checkC_ui = CreateWindow(wnd.id, 400, 200, 720, 510)
	for i=1,9 do
		local fontC = task[i]
		local fontCDescribe = taskdescribe[i]
		local fontCIsFinishCont = taskIsFinishCont[i]
		TaskN_POSY[i] = -70+i*120
		taskFont[i] = checkC_ui: AddImage(path_equip.."bag_equip.png", 32, TaskN_POSY[i], 52, 52)
		taskFont[i]:SetTransparent(0)
		taskFont[i]:AddFont(fontC, 15, 0, 0, -41, 200, 20, 0x7f94cd)
		taskFont[i]:AddFont(fontCIsFinishCont, 15, 0, 268, -41, 200, 20, 0x7f94cd)
		taskFont[i]:AddFont("/1", 15, 0, 281, -41, 200, 20, 0x7f94cd)
		taskFont[i]:AddFont(fontCDescribe, 15, 0, 0, -19, 200, 20, 0x7f94cd)
		taskFont[i]:AddFont("������", 15, 0, 8, 20, 200, 20, 0x7f94cd)
		taskFont[i]:AddImage(path_task.."partition_sign.png", 0, 64, 621, 2)
		local taskisgetImage = taskFont[i]:AddImage(path_task.."SignIned_sign.png", 508, 0, 64, 64)
		taskisgetImage:SetVisible(0)
		local taskIsDoneImage = taskFont[i]:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",476,-41,100,32)
		if taskisgetImage:IsVisible() == true then
			taskFont[i]:AddFont("�����", 15, 8, 0, 0, 100, 32, 0x7f94cd)
		else
			taskFont[i]:AddFont("ǰ�����", 15, 8, 0, 0, 100, 32, 0x7f94cd)
		end
		
		for j=1,5 do
		    taskFont[i]:AddImage(path_equip.."bag_equip.png", 63+69*j, 0, 50, 50)
			taskFont[i]:AddImage(path_shop.."iconside_shop.png", 63+69*j-2, -2, 54, 54)
		end

		if TaskN_POSY[i] >450 or TaskN_POSY[i] <0 then
			taskFont[i]:SetVisible(0)
		else
			taskFont[i]:SetVisible(1)
		end
	end
	
	---�ұ߹�����
	local C_ToggleBK = checkC_ui:AddImage(path.."toggleBK_main.png",680,16,16,438)
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
				for i,value in pairs(taskFont) do
					local Ti = TaskN_POSY[i]-Many*120
					
					taskFont[i]:SetPosition(32, Ti)
					
					if Ti >450 or Ti <0 then
						taskFont[i]:SetVisible(0)
					else
						taskFont[i]:SetVisible(1)
					end
				end
				
				Many_Charge = Many
			end
			C_ToggleBTN._T = T
		end
	end
	--checkC_ui:AddFont("ÿ��UI�·�Ԥ����һС�����ֵĿռ䣬��Ϊ��Ҫ�������ѵı���", 11, 0, 200, 485, 400, 20, 0x7f94cd)
	
	----------���߽���
	checkD_ui = CreateWindow(wnd.id, 400, 200, 720, 510)
	onlineTimeCount =  checkD_ui:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",528,19,100,32)
	onlineTimeCount:AddFont("�����������Ѵﵽ��XʱX��X��", 15, 0, -482, 4, 250, 20, 0x7f94cd)
	onlineTimeCount:AddFont("һ����ȡ", 15, 8, 0, 0, 100, 32, 0x7f94cd)
	onlineTimeCount:AddImage(path_task.."partition_sign.png", -528, 48, 621, 2)
	for i=1,9 do
	    OnlinerewardN_POSY[i] = 75+204*(i-1)
		onlinerewardFont[i] = checkD_ui:AddImage(path_task.."onlinesmallBK_task.png",46,OnlinerewardN_POSY[i],142,196)
		onlinerewardFont[i]:SetTransparent(0)
		for j=1,4 do
			onlinerewardFont[i]:AddImage(path_task.."onlinesmallBK_task.png",152*(j-1),0,142,196)
			onlinerewardFont[i]:AddFont("���ߴﵽ", 15, 0, 39+152*(j-1), 10, 200, 20, 0x7f94cd)
			local onlineTimeIndex = 4*(i-1)+j    
			onlinerewardFont[i]:AddFont(onlineTime[onlineTimeIndex].."����", 15, 0, 48+152*(j-1), 34, 200, 15, 0x7f94cd)
			local IsOnlineRewardGet = onlinerewardFont[i]:AddImage(path_task.."SignIned_sign.png", 48+152*(j-1), 55, 64, 64)
			onlinerewardFont[i]:AddImage(path_equip.."bag_equip.png", 44+152*(j-1), 106, 50, 50)
			onlinerewardFont[i]:AddImage(path_shop.."iconside_shop.png", 44+152*(j-1)-2, 106-2, 54, 54)
			onlinerewardFont[i]:AddImage(path.."friend4_hall.png", 47+152*(j-1), 109, 32, 32)
			IsOnlineRewardGet:SetVisible(0)
			if IsOnlineRewardGet:IsVisible() == true then
				onlinerewardFont[i]:AddFont("����ȡ", 15, 0, 48+152*(j-1), 171, 200, 20, 0x7f94cd)
			else
				onlinerewardFont[i]:AddFont("δ��ȡ", 15, 0, 48+152*(j-1), 171, 200, 20, 0x7f94cd)
			end
			
			if OnlinerewardN_POSY[i] >450 or OnlinerewardN_POSY[i] <70 then
				onlinerewardFont[i]:SetVisible(0)
			else
				onlinerewardFont[i]:SetVisible(1)
			end
		end
	end
	
	---�ұ߹�����
	local D_ToggleBK = checkD_ui:AddImage(path.."toggleBK_main.png",680,16,16,438)
	D_ToggleBTN = D_ToggleBK:AddButton(path.."toggleBTN1_main.png",path.."toggleBTN2_main.png",path.."toggleBTN3_main.png",0,0,16,50)
	local ToggleT = D_ToggleBK:AddImage(path.."TD1_main.png",0,-16,16,16)
	local ToggleD = D_ToggleBK:AddImage(path.."TD1_main.png",0,438,16,16)
	
	XSetWindowFlag(D_ToggleBTN.id,1,1,0,388)
	D_ToggleBTN:ToggleBehaviour(XE_ONUPDATE, 1)
	D_ToggleBTN:ToggleEvent(XE_ONUPDATE, 1)
	D_ToggleBTN.script[XE_ONUPDATE] = function()
		if D_ToggleBTN._T == nil then
			D_ToggleBTN._T = 0
		end
		local L,T,R,B = XGetWindowClientPosition(D_ToggleBTN.id)
		if D_ToggleBTN._T ~= T then
		
			local Many = math.floor(T/50)
			
			if Many_Charge ~= Many then
				for i,value in pairs(onlinerewardFont) do
					local Ti = OnlinerewardN_POSY[i]-Many*204
					
					onlinerewardFont[i]:SetPosition(46, Ti)
					
					if Ti >450 or Ti <70 then
						onlinerewardFont[i]:SetVisible(0)
					else
						onlinerewardFont[i]:SetVisible(1)
					end
				end
				
				Many_Charge = Many
			end
			D_ToggleBTN._T = T
		end
	end
	--checkD_ui:AddFont("ÿ��UI�·�Ԥ����һС�����ֵĿռ䣬��Ϊ��Ҫ�������ѵı���", 11, 0, 200, 485, 400, 20, 0x7f94cd)
	
	----------����һ�
	checkE_ui = CreateWindow(wnd.id, 570, 325, 512, 64)
	CDKeyExchangeInput = checkE_ui:AddEdit(path_task.."CDKeyBK_task.png","","onKeyEnter","",20,0,10,417,42,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(CDKeyExchangeInput.id,40)
	XEditInclude(CDKeyExchangeInput.id,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890")
	
	checkE_ui:AddFont("�һ��룺", 15, 0, -75, 10, 200, 20, 0xbcbcc4)
	checkE_ui:AddButton(path.."button1_hall.png",path.."button2_hall.png",path.."button3_hall.png",75,75,179,56)
	checkE_ui:AddFont("����һ�", 15, 0, 127, 90, 200, 20, 0xffffff)
	local Attention = checkE_ui:AddFont("��ʾ������һ��ɹ����Զ����ʼ���ʽ���͡�", 11, 0, 58, 150, 250, 20, 0x8295cf)
	Attention:SetFontSpace(1,1)
	
	
	checkA_ui:SetVisible(1)
	checkB_ui:SetVisible(0)
	checkC_ui:SetVisible(0)
	checkD_ui:SetVisible(0)
	checkE_ui:SetVisible(0)
end
------------------�һ����
function IsFocusOn_KeyEnter()
	-- if (g_task_growup_ui:IsVisible() == true) and (checkE_ui:IsVisible() == true) then
		-- -------�������
		-- local Input_Focus = CDKeyExchangeInput:IsFocus()
		
		-- if Input_Focus == true then
			-- CDKeyExchangeInputText:SetVisible(0)
		-- elseif Input_Focus == false and CDKeyExchangeInputText:IsVisible() == false then
			-- CDKeyExchangeInput:SetEdit("")
			-- CDKeyExchangeInputText:SetVisible(1)
		-- end
	-- end
end
function onKeyEnter()
	CDKeyExchangeInput:SetEdit("")
end

function SetTask_growupIsVisible(flag) 
	if g_task_growup_ui ~= nil then
		if flag == 1 and g_task_growup_ui:IsVisible() == false then
			g_task_growup_ui:SetVisible(1)
			
			Click_btn:SetPosition(163,203)
			Click_dirR:SetPosition(370,213)
		elseif flag == 0 and g_task_growup_ui:IsVisible() == true then
			g_task_growup_ui:SetVisible(0)
		end
	end
end

function GetTask_growupIsVisible()  
    if g_task_growup_ui ~= nil and g_task_growup_ui:IsVisible()  then
       return 1
    else
       return 0
    end
end