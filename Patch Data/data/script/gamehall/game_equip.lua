include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")


-------------װ������UI
local btn_equip_allEquip = nil
local btn_equip_strEquip = nil
local btn_equip_stoneInlay = nil
local btn_equip_synthesize = nil
local btn_ListBK = nil

 ----װ���ĸ�������-----------------------------------���ɹ�������
equipManage = {}--װ�����ݿ�
equipManage.name = {} --װ������
equipManage.id = {} --װ��ͼƬ�ڿ����ID
equipManage.CitemIndex = {} --��Ʒ���������Id
equipManage.CpackCindex = {} --��Ʒ�ڷ����������е�λ��
equipManage.picPath = {} --װ��ͼƬ·��
equipManage.picPath1 = {}
equipManage.picPath2 = {}

equipManage.type = {}--��Ʒ����
equipManage.itemCount = {}--��Ʒ����
equipManage.itemOnlyID = {} --id ӦΪlua��֧��int64 ��ʱʹ��char*����
equipManage.tip = {} --װ����Tip
equipManage.bagType = {}
equipManage.itemAnimation = {}
-- equipManage.money = {} --װ���۸�
-- equipManage.attack = {}  --������
-- equipManage.defense = {}  --������
-- equipManage.magicattack = {}  --����
-- equipManage.magicdefense = {}  --��������
-- equipManage.normal = {}  --�Ƿ���ͨװ��
-- equipManage.heroEquip = {}  --�Ƿ�Ӣ��װ��
-- equipManage.skillequip = {}  --�Ƿ�����װ��
-- equipManage.repeatEquip = {}  --�Ƿ�������װ��
-- equipManage.GodEquip={}  --�Ƿ�������
-- equipManage.HaveStoneEquip={}  --�Ƿ��Ѿ���Ƕ��ʯ
--------------����Ҫ���߼�-----------------


pullPicType = {} --������ק������  ������קͼƬ
pullPicType.pullPosX = 0 --��ק��X����
pullPicType.pullPosY = 0--��ק��y����
pullPicType.pic = nil --��קͼƬ
pullPicType.id = 0 --��קͼƬ������ϢID 0 ��ʾû��ͼƬ
pullPicType.type = 0 --ͼƬ������װ�����Ǳ�ʯ �ֱ��� 1��2 ��ʾװ�� �� ��ʯ 0 ����û��װ�� 
pullPicType.ustID = 0


equipTypeNumber = {0,0,0,0,0} --1Ϊ��� --10Ϊ��ʯ --3Ϊװ�� --else���� --5Ϊ��������Ʒ



local itemChangeRanking = 0--���ڸ���������ʹ��
local EventCase = 0
local itemUsingOnlyId = 0
--1.����ɾ��
--2.��������
--3.����ɾ��
--4.ս��ҩˮ����
--5.ս��װ����������
--6.����ʹ��
--7.����ʹ��

function SetitemChangeRanking(index)
    itemChangeRanking = index
end
function GetitemChangeRanking()
    return itemChangeRanking
end
function SetEventCase(index)
    EventCase = index
end
function GetEventCase()
    return EventCase
end
function SetitemUsingOnlyId(onlyid)
    itemUsingOnlyId = onlyid
end
function GetitemUsingOnlyId()
    return itemUsingOnlyId
end

function EquipOutCreateResource()
	g_game_equip_ui:CreateResource()
	g_bag_value_ui:CreateResource()
	g_bag_hero_ui:CreateResource()
	g_bag_equip_ui:CreateResource()
	g_bag_expend_ui:CreateResource()
	g_bag_expend2_ui:CreateResource()
	g_BagStorage_ui:CreateResource()
	g_str_Strength_ui:CreateResource()
	g_str_Rebuild_ui:CreateResource()
	g_str_Soul_ui:CreateResource()
	g_str_Make_ui:CreateResource()
	g_str_BagSoul_ui:CreateResource()
	g_str_BagMake_ui:CreateResource()
	g_equip_geminlay_ui:CreateResource()
	g_equip_gemsyn_ui:CreateResource()
	g_syn_equip_ui:CreateResource()
