include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-------checkA_ui--------------------------------------------------------------------------------------------------------------------------------------
local equip_font = nil --װ������
local stone_BlockImage = {} --���--��һ�ſ�Ϊ�����
local stone_BlockEndImage = {} --��ʵ��ͼ
local stone_BlockImagePosY = {160,270,390} --����y����
local EquipName = nil
local stone_FontTitle = {} --title
local stone_FontTitlePosY = {0,125,225,325} --title��Y����
local stone_FontDetail = {} --��������
local stone_FontDetailPosY = {150,165,200,215,290,305,400,415} --��������Y����
local lightline = {} --������
local lightlinePosY = {114,214,314,414}--�����ߵ�Y����
local package_AEndImage = {}--������A��ͼ����
package_AEndImage.kuang = {}
local package_BEndImage = {}--������B��ͼ����
package_BEndImage.kuang = {}
---������--
local btn_Show = {} --btn
local showFont = {} --�ֶ�
local showEquipTypeAllFont ={"ȫ����ʾ","��ͨװ��","Ӣ��ר��","������װ��","������װ��","������װ��","���ⱦʯ��װ��"}--װ�����������ֶ�
local showQuilityAllFont = {"�ۺ�����"}--װ������
local showStoneSortAllFont = {"�ۺ�����"}--��ʯ����
local showAllFont = {showEquipTypeAllFont,showQuilityAllFont,showStoneSortAllFont}--��������
local showBack = {}--����������
local btn_backEquip ={}--װ��������btn
local btn_backQuility = {}--װ������������btn
local btn_backStonrQuility = {}--��ʯ����������btn
local AllBackBtn ={btn_backEquip,btn_backQuility,btn_backStonrQuility}--�����������btn
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
----����button---
local ThreeButtonTakeOff = {}--ժ����ť

local ThreeButtonOpen = {}--������Ƕ��ť��ť
local ThreeButtonOpenGrey = {} --������Ƕ��ť��
local UseChange = nil
local UseChangeGrey = nil


--������A--ֻ�����ڴ��װ��
local packageBlockA = {} --���������ڴ��װ��
packageBlockA.pic = {} --�������ͼƬ
packageBlockA.id= {} --��������װ������������Id 0 Ϊû��װ��
packageBlockA.type = {} --������������Ʒ����

--������B--ֻ�����ڴ�ű�ʯ
local packageBlockB = {} --���������ڴ��װ��
packageBlockB.pic = {} --�������ͼƬ
packageBlockB.id= {} --��������װ������������Id 0 Ϊû��װ��
packageBlockB.type = {} --������������Ʒ����
packageBlockB.itemCount={}



local blockItem = {}
blockItem.pic = {}
blockItem.onlyid = {}
blockItem.type = {}

local lock = {}




