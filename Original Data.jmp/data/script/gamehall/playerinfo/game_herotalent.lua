include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

local btn_AP = nil
local btn_AD = nil
local btn_TANK = nil
local Font_page = {}				-- 10��ҳ�水ť
local PosX_page = {}				-- 10��ҳ�水ť��X��λ��
local btnDown_page = nil			-- ����ȥ��ҳ��
local btnDown_pageFont = nil		-- ����ȥ��ҳ���ҳ��
local Font_PageFlag = {}
local PageFlagBool = {}
local numPage = 1
local TalentPageIndex = {}			-- û�����ص�ҳ��
local btn_pageD = nil				-- ҳ���ļӺš�+��
local index_pageD = 0 				-- ҳ��ӺŰ���ȥ�Ĵ���

-- ����ר���ȵ�10/15
local Font_LEFT = nil				-- ʣ������Ŀؼ�
local Font_AP = nil
local Font_AD = nil
local Font_TANK = nil
local NUM_LEFT = 30					-- ʣ�����
local NUM_AP = 0
local NUM_AD = 0
local NUM_TANK = 0
local btnD_AP = nil 				-- ����ר����+��ť
local btnP_AP = nil 				-- ����ר����-��ť
local btnD_AD = nil 				-- ����ר����+��ť
local btnP_AD = nil 				-- ����ר����-��ť
local btnD_TANK = nil 				-- ͨ��ר����+��ť
local btnP_TANK = nil 				-- ͨ��ר����-��ť

local index_AP_BK = {}				-- ����ר�����ұ�С�ӵ��
local index_AP = {}					-- ����ר�����ұ�С�ӵ�
local index_AD_BK = {}				-- ����ר�����ұ�С�ӵ��
local index_AD = {}					-- ����ר�����ұ�С�ӵ�
local index_TANK_BK = {}			-- ͨ��ר�����ұ�С�ӵ��
local index_TANK = {}				-- ͨ��ר�����ұ�С�ӵ�

-- ����ר��
local AP_pic = {}
local AP_side = {}
local AP_hide = {}
local AP_plus = {}
local AP_lock = {}

-- ����ר��
local AD_pic = {}
local AD_side = {}
local AD_hide = {}
local AD_plus = {}
local AD_lock = {}

-- ͨ��ר��
local TANK_pic = {}
local TANK_side = {}
local TANK_hide = {}
local TANK_plus = {}
local TANK_lock = {}

-- ������ֽ��գ�������������ͨ�á�����ר���������츳
local FontTextTable = {}
FontTextTable.ap = {}
FontTextTable.ad = {}
FontTextTable.tank = {}
local FontText_AP = nil
local FontText_AD = nil
local FontText_TANK = nil
local FontText_Single = nil
local FontText_Talent = nil
local FontText_Single_Info = ""
local FontText_Talent_Info = ""
local AP_hideIStouch = true
local posy = -100
local m_SelTalentPage = 1

function InitGame_HeroTalentUI(wnd, bisopen)
	g_game_heroTalent_ui = CreateWindow(wnd.id, 0, 100, 1280, 700)
	InitMainGame_HeroTalent(g_game_heroTalent_ui)
	g_game_heroTalent_ui:SetVisible(bisopen)