end
function EquipOutDeleteResource()
	g_game_equip_ui:DeleteResource()
	g_bag_value_ui:DeleteResource()
	g_bag_hero_ui:DeleteResource()
	g_bag_equip_ui:DeleteResource()
	g_bag_expend_ui:DeleteResource()
	g_bag_expend2_ui:DeleteResource()
	g_BagStorage_ui:DeleteResource()
	g_str_Strength_ui:DeleteResource()
	g_str_Rebuild_ui:DeleteResource()
	g_str_Soul_ui:DeleteResource()
	g_str_Make_ui:DeleteResource()
	g_str_BagSoul_ui:DeleteResource()
	g_str_BagMake_ui:DeleteResource()
	g_equip_geminlay_ui:DeleteResource()
	g_equip_gemsyn_ui:DeleteResource()
	g_syn_equip_ui:DeleteResource()	
end

function InitGame_EquipUI(wnd, bisopen)
	g_game_equip_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainGame_Equip(g_game_equip_ui)
	g_game_equip_ui:SetVisible(bisopen)
end

function InitMainGame_Equip(wnd)

	--��ͼ����
	wnd:AddImage(path_shop.."BK_shop.png",0,0,1280,800)
	--�ϱ���
	wnd:AddImage(path.."upBK_hall.png",0,0,1280,54)
	wnd:AddImage(path.."upLine2_hall.png",0,54,1280,35)
	for i=1,3 do
		wnd:AddImage(path.."linecut_hall.png",163+110*i,60,2,32)
	end
	btn_ListBK = wnd:AddImage(path_start.."ListBK_start.png",150,53,256,38)

	InitEquip_allUI(g_game_equip_ui, 0)					--װ������
	InitEquip_strUI(g_game_equip_ui, 0)					--װ��ǿ��
	InitEquip_stoneInlayUI(g_game_equip_ui, 0)			--��ʯ��Ƕ
	InitEquip_synthesizeUI(g_game_equip_ui, 0)			--��Ʒ�ϳ�
	
	--װ������
	btn_equip_allEquip = wnd:AddCheckButton(path_equip.."indexA1_equip.png",path_equip.."indexA2_equip.png",path_equip.."indexA3_equip.png",165,53,110,33)
	XWindowEnableAlphaTouch(btn_equip_allEquip.id)
	btn_equip_allEquip.script[XE_LBDOWN] = function()
		XClickPlaySound(5)
		btn_ListBK:SetPosition(135,53)
		
		SetEquip_allIsVisible(1)
		SetEquip_strIsVisible(0)
		SetEquip_stoneInlayIsVisible(0)
		SetEquip_synthesizeIsVisible(0)
		
		btn_equip_strEquip:SetCheckButtonClicked(0)
		btn_equip_stoneInlay:SetCheckButtonClicked(0)
		btn_equip_synthesize:SetCheckButtonClicked(0)
		
	end
	--װ��ǿ��
	btn_equip_strEquip = wnd:AddCheckButton(path_equip.."indexB1_equip.png",path_equip.."indexB2_equip.png",path_equip.."indexB3_equip.png",275,53,110,33)
	XWindowEnableAlphaTouch(btn_equip_strEquip.id)
	btn_equip_strEquip.script[XE_LBDOWN] = function()
		XClickPlaySound(5)
		btn_ListBK:SetPosition(245,53)
		SetEquip_allIsVisible(0)
		SetEquip_strIsVisible(1)
		SetEquip_stoneInlayIsVisible(0)
		SetEquip_synthesizeIsVisible(0)
			
		btn_equip_allEquip:SetCheckButtonClicked(0)
		btn_equip_stoneInlay:SetCheckButtonClicked(0)
		btn_equip_synthesize:SetCheckButtonClicked(0)
	end
	--��ʯ��Ƕ
	btn_equip_stoneInlay = wnd:AddCheckButton(path_equip.."indexC1_equip.png",path_equip.."indexC2_equip.png",path_equip.."indexC3_equip.png",385,53,110,33)
	XWindowEnableAlphaTouch(btn_equip_stoneInlay.id)
	btn_equip_stoneInlay.script[XE_LBDOWN] = function()
		XClickPlaySound(5)
		btn_ListBK:SetPosition(355,53)
		
		SetEquip_allIsVisible(0)
		SetEquip_strIsVisible(0)
		SetEquip_stoneInlayIsVisible(1)
		SetEquip_synthesizeIsVisible(0)
			
		btn_equip_allEquip:SetCheckButtonClicked(0)
		btn_equip_strEquip:SetCheckButtonClicked(0)
		btn_equip_synthesize:SetCheckButtonClicked(0)
		
	end
	--��Ʒ�ϳ�
	btn_equip_synthesize = wnd:AddCheckButton(path_equip.."indexD1_equip.png",path_equip.."indexD2_equip.png",path_equip.."indexD3_equip.png",495,53,110,33)
	XWindowEnableAlphaTouch(btn_equip_synthesize.id)
	btn_equip_synthesize.script[XE_LBDOWN] = function()
		XClickPlaySound(5)
		btn_ListBK:SetPosition(465,53)
	
		SetEquip_allIsVisible(0)
		SetEquip_strIsVisible(0)
		SetEquip_stoneInlayIsVisible(0)
		SetEquip_synthesizeIsVisible(1)
		
		btn_equip_allEquip:SetCheckButtonClicked(0)
		btn_equip_strEquip:SetCheckButtonClicked(0)
		btn_equip_stoneInlay:SetCheckButtonClicked(0)
		
		Reset_EquipSynthesizeBagPage()
	end
