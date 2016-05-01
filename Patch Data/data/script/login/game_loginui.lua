include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

function show_login_ui(wnd,bisopen)
    if G_login_ui == nil then
		G_login_ui = CreateWindow(wnd, 0, 0, 1280, 800)
		G_login_ui:ToggleFlags(XF_ENABLEMSGPROCESS,0)
				
		-- ս����UI����
		SkipLoadResource(1)
		InitScore_ui(G_login_ui,0)							-- �ȷ�
		InitData_ui(G_login_ui,0)							-- ��ɱ������������������
		InitState_ui(G_login_ui,0)							-- ���ܽ���
		InitLolmain_ui(G_login_ui,0)						-- ���ܽ���
		InitTimeProgress_ui(G_login_ui,0)					-- �سǽ�����
		
		InitFightbag_ui(G_login_ui,0)   					-- �Լ���ս������
		InitFighttaget_ui(G_login_ui,0)  					-- ѡ�е�λ��ս������
		InitTeamplayer_ui(G_login_ui,0)  					-- ������Ϣ����
		InitMinimap_ui(G_login_ui,0)						-- С��ͼ
		
		InitFarshop_ui(G_login_ui,0)						-- Զ���̵�
		InitSurrender_ui(G_login_ui,0)						-- Ͷ������
		
		InitChatIn_UI(G_login_ui,0)							-- �����������	
	
		InitDeadData_ui(G_login_ui,0)						-- �����ط�
		InitMarket_ui(G_login_ui,0)							-- �����̵�
		InitTab_ui(G_login_ui,0)							-- ��Tab��
		InitSoulChange_ui(G_login_ui,0)						-- �����Լ
		InitSelectFirstHero_ui(G_login_ui,0)				-- ��������ѡ��Ӣ�۽���
		InitEndData_ui(G_login_ui,0)						-- �������
		
		InitBattleSignal_ui(G_login_ui,0)					-- �����ź�
		InitBattleSignalSetting_ui(G_login_ui,0)			-- �����ź�����
		
		InitCreatePlayerUI(G_login_ui,0)					-- �����ٻ�ʦ
		SkipLoadResource(0)
		
		-- ����UI����		
		Initserver_selectionUI(G_login_ui,0)		
		InitGame_hallUI(G_login_ui,0)						-- ��Ϸ����������
		InitLobbyAdvert_ui(G_login_ui,0)        			-- ������
		InitGame_FightUI(G_login_ui, 0)						-- ��Ϸģʽ������ս�������㾺���ȵ�
		InitGame_HeroUI(G_login_ui, 0)						-- Ӣ�۽���
		InitShop_InsideUI(G_login_ui,0)						-- �����̳�UI
		InitGame_ShopUI(G_login_ui, 0)						-- �̳ǽ���
		
		SkipLoadResource(1)
		InitEquip_InsideUI(G_login_ui,0)					-- ���ڱ���UI
		InitGame_EquipUI(G_login_ui, 0)						-- װ������
		Init_EquipRedemptionUI( G_login_ui, 0)				-- װ�����
		SkipLoadResource(0)
		
		InitTask_UI(G_login_ui, 0)							-- ����ͻ����
		InitTalent_InsideUI(G_login_ui, 0)					-- ѡ�˽�����츳ר��
		InitAchievement_InsideUI(G_login_ui,0)				-- ���ڳɾ�UI
		Init_PlayerInfoUI(G_login_ui, 0)					-- ������Ϣ����

		InitGame_FourpartUI(G_login_ui,0)
	
		InitGameStart_ui(G_login_ui, 0)						--log("\nshow_login_ui31   ")-- ��Ϸ��ʼ����1
		InitSummonerSkill_ui(G_login_ui, 0)					--log("\nshow_login_ui32   ")-- �ٻ�ʦ����ѡ��
		InitGame_ChoseHeroUI(G_login_ui, 0)					--log("\nshow_login_ui33   ")-- ��Ϸ��ʼ����2
		InitGame_SkinFrame(G_login_ui, 0)					--log("\nshow_login_ui34   ")-- Ƥ��ѡ��
		InitReadyTime_ui(G_login_ui,0)						--log("\nshow_login_ui35   ")-- ׼����ʼʱ��90�뵹��ʱ
		
		InitGameTeamFight_ui(G_login_ui, 0)					--log("\nshow_login_ui37   ")-- ��Խ����ڻ���3�н����ϲ�
		InitEquip_GemBuy_ui(G_login_ui, 0)	    			--log("\nshow_login_ui38   ")-- װ���б�ʯ�������
		
		SkipLoadResource(1)
		InitMail_UI(G_login_ui, 0)							--log("\nshow_login_ui39   ")-- �ʼ�����
		InitTalk_UI(G_login_ui, 0)							--log("\nshow_login_ui399   ")-- ���ѽ���
		SkipLoadResource(0)	
				
		game_equip_creatpullPic(G_login_ui)					-- ��ק
		Fightbag_creatSmallpullPic(G_login_ui)  			-- ��ק
        Market_creatpullPicMarket(G_login_ui)				-- ��ק
		
		InitPlayerRoleInfo_ui(G_login_ui,0)					-- ��C����
		
		-- ���ý���
		SkipLoadResource(1)
		InitSetup_UI(G_login_ui, 0)
		InitSetup_FaceUI(g_setup_ui, 0)
		InitSetup_GameUI(g_setup_ui, 0)
		InitSetup_KeypressUI(g_setup_ui, 0)
		InitSetup_ImpeachUI(g_setup_ui, 0)
		InitSetup_QuitUI(g_setup_ui, 0)
		InitSetup_SafeUI(g_setup_ui, 0)
		InitSetup_AccuseUI(G_login_ui, 0)
		InitTalkMessageBox_ui(G_login_ui,0)	
		
		InitRoomList_ui(G_login_ui,0)						-- ��������
		InitRoomFounder_ui(G_login_ui,0)
		InitRoomFind_ui(G_login_ui,0)
		InitRoomPassword_ui(G_login_ui,0)
		InitRoomSet_ui(G_login_ui,0)
		
		InitInputBox_ui(G_login_ui,0)
		
		InitShopBuy_ui(G_login_ui, 0)						-- �̳ǹ������
		InitBagBuyUi(G_login_ui, 0)
		InitSetup_PassWord(G_login_ui,0)
		InitLoading_ui(G_login_ui,0)
		
		InitMessageBox_ui(G_login_ui,0)
		InitExitWait_ui(G_login_ui,0)
		InitEqMessageBox_ui(G_login_ui,0)
		InitAutoBox_ui(G_login_ui,0)	
		SkipLoadResource(0)
				
	end
	G_login_ui:SetVisible(bisopen)