function InitEquip_GemInlayUI(wnd, bisopen)
	g_equip_geminlay_ui = CreateWindow(wnd.id, 200, 200, 860, 470)
	
	EquipName = g_equip_geminlay_ui:AddFont("װ������",15, 8, 0, -6, 416, 20, 0x49d3f0)
	EquipName:SetVisible(0)
	----��ʯѡ��   
	local btn_Gembuy = g_equip_geminlay_ui:AddButton(path_setup.."btn1_mail.png",path_setup.."btn2_mail.png",path_setup.."btn3_mail.png",470,227,100,32)
	btn_Gembuy:AddFont("��ʯ����",12, 8, 0, 0, 100, 32, 0xffffff)
	btn_Gembuy.script[XE_LBUP] = function()
		XClickPlaySound(5)
		g_equip_GemBuy_ui:SetVisible(1)
		XEquip_GemBuyClickVisible(2)
	end
	
	local Inlay_posx = {180,180,180,180}
	local Inlay_posy = {34,135,235,335}
	for i=1,4 do
		stone_BlockEndImage[i] = g_equip_geminlay_ui:AddImage(path_equip.."bag_equip.png",Inlay_posx[i],Inlay_posy[i],50,50)
		lock[i] = stone_BlockEndImage[i]:AddImage(path_info.."lock_info.png",-2,-2,64,64)
		lock[i]:SetVisible(0)
		blockItem.pic[i] = stone_BlockEndImage[i]:AddImage(path_equip.."bag_equip.png",0,2,50,50)
	    blockItem.pic[i]:SetVisible(0)
		if i==1 then
			stone_BlockEndImage[i]:AddImage(path_equip.."HeadShine_equip.png",-9,-9,68,68)
		else
			stone_BlockEndImage[i]:AddImage(path_shop.."iconside_shop.png",-2,-2,54,54)
		end
	end
	
	--��һ��װ������
	blockItem.pic[1].script[XE_RBUP] = function()
		if(blockItem.onlyid[1] == nil or blockItem.onlyid[1] == "0" or blockItem.onlyid[i] == " ") then--id������ ����Ӧ
			return
		end
		XEquip_GemInlay_CheanOneByClick(1,blockItem.onlyid[1])
		--------------------
	end   
	--��2-4����ʯ����
	for i = 2,4 do
	    blockItem.pic[i].script[XE_RBUP] = function()
		    if(blockItem.onlyid[i] == nil or blockItem.onlyid[i] == "0" or blockItem.onlyid[i] == " ") then--id������ ����Ӧ
			    return
		    end
		    XEquip_GemInlay_CheanOneByClick(i,blockItem.onlyid[i])
		--------------------
	    end   
    end
	
	
	
	
	
	
	--����������
	for index = 1,4 do
	    lightline[index]= g_equip_geminlay_ui:AddImage(path_equip.."LigheLine_equip.png",0,lightlinePosY[index],512,2)
		lightline[index]:SetVisible(1)
	end
	--����title
	for index = 1,4 do
	    stone_FontTitle[index] = g_equip_geminlay_ui:AddFont(" ",14,0,30,stone_FontTitlePosY[index],200,200,0xbddcee)
		stone_FontTitle[index]:SetVisible(0)
	end

	--����������
	for index = 1,21 do --װ��
	    local PosX = (index-1)%7*54+460
		local PosY = math.ceil(index/7)*54
		package_AEndImage[index] = g_equip_geminlay_ui:AddImage(path_equip.."bag_equip.png",PosX,PosY,50,50) 
		packageBlockA.pic[index] = package_AEndImage[index]:AddImage(path_equip.."bag_equip.png",0,0,50,50)
		packageBlockA.pic[index]:SetVisible(0)
		package_AEndImage.kuang[index] = package_AEndImage[index]:AddImage(path_equip.."kuang_equip.png",0,0,50,50)
		 
		packageBlockA.pic[index].script[XE_DRAG] = function()
		    if(packageBlockA.id[index] == nil or packageBlockA.id[index] == 0) then--id������ ����Ӧ
			    return
			end
			game_equip_pullPic(packageBlockA.id[index],packageBlockA.pic[index])
			package_AEndImage.kuang[index].changeimage(path_equip.."kuang3_equip.png")
		end
		packageBlockA.pic[index].script[XE_ONHOVER] = function()
			package_AEndImage.kuang[index].changeimage(path_equip.."kuang2_equip.png")
		end
		packageBlockA.pic[index].script[XE_ONUNHOVER] = function()
			package_AEndImage.kuang[index].changeimage(path_equip.."kuang_equip.png")
		end
		
		packageBlockA.pic[index].script[XE_RBUP] = function()
            Equip_GemInlay_PA_RClickUp(index)
		end
	end
	
	

	
	
	for index = 1,21 do --��ʯ
	    local PosX = (index-1)%7*54+460
		local PosY = math.floor((index-1)/7)
		PosY = PosY*54+270
		package_BEndImage[index] = g_equip_geminlay_ui:AddImage(path_equip.."bag_equip.png",PosX,PosY,50,50)
		packageBlockB.pic[index] = package_BEndImage[index]:AddImage(path_equip.."bag_equip.png",0,0,50,50)
		packageBlockB.pic[index]:SetVisible(0)
		package_BEndImage.kuang[index] = package_BEndImage[index]:AddImage(path_equip.."kuang_equip.png",0,0,50,50)
		packageBlockB.pic[index].script[XE_DRAG] = function()
		    if(packageBlockB.id[index] == nil or packageBlockB.id[index] == 0) then--id������ ����Ӧ
			    return
			end
			game_equip_pullPic(packageBlockB.id[index],packageBlockB.pic[index])
			package_BEndImage.kuang[index].changeimage(path_equip.."kuang3_equip.png")
		end
		packageBlockB.pic[index].script[XE_ONHOVER] = function()
			package_BEndImage.kuang[index].changeimage(path_equip.."kuang2_equip.png")
		end
		packageBlockB.pic[index].script[XE_ONUNHOVER] = function()
			package_BEndImage.kuang[index].changeimage(path_equip.."kuang_equip.png")
		end
		packageBlockB.pic[index].script[XE_RBUP] = function()
             Equip_GemInlay_PB_RClickUp(index)
		end		
	end
	
	for index = 1,21 do --��ʯ
	    packageBlockB.itemCount[index] = packageBlockB.pic[index]:AddFont("0",12,6,-50,-33,100,17,0xFFFFFF)
	    packageBlockB.itemCount[index]:SetVisible(0)
		packageBlockB.itemCount[index]:SetFontBackground()
	end
	
	
		-- EquipChangeBag()
	    -- XEquip_GemInlay_Left_DragOn(tempRanking,equipManage.itemOnlyID[pullPicType.id])
	
	--�����Ϣ--

	----������ͷ���----
	PageNumber = 1
	PageNumberMax =1
	
	LArrowButton = g_equip_geminlay_ui:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png",603,215,27,36)
	local pageBK = LArrowButton:AddImage(path_setup.."yemadiban_mail.png", 27, 9, 42, 18)
	PageNumberFont = pageBK:AddFont(PageNumber.."/"..PageNumberMax,15, 8, -3, 0, 32, 18, 0xffffffff)

	
	LArrowButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber > 1) then
		   PageNumber = PageNumber-1
		   PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)
		   Equip_GemInlay_PA_needEquipInfo()
		end
	end
	
	RArrowButton = g_equip_geminlay_ui:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png",673,215,27,36)
	XWindowEnableAlphaTouch(LArrowButton.id)
	XWindowEnableAlphaTouch(RArrowButton.id)
	RArrowButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber < PageNumberMax) then
		   PageNumber = PageNumber+1
		   PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)
		   Equip_GemInlay_PA_needEquipInfo()
		end
	end
	
	PageNumber2 = 1
	PageNumberMax2 =1

	
	LArrowButton2 = g_equip_geminlay_ui:AddButton(path_info.."L1_info.png",path_info.."L2_info.png",path_info.."L3_info.png",603,430,27,36)
	XWindowEnableAlphaTouch(LArrowButton2.id)
	local pageBK = LArrowButton2:AddImage(path_setup.."yemadiban_mail.png", 27, 9, 42, 18)
	PageNumberFont2 = pageBK:AddFont(PageNumber2.."/"..PageNumberMax2,15, 8, -3, 0, 32, 18, 0xffffffff)
	RArrowButton2 = g_equip_geminlay_ui:AddButton(path_info.."R1_info.png",path_info.."R2_info.png",path_info.."R3_info.png",673,430,27,36)	
	XWindowEnableAlphaTouch(RArrowButton2.id)
	LArrowButton2.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber2 > 1) then
		   PageNumber2 = PageNumber2-1
		   Equip_GemInlay_PB_needEquipInfo()
		end
	end
	

	RArrowButton2.script[XE_LBUP] = function()
		XClickPlaySound(5)
		if(PageNumber2 < PageNumberMax2) then
		   PageNumber2 = PageNumber2+1
		   Equip_GemInlay_PB_needEquipInfo()
		end
	end
	
	
	
	
	
	---�ĸ��̶��ֶ�---
	-- g_equip_geminlay_ui:AddFont("װ������",15,0,460,20,100,20,0xbeb5ee)
	-- g_equip_geminlay_ui:AddFont("��������",15,0,660,20,100,20,0xbeb5ee)
	-- g_equip_geminlay_ui:AddFont("��ʯѡ��",15,0,430,235,100,20,0xbeb5ee)
	-- g_equip_geminlay_ui:AddFont("��ʯ����",15,0,660,250,100,20,0xbeb5ee)
	-- ----����������----
	-- btn_Show[1] = g_equip_geminlay_ui:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",535,15,128,32)
	-- btn_Show[2] = g_equip_geminlay_ui:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",735,15,128,32)
	-- btn_Show[3] = g_equip_geminlay_ui:AddTwoButton(path_hero.."herolist1_hero.png", path_hero.."herolist2_hero.png", path_hero.."herolist1_hero.png",735,244,128,32)
	-- showBack[1] = g_equip_geminlay_ui:AddImage(path_hero.."listBK1_hero.png",535,45,128,256)
	-- showBack[1]:SetVisible(0)
	-- showBack[2] = g_equip_geminlay_ui:AddImage(path_hero.."listBK1_hero.png",735,45,128,256)	
	-- showBack[2]:SetVisible(0)
	-- showBack[3] = g_equip_geminlay_ui:AddImage(path_hero.."listBK1_hero.png",735,274,128,256)
	-- showBack[3]:SetVisible(0)
	-- ----����������������ֶ�----
	-- for index = 1,3 do
	    -- showFont[index] = btn_Show[index]:AddFont(showAllFont[index][1],12,0,8,6,100,15,0xbeb5ee)
	-- end
	
	-- for index =1,3 do
	    -- for j ,value in pairs(showAllFont[index]) do
		    -- AllBackBtn[index][j] = showBack[index]:AddImage(path_hero.."listhover_hero.png",0,29*(j-1),128,32)
			-- showBack[index]:AddFont(showAllFont[index][j],12,0,8,j*29-23,128,32,0xbeb5ee)
			-- AllBackBtn[index][j]:SetVisible(1)
			-- AllBackBtn[index][j]:SetTransparent(0)
	     	-- AllBackBtn[index][j]:SetTouchEnabled(0)
			-- -----------��껬��
	     	-- AllBackBtn[index][j].script[XE_ONHOVER] = function()
			    -- if showBack[index]:IsVisible() == true then
				   -- AllBackBtn[index][j]:SetTransparent(1)
			    -- end
		    -- end
		    -- AllBackBtn[index][j].script[XE_ONUNHOVER] = function()
			    -- if showBack[index]:IsVisible() == true then
				   -- AllBackBtn[index][j]:SetTransparent(0)
			    -- end
		    -- end
			-- AllBackBtn[index][j].script[XE_LBUP] = function()
			   -- showFont[index]:SetFontText(showAllFont[index][j],0xbeb5ee)	
			   -- btn_Show[index]:SetButtonFrame(0)
			   -- showBack[index]:SetVisible(0)
			   -- for w,value in pairs(showAllFont[index]) do
				    -- AllBackBtn[index][w]:SetTransparent(0)
				    -- AllBackBtn[index][w]:SetTouchEnabled(0)
			   -- end
		    -- end
		-- end
	-- end
	
	-- for index = 1,3 do
	    -- btn_Show[index].script[XE_LBUP] = function()
		    -- XClickPlaySound(5)
		    -- if showBack[index]:IsVisible() then
			   -- showBack[index]:SetVisible(0)
			   -- for w,value in pairs(showAllFont[index]) do
				    -- AllBackBtn[index][w]:SetTransparent(0)
				    -- AllBackBtn[index][w]:SetTouchEnabled(0)
			   -- end
		    -- else
			    -- showBack[index]:SetVisible(1)
			    -- for w,value in pairs(showAllFont[index]) do
				    -- AllBackBtn[index][w]:SetTransparent(0)
				    -- AllBackBtn[index][w]:SetTouchEnabled(1)
			    -- end
		    -- end
    	-- end
	-- end
	
	UseChange = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,46,83,35)
	UseChange:SetEnabled(0)
	UseChange:AddFont("��Ƕ",15,8,0,0,83,35,0xbcbcc4)
	
	UseChange.script[XE_LBUP] = function()
	    XEquip_GemInlayUseChange()
	end
	