end


function EquipChangeBag(index)
	XGame_EquipChangeBag(index)
end
-----------------------�ǳ���Ҫ�ĺ��� ���ڲֿ��ת��---------------------

-- function EquipChangeBagById(index)
    -- if(equipManage.bagType[index] ==nil) then
	    -- return
	-- end	
	-- local bagid = equipManage.bagType[index]
	-- local onlyid = equipManage.itemOnlyID[index]
    -- XGame_EquipChangeBag(bagid,onlyid,itemChangeRanking)
-- end


--------------------------------------������-------------------------------

function EquipInfo_Receivetolua(strPic,strPic1,strPic2,strName,itemtype,index,itemCount,itempackindex,itemOnlyID,tip,ibagtype,itemAnimation)---������������е�����
	local indexE = #equipManage.CitemIndex+1--������A
	equipManage.picPath[indexE] = "..\\"..strPic	--ͼƬ·��
	equipManage.picPath1[indexE] = "..\\"..strPic1	--ͼƬ·��
    equipManage.picPath2[indexE] = "..\\"..strPic2   --ͼƬ·��
		
	equipManage.name[indexE] = strName --item����
	equipManage.id[indexE] = indexE --item�ڱ����id  ����vector indexE����ֵ
	equipManage.CitemIndex[indexE] = index --item������id
	equipManage.type[indexE] = itemtype --item����
    equipManage.itemCount[indexE] = itemCount
	equipManage.CpackCindex[indexE] = itempackindex --��Ʒ�ڷ����������е�λ��
	equipManage.itemOnlyID[indexE] = itemOnlyID --Ψһid
	equipManage.tip[indexE] = tip--Tip
	equipManage.bagType[indexE] = ibagtype
	equipManage.itemAnimation[indexE] = itemAnimation
	if(itemtype == 1) then
	    equipTypeNumber[1] = equipTypeNumber[1]+1
	elseif(itemtype == 10) then
	    equipTypeNumber[2] = equipTypeNumber[2]+1
	elseif(itemtype == 3) then
	    equipTypeNumber[3] = equipTypeNumber[3]+1
	else
	    equipTypeNumber[4] = equipTypeNumber[4]+1
		if(itemtype == 5) then
		    equipTypeNumber[5] = equipTypeNumber[5]+1
		end
	end
end
function EquipInfo_EquipSetilevel(ilevel)
    local indexE = #equipManage.CitemIndex
	equipManage.itemlevel[indexE] = ilevel
end

function CaculatepageMax(count,PackageMax)
    if(count == 0) then
        return 1
	else	
        return math.ceil(count/PackageMax)
	end	
end

--------------------------------------������-------------------------------
----��װ��������һ��û�б��ù���id�������---
function findEquipManageEmpty()
   local i = 1
   while(equipManage.id[i]~=nil and equipManage.id[i]~=0) do
       i=i+1
   end
   return i
