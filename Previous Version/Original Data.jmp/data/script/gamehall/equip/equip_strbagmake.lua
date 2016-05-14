include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

------------

local BagCurPage = 1
local BagAllPage = 4
local Bag_PageInfo = nil

					---------�������
local makeCurPage = 1
local makeAllPage = 3
local make_PageInfo = nil

local expLength = 0.5
local CurExp = 11111
local MaxExp = 99999
local StrExp,Exp_font = nil
local MakeIcon = nil

local EquipType,EquipSort = nil
local EquipType_BK,EquipSort_BK = nil
local Font_EquipType,Font_EquipSort = nil
local BTN_EquipType = {}
local BTN_EquipSort = {}
local EquipType_list = {"��ʾȫ��","��ͨװ��","Ӣ��ר��","������װ��","������װ��","������װ��"}
local EquipSort_list = {"�ۺ�����","������","����ǿ��","�����ٶ�","��ȴ����","�ƶ��ٶ�"}

--������
local BagItem = {}
BagItem.kuang = {}
local packageBlockA = {} --���������ڴ��װ��
packageBlockA.pic = {} --�������ͼƬ
packageBlockA.id= {} --��������װ������������Id 0 Ϊû��װ��
packageBlockA.type = {} --����������װ�����Ǳ�ʯ �ֱ��� 1��2 ��ʾװ�� �� ��ʯ 0 ����û��װ�� 


--������B--ֻ�����ڴ������Ʒ
local MakeItem = {}     
MakeItem.kuang = {}
local packageBlockB = {} --���������ڴ��װ��
packageBlockB.pic = {} --�������ͼƬ
packageBlockB.id= {} --��������װ������������Id 0 Ϊû��װ��
packageBlockB.type = {} --������������Ʒ����
packageBlockB.itemCount={}

---��ͷ���---
local LArrowButton = nil
local RArrowButton = nil
local PageNumber = 1
local PageNumberMax = 1
local PageNumberFont = nil

---��ͷ���---
local LArrowButton2 = nil
local RArrowButton2 = nil
local PageNumber2 = 1
local PageNumberMax2 = 1
local PageNumberFont2 = nil