end
function InitMainGame_HeroTalent(wnd)
	wnd:AddImage(path_info.."line_talent.png",0,160+posy,1024,2)
		
	btn_AP = wnd:AddTwoButton(path_info.."smalllist1_info.png",path_info.."smalllist2_info.png",path_info.."smalllist3_info.png",180,110+posy,128,64)
	btn_AP:AddFont("����(AP)", 15, 8, 0, 0, 128, 42, 0xbeb5ee)
	btn_AP.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XIsClickTalentApTuiJian(1)
		btn_AD:SetButtonFrame(0)
		btn_TANK:SetButtonFrame(0)
		Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 1
	end
	
	btn_AD = wnd:AddTwoButton(path_info.."smalllist1_info.png",path_info.."smalllist2_info.png",path_info.."smalllist3_info.png",300,110+posy,128,64)
	btn_AD:AddFont("����(AD)", 15, 8, 0, 0, 128, 42, 0xbeb5ee)
	btn_AD.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XIsClickTalentAdTuiJian(1)
		btn_AP:SetButtonFrame(0)
		btn_TANK:SetButtonFrame(0)
		Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 1
	end
	
	btn_TANK = wnd:AddTwoButton(path_info.."smalllist1_info.png",path_info.."smalllist2_info.png",path_info.."smalllist3_info.png",420,110+posy,128,64)
	btn_TANK:AddFont("̹��(Tank)", 15, 8, 0, 0, 128, 42, 0xbeb5ee)
	btn_TANK.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XIsClickTalentTankTuiJian(1)
		btn_AD:SetButtonFrame(0)
		btn_AP:SetButtonFrame(0)
		Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 1
	end
	-- ���ҳ���ġ�+��
	btn_pageD = wnd:AddButton(path_shop.."D_rec.png", path_shop.."D1_rec.png", path_shop.."D2_rec.png",1150,130+posy,30,30)
	btn_pageD.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XClickAddTalentPage(1)
		-- index_pageD = index_pageD + 1
		-- for index,value in pairs(Font_page) do
			-- Font_page[index]:SetPosition(PosX_page[index]-33*index_pageD,114)
			-- if PosX_page[index]-33*index_pageD > 1100 then
				-- Font_page[index]:SetVisible(0)
			-- else
				-- Font_page[index]:SetVisible(1)
			-- end
		-- end
		-- if index_pageD >= 9 then
			-- btn_pageD:SetVisible(0)
		-- end
		-- btnDown_page:SetPosition(1098,114)
		-- btnDown_pageFont:SetFontText(index_pageD+1,0x83d1e7)
	end
	--------------�ӵ�һҳ����ʮҳ�İ�ť
	for i =1,10 do
		PosX_page[i] = 33*i+1065
		Font_page[i] = wnd:AddButton(path_info.."page1_talent.png",path_info.."page2_talent.png",path_info.."page3_talent.png",PosX_page[i],114+posy,64,64)
		Font_page[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			m_SelTalentPage = i
			local Li,Ti = Font_page[i]:GetPosition()
			btnDown_page:SetPosition(Li,114+posy)
			btn_AP:SetButtonFrame(0)
			btn_AD:SetButtonFrame(0)
			btn_TANK:SetButtonFrame(0)
			numPage = i
			-- log("\nnumPage = ".. numPage)
			-- log("\nTalentPageIndexlong = ".. #TalentPageIndex)
			-- log("\nTalentPageIndex = ".. TalentPageIndex[numPage])
			XIsClickTalentPage(1, TalentPageIndex[numPage])		-- C�����������Ǵ�0��ʼ�����
		end	
		Font_PageFlag[i] = Font_page[i]:AddFont(i, 15, 0, 21, 22, 100, 15, 0x83d1e7)
		PageFlagBool[i] = 0
		if PosX_page[i] > 1100 then
			Font_page[i]:SetVisible(0)
		else
			Font_page[i]:SetVisible(1)
		end
	end
	-- ����ȥ��ҳ�����ʾ
	btnDown_page = wnd:AddImage(path_info.."page3_talent.png",1098,114+posy,64,64)
	btnDown_pageFont = btnDown_page:AddFont("1", 15, 0, 21, 22, 100, 15, 0x83d1e7)
	
	-- ����ר��
	wnd:AddImage(path_info.."talentBK1_info.png",83,188+posy,264,541)
	btnD_AP = wnd:AddButton(path_shop.."D_rec.png", path_shop.."D1_rec.png", path_shop.."D2_rec.png",265,198+posy,30,30)
	btnD_AP.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointAdd(1, 1)	-- 1����ǰ��APר��
	end
	btnP_AP = wnd:AddButton(path_shop.."P_rec.png",path_shop.."P1_rec.png",path_shop.."P2_rec.png",302,198+posy,30,30)
	btnP_AP.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointPus(1, 1)
	end
	Font_AP = wnd:AddFont(NUM_AP.."/15", 15, 0, 192, 203+posy, 100, 15, 0x7787c3)
	local AP_tiphide = {}
	for i=1,15 do
		local pA = math.ceil(i/3)
		local indexA_posY = 229+20*i+(pA-1)*22+posy
		index_AP_BK[i] = wnd:AddImage(path_info.."indexBK_talent.png",103,indexA_posY,16,16)
		index_AP[i] = wnd:AddImage(path_info.."indexD_talent.png",103,indexA_posY,16,16)
		index_AP[i]:SetVisible(0)
		
		---�͵ı�������
		local APY = 82*math.ceil(i/3)+167+posy
		local APX = 64*((i-1)%3)+140
		
		AP_pic[i] = wnd:AddImage(path_equip.."bag_equip.png",APX,APY,54,54)
		AP_side[i] = wnd:AddImage(path_shop.."iconside_shop.png",APX,APY,54,54)
		AP_hide[i] = wnd:AddImage(path_info.."hide_talent.png",APX,APY,65,65)
		AP_plus[i] = wnd:AddImage(path_info.."plus_talent.png",APX,APY,64,64)
		AP_plus[i]:SetTouchEnabled(0)
		AP_lock[i] = wnd:AddImage(path_info.."lock_info.png",APX,APY,64,64)	
		AP_plus[i]:SetVisible(0)
		AP_hide[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			AP_hide[i]:SetVisible(0)
			AP_plus[i]:SetVisible(0)
			if i%3 == 0 then
				AP_hide[i-1]:SetVisible(1)
				AP_hide[i-2]:SetVisible(1)
				AP_plus[i-1]:SetVisible(1)
				AP_plus[i-2]:SetVisible(1)
			elseif i%3 == 2 then
				AP_hide[i-1]:SetVisible(1)
				AP_hide[i+1]:SetVisible(1)
				AP_plus[i-1]:SetVisible(1)
				AP_plus[i+1]:SetVisible(1)
			else
				AP_hide[i+1]:SetVisible(1)
				AP_hide[i+2]:SetVisible(1)
				AP_plus[i+1]:SetVisible(1)
				AP_plus[i+2]:SetVisible(1)
			end
			
			-- ���߼������������ÿ�����
			local row = 0
			if i/3 <= 1 then
				row = 0
			elseif i/3 <= 2 and i/3 > 1 then
				row = 1
			elseif i/3 <= 3 and i/3 > 2 then
				row = 2
			elseif i/3 <= 4 and i/3 > 3 then
				row = 3
			elseif i/3 <= 5 and i/3 > 4 then
				row = 4
			else

			end
			XClickTalentIcon(1, 1, row, i + 15)
			AP_hideIStouch = true
		end
	end
	--for i=1,NUM_AP do
	--	index_AP[i]:SetVisible(1)
	--end
	
	
	----����ר��
	wnd:AddImage(path_info.."talentBK1_info.png",366,188+posy,264,541)
	btnD_AD = wnd:AddButton(path_shop.."D_rec.png", path_shop.."D1_rec.png", path_shop.."D2_rec.png",548,198+posy,30,30)
	btnD_AD.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointAdd(1, 0)	-- 0����ǰ��ADר��
	end
	btnP_AD = wnd:AddButton(path_shop.."P_rec.png",path_shop.."P1_rec.png",path_shop.."P2_rec.png",585,198+posy,30,30)
	btnP_AD.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointPus(1, 0)
	end
	Font_AD = wnd:AddFont(NUM_AD.."/15", 15, 0, 475, 203+posy, 100, 15, 0x7787c3)
	for i=1,15 do
		local pB = math.ceil(i/3)
		local indexB_posY = 229+20*i+(pB-1)*22+posy
		index_AD_BK[i] = wnd:AddImage(path_info.."indexBK_talent.png",386,indexB_posY,16,16)
		index_AD[i] = wnd:AddImage(path_info.."indexD_talent.png",386,indexB_posY,16,16)
		index_AD[i]:SetVisible(0)
		
		---�͵ı�������
		local ADY = 82*math.ceil(i/3)+167+posy
		local ADX = 64*((i-1)%3)+423
		
		AD_pic[i] = wnd:AddImage(path_equip.."bag_equip.png",ADX,ADY,54,54)
		AD_side[i] = wnd:AddImage(path_shop.."iconside_shop.png",ADX,ADY,54,54)
		AD_hide[i] = wnd:AddImage(path_info.."hide_talent.png",ADX,ADY,65,65)
		AD_plus[i] = wnd:AddImage(path_info.."plus_talent.png",ADX,ADY,64,64)
		AD_plus[i]:SetTouchEnabled(0)
		AD_lock[i] = wnd:AddImage(path_info.."lock_info.png",ADX,ADY,64,64)
		
		AD_plus[i]:SetVisible(0)
		AD_hide[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			AD_hide[i]:SetVisible(0)
			AD_plus[i]:SetVisible(0)
			if i%3 == 0 then
				AD_hide[i-1]:SetVisible(1)
				AD_hide[i-2]:SetVisible(1)
				AD_plus[i-1]:SetVisible(1)
				AD_plus[i-2]:SetVisible(1)
			elseif i%3 == 2 then
				AD_hide[i-1]:SetVisible(1)
				AD_hide[i+1]:SetVisible(1)
				AD_plus[i-1]:SetVisible(1)
				AD_plus[i+1]:SetVisible(1)
			else
				AD_hide[i+1]:SetVisible(1)
				AD_hide[i+2]:SetVisible(1)
				AD_plus[i+1]:SetVisible(1)
				AD_plus[i+2]:SetVisible(1)
			end
			
			-- ���߼������������ÿ�����
			local row = 0
			if i/3 <= 1 then
				row = 0
			elseif i/3 <= 2 and i/3 > 1 then
				row = 1
			elseif i/3 <= 3 and i/3 > 2 then
				row = 2
			elseif i/3 <= 4 and i/3 > 3 then
				row = 3
			elseif i/3 <= 5 and i/3 > 4 then
				row = 4
			else
				
			end
			XClickTalentIcon(1, 0, row, i)
		end
	end
	--for i=1,NUM_AD do
	--	index_AD[i]:SetVisible(1)
	--end
	
	
	
	-- ͨ��ר��
	wnd:AddImage(path_info.."talentBK1_info.png",649,188+posy,264,541)
	btnD_TANK = wnd:AddButton(path_shop.."D_rec.png", path_shop.."D1_rec.png", path_shop.."D2_rec.png",831,198+posy,30,30)
	btnD_TANK.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointAdd(1, 2)	-- 2����ǰ��TANKר��
	end
	btnP_TANK = wnd:AddButton(path_shop.."P_rec.png",path_shop.."P1_rec.png",path_shop.."P2_rec.png",868,198+posy,30,30)
	btnP_TANK.script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			XTalentPointPus(1, 2)
	end
	Font_TANK = wnd:AddFont(NUM_TANK.."/15", 15, 0, 758, 203+posy, 100, 15, 0x7787c3)
	for i=1,15 do
		local pC = math.ceil(i/3)
		local indexC_posY = 229+20*i+(pC-1)*22+posy
		index_TANK_BK[i] = wnd:AddImage(path_info.."indexBK_talent.png",669,indexC_posY,16,16)
		index_TANK[i] = wnd:AddImage(path_info.."indexD_talent.png",669,indexC_posY,16,16)
		index_TANK[i]:SetVisible(0)
		
		---�͵ı�������
		local TANKY = 82*math.ceil(i/3)+167+posy
		local TANKX = 64*((i-1)%3)+710
		
		TANK_pic[i] = wnd:AddImage(path_equip.."bag_equip.png",TANKX,TANKY,54,54)
		TANK_side[i] = wnd:AddImage(path_shop.."iconside_shop.png",TANKX,TANKY,54,54)
		TANK_hide[i] = wnd:AddImage(path_info.."hide_talent.png",TANKX,TANKY,65,65)
		TANK_plus[i] = wnd:AddImage(path_info.."plus_talent.png",TANKX,TANKY,64,64)
		TANK_plus[i]:SetTouchEnabled(0)
		TANK_lock[i] = wnd:AddImage(path_info.."lock_info.png",TANKX,TANKY,64,64)
		
		TANK_plus[i]:SetVisible(0)
		TANK_hide[i].script[XE_LBUP] = function()
			XClickPlaySound(5)
			Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
			PageFlagBool[numPage] = 1
			TANK_hide[i]:SetVisible(0)
			TANK_plus[i]:SetVisible(0)
			if i%3 == 0 then
				TANK_hide[i-1]:SetVisible(1)
				TANK_hide[i-2]:SetVisible(1)
				TANK_plus[i-1]:SetVisible(1)
				TANK_plus[i-2]:SetVisible(1)
			elseif i%3 == 2 then
				TANK_hide[i-1]:SetVisible(1)
				TANK_hide[i+1]:SetVisible(1)
				TANK_plus[i-1]:SetVisible(1)
				TANK_plus[i+1]:SetVisible(1)
			else
				TANK_hide[i+1]:SetVisible(1)
				TANK_hide[i+2]:SetVisible(1)
				TANK_plus[i+1]:SetVisible(1)
				TANK_plus[i+2]:SetVisible(1)
			end
			
			-- ���߼������������ÿ�����
			local row = 0
			if i/3 <= 1 then
				row = 0
			elseif i/3 <= 2 and i/3 > 1 then
				row = 1
			elseif i/3 <= 3 and i/3 > 2 then
				row = 2
			elseif i/3 <= 4 and i/3 > 3 then
				row = 3
			elseif i/3 <= 5 and i/3 > 4 then
				row = 4
			else
				
			end
			XClickTalentIcon(1, 2, row, i + 30)
		end
	end
	--for i=1,NUM_TANK do
	--	index_TANK[i]:SetVisible(1)
	--end
	
	
	-------�츳����
	wnd:AddImage(path_info.."talentBK2_info.png",954,188+posy,235,544)
	
	local TalentNameInputEdit = CreateWindow(wnd.id, 985,225+posy, 256, 64)
	TalentNameInput = TalentNameInputEdit:AddEdit(path_info.."name_talent.png","","onSearchEnter","",16,5,5,170,30,0xffffffff,0xff000000,0,"")
	XEditSetMaxByteLength(TalentNameInput.id,15)
	
	------���桢�ָ�����ա�ɾ��
	local btn_save = wnd:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",985,270+posy,83,35)
	btn_save:AddFont("����", 15, 0, 22, 7, 100, 15, 0xbeb5ee)
	local btn_recover = wnd:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",1075,270+posy,83,35)
	btn_recover:AddFont("�ָ�", 15, 0, 22, 7, 100, 15, 0xbeb5ee)
	local btn_clear = wnd:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",985,310+posy,83,35)
	btn_clear:AddFont("���", 15, 0, 22, 7, 100, 15, 0xbeb5ee)
	local btn_delete = wnd:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",1075,310+posy,83,35)
	btn_delete:AddFont("ɾ��", 15, 0, 22, 7, 100, 15, 0xbeb5ee)
	
	btn_save.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Font_PageFlag[numPage]:SetFontText(""..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 0
		btnDown_pageFont:SetFontText(""..numPage, 0x83d1e7)
		XIsClickTalentPageSave(1, TalentNameInput:GetEdit(), numPage - 1)
	end
	btn_recover.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Font_PageFlag[numPage]:SetFontText(""..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 0
		btnDown_pageFont:SetFontText(""..numPage, 0x83d1e7)
		XIsClickTalentPageReset(1, numPage - 1)
	end
	btn_clear.script[XE_LBUP] = function()
		XClickPlaySound(5)
		Font_PageFlag[numPage]:SetFontText("*"..numPage, 0x83d1e7)
		PageFlagBool[numPage] = 1
		btnDown_pageFont:SetFontText("*"..numPage, 0x83d1e7)
		XIsClickTalentPageClear(1, numPage - 1)
	end
	btn_delete.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XIsClickTalentPageDel(1, numPage - 1)
	end
	
	wnd:AddFont("ʣ�����", 15, 0, 985, 350+posy, 100, 20, 0x7787c3)
	
	Font_LEFT = wnd:AddFont(NUM_LEFT, 15, 0, 1050, 350+posy, 100, 20, 0x83d1e7)
	
	wnd:AddFont("����ר��", 15, 0, 985, 370+posy, 100, 20, 0x7787c3)
	wnd:AddFont("�����츳", 15, 0, 985, 490+posy, 100, 20, 0x7787c3)
	
	
	wnd:AddImage(path_info.."Font1_talent.png",83,122+posy,128,32)
	wnd:AddImage(path_info.."Font2_talent.png",93,204+posy,128,32)
	wnd:AddImage(path_info.."Font3_talent.png",376,204+posy,128,32)
	wnd:AddImage(path_info.."Font4_talent.png",659,204+posy,128,32)
	wnd:AddImage(path_info.."Font5_talent.png",968,202+posy,128,32)
	
	FontText_AP = wnd:AddFont("", 15, 0, 100, 650+posy, 200, 100, 0x83d1e6)
	FontText_AD = wnd:AddFont("", 15, 0, 383, 650+posy, 200, 100, 0x83d1e6)
	FontText_TANK = wnd:AddFont("", 15, 0, 666, 650+posy, 200, 100, 0x83d1e6)
	FontText_Single = wnd:AddFont("", 12, 0, 985, 389+posy, 180, 200, 0x83d1e7)
	FontText_Talent = wnd:AddFont("", 12, 0, 985, 509+posy, 180, 200, 0x83d1e7)
	
	
end

-------------������ֽ��գ�������������ͨ�á�����ר���������츳
function FiveFontFormCPP(Font1,Font2,Font3,Font4,Font5)
	FontText_AP:SetFontText(Font1,0x83d1e7)
	FontText_AD:SetFontText(Font2,0x83d1e7)
	FontText_TANK:SetFontText(Font3,0x83d1e7)
	FontText_Single:SetFontText(Font4,0x83d1e7)
	FontText_Talent:SetFontText(Font5,0x83d1e7)
end

function SetGameHeroTalentIsVisible(flag) 
	if g_game_heroTalent_ui ~= nil then
		if flag == 1 and g_game_heroTalent_ui:IsVisible() == false then
			g_game_heroTalent_ui:SetVisible(1)
			SetGameSkinFrameIsVisible(0)
		elseif flag == 0 and g_game_heroTalent_ui:IsVisible() == true then
			-- log("\nm_SelTalentPage = "..m_SelTalentPage)
			ColseTalentSelTalent(m_SelTalentPage)
			XIsCloseTatle(1)
			g_game_heroTalent_ui:SetVisible(0)
			btn_AP:SetButtonFrame(0)
			btn_AD:SetButtonFrame(0)
			btn_TANK:SetButtonFrame(0)
		end
	end
end
function SetTatleUiVisible(cVisible)
	SetGameHeroTalentIsVisible(cVisible)
end

function GetGameHeroTalentIsVisible()  
    if(g_game_heroTalent_ui:IsVisible()) then
       -- XGameHeroSkinIsOpen(1)
    else
       -- XGameHeroSkinIsOpen(0)
    end
end

-- �õ��츳ר����һ�ȼ������Ϣ����C++����
function GetTalentNextLevelAttribute( Tipstr, ID, Level, Type)
	if (Type == 0) then
		FontText_AD:SetFontText("��һ�ȼ�\n"..Tipstr, 0xff83d1e7)
	elseif (Type == 1) then
		FontText_AP:SetFontText("��һ�ȼ�\n"..Tipstr, 0xff83d1e7)
	elseif (Type == 2) then
		FontText_TANK:SetFontText("��һ�ȼ�\n"..Tipstr, 0xff83d1e7)
	else
		
	end
end

-- �õ��Ѿ�ʹ�õĵ�����15/15��
function SetTatleUsedPointToLua( strTemp, TypeIdx, point)
	if (TypeIdx == 0) then
		AutoDrawTable(point, TypeIdx)
		Font_AD:SetFontText(strTemp, 0x7787c3)
	elseif (TypeIdx == 1) then
		AutoDrawTable(point, TypeIdx)
		Font_AP:SetFontText(strTemp, 0x7787c3)
	elseif (TypeIdx == 2) then
		AutoDrawTable(point, TypeIdx)
		Font_TANK:SetFontText(strTemp, 0x7787c3)
	else
		
	end
end

-- �õ�ʣ�����
function SetTatleLastPointToLua( lastpoint)
	NUM_LEFT = lastpoint
	Font_LEFT:SetFontText( lastpoint, 0x83d1e7)
end

-- �õ���ǰ�츳ҳ����
function SetTatlePageName( pagename)
	TalentNameInput:SetEdit(pagename)
end

-- ����ר��
function SetSingleInfo( s_1)
	FontText_Single_Info = FontText_Single_Info..s_1
	FontText_Single:SetFontText(FontText_Single_Info, 0x83d1e7)
end

-- �����츳
function SetTatleInfo( s_1)
	FontText_Talent_Info = FontText_Talent_Info..s_1
	FontText_Talent:SetFontText(FontText_Talent_Info, 0x83d1e7)
end

-- �����������
function ClearAllFontInfo()
	FontText_Single_Info = ""
	FontText_Talent_Info = ""
	FontText_Single:SetFontText("", 0x83d1e7)
	FontText_Talent:SetFontText("", 0x83d1e7)
end

-- ����C��ȡר���ӵ��ʵ��Ч��
function AutoDrawTable(num, typeindex)
	if typeindex == 0 then
		-- AD
		NUM_AD = num
		for index,value in pairs(index_AD) do
			index_AD[index]:SetVisible(0)
		end
		
		if NUM_AD > 0 then
			for i=1,NUM_AD do
				index_AD[i]:SetVisible(1)
				-- ȥ�����ֺ���
				if i%3==0 then
					local tempnum = 1 + ((i/3)-1)*3
					for j=tempnum, tempnum+2 do
						AD_lock[j]:SetVisible(0)
						AD_plus[j]:SetVisible(1)
					end
				end
			end
		end
	elseif typeindex == 1 then
		-- AP
		NUM_AP = num
		for index,value in pairs(index_AP) do
			index_AP[index]:SetVisible(0)
		end
		
		if NUM_AP > 0 then
			for i=1,NUM_AP do
				index_AP[i]:SetVisible(1)
				-- ȥ�����ֺ���
				if i%3==0 then
					local tempnum = 1 + ((i/3)-1)*3
					for j=tempnum, tempnum+2 do
						AP_lock[j]:SetVisible(0)
						AP_plus[j]:SetVisible(1)
					end
				end
			end
		end
	elseif typeindex == 2 then
		-- TANK
		NUM_TANK = num
		for index,value in pairs(index_TANK) do
			index_TANK[index]:SetVisible(0)
		end
		
		if NUM_TANK > 0 then
			for i=1,NUM_TANK do
				index_TANK[i]:SetVisible(1)
				-- ȥ�����ֺ���
				if i%3==0 then
					local tempnum = 1 + ((i/3)-1)*3
					for j=tempnum, tempnum+2 do
						TANK_lock[j]:SetVisible(0)
						TANK_plus[j]:SetVisible(1)
					end
				end
			end
		end
	end
end

-- ����ͼƬ��ѡ�е�״̬
function SetPicSelType( row, col, typeindex)
	if (typeindex == 0) then
		AD_hide[row * 3 + col]:SetVisible(0)
		AD_plus[row * 3 + col]:SetVisible(0)
	elseif (typeindex == 1) then
		AP_hide[row * 3 + col]:SetVisible(0)
		AP_plus[row * 3 + col]:SetVisible(0)
	elseif (typeindex == 2)then
		TANK_hide[row * 3 + col]:SetVisible(0)
		TANK_plus[row * 3 + col]:SetVisible(0)
	else
		
	end
end

-- ����ͼƬ
function ClearPic()
	NUM_TANK = 0
	NUM_AP = 0
	NUM_AD = 0
	for i = 1,15 do
		AD_plus[i]:SetVisible(0)
		AD_hide[i]:SetVisible(1)
		AD_lock[i]:SetVisible(1)
		AP_plus[i]:SetVisible(0)
		AP_hide[i]:SetVisible(1)
		AP_lock[i]:SetVisible(1)
		TANK_plus[i]:SetVisible(0)
		TANK_hide[i]:SetVisible(1)
		TANK_lock[i]:SetVisible(1)
	end
	for index,value in pairs(index_AP) do
		index_AP[index]:SetVisible(0)
	end
	for index,value in pairs(index_AD) do
		index_AD[index]:SetVisible(0)
	end
	for index,value in pairs(index_TANK) do
		index_TANK[index]:SetVisible(0)
	end
	ClearAllFontInfo()
end

-- ��
function AddPage()
	index_pageD = index_pageD + 1
	for index,value in pairs(Font_page) do
		Font_page[index]:SetPosition(PosX_page[index]-33*index_pageD,114+posy)
		if PosX_page[index]-33*index_pageD > 1100 then
			Font_page[index]:SetVisible(0)
		else
			Font_page[index]:SetVisible(1)
		end
	end
	if index_pageD >= 9 then
		btn_pageD:SetVisible(0)
	end
	btnDown_page:SetPosition(1098,114+posy)
	btnDown_pageFont:SetFontText(index_pageD+1,0x83d1e7)
end

-- ��
function PusPage()
	index_pageD = index_pageD - 1
	if index_pageD < 0 then
		index_pageD = 0
	end
	for index,value in pairs(Font_page) do
		Font_page[index]:SetPosition(PosX_page[index]-33*index_pageD,114+posy)
		if PosX_page[index]-33*index_pageD > 1100 then
			Font_page[index]:SetVisible(0)
		else
			Font_page[index]:SetVisible(1)
		end
	end
	if index_pageD < 9 then
		btn_pageD:SetVisible(1)
	end
	btnDown_page:SetPosition(1098,114+posy)
	btnDown_pageFont:SetFontText(index_pageD+1,0x83d1e7)
end

-- ���õ�ǰѡ��ҳ����ÿ�δ򿪽�����Զ�ǵ�һ����ѡ�У�
function SetSelPage( Selindex)
	Selindex = Selindex + 1
	numPage = Selindex
	m_SelTalentPage = numPage
	local Li,Ti = Font_page[Selindex]:GetPosition()
	btnDown_page:SetPosition(Li,114+posy)
	if (PageFlagBool[numPage] == 1) then
		btnDown_pageFont:SetFontText("*"..numPage,0x83d1e7)
	else
		btnDown_pageFont:SetFontText(""..numPage,0x83d1e7)
	end
end

-- �õ��츳ҳ��C++�����е���������
function GetTalentPageIndex(index, flag)
	TalentPageIndex[index] = flag
end

-- �������
function ClearData()
	if (Font_page[1] ~= nil) then
		for i = 1, 10 do
			PusPage()
			Font_PageFlag[i]:SetFontText(""..i, 0x83d1e7)
			PageFlagBool[i] = 0
		end
	end
end

-- ���ü���ͼƬ����C++�л�ȡ
function SetTalentSkillIcon( pathstr, index,tip)
	if (index >= 1 and index < 16) then
		AD_pic[index].changeimage("..\\"..pathstr)
		AD_pic[index]:SetImageTip(tip)
		AD_hide[index]:SetImageTip(tip)
		AD_lock[index]:SetImageTip(tip)
	elseif (index >= 16 and index < 31) then
		AP_pic[index - 15].changeimage("..\\"..pathstr)
		AP_pic[index - 15]:SetImageTip(tip)
		AP_hide[index - 15]:SetImageTip(tip)
		AP_lock[index - 15]:SetImageTip(tip)
	elseif (index >= 31 and index < 46) then
		TANK_pic[index - 30].changeimage("..\\"..pathstr)
		TANK_pic[index - 30]:SetImageTip(tip)
		TANK_hide[index - 30]:SetImageTip(tip)
		TANK_lock[index - 30]:SetImageTip(tip)
	else
		
	end
end