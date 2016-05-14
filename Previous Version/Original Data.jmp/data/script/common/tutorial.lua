include("../Data/Script/Common/include.lua")

local TutorialString = {"�����ٻ�ʦ����ӭ��������ѵ��Ӫ�������[color=0xffffff00]ȷ��[color=0xffffffff]����ʼѵ���ɡ�",
"����[color=0xffffff00]׼������[color=0xffffffff]������Ҫ[color=0xffffff00]ѡ��һ��Ӣ��[color=0xffffffff]������Ϸ��",
"ͨ��ѡ��Ӣ������[color=0xffffff00]ʱ������[color=0xffffffff]�����ڹ涨ʱ����ѡ�����Ӣ�ۡ�",
"����ѡ��Ӣ�ۺ��������ʾ[color=0xffffff00]����ѡӢ��[color=0xffffffff]�İ�����",
"��[color=0xffffff00]��Ķ���[color=0xffffffff]ѡ��Ӣ�ۺ��������ʾ���ǵ�Ӣ����Ϣ��",
"������[color=0xffffff00]�����[color=0xffffffff]�������������Ͷ�������ս����",
"����[color=0xffffff00]Ӣ��ѡ��ť[color=0xffffffff]����ʼѡ��Ӣ�۰ɣ�",
"ͨ��[color=0xffffff00]�ֶ�����[color=0xffffffff]��[color=0xffffff00]ɸѡ����[color=0xffffffff]������Ѹ�ٶ�λ��Ҫѡ���Ӣ�ۡ�",
"�·��ǿɳ���[color=0xffffff00]Ӣ���б�[color=0xffffffff]������[color=0xffffff00]����ӵ��[color=0xffffffff]��[color=0xffffff00]��ʱ���[color=0xffffffff]��Ӣ�ۡ�",
"��������ѡ��һ��Ӣ�۰ɣ�[color=0xffffff00]�������[color=0xffffffff]Ӣ�۵İ����񼴿ɡ�",
"ѡ��Ӣ�ۺ��[color=0xffffff00]˫��Ӣ��[color=0xffffffff]����[color=0xffffff00]���ذ�ť[color=0xffffffff]������׼��������",
"[color=0xffffff00]�츳ר��[color=0xffffffff]�ܼ�ǿ���Ӣ�ۣ������������鿴���޸ġ�",
"�����ѡ������[color=0xffffff00]�ٻ�ʦ����[color=0xffffffff]�������Ӣ�ۣ��������ͼ��ɽ���ѡ��",
"��󣬵��[color=0xffffff00]������ť[color=0xffffffff]ȷ��ѡ�����Ӣ�ۣ�����ʱ����ǰ������Ȼ�����޸�����츳���ٻ�ʦ���ܡ�"}

local IsEnterTutorialMode = 0
local StepIndex = 0
local TutorialBackGroundImage = {}		-- ����ͼ
local TutorialFont = {}
local TutorialButton_OK = {}
local ImageSizeW = { 322, 324, 322, 339}
local ImageSizeH = { 222, 240, 238, 222}
local KongJianPosX = { -8, -8, -8, -8}
local KongJianPosY = { -5, -23, -5, -5}

function InitTutorial_UI( wnd, bIsOpen)
	g_Tutorial_ui = CreateWindow(wnd.id, 0, 0, 340, 240)
	InitMain_Tutorial(g_Tutorial_ui)
	g_Tutorial_ui:SetVisible(bIsOpen)
end