function InitEquip_StrBagMakeUI(wnd, bisopen)
	g_str_BagMake_ui = CreateWindow(wnd.id, 640, 200, 420, 470)
		
	-- g_str_BagMake_ui:AddFont("װ������",12, 0, 20, 25, 250, 20, 0xbeb5ee)
	-- g_str_BagMake_ui:AddFont("��������",12, 0, 224, 25, 250, 20, 0xbeb5ee)
	g_str_BagMake_ui:AddFont("�������",12, 0, 20, 240, 250, 20, 0x7787c3)
	g_str_BagMake_ui:AddFont("�����ʦ Lv0",15, 0, 186, 390, 250, 20, 0x7787c3)
	
	for i=1,21 do
		local posx = 54*((i-1)%7+1)-34
		local posy = math.ceil(i/7)*54
	
		BagItem[i] = g_str_BagMake_ui:AddImage(path_equip.."bag_equip.png",posx,posy,50,50)
		packageBlockA.pic[i] = BagItem[i]:AddImage(path_equip.."bag_equip.png",0,0,50,50)
		packageBlockA.pic[i]:SetVisible(0)
		BagItem.kuang[i] = BagItem[i]:AddImage(path_equip.."kuang_equip.png",0,0,50,50)
		
		packageBlockA.pic[i].script[XE_DRAG] = function()
		    if(packageBlockA.id[i] == nil or packageBlockA.id[i] == 0) then--id������ ����Ӧ
			    return
			end
			game_equip_pullPic(packageBlockA.id[i],packageBlockA.pic[i])
			BagItem.kuang[i].changeimage(path_equip.."kuang3_equip.png")
		end
		
		packageBlockA.pic[i].script[XE_ONHOVER] = function()
			BagItem.kuang[i].changeimage(path_equip.."kuang2_equip.png")
		end
		packageBlockA.pic[i].script[XE_ONUNHOVER] = function()
			BagItem.kuang[i].changeimage(path_equip.."kuang_equip.png")
		end
		packageBlockA.pic[i].script[XE_RBUP] = function()
			if(g_str_BagMake_ui:IsVisible() == false or packageBlockA.type[i] ~=3) then
	            return
	        end
            Equip_StrMake_RClickUp(packageBlockA.id[i])
	    end
	end
	
	
	
	
		----������ͷ���----
	PageNumber = 1
	PageNumberMax =1
	
	LArrowButton = g_str_BagMake_ui:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png",165,215,27,36)
	local pageBK = LArrowButton:AddImage(path_setup.."yemadiban_mail.png", 27, 9, 42, 18)	
	PageNumberFont = pageBK:AddFont(PageNumber.."/"..PageNumberMax,15, 8, -3, 0, 32, 18, 0xffffffff)
	RArrowButton = g_str_BagMake_ui:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png",235,215,27,36)	
	XWindowEnableAlphaTouch(LArrowButton.id)
	XWindowEnableAlphaTouch(RArrowButton.id)
	LArrowButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber > 1) then
		   PageNumber = PageNumber-1
		   PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)
		   Equip_Make_PA_needEquipInfo()
		end
	end
	

	RArrowButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber < PageNumberMax) then
		   PageNumber = PageNumber+1
		   PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)
		   Equip_Make_PA_needEquipInfo()
		end
	end
	
	PageNumber2 = 1
	PageNumberMax2 =1

	
	LArrowButton2 = g_str_BagMake_ui:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png",165,325,27,36)
	local pageBK = LArrowButton2:AddImage(path_setup.."yemadiban_mail.png", 27, 9, 42, 18)	
	PageNumberFont2 = pageBK:AddFont(PageNumber2.."/"..PageNumberMax2,15, 8, -3, 0, 32, 18, 0xffffffff)
	RArrowButton2 = g_str_BagMake_ui:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png",235,325,27,36)
	XWindowEnableAlphaTouch(LArrowButton2.id)
	XWindowEnableAlphaTouch(RArrowButton2.id)	
	LArrowButton2.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber2 > 1) then
		   PageNumber2 = PageNumber2-1
		   Equip_Make_PB_needEquipInfo()
		end
	end
	

	RArrowButton2.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber2 < PageNumberMax2) then
		   PageNumber2 = PageNumber2+1
		   Equip_Make_PB_needEquipInfo()
		end
	end
	
	
	local AA = g_str_BagMake_ui:AddFont("����ս��װ�����̳ǹ���",11, 0, 260, 225, 250, 30, 0x8295cf)
	AA:SetFontSpace(1,1)
	

	
	----�������
	for i=1,7 do
		MakeItem[i] = g_str_BagMake_ui:AddImage(path_equip.."bag_equip.png",54*i-34,270,50,50)
		packageBlockB.pic[i] = MakeItem[i]:AddImageMultiple(path_equip.."bag_equip.png","","",0,0,50,50)
		packageBlockB.pic[i]:SetVisible(0)
		MakeItem.kuang[i] = MakeItem[i]:AddImage(path_equip.."kuang_equip.png",0,0,50,50)
		packageBlockB.pic[i].script[XE_DRAG] = function()
		    if(packageBlockB.id[i] == nil or packageBlockB.id[i] == 0) then--id������ ����Ӧ
			    return
			end
			game_equip_pullPic(packageBlockB.id[i],packageBlockB.pic[i])
			MakeItem.kuang[i].changeimage(path_equip.."kuang3_equip.png")
		end
		
		packageBlockB.pic[i].script[XE_ONHOVER] = function()
			MakeItem.kuang[i].changeimage(path_equip.."kuang2_equip.png")
		end
		packageBlockB.pic[i].script[XE_ONUNHOVER] = function()
			MakeItem.kuang[i].changeimage(path_equip.."kuang_equip.png")
		end
		
		packageBlockB.pic[i].script[XE_RBUP] = function()
			if(g_str_BagMake_ui:IsVisible() == false or packageBlockB.type[i] ~=5) then
	            return
	        end
            Equip_StrCost_RClickUp(packageBlockB.id[i])
	    end
	end
	
	for i=1,7 do
	    packageBlockB.itemCount[i] = packageBlockB.pic[i]:AddFont("0",12,6,-50,-33,100,17,0xFFFFFF)
	    packageBlockB.itemCount[i]:SetVisible(0)
		packageBlockB.itemCount[i]:SetFontBackground()
	end
	
	MakeIcon = g_str_BagMake_ui:AddImage(path_equip.."makemoney_equip.png",20,382,52,52)
	MakeIcon:AddImage(path_shop.."iconside_shop.png",0,0,54,54)	
	local StrExpBack = g_str_BagMake_ui:AddImage(path_equip.."StrExpBK_equip.png",90,416,308,16)	

	-------�����ʦ�ȼ�����
	StrExp = StrExpBack:AddImage(path_equip.."StrExp_equip.png",0,0,308,16)
	StrExp:SetAddImageRect(StrExp.id, 0, 0, 308*(0/500),16, 0 ,0, 308*(0/500), 16)
	Exp_font = StrExpBack:AddFontEx("0/500",15,8,0,0,308,16,0x7787c3)
	
	
	
	-- ------����������
	-- EquipType = g_str_BagMake_ui:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",85,20,128,32)
	-- Font_EquipType = EquipType:AddFont(EquipType_list[1], 12, 0, 8, 6, 100, 15, 0xbeb5ee)

	-- EquipType_BK = g_str_BagMake_ui:AddImage(path_hero.."listBK2_hero.png", 85, 50, 128, 256)
	-- g_str_BagMake_ui:SetAddImageRect(EquipType_BK.id,0,0,128,204,85,50,128,204)
	-- EquipType_BK:SetVisible(0)
	
	-- for dis = 1,6 do
		-- BTN_EquipType[dis] = g_str_BagMake_ui:AddImage(path_hero.."listhover_hero.png",85,21+dis*29,128,32)
		-- EquipType_BK:AddFont(EquipType_list[dis],12,0,8,dis*29-23,128,32,0xbeb5ee)
		-- BTN_EquipType[dis]:SetTransparent(0)	
		-- BTN_EquipType[dis]:SetTouchEnabled(0)
		-- -----------��껬��
		-- BTN_EquipType[dis].script[XE_ONHOVER] = function()
			-- if EquipType_BK:IsVisible() == true then
				-- BTN_EquipType[dis]:SetTransparent(1)
			-- end
		-- end
		-- BTN_EquipType[dis].script[XE_ONUNHOVER] = function()
			-- if EquipType_BK:IsVisible() == true then
				-- BTN_EquipType[dis]:SetTransparent(0)
			-- end
		-- end
		-- BTN_EquipType[dis].script[XE_LBUP] = function()
			-- Font_EquipType:SetFontText(EquipType_list[dis],0xbeb5ee)
			
			-- --onSearchEnter()
			-- EquipType:SetButtonFrame(0)
			-- EquipType_BK:SetVisible(0)
			-- for index,value in pairs(BTN_EquipType) do
				-- BTN_EquipType[index]:SetTransparent(0)
				-- BTN_EquipType[index]:SetTouchEnabled(0)
			-- end
		-- end
		
	-- end
	
	-- EquipType.script[XE_LBUP] = function()
		-- XClickPlaySound(5)
		-- if EquipType_BK:IsVisible() then
			-- EquipType_BK:SetVisible(0)
			-- for index,value in pairs(BTN_EquipType) do
				-- BTN_EquipType[index]:SetTransparent(0)
				-- BTN_EquipType[index]:SetTouchEnabled(0)
			-- end
		-- else
			-- EquipType_BK:SetVisible(1)
			-- for index,value in pairs(BTN_EquipType) do
				-- BTN_EquipType[index]:SetTransparent(0)
				-- BTN_EquipType[index]:SetTouchEnabled(1)
			-- end
		-- end
	-- end	