--1
	ThreeButtonTakeOff[1] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,150,83,35)
	ThreeButtonTakeOff[1]:AddFont("��ʯժ��",15,8,0,0,83,35,0xbcbcc4)	
	ThreeButtonOpen[1] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,147,83,35)
	ThreeButtonOpen[1]:AddFont("������Ƕ",15,8,0,0,83,35,0xbcbcc4)
--2
    ThreeButtonTakeOff[2] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,247,83,35)
	ThreeButtonTakeOff[2]:AddFont("��ʯժ��",15,8,0,0,83,35,0xbcbcc4)
	ThreeButtonOpen[2] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,247,83,35)
	ThreeButtonOpen[2]:AddFont("������Ƕ",15,8,0,0,83,35,0xbcbcc4)
--3
	ThreeButtonTakeOff[3] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,347,83,35)
	ThreeButtonTakeOff[3]:AddFont("��ʯժ��",15,8,0,0,83,35,0xbcbcc4)
	ThreeButtonOpen[3] = g_equip_geminlay_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",300,347,83,35)
	ThreeButtonOpen[3]:AddFont("������Ƕ",15,8,0,0,83,35,0xbcbcc4)
	
	
	
	
	for index = 1,3 do
	    ThreeButtonTakeOff[index].script[XE_LBUP] = function()
		    XEquip_GemInlay_takeOff(index)
		end
		ThreeButtonOpen[index].script[XE_LBUP] = function()
		    XEquip_GemInlay_takeOpen(index)
		end
	end
	
	
	for index = 1,3 do
	    ThreeButtonTakeOff[index]:SetVisible(0)
		ThreeButtonOpen[index]:SetVisible(0)
	end

	local AM = g_equip_geminlay_ui:AddFont("��ʾ��\n��ÿ��װ��ͬ����ɫ��ʯ��ֻ����Ƕһ�ţ�����˫ɫ��ʯ.\n��ͬ��װ���б�ʯ�����е����ԡ��ﴩ�ͷ�������ͬ�ĵڶ�����ʼ˥��50%.", 11, 0, 20, 424, 470, 200, 0x8295cf)
	AM:SetFontSpace(1,1)
	g_equip_geminlay_ui:SetVisible(bisopen)