end

function CreateHall()
	ShopCreateResource()
	
	g_game_hero_ui:CreateResource()
	g_PlayerInfo_ui:CreateResource()
	g_game_heroTalent_ui:CreateResource()
	g_game_fight_ui:CreateResource()
	g_GameTeamFight_ui:CreateResource()
	
	g_task_ui:CreateResource()
	g_task_signin_ui:CreateResource()
	g_task_limittime_ui:CreateResource()
	g_task_growup_ui:CreateResource()
	g_task_sevenday_ui:CreateResource()
	g_task_newserver_ui:CreateResource()
	
	g_game_start_ui:CreateResource()
	g_game_chosehero_ui:CreateResource()
	g_game_SkinFrame_ui:CreateResource()
	n_summonerskill_ui:CreateResource()
	
	n_roomlist_ui:CreateResource()
	n_roomfounder_ui:CreateResource()
	n_roomfind_ui:CreateResource()
	n_roompassword_ui:CreateResource()
	n_roomset_ui:CreateResource()	
	
end
function ReleaseHall()
	ShopDeleteResource()
	
	g_game_hero_ui:DeleteResource()
	g_PlayerInfo_ui:DeleteResource()
	g_game_heroTalent_ui:DeleteResource()
	g_game_fight_ui:DeleteResource()
	g_GameTeamFight_ui:DeleteResource()
	
	g_task_ui:DeleteResource()
	g_task_signin_ui:DeleteResource()
	g_task_limittime_ui:DeleteResource()
	g_task_growup_ui:DeleteResource()
	g_task_sevenday_ui:DeleteResource()
	g_task_newserver_ui:DeleteResource()
	
	g_game_start_ui:DeleteResource()
	g_game_chosehero_ui:DeleteResource()
	g_game_SkinFrame_ui:DeleteResource()
	n_summonerskill_ui:DeleteResource()
	
	n_roomlist_ui:DeleteResource()
	n_roomfounder_ui:DeleteResource()
	n_roomfind_ui:DeleteResource()
	n_roompassword_ui:DeleteResource()
	n_roomset_ui:DeleteResource()
	
end