-- ---------��������
	-- EquipSort = g_str_BagMake_ui:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",288,20,128,32)
	-- Font_EquipSort = EquipSort:AddFont("�ۺ�����", 12, 0, 18, 6, 100, 15, 0xbeb5ee)

	-- EquipSort_BK = g_str_BagMake_ui:AddImage(path_hero.."listBK2_hero.png", 288, 50, 128, 256)
	-- g_str_BagMake_ui:SetAddImageRect(EquipSort_BK.id,0,0,128,210,288,50,128,210)
	-- EquipSort_BK:SetVisible(0)
	
	-- for dis = 1,6 do
		-- BTN_EquipSort[dis] = g_str_BagMake_ui:AddImage(path_hero.."listhover_hero.png",288,21+dis*29,128,32)
		-- EquipSort_BK:AddFont(EquipSort_list[dis],12,0,18,dis*29-23,128,32,0xbeb5ee)
		-- BTN_EquipSort[dis]:SetTransparent(0)	
		-- BTN_EquipSort[dis]:SetTouchEnabled(0)
		-- -----------��껬��
		-- BTN_EquipSort[dis].script[XE_ONHOVER] = function()
			-- if EquipSort_BK:IsVisible() == true then
				-- BTN_EquipSort[dis]:SetTransparent(1)
			-- end
		-- end
		-- BTN_EquipSort[dis].script[XE_ONUNHOVER] = function()
			-- if EquipSort_BK:IsVisible() == true then
				-- BTN_EquipSort[dis]:SetTransparent(0)
			-- end
		-- end
		-- BTN_EquipSort[dis].script[XE_LBUP] = function()
			-- Font_EquipSort:SetFontText(EquipSort_list[dis],0xbeb5ee)
			
			-- --onSearchEnter()
			-- EquipSort:SetButtonFrame(0)
			-- EquipSort_BK:SetVisible(0)
			-- for index,value in pairs(BTN_EquipSort) do
				-- BTN_EquipSort[index]:SetTransparent(0)
				-- BTN_EquipSort[index]:SetTouchEnabled(0)
			-- end
		-- end
		
	-- end
	
	-- EquipSort.script[XE_LBUP] = function()
		-- XClickPlaySound(5)
		-- if EquipSort_BK:IsVisible() then
			-- EquipSort_BK:SetVisible(0)
			-- for index,value in pairs(BTN_EquipSort) do
				-- BTN_EquipSort[index]:SetTransparent(0)
				-- BTN_EquipSort[index]:SetTouchEnabled(0)
			-- end
		-- else
			-- EquipSort_BK:SetVisible(1)
			-- for index,value in pairs(BTN_EquipSort) do
				-- BTN_EquipSort[index]:SetTransparent(0)
				-- BTN_EquipSort[index]:SetTouchEnabled(1)
			-- end
		-- end
	-- end	
	
	
	g_str_BagMake_ui:SetVisible(bisopen)