end


function SetEquip_GemInlayIsVisible(flag) 
	if g_equip_geminlay_ui ~= nil then
		if flag == 1 and g_equip_geminlay_ui:IsVisible() == false then
			g_equip_geminlay_ui:SetVisible(1)
            Equip_GemInlay_needEquipInfo()
			XEquip_GemInlay_ClickUp()
		elseif flag == 0 and g_equip_geminlay_ui:IsVisible() == true then
			g_equip_geminlay_ui:SetVisible(0)
			if(blockItem.onlyid[1] ~= nil and blockItem.onlyid[1] ~= "0" and blockItem.onlyid[i] ~= " ") then--id������ ����Ӧ
			    XEquip_GemInlay_CheanOneByClick(1,blockItem.onlyid[1])
		    end
			Equip_GemInlay_PA_cleanALl_ItemInfo()
			Equip_GemInlay_PB_cleanALl_ItemInfo()
			Equip_GemInlay_cleanPage()
			Equip_GemInlay_cleanPage2()
			Equip_GemInlay_Left_clean()
			g_equip_GemBuy_ui:SetVisible(0) --��ʯ�������������������ص�
		end
	end
end

function Equip_GemInlay_PA_needEquipInfo()	--װ��
    if(g_equip_geminlay_ui:IsVisible() == false) then
        return
	end	
	Equip_GemInlay_PA_cleanALl_ItemInfo()

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