end

function equipManage_cleanALl_ItemInfo()
    equipManage.name = {} --װ������
    equipManage.id = {} --װ��ͼƬ�ڿ����ID
    equipManage.CitemIndex = {} --��Ʒ���������Id
    equipManage.CpackCindex = {} --��Ʒ�ڷ����������е�λ��
    equipManage.picPath = {} --װ��ͼƬ·��
    equipManage.picPath1 = {}
    equipManage.picPath2 = {}
    equipManage.type = {}--��Ʒ����
    equipManage.itemCount = {}--��Ʒ����
    equipManage.itemOnlyID = {} --id ӦΪlua��֧��int64 ��ʱʹ��char*����
	equipManage.tip = {}--Tip
	equipManage.bagType = {}
	equipManage.itemAnimation = {}
	for index =1,5 do
	    equipTypeNumber[index] = 0
	end 
end


function game_equip_cleanpullPicType()--�����קͼƬ
    pullPicType.pullPosX = 0
	pullPicType.pullPosY = 0
	pullPicType.pic:SetVisible(0)
	pullPicType.pic:SetTouchEnabled(0)
	pullPicType.pic.changeimage()
	pullPicType.id = 0
	pullPicType.type = 0
	pullPicType.ustID = 0
	pullPicType.pic:ToggleEvent(XE_ONUPDATE, 0)	-- �����Ϣ	
end
function game_equip_creatpullPic(wnd)--������ק����
    pullPicType.pic = wnd:AddImageMultiple(path_equip.."bag_equip.png","","",0,0,50,50)
	pullPicType.pic.changeimage()
	pullPicType.pic:SetVisible(0)--��Ҫ��Ϊ����
	pullPicType.pic:SetTouchEnabled(0)--��Ҫ��Ϊ����
	pullPicType.pic:ToggleBehaviour(XE_ONUPDATE, 1)	-- �����Ϣ
	--pullPicType.pic:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
	
	pullPicType.pic.script[XE_ONUPDATE] = function()--������ƶ�ʱ --��Ӧ��ק
		if(pullPicType.pic:IsVisible()) then
		    local PosX = XGetCursorPosX()-pullPicType.pullPosX
		    local PosY = XGetCursorPosY()-pullPicType.pullPosY
		    pullPicType.pic:SetPosition(PosX,PosY)
		end
	end
	
	pullPicType.pic.script[XE_LBUP] = function()--��������̧��
	    if(pullPicType.pic:IsVisible()) then
		    Equip_allDragXLUP()
			Equip_allInsideDragXLUP()
			Fightbag_LargepullPicXELP() --����װ����ק-������
			waterbag_LargepullPicXELP() --����ҩˮ��ק-������
            Equip_BattleBag_XELP_inGame()--����װ��-��������װ	
			Equip_BattleBag_XELP() --����װ������-����װ  			
			Equip_BagStorage_pullPicXLUP() --����ֿ���ק			
		    Equip_BagEquip_pullPicXLUP()  --װ������-��ȫ����Ʒ 
			Equip_BagEquip_PullPicDeleteXLUP() --����-��ɾ����Ʒ
			Equip_BagExpand_pullPicXLUP() --��չ����1-��ȫ����Ʒ 
			Equip_BagExpand_PullPicDeleteXLUP()  --��չ����1��ɾ����Ʒ
			Equip_BagExpand2_pullPicXLUP() --��չ����2-��ȫ����Ʒ 
			Equip_BagExpand2_PullPicDeleteXLUP() --��չ����2-��ɾ����Ʒ			
			Equip_StrBagSoul_pullPicXLUP() --װ��ǿ��-���ұ߰���
			Equip_StrStrength_pullPicXLUP() --װ��ǿ��-��ǿ������
			Equip_StrRebuild_pullPicXLUP() --װ��ǿ��-����������
			Equip_StrSoul_pullPicXLUP()--װ��ǿ��-���������
			Equip_StrMake_pullPicXLUP() --װ��ǿ��-���������
			Equip_StrCost_pullPicXLUP() --װ��ǿ��-�������������Ʒ
			Equip_GemSyn_bag_pullPicXLUP()  --��ʯ��Ƕ-����ʯ�ϳ�-���ұ߰���
			Equip_GemSyn_Left_pullPicXLUP()  --��ʯ��Ƕ-����ʯ�ϳ�-����߸���
			Equip_GemInlay_PA_pullPicXLUP()  --��ʯ��Ƕ-����ʯ��Ƕ-���ұ߰���A
			Equip_GemInlay_PB_pullPicXLUP()  --��ʯ��Ƕ-����ʯ��Ƕ-���ұ߰���B
			Equip_GemInlay_Left_PA_pullPicXLUP() --��ʯ��Ƕ-����ʯ��Ƕ-����߰���A
			Equip_GemInlay_Left_PB_pullPicXLUP() --��ʯ��Ƕ-����ʯ��Ƕ-����߰���B
			Equip_Make_PA_pullPicXLUP() --����-���ұ߱���
			Equip_Make_PB_pullPicXLUP() --����-���ұ߱���
			Equip_SynEquip_pullPicXLUP()  --��Ʒ�ϳ�-���ұ߸���
		    game_equip_cleanpullPicType() --��ק���
		end
	end	