end

function Equip_Make_PA_needEquipInfo()	--װ��
    if(g_str_BagMake_ui:IsVisible() == false) then
        return
	end	
	Equip_Make_PA_cleanALl_ItemInfo()

	PageNumberMax = math.ceil(equipTypeNumber[3]/21)
	PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)
	
	if(PageNumber == 1) then
		LArrowButton:SetEnabled(0)		   
    else
		LArrowButton:SetEnabled(1)				   
	end
	if(PageNumber == PageNumberMax) then
		RArrowButton:SetEnabled(0)
    else
		RArrowButton:SetEnabled(1)		   
    end
	
    local i = 0
	local j = 0
	for index,value in pairs(equipManage.CitemIndex) do
	    if(equipManage.type[index] == 3) then
		    j = j+1	
			if(i<21 and j>((PageNumber-1)*21)) then	
                i=i+1			
	            packageBlockA.pic[i].changeimage(equipManage.picPath[index])
		        packageBlockA.pic[i]:SetVisible(1)
		    	packageBlockA.pic[i]:SetImageTip(equipManage.tip[index])
                packageBlockA.id[i] = equipManage.id[index]
                packageBlockA.type[i] = equipManage.type[index]	
				if(equipManage.itemAnimation[index] ~= -1) then
			        packageBlockA.pic[i]:EnableImageAnimate(1,equipManage.itemAnimation[index],15,5)
			    end	
		    end	
		end	
	end