function Equip_GemInlay_PA_cleanALl_ItemInfo() --װ��
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

function Equip_GemInlay_cleanPage()
    PageNumber = 1
	PageNumberMax = 1
end
function Equip_GemInlay_cleanPage2()
    PageNumber2 = 1
	PageNumberMax2 = 1
end

function Equip_GemInlay_PB_needEquipInfo()	--��ʯ
    if(g_equip_geminlay_ui:IsVisible() == false) then
        return
	end	
	Equip_GemInlay_PB_cleanALl_ItemInfo()
    local i = 0
	local j = 0
	PageNumberMax2 = CaculatepageMax(equipTypeNumber[2],21)
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
	    if(equipManage.type[index] == 10) then
		    j = j+1	
	        if(i<21 and j>((PageNumber2-1)*21)) then
                i=i+1				
	            packageBlockB.pic[i].changeimage(equipManage.picPath[index])
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
				if(equipManage.itemAnimation[index] ~= -1) then
			         packageBlockB.pic[i]:EnableImageAnimate(1,equipManage.itemAnimation[index],15,5)
			    end	
		    end	
		end	
	end
end

function Equip_GemInlay_PB_cleanALl_ItemInfo() --��ʯ
    for index =1,21 do
	    packageBlockB.pic[index].changeimage() --�������ͼƬ
		packageBlockB.pic[index]:SetVisible(0)
		packageBlockB.pic[index]:SetImageTip(0)
		packageBlockB.itemCount[index]:SetFontText("0",0xFFFFFF)
		if(packageBlockB.pic[index]:GetBoolImageAnimate() == 1) then
		    packageBlockB.pic[index]:CleanImageAnimate()
		end
	end
	packageBlockB.id = {}
    packageBlockB.type = {}
end

function Equip_GemInlay_needEquipInfo()
    if(g_equip_geminlay_ui:IsVisible() == false) then
        return
	end	
    local i = 0
	local j = 0
	local k = 0
	local w = 0
	Equip_GemInlay_PA_cleanALl_ItemInfo()
	Equip_GemInlay_PB_cleanALl_ItemInfo()
	PageNumberMax = CaculatepageMax(equipTypeNumber[3],21)
	PageNumberFont:SetFontText(PageNumber.."/"..PageNumberMax,0xbeb5ee)

	PageNumberMax2 = CaculatepageMax(equipTypeNumber[2],21)
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
		elseif(equipManage.type[index] == 10) then
		    w=w+1
			if(j<21 and w>((PageNumber2-1)*21)) then
                j=j+1				
	             packageBlockB.pic[j].changeimage(equipManage.picPath[index])
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
				 if(equipManage.itemAnimation[index] ~= -1) then
			        packageBlockB.pic[j]:EnableImageAnimate(1,equipManage.itemAnimation[index],15,5)
			     end	
			end	 
		end	
	end
	Equip_StrSoul_Checktip()--��ʯ��Ƕtip����
end

function Equip_StrSoul_Checktip()
    if(g_equip_geminlay_ui:IsVisible() == true) then
        for index,value in pairs(equipManage.CitemIndex) do
	        if(blockItem.onlyid[1] == equipManage.itemOnlyID[index]) then
			    blockItem.pic[1]:SetImageTip(equipManage.tip[index])
			end
	    end
    end	   
end



---������ק---
--PA---
function Equip_GemInlay_PA_pullPicXLUP()
    if(g_equip_geminlay_ui:IsVisible() == false or pullPicType.type ~=3) then
	    return
	end
    local tempRanking = Equip_GemInlay_PA_checkRect() --�ж��Ƿ��ڰ�����
	local oldranking = Equip_GemInlay_PA_getPullPicIndexInPackage(pullPicType.id) --�õ��ϵ�λ��
	if(oldranking<=21 and oldranking>=1) then
	    package_AEndImage.kuang[oldranking].changeimage(path_equip.."kuang_equip.png")	
    end	
	
	if(tempRanking == 0) then
	    return
	end
	if(oldranking~=0 and packageBlockA.id[tempRanking] ~= 0 and packageBlockA.id[tempRanking]~= nil) then
		Equip_GemInlay_PA_change(oldranking,packageBlockA.id[tempRanking])--����ڱ����ڴ���		
	elseif(oldranking~=0 and (packageBlockA.id[tempRanking] == 0 or packageBlockA.id[tempRanking]== nil)) then
		Equip_GemInlay_PA_cleanOne_ItemInfo(oldranking)
	end
    Equip_GemInlay_PA_change(tempRanking,pullPicType.id) 
end






function Equip_GemInlay_PA_checkRect() --�ж��Ƿ��ڰ�����
    for i = 1,21 do
	    if(CheckEquipPullResult(package_AEndImage[i])) then
		    return i
		end
	end
	return 0
end
function Equip_GemInlay_PA_getPullPicIndexInPackage(id) --�õ��ϵ�λ��
   for i = 1,21 do
	    if(packageBlockA.id[i]== id) then
		    return i
		end
	end
	return 0
end



function Equip_GemInlay_PA_change(ranking,id)--λ�� �����ݿ����id
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
function Equip_GemInlay_PA_cleanOne_ItemInfo(ranking)
    packageBlockA.pic[ranking].changeimage() --�������ͼƬ
	packageBlockA.pic[ranking]:SetVisible(0)
	packageBlockA.pic[ranking]:SetImageTip(0)
	packageBlockA.id[ranking] = 0
    packageBlockA.type[ranking] = 0
end


--PB---
function Equip_GemInlay_PB_pullPicXLUP()
    if(g_equip_geminlay_ui:IsVisible() == false or pullPicType.type ~=10) then
	    return
	end
    local tempRanking = Equip_GemInlay_PB_checkRect() --�ж��Ƿ��ڰ�����
	
	local oldranking = Equip_GemInlay_PB_getPullPicIndexInPackage(pullPicType.id) --�õ��ϵ�λ��
	if(oldranking<=21 and oldranking>=1) then
	    package_BEndImage.kuang[oldranking].changeimage(path_equip.."kuang_equip.png")	
    end	
	if(tempRanking == 0) then
	    return
	end
	if(oldranking~=0 and packageBlockB.id[tempRanking] ~= 0 and packageBlockB.id[tempRanking]~= nil) then
		Equip_GemInlay_PB_change(oldranking,packageBlockB.id[tempRanking])--����ڱ����ڴ���		
	elseif(oldranking~=0 and (packageBlockB.id[tempRanking] == 0 or packageBlockB.id[tempRanking]== nil)) then
		Equip_GemInlay_PB_cleanOne_ItemInfo(oldranking)
	end
    Equip_GemInlay_PB_change(tempRanking,pullPicType.id) 
end


function Equip_GemInlay_PB_checkRect() --�ж��Ƿ��ڰ�����
    for i = 1,21 do
	    if(CheckEquipPullResult(package_BEndImage[i])) then
		    return i
		end
	end
	return 0