end


function game_equip_pullPic(id,tempic) ---����id����
    local tempPosX,tempPosY = tempic:GetPosition()--GetPosition��XgetCursorPosX�õ��Ķ��Ǿ�������
	pullPicType.pic:SetVisible(1) --�ü�ͼƬ��ʾ
	pullPicType.pic:SetTouchEnabled(1) --�ü�ͼƬ��Ӧ
	pullPicType.pic:SetPosition(XGetCursorPosX()-25,XGetCursorPosY()-25) --���ó�ʼ
	pullPicType.pullPosX = 25 --���ý������X
	pullPicType.pullPosY = 25--���ý������Y
	pullPicType.id = id  --����ͼƬ��Id
	pullPicType.type = equipManage.type[id] --����ͼƬ������
	pullPicType.pic.changeimageMultiple(equipManage.picPath[id],equipManage.picPath1[id],equipManage.picPath2[id]) --����ͼƬ\
	pullPicType.pic:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
	pullPicType.pic:TriggerBehaviour(XE_LBDOWN)--ģ����
end	

function game_equip_pullPicbyUstID(picPath,picPath1,picPath2,ustid,tempic) ---ֱ������
    local tempPosX,tempPosY = tempic:GetPosition()--GetPosition��XgetCursorPosX�õ��Ķ��Ǿ�������
	pullPicType.pic:SetVisible(1) --�ü�ͼƬ��ʾ
	pullPicType.pic:SetTouchEnabled(1) --�ü�ͼƬ��Ӧ
	pullPicType.pic:SetPosition(XGetCursorPosX()-25,XGetCursorPosY()-25) --���ó�ʼ
	pullPicType.pullPosX = 25 --���ý������X
	pullPicType.pullPosY = 25 --���ý������Y
	pullPicType.ustID = ustid  ----����������id����
	pullPicType.pic.changeimageMultiple(picPath,picPath1,picPath2) --����ͼƬ\
	pullPicType.pic:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
	pullPicType.pic:TriggerBehaviour(XE_LBDOWN)--ģ����
end	

function game_equip_pullPicbyUstIDandType(picPath,ustid,itype,tempic)
    local tempPosX,tempPosY = tempic:GetPosition()--GetPosition��XgetCursorPosX�õ��Ķ��Ǿ�������
	pullPicType.pic:SetVisible(1) --�ü�ͼƬ��ʾ
	pullPicType.pic:SetTouchEnabled(1) --�ü�ͼƬ��Ӧ
	pullPicType.pic:SetPosition(XGetCursorPosX()-25,XGetCursorPosY()-25) --���ó�ʼ
	pullPicType.pullPosX = 25 --���ý������X
	pullPicType.pullPosY = 25 --���ý������Y
	pullPicType.ustID = ustid  ----����������id����
	pullPicType.type = itype 
	pullPicType.pic.changeimage(picPath) --����ͼƬ\
	pullPicType.pic:ToggleEvent(XE_ONUPDATE, 1)	-- �����Ϣ	
	pullPicType.pic:TriggerBehaviour(XE_LBDOWN)--ģ����
end




function game_equip_getMadel()--���ؽ�������
    local medal_1 = 0
	local medal_2 = 0
	local medal_3 = 0
    for i,value in pairs(equipManage.CitemIndex) do
	    if(equipManage.CitemIndex[i] == 40001) then
		    medal_1 = medal_1 + equipManage.itemCount[i]
		elseif(equipManage.CitemIndex[i] == 40002) then
		    medal_2 = medal_2 + equipManage.itemCount[i]
		elseif(equipManage.CitemIndex[i] == 40003) then
		    medal_3 = medal_3 + equipManage.itemCount[i]	
		end	
	end
	return medal_1,medal_2,medal_3
end

function game_equip_GetRankingidByonlyId(onlyid)
    for i,value in pairs(equipManage.CitemIndex) do
	    if(equipManage.itemOnlyID[i] == onlyid) then
		    return i
		end
	end
	return 0
end








function CheckEquipPullResultByRect(top,buttom,left,right)
    local PosX = XGetCursorPosX()
	local PosY = XGetCursorPosY()
	if(PosX>left and PosX<right and PosY>top and PosY<buttom) then
	    return true
    else 
	    return false
    end
end

function CheckEquipPullResultDestory(pic)
    local PosX = XGetCursorPosX()
	local PosY = XGetCursorPosY()
	local BlockX,BlockY = pic:GetPosition()
	if(PosX>BlockX and PosX<BlockX+120 and PosY>BlockY-15 and PosY<BlockY+50) then
	    return true
    else 
	    return false
    end
end

function CheckEquipPullResultSmallPic(pic)
    local PosX = XGetCursorPosX()
	local PosY = XGetCursorPosY()
	local BlockX,BlockY = pic:GetPosition()
	if(PosX>BlockX and PosX<BlockX+32 and PosY>BlockY and PosY<BlockY+32) then
	    return true
    else 
	    return false
    end
end

function CheckEquip_All_ResultByPic(RectCheck)
    local x,y,w,h = RectCheck:GetRect()
	local PosX = XGetCursorPosX()
	local PosY = XGetCursorPosY()

	if(PosX>x and PosX<w and PosY>y and PosY<h) then
	    return true
    else 
	    return false
    end
end


function CheckEquipPullResult(pic)
    local PosX = XGetCursorPosX()
	local PosY = XGetCursorPosY()
	local BlockX,BlockY = pic:GetPosition()
	if(PosX>BlockX and PosX<BlockX+52 and PosY>BlockY and PosY<BlockY+52) then
	    return true
    else 
	    return false
    end
end

------------������ʾ
function SetGameEquipIsVisible(flag) 
	if g_game_equip_ui ~= nil then
		if flag == 1 and g_game_equip_ui:IsVisible() == false then	

			EquipOutCreateResource()
		
			g_game_equip_ui:SetVisible(1)
			SetFourpartUIVisiable(3)
			
			SetEquip_allIsVisible(1)
			SetEquip_strIsVisible(0)
			SetEquip_stoneInlayIsVisible(0)
			SetEquip_synthesizeIsVisible(0)
		
			btn_ListBK:SetPosition(135,53)
			btn_ListBK:SetVisible(1)
			
			btn_equip_allEquip:SetCheckButtonClicked(1)
			btn_equip_strEquip:SetCheckButtonClicked(0)
			btn_equip_stoneInlay:SetCheckButtonClicked(0)
			btn_equip_synthesize:SetCheckButtonClicked(0)
			Xgame_equip_checkClickUp()
			
		elseif flag == 0  and g_game_equip_ui:IsVisible() == true then
		
			EquipOutDeleteResource()
		
			g_game_equip_ui:SetVisible(0)
			SetEquip_allIsVisible(0)
			SetEquip_strIsVisible(0)
			SetEquip_stoneInlayIsVisible(0)
			SetEquip_synthesizeIsVisible(0)
			Xgame_equip_checkReturn()
		end
	end	
end

function GetGameEquipIsVisible()  
    if g_game_equip_ui~=nil and g_game_equip_ui:IsVisible()==true then
		return 1
    else
		return 0
    end
end