end

function Equip_StrAlchemySkillData(uLevel,uExp)
    -- �����ʦ�ȼ�����
	-- log("�����ʦ�ȼ�����")
	CurExp = uExp
	if(uLevel == 0) then
	    MaxExp = 500
	elseif(uLevel == 1) then
	    MaxExp = 750
	elseif(uLevel == 2) then
        MaxExp = 1000
	elseif(uLevel == 3) then
        MaxExp = 1400
	elseif(uLevel == 4) then
        MaxExp = 2300
	elseif(uLevel == 5) then	
	    StrExp:SetAddImageRect(StrExp.id, 0, 0, 308, 16, 0 ,0, 308, 16)
		Exp_font:SetVisible(0)
		ProduceTitle:SetFontText("�����ʦ Lv"..uLevel, 0x7787c3)
		return
	end
	StrExp:SetAddImageRect(StrExp.id, 0, 0, 308*(CurExp/MaxExp), 16, 0 ,0, 308*(CurExp/MaxExp), 16)
	Exp_font:SetFontText(CurExp.."/"..MaxExp,0x7787c3)
	ProduceTitle:SetFontText("�����ʦ Lv"..uLevel, 0x7787c3)
end

function Equip_Make_PA_cleanALl_ItemInfo() --װ��
    for index =1,21 do
	    packageBlockA.pic[index].changeimage() --�������ͼƬ
		packageBlockA.pic[index]:SetVisible(0)
		packageBlockA.pic[index]:SetImageTip(0)
		if(packageBlockA.pic[index]:GetBoolImageAnimate() == 1) then
		    packageBlockA.pic[index]:CleanImageAnimate()
		end
	end
	packageBlockA.id = {}
    packageBlockA.type = {}
end

function Equip_Make_PB_needEquipInfo()	--��������Ʒ
    if(g_str_BagMake_ui:IsVisible() == false) then
        return
	end	
	Equip_Make_PB_cleanALl_ItemInfo()
    local i = 0
	local j = 0
	PageNumberMax2 = CaculatepageMax(equipTypeNumber[5],7)
	PageNumberFont2:SetFontText(PageNumber2.."/"..PageNumberMax2,0xbeb5ee)
	
	
	if(PageNumber2 == 1) then
		LArrowButton2:SetEnabled(0)		   
    else
		LArrowButton2:SetEnabled(1)				   
	end
	if(PageNumber2 == PageNumberMax2) then
		RArrowButton2:SetEnabled(0)
    else
		RArrowButton2:SetEnabled(1)		   
    end
	
	for index,value in pairs(equipManage.CitemIndex) do
	    if(equipManage.type[index] == 5) then
		    j = j+1	
	        if(i<7 and j>((PageNumber2-1)*7)) then
                i=i+1				
	            packageBlockB.pic[i].changeimageMultiple(equipManage.picPath[index],equipManage.picPath1[index],equipManage.picPath2[index])
		        packageBlockB.pic[i]:SetVisible(1)
			    packageBlockB.pic[i]:SetImageTip(equipManage.tip[index])
                packageBlockB.id[i] = equipManage.id[index]
                packageBlockB.type[i] = equipManage.type[index]
				packageBlockB.itemCount[i]:SetFontText(equipManage.itemCount[index])
				if(equipManage.itemCount[index]>1) then
			        packageBlockB.itemCount[i]:SetVisible(1)
		        else 
			        packageBlockB.itemCount[i]:SetVisible(0)
		        end
		    end	
		end	
	end