end
function Equip_GemInlay_PB_getPullPicIndexInPackage(id) --�õ��ϵ�λ��
   for i = 1,21 do
	    if(packageBlockB.id[i]== id) then
		    return i
		end
	end
	return 0
end



function Equip_GemInlay_PB_change(ranking,id)--λ�� �����ݿ����id
    packageBlockB.id[ranking] = id
	packageBlockB.pic[ranking].changeimage(equipManage.picPath[id])--����ͼƬ
    packageBlockB.type[ranking] = equipManage.type[id]
	packageBlockB.pic[ranking]:SetVisible(1)
	packageBlockB.pic[ranking]:SetImageTip(equipManage.tip[id])
	packageBlockB.itemCount[ranking]:SetFontText(equipManage.itemCount[id]) 
	if(equipManage.itemCount[id]>1) then
		packageBlockB.itemCount[ranking]:SetVisible(1)
	else 
		packageBlockB.itemCount[ranking]:SetVisible(0)
	end
	if(equipManage.itemAnimation[id] ~= -1) then
		packageBlockB.pic[ranking]:EnableImageAnimate(1,equipManage.itemAnimation[id],15,5)             
    else
	    if(packageBlockB.pic[ranking]:GetBoolImageAnimate() == 1) then
		    packageBlockB.pic[ranking]:CleanImageAnimate()
		end
	end
end
function Equip_GemInlay_PB_cleanOne_ItemInfo(ranking)
    packageBlockB.pic[ranking].changeimage() --�������ͼƬ
	packageBlockB.pic[ranking]:SetVisible(0)
	packageBlockB.pic[ranking]:SetImageTip(0)
	packageBlockB.itemCount[ranking]:SetFontText("0",0xFFFFFF)
	packageBlockB.id[ranking] = 0
    packageBlockB.type[ranking] = 0
end

--------------������ק--------------------


function Equip_GemInlay_Left_clean()--left
    --���ǿ��װ��ͼƬ����Ϣ
	for i= 1, 4 do
        blockItem.pic[i].changeimage() 
	    blockItem.pic[i]:SetVisible(0)
	    blockItem.onlyid[i] = nil
        blockItem.type[i] = 0
		blockItem.pic[i]:SetImageTip(0)
	end
	Equip_GemInlay_Left_PA_PullOutClean()
	Equip_GemInlay_Left_PB_PullOutClean(2)
	Equip_GemInlay_Left_PB_PullOutClean(3)
	Equip_GemInlay_Left_PB_PullOutClean(4)
	for index = 1,3 do 
        Equip_GemInlay_TakeOff(index,0)	
		Equip_GemInlay_TakeOpen(index,0)
	end
end

function Equip_GemInlay_Left_cleanOne_ItemInfo(ranking)--left
    blockItem.pic[ranking].changeimage() --�������ͼƬ
	blockItem.pic[ranking]:SetVisible(0)
	blockItem.onlyid[ranking] = nil
    blockItem.type[ranking] = 0
	blockItem.pic[ranking]:SetImageTip(0)
	if(ranking == 1) then
		Equip_GemInlay_Left_PA_PullOutClean()
	elseif(ranking<=4 and ranking>=2) then	
		Equip_GemInlay_Left_PB_PullOutClean(ranking)
	end	
end


function Equip_GemInlay_Left_changeByonlyId(strPic,onlyidid,name,ranking,itemAnimation)
    if(strPic == "") then
	    return
	end	
	blockItem.pic[ranking].changeimage("..\\"..strPic)--����ͼƬ
	blockItem.onlyid[ranking] = onlyidid
	blockItem.pic[ranking]:SetVisible(1)
    if(ranking == 1) then
	    blockItem.type[ranking] = 3
		EquipName:SetFontText(name,0x49d3f0)
	    EquipName:SetVisible(1)		
		if(blockItem.pic[ranking]:GetBoolImageAnimate() == 1 and itemAnimation == -1) then
	        blockItem.pic[ranking]:CleanImageAnimate()
	    elseif(itemAnimation ~= -1) then
	        blockItem.pic[ranking]:EnableImageAnimate(1,itemAnimation,15,5)
        end    
	elseif(ranking<=4 and ranking>=2) then
	    blockItem.type[ranking] = 10
		stone_FontTitle[ranking]:SetFontText(name,0xbddcee)
	    stone_FontTitle[ranking]:SetVisible(1)
		if(blockItem.pic[ranking]:GetBoolImageAnimate() == 1 and itemAnimation == -1) then
	        blockItem.pic[ranking]:CleanImageAnimate()
	    elseif(itemAnimation ~= -1) then
	        blockItem.pic[ranking]:EnableImageAnimate(1,itemAnimation,15,5)
        end    
	end