function InitMain_Tutorial( wnd)
	-- Ĭ�ϴ���һ�ű���ͼ
	for i=1, 4 do
		TutorialBackGroundImage[i] = wnd:AddImage( path_tutorial.."tutorialbackground_" .. i .. ".png", 0, 0, ImageSizeW[i], ImageSizeH[i])
		TutorialFont[i] = TutorialBackGroundImage[i]:AddChat( 15, 8, KongJianPosX[i], KongJianPosY[i], 306, 160, 0xffbeb5ee)
		TutorialButton_OK[i] = TutorialBackGroundImage[i]:AddButton( path_hero.."detail1_hero.png", path_hero.."detail2_hero.png", path_hero.."detail3_hero.png", -(KongJianPosX[i]-108), -(KongJianPosY[i]-165), 90, 40)
		TutorialButton_OK[i]:AddFont( "ȷ��", 15, 8, 0, 0, 90, 40)
		TutorialBackGroundImage[i]:SetVisible(0)
		
		TutorialButton_OK[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			XNextStepStart()
		end
	end
end

-- Type
-- �� 1
-- �� 2
-- �� 3
-- �� 4
function TutorialChangeBackImage( Type, String)
	for i=1, #TutorialBackGroundImage do
		TutorialBackGroundImage[i]:SetVisible(0)
	end
	TutorialBackGroundImage[Type]:SetVisible(1)
	TutorialFont[Type]:ClearChatText()
	TutorialFont[Type]:AddChatText( String)
end

-- �õ���������
function GetTutorialStringFromLua( CurStep)
	XGetTutorialStringFromLua(TutorialString[CurStep+1])
	StepIndex = CurStep
end

function RunTutorialFromLua( RunStep)
	if RunStep==1 then
		
	elseif RunStep==2 then
		
	elseif RunStep==3 then
		SetReadyTimeTutorialState(1)
	elseif RunStep==4 then
		SetReadyTimeTutorialState(0)
		SetGameStartTutorialState(1, 1)
	elseif RunStep==5 then
		SetGameStartTutorialState(0, 1)
		SetGameStartTutorialState(1, 2)
	elseif RunStep==6 then
		SetGameStartTutorialState(0, 2)
		SetGameStartTutorialState(1, 3)
	elseif RunStep==7 then
		SetGameStartTutorialState(0, 3)
		SetGameStartTutorialState(1, 4)
	elseif RunStep==8 then
		SetGameStartTutorialState(0, 4)
		SetchoseheroTutorialState(1, 1)
	elseif RunStep==9 then
		SetchoseheroTutorialState(0, 1)
		SetchoseheroTutorialState(1, 2)
	elseif RunStep==10 then
		SetchoseheroTutorialState(0, 2)
		SetchoseheroTutorialState(1, 3)
	elseif RunStep==11 then
		SetchoseheroTutorialState(0, 3)
		SetchoseheroTutorialState(1, 4)
	elseif RunStep==12 then
		SetchoseheroTutorialState(0, 4)
		SetGameStartTutorialState(1, 5)
	elseif RunStep==13 then
		SetGameStartTutorialState(0, 5)
		SetGameStartTutorialState(1, 6)
	elseif RunStep==14 then
		SetGameStartTutorialState(0, 6)
	else
	end
end

function SetTutorialButtonTouchStateToLua( StepID, State)
	if IsEnterTutorialMode==1 then
		if StepID==1 then
			SetTutorialAllButtonEnable(State)
		elseif StepID==7 then
			-- "�����Ҫ���Ӣ��ѡ����ܽ�����һ��"
			SetTutorialButtonEnable(State)
		elseif StepID==8 then
			-- ��ҽ���Ӣ��ѡ�����
			SetTutorialButtonEnable(1)
			-- ʹӢ��ɾѡUI����ʹ��
			SetChoseHeroTutorialAllButtonEnable(State)
		elseif StepID==9 then
			-- ʹӢ���б�UI����ʹ��
			SetChoseHeroTutorialButtonEnable()
			AutoChoseHero_DeBug()
		elseif StepID==10 then
			SetTutorialButtonEnable(0)
		elseif StepID==11 then
			SetTutorialAllButtonEnable(State)
			ReturnGameStartUI()
		elseif StepID==14 then
			SetTutorialAllButtonEnable(State)
			SetChoseHeroTutorialAllButtonEnable(State)
		end
	end
end

function SetLOLGameMode( IsEnterTutorail)
	IsEnterTutorialMode = IsEnterTutorail
	
	if IsEnterTutorialMode==0 then
		SetTutorialAllButtonEnable(1)
		SetChoseHeroTutorialAllButtonEnable(1)
		
		SetReadyTimeTutorialState(0)
		for i=1, 6 do
			SetGameStartTutorialState(0, i)
		end
		for i=1, 4 do
			SetchoseheroTutorialState(0, i)
		end
	end
end

function GetTutorailModeIsOpen()
	return IsEnterTutorialMode
end

function GetStepIndex_Tutorial()
	return StepIndex
end