end

function Equip_Make_PB_cleanALl_ItemInfo() --��������Ʒ
    for index =1,7 do
	    packageBlockB.pic[index].changeimage() --�������ͼƬ
		packageBlockB.pic[index]:SetVisible(0)
		packageBlockB.pic[index]:SetImageTip(0)
		packageBlockB.itemCount[index]:SetFontText("0",0xFFFFFF)
	end
	packageBlockB.id = {}
    packageBlockB.type = {}
end


---������ק---
--PA---
function Equip_Make_PA_pullPicXLUP()
    if(g_str_BagMake_ui:IsVisible() == false or pullPicType.type ~=3) then
	    return
	end
    local tempRanking = Equip_Make_PA_checkRect() --�ж��Ƿ��ڰ�����
	local oldranking = Equip_Make_PA_getPullPicIndexInPackage(pullPicType.id) --�õ��ϵ�λ��
	if(oldranking<=21 and oldranking>=1) then
	    BagItem.kuang[oldranking].changeimage(path_equip.."kuang_equip.png")	
    end	
	if(tempRanking == 0) then
	    return
	end
	if(oldranking~=0 and packageBlockA.id[tempRanking] ~= 0 and packageBlockA.id[tempRanking]~= nil) then
		Equip_Make_PA_change(oldranking,packageBlockA.id[tempRanking])--����ڱ����ڴ���		
	elseif(oldranking~=0 and (packageBlockA.id[tempRanking] == 0 or packageBlockA.id[tempRanking]== nil)) then
		Equip_Make_PA_cleanOne_ItemInfo(oldranking)
	end
    Equip_Make_PA_change(tempRanking,pullPicType.id) 
end

function Equip_Make_PA_checkRect() --�ж��Ƿ��ڰ�����
    for i = 1,21 do
	    if(CheckEquipPullResult(BagItem[i])) then
		    return i
		end
	end
	return 0
end
function Equip_Make_PA_getPullPicIndexInPackage(id) --�õ��ϵ�λ��
   for i = 1,21 do
	    if(packageBlockA.id[i]== id) then
		    return i
		end
	end
	return 0
end


function Equip_Make_PA_change(ranking,id)--λ�� �����ݿ����id
    packageBlockA.id[ranking] = id
	packageBlockA.pic[ranking].changeimage(equipManage.picPath[id])--����ͼƬ
    packageBlockA.type[ranking] = equipManage.type[id]
	packageBlockA.pic[ranking]:SetVisible(1)
	packageBlockA.pic[ranking]:SetImageTip(equipManage.tip[id])
	if(equipManage.itemAnimation[id] ~= -1) then
		packageBlockA.pic[ranking]:EnableImageAnimate(1,equipManage.itemAnimation[id],15,5)             
    else
	    if(packageBlockA.pic[ranking]:GetBoolImageAnimate() == 1) then
		    packageBlockA.pic[ranking]:CleanImageAnimate()
		end
	end
end
function Equip_Make_PA_cleanOne_ItemInfo(ranking)
    packageBlockA.pic[ranking].changeimage() --�������ͼƬ
	packageBlockA.pic[ranking]:SetVisible(0)
	packageBlockA.pic[ranking]:SetImageTip(0)
	packageBlockA.id[ranking] = 0
    packageBlockA.type[ranking] = 0
end