end

function Equip_GemInlay_Left_settip(tip,ranking)
    blockItem.pic[ranking]:SetImageTip(tip)
end



function Equip_GemInlay_Left_PA_pullPicXLUP()
    if(g_equip_geminlay_ui:IsVisible() == false or pullPicType.type ~=3) then
	    return
	end
    local tempRanking = Equip_GemInlay_Left_PA_checkRect() --�ж��Ƿ��ڰ�����--left
	if(tempRanking == 1) then
	    XEquip_GemInlay_Left_DragOn(1,equipManage.itemOnlyID[pullPicType.id])
	end
end

function Equip_GemInlay_PA_RClickUp(index)
	    XEquip_GemInlay_Left_DragOn(1,equipManage.itemOnlyID[packageBlockA.id[index]])
end


function Equip_GemInlay_Left_PB_pullPicXLUP()
    if(g_equip_geminlay_ui:IsVisible() == false or pullPicType.type ~=10) then
	    return
	end
    local tempRanking = Equip_GemInlay_Left_PB_checkRect() --�ж��Ƿ��ڰ�����--left
	if(tempRanking <=4 and tempRanking>=2) then
	    XEquip_GemInlay_Left_DragOn(tempRanking,equipManage.itemOnlyID[pullPicType.id])
	end
end

function Equip_GemInlay_PB_RClickUp(index)
	for tempRanking = 2,4 do
		if((blockItem.onlyid[tempRanking] == nil or blockItem.onlyid[tempRanking] == "0" or blockItem.onlyid[tempRanking] == " " or blockItem.onlyid[tempRanking] == nil) and blockItem.pic[tempRanking]:IsVisible() == false)then
	        XEquip_GemInlay_Left_DragOn(tempRanking,equipManage.itemOnlyID[packageBlockB.id[index]])
			return
		end
	end	
end

-- function Equip_GemInlay_Storage()
    -- if(g_equip_geminlay_ui:IsVisible() == false) then
	    -- return
	-- end
	-- local itemChangeRank = GetitemChangeRanking()
	-- local itemUsingOnlyId = GetitemUsingOnlyId()
	-- XEquip_GemInlay_Left_DragOn(itemChangeRank+1,itemUsingOnlyId)--����lua��Ϣ
-- end


function Equip_GemInlay_Left_PB_checkRect() --left_�ж��Ƿ��ڰ�����
    for i = 2,4 do
	    if(CheckEquipPullResult(stone_BlockEndImage[i])) then
		    return i
	    end
	end	 
	return 0
end
function Equip_GemInlay_Left_PA_checkRect() --left_�ж��Ƿ��ڰ�����
	if(CheckEquipPullResult(stone_BlockEndImage[1])) then
		return 1
	end
	return 0
end

function Equip_GemInlay_Left_PA_PullOutClean()
    EquipName:SetFontText("0")
	EquipName:SetVisible(0)
end

function Equip_GemInlay_Left_PB_PullOutClean(ranking)
    stone_FontTitle[ranking]:SetFontText(" ")
	stone_FontTitle[ranking]:SetVisible(0)
end




function Equip_GemInlay_TakeOff(index,ibool)
    if(index>3 or index<1) then
	   return
	end   
    ThreeButtonTakeOff[index]:SetVisible(ibool)
	ThreeButtonTakeOff[index]:SetEnabled(ibool)
end

function Equip_GemInlay_TakeOpen(index,ibool)
    if(index>3 or index<1) then
	   return
	end   
    ThreeButtonOpen[index]:SetVisible(ibool)
	ThreeButtonOpen[index]:SetEnabled(ibool)
	lock[index+1]:SetVisible(ibool)
end

function Equip_GemInlay_TakeOpenSetEnable(index,ibool)
    if(index>3 or index<1) then
	   return
	end   
    if(ibool==0) then
	    ThreeButtonOpen[index]:SetEnabled(0)
    else
	    ThreeButtonOpen[index]:SetEnabled(1)
	end
end

function Equip_GemInlay_changeUseItem(ibool)
    if(ibool==0) then
	    UseChange:SetEnabled(0)
    else
	    UseChange:SetEnabled(1)
	end
end




