function Equip_Make_PB_pullPicXLUP()
    if(g_str_BagMake_ui:IsVisible() == false or pullPicType.type ~=5) then
	    return
	end
    local tempRanking = Equip_Make_PB_checkRect() --�ж��Ƿ��ڰ�����
	local oldranking = Equip_Make_PB_getPullPicIndexInPackage(pullPicType.id) --�õ��ϵ�λ��
	if(oldranking<=7 and oldranking>=1) then
	    MakeItem.kuang[oldranking].changeimage(path_equip.."kuang_equip.png")	
    end	
	if(tempRanking == 0) then
	    return
	end
	if(oldranking~=0 and packageBlockB.id[tempRanking] ~= 0 and packageBlockB.id[tempRanking]~= nil) then
		Equip_Make_PB_change(oldranking,packageBlockB.id[tempRanking])--����ڱ����ڴ���		
	elseif(oldranking~=0 and (packageBlockB.id[tempRanking] == 0 or packageBlockB.id[tempRanking]== nil)) then
		Equip_Make_PB_cleanOne_ItemInfo(oldranking)
	end
    Equip_Make_PB_change(tempRanking,pullPicType.id) 
end

function Equip_Make_PB_checkRect() --�ж��Ƿ��ڰ�����
    for i = 1,7 do
	    if(CheckEquipPullResult(MakeItem[i])) then
		    return i
		end
	end
	return 0
end
function Equip_Make_PB_getPullPicIndexInPackage(id) --�õ��ϵ�λ��
   for i = 1,7 do
	    if(packageBlockB.id[i]== id) then
		    return i
		end
	end
	return 0
end


function Equip_Make_PB_change(ranking,id)--λ�� �����ݿ����id
    packageBlockB.id[ranking] = id
	packageBlockB.pic[ranking].changeimageMultiple(equipManage.picPath[id],equipManage.picPath1[id],equipManage.picPath2[id])
    packageBlockB.type[ranking] = equipManage.type[id]
	packageBlockB.pic[ranking]:SetVisible(1)
	packageBlockB.pic[ranking]:SetImageTip(equipManage.tip[id])
	packageBlockB.itemCount[ranking]:SetFontText(equipManage.itemCount[id]) 
	if(equipManage.itemCount[id]>1) then
		packageBlockB.itemCount[ranking]:SetVisible(1)
	else 
		packageBlockB.itemCount[ranking]:SetVisible(0)
	end
end
function Equip_Make_PB_cleanOne_ItemInfo(ranking)
    packageBlockB.pic[ranking].changeimage() --�������ͼƬ
	packageBlockB.pic[ranking]:SetVisible(0)
	packageBlockB.pic[ranking]:SetImageTip(0)
	packageBlockB.itemCount[ranking]:SetFontText("0",0xFFFFFF)
	packageBlockB.id[ranking] = 0
    packageBlockB.type[ranking] = 0
end


function Equip_Make_cleanPage()
    PageNumber = 1
	PageNumberMax = 1
end
function Equip_Make_cleanPage2()
    PageNumber2 = 1
	PageNumberMax2 = 1
end

function Equip_Make_needEquipInfo()
    if(g_str_BagMake_ui:IsVisible() == false) then
        return
	end	
    local i = 0
	local j = 0
	local k = 0
	local w = 0
	Equip_Make_PA_cleanALl_ItemInfo()
	Equip_Make_PB_cleanALl_ItemInfo()
	PageNumberMax = CaculatepageMax(equipTypeNumber[3],21)
	PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)

	PageNumberMax2 = CaculatepageMax(equipTypeNumber[5],7)
	PageNumberFont2:SetFontText(PageNumber2.."/"..PageNumberMax2,0xbeb5ee)
	
	if(PageNumber == 1) then
		LArrowButton:SetEnabled(0)		   
    else
		LArrowButton:SetEnabled(1)				   
	end
	if(PageNumber == PageNumberMax) then
		RArrowButton:SetEnabled(0)
    else
		RArrowButton:SetEnabled(1)		   
    end
	
	if(PageNumber2 == 1) then
		LArrowButton2:SetEnabled(0)		   
    else
		LArrowButton2:SetEnabled(1)				   
	end
	if(PageNumber2 == PageNumberMax2) then
		RArrowButton2:SetEnabled(0)
    else
		RArrowButton2:SetEnabled(1)		   
    end
	
	
	for index,value in pairs(equipManage.CitemIndex) do
        if(equipManage.type[index] == 3) then
		    k = k+1	
			if(i<21 and k>((PageNumber-1)*21)) then	
                i=i+1			
	            packageBlockA.pic[i].changeimage(equipManage.picPath[index])
		        packageBlockA.pic[i]:SetVisible(1)
		    	packageBlockA.pic[i]:SetImageTip(equipManage.tip[index])
                packageBlockA.id[i] = equipManage.id[index]
                packageBlockA.type[i] = equipManage.type[index]
				if(equipManage.itemAnimation[index] ~= -1) then
			        packageBlockA.pic[i]:EnableImageAnimate(1,equipManage.itemAnimation[index],15,5)
			    end	
		    end	
		elseif(equipManage.type[index] == 5) then
		    w=w+1
			if(j<7 and w>((PageNumber2-1)*7)) then
                j=j+1				
	             packageBlockB.pic[j].changeimageMultiple(equipManage.picPath[index],equipManage.picPath1[index],equipManage.picPath2[index])
		         packageBlockB.pic[j]:SetVisible(1)
			     packageBlockB.pic[j]:SetImageTip(equipManage.tip[index])
                 packageBlockB.id[j] = equipManage.id[index]
                 packageBlockB.type[j] = equipManage.type[index]
			     packageBlockB.itemCount[j]:SetFontText(equipManage.itemCount[index])
		         if(equipManage.itemCount[index]>1) then
			         packageBlockB.itemCount[j]:SetVisible(1)
		         else 
			         packageBlockB.itemCount[j]:SetVisible(0)
		         end
			end	 
		end	
	end
	Equip_StrMake_Checktip()--����װ��tip����
end


function IsFocusOn_EquipStrBagMake()
	local flagA = (EquipType_BK:IsVisible() == true and EquipType:IsFocus() == false and BTN_EquipType[1]:IsFocus() == false and BTN_EquipType[2]:IsFocus() == false
		and BTN_EquipType[3]:IsFocus() == false and BTN_EquipType[4]:IsFocus() == false and BTN_EquipType[5]:IsFocus() == false and BTN_EquipType[6]:IsFocus() == false)

	if(flagA == true) then
		EquipType:SetButtonFrame(0)
		EquipType_BK:SetVisible(0)
		for index,value in pairs(BTN_EquipType) do
			BTN_EquipType[index]:SetTransparent(0)
			BTN_EquipType[index]:SetTouchEnabled(0)
		end
	end
	
	local flagB = (EquipSort_BK:IsVisible() == true and EquipSort:IsFocus() == false and BTN_EquipSort[1]:IsFocus() == false and BTN_EquipSort[2]:IsFocus() == false
		and BTN_EquipSort[3]:IsFocus() == false and BTN_EquipSort[4]:IsFocus() == false and BTN_EquipSort[5]:IsFocus() == false and BTN_EquipSort[6]:IsFocus() == false)

	if(flagB == true) then
		EquipSort:SetButtonFrame(0)
		EquipSort_BK:SetVisible(0)
		for index,value in pairs(BTN_EquipSort) do
			BTN_EquipSort[index]:SetTransparent(0)
			BTN_EquipSort[index]:SetTouchEnabled(0)
		end
	end
end

function SetEquip_StrBagMakeIsVisible(flag) 
	if g_str_BagMake_ui ~= nil then
		if flag == 1 and g_str_BagMake_ui:IsVisible() == false then
			g_str_BagMake_ui:SetVisible(1)	
            Equip_Make_needEquipInfo()
		elseif flag == 0 and g_str_BagMake_ui:IsVisible() == true then
			g_str_BagMake_ui:SetVisible(0)
			Equip_Make_PA_cleanALl_ItemInfo()
			Equip_Make_PB_cleanALl_ItemInfo()
			Equip_Make_cleanPage()
			Equip_Make_cleanPage2()
		end
	end
end
