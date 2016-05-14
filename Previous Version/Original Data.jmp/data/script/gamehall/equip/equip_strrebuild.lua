include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")


local iWord = {"","","","","",""}--�������Ե�����
local iNum = {0,0,0,0,0,0}--�������Ե�����
local iColor = {0,0,0,0,0,0}--����������ɫ

local tempcolor = {0x49d3f0,0x3C285A}--2����ɫ


local FontPlayIdea1 = {"��װ��ǿ���ﵽ4��9��15��ʱ��������һ�ζ���ļӻ�����.",
"���ӻ����Եĸߵͣ�����ͨ��װ������������ı�.",
"�������󣬼̳��������������ã����̳�������ԭ��"}

local btn_rebuild = {}   						-----װ��������ť


local Font_rebuild = {"��ԭ","����","����"} 	-----װ��������ť����
local EquipName,EquipIcon = nil
local Cur_property = {}
local Next_property = {}
local Cur_font = {"[4������]+9��������","[9������]+130����ֵ","[15������]+15�㷨������"}
local Next_font = {"[4������]+9��������","[9������]+130����ֵ","[15������]+15�㷨������"}

local rebuildItem = {} --��ק--Ŀ��item
rebuildItem.pic = nil
rebuildItem.id = nil
rebuildItem.type = nil


function InitEquip_StrRebuildUI(wnd, bisopen)
	g_str_Rebuild_ui = CreateWindow(wnd.id, 200, 200, 450, 470)
		
	EquipName = g_str_Rebuild_ui:AddFont("װ������װ������",15,  8, 0, -6, 416, 20, 0x49d3f0)
	EquipName:SetVisible(0)
	EquipIcon = g_str_Rebuild_ui:AddImage(path_equip.."bag_equip.png",180,34,50,50)
	rebuildItem.pic = EquipIcon:AddImage(path_equip.."bag_equip.png",0,0,50,50)
	rebuildItem.pic.script[XE_RBUP] = function()
		if(rebuildItem.id == nil or rebuildItem.id == 0) then--id������ ����Ӧ
			return
	    end
		Equip_StrRebuild_clean()
	end	
	
	
	g_str_Rebuild_ui:AddImage(path_equip.."HeadShine_equip.png",171,25,68,68)
	g_str_Rebuild_ui:AddImage(path_equip.."rebuild_equip.png",164,114,128,16)
	g_str_Rebuild_ui:AddImage(path_equip.."playidea_equip.png",25,266,64,16)
	local AM1 = g_str_Rebuild_ui:AddFont(FontPlayIdea1[1], 12, 0, 44, 288, 400, 20, 0x8295cf)
	local AM2 = g_str_Rebuild_ui:AddFont(FontPlayIdea1[2], 12, 0, 44, 308, 400, 20, 0x8295cf)
	local AM3 = g_str_Rebuild_ui:AddFont(FontPlayIdea1[3], 12, 0, 44, 328, 400, 20, 0x8295cf)
	AM1:SetFontSpace(1,1)
	AM2:SetFontSpace(1,1)
	AM3:SetFontSpace(1,1)
	for idx=1,3 do
		btn_rebuild[idx] = g_str_Rebuild_ui:AddButton(path_setup.."buy1_setup.png",path_setup.."buy2_setup.png",path_setup.."buy3_setup.png",40+127*(idx-1),400,83,35)
		btn_rebuild[idx]:AddFont(Font_rebuild[idx], 15, 8, 0, 0, 83, 35, 0xbcbcc4)
		btn_rebuild[idx]:SetEnabled(0)
	end
	
	btn_rebuild[1].script[XE_LBUP] = function()
	    if(rebuildItem.id ~= 0 and rebuildItem.id ~= nil) then
		    XEquip_StrRebuildLwantReturn(1,equipManage.CitemIndex[rebuildItem.id],equipManage.itemOnlyID[rebuildItem.id])
		end
		Equip_StrRebuildRSetReturn()
		Equip_StrRebuild_SetUseButton(0)--����Ϊ�Ҳ��ɵ��
		Equip_StrRebuild_SetReturnButton(0)--����Ϊ�Ҳ��ɵ��
	end
	
	btn_rebuild[2].script[XE_LBUP] = function()
	    if(rebuildItem.id ~= 0 and rebuildItem.id ~= nil) then
		    XEquip_StrRebuildLwantrebuild(1,equipManage.CitemIndex[rebuildItem.id],equipManage.itemOnlyID[rebuildItem.id])
		end
	end
	
	btn_rebuild[3].script[XE_LBUP] = function()
	    if(rebuildItem.id ~= 0 and rebuildItem.id ~= nil) then
		    XEquip_StrRebuildLwantUseMyrebuild(1,equipManage.CitemIndex[rebuildItem.id],equipManage.itemOnlyID[rebuildItem.id])
			if(iNum[4]~=0 or iNum[5]~=0 or iNum[6]~=0) then
			    Equip_StrRebuild_SetData_PullIn(iWord[4],iNum[4],iWord[5],iNum[5],iWord[6],iNum[6],0,0,0,0,0,0,iColor[4],iColor[5],iColor[6],0,0,0)
			end	
			Equip_StrRebuild_SetUseButton(0)--����Ϊ�Ҳ��ɵ��
			Equip_StrRebuild_SetReturnButton(0)--����Ϊ�Ҳ��ɵ��
		end
	end

	
	Cur_property[1] = g_str_Rebuild_ui:AddFont(Cur_font[1], 12, 0, 60, 150, 200, 15, 0x49d3f0)
	Cur_property[1]:SetFontSpace(1,0)
	Cur_property[2] = g_str_Rebuild_ui:AddFont(Cur_font[2], 12, 0, 60, 165, 200, 15, 0x49d3f0)
	Cur_property[2]:SetFontSpace(1,0)
	Cur_property[3] = g_str_Rebuild_ui:AddFont(Cur_font[3], 12, 0, 60, 180, 200, 15, 0x49d3f0)
	Cur_property[3]:SetFontSpace(1,0)
	Next_property[1] = g_str_Rebuild_ui:AddFont(Next_font[1], 12, 0, 230, 150, 200, 15, 0x49d3f0)
	Next_property[1]:SetFontSpace(1,0)
	Next_property[2] = g_str_Rebuild_ui:AddFont(Next_font[2], 12, 0, 230, 165, 200, 15, 0x49d3f0)
	Next_property[2]:SetFontSpace(1,0)
	Next_property[3] = g_str_Rebuild_ui:AddFont(Next_font[3], 12, 0, 230, 180, 200, 15, 0x49d3f0)
	Next_property[3]:SetFontSpace(1,0)
	for index = 1,3 do
	    Cur_property[index]:SetVisible(0)
		Next_property[index]:SetVisible(0)
	end
	
	g_str_Rebuild_ui:SetVisible(bisopen)
end

function Equip_StrRebuild_Checktip()
   if(g_str_Rebuild_ui:IsVisible() == true) then
      rebuildItem.pic:SetImageTip(equipManage.tip[rebuildItem.id])
   end	   
end


function Equip_StrRebuild_checkRect() --�ж��Ƿ��ڰ�����
	if(CheckEquipPullResult(EquipIcon)) then
		return 1
	else
	    return 0
	end
end

function Equip_StrRebuild_clean()
    --���ǿ��װ��ͼƬ����Ϣ
    rebuildItem.pic.changeimage() 
	rebuildItem.pic:SetVisible(0)
	rebuildItem.id = 0
    rebuildItem.type = 0
	rebuildItem.pic:SetImageTip(0)
	EquipName:SetFontText("")
	EquipName:SetVisible(0)
	
	Equip_StrRebuild_cleanNumandtype()--�������
	Equip_StrRebuild_SetUseButton(0)--�����ð�������Ϊ��
	Equip_StrRebuild_SetRebuildButton(0)--��������������Ϊ��
	Equip_StrRebuild_SetReturnButton(0)
end

function Equip_StrRebuild_Settip(tip)
    rebuildItem.pic:SetImageTip(tip)
end


function Equip_StrRebuild_change(id)--�����ݿ����id
    rebuildItem.id = id
	rebuildItem.pic.changeimage(equipManage.picPath[id])--����ͼƬ
    rebuildItem.type = equipManage.type[id]
	rebuildItem.pic:SetVisible(1)
	if(rebuildItem.pic:GetBoolImageAnimate() == 1 and equipManage.itemAnimation[id] == -1) then
	    rebuildItem.pic:CleanImageAnimate()
	elseif(equipManage.itemAnimation[id] ~= -1) then
	    rebuildItem.pic:EnableImageAnimate(1,equipManage.itemAnimation[id],15,5)
    end  
end

function Equip_StrRebuild_pullPicXLUP()
    if(g_str_Rebuild_ui:IsVisible() == false) then
	    return
	end
    local tempRanking = Equip_StrRebuild_checkRect() --�ж��Ƿ��ڰ�����
	if(tempRanking == 1) then
	    Equip_StrRebuild_clean()
		Equip_StrRebuild_change(pullPicType.id) 
		Equip_StrRebuild_changeinfo()	
		Equip_StrRebuild_SetRebuildButton(1)
        XEquip_StrRebuild_NeedItemRaiseInfo(1,equipManage.CitemIndex[rebuildItem.id],equipManage.itemOnlyID[rebuildItem.id])
	end
end

function Equip_StrRebuild_RClickUp(id)
    if(g_str_Rebuild_ui:IsVisible() == false or equipManage.type[id] ~= 3) then
	    return
	end
	   Equip_StrRebuild_clean()
	   Equip_StrRebuild_change(id) 
	   Equip_StrRebuild_changeinfo()	
	   Equip_StrRebuild_SetRebuildButton(1)
       XEquip_StrRebuild_NeedItemRaiseInfo(1,equipManage.CitemIndex[rebuildItem.id],equipManage.itemOnlyID[rebuildItem.id])		
end


function Equip_StrRebuild_changeinfo() --��װ��������ʱ�����л�����
    if(rebuildItem.id <=0 or rebuildItem.id == nil) then
	    return
	end
    EquipName:SetFontText(equipManage.name[rebuildItem.id],0x49d3f0)
	EquipName:SetVisible(1)
end

function Equip_StrRebuild_SetData_PullIn(word_1,num_1,word_2,num_2,word_3,num_3,word_4,num_4,word_5,num_5,word_6,num_6,iLuaColor_1,iLuaColor_2,iLuaColor_3,iLuaColor_4,iLuaColor_5,iLuaColor_6)

    iWord[1] = word_1
	iWord[2] = word_2
	iWord[3] = word_3
	iWord[4] = word_4
	iWord[5] = word_5
	iWord[6] = word_6
    iNum[1] = num_1
	iNum[2] = num_2
	iNum[3] = num_3
	iNum[4] = num_4
	iNum[5] = num_5
	iNum[6] = num_6
	iColor[1] = iLuaColor_1
	iColor[2] = iLuaColor_2
	iColor[3] = iLuaColor_3
	iColor[4] = iLuaColor_4
	iColor[5] = iLuaColor_5
	iColor[6] = iLuaColor_6

	
	

    Cur_property[1]:SetFontText(word_1,iLuaColor_1)
	Cur_property[2]:SetFontText(word_2,iLuaColor_2)
	Cur_property[3]:SetFontText(word_3,iLuaColor_3)
	Next_property[1]:SetFontText(word_4,iLuaColor_4)
	Next_property[2]:SetFontText(word_5,iLuaColor_5)
	Next_property[3]:SetFontText(word_6,iLuaColor_6)
	
	
	if(num_1~=0)then
	    Cur_property[1]:SetVisible(1)
	else
	    Cur_property[1]:SetVisible(0)
	end
	if(num_2~=0)then
	    Cur_property[2]:SetVisible(1)
	else
	    Cur_property[2]:SetVisible(0)
	end
	if(num_3~=0)then
	    Cur_property[3]:SetVisible(1)
	else
	    Cur_property[3]:SetVisible(0)
	end
	if(num_4~=0)then
	    Next_property[1]:SetVisible(1)
	else
	    Next_property[1]:SetVisible(0)
		Next_property[2]:SetVisible(0)
		Next_property[3]:SetVisible(0)
		return
	end
	if(num_5~=0)then
	    Next_property[2]:SetVisible(1)
	else
	    Next_property[2]:SetVisible(0)
		Next_property[3]:SetVisible(0)
		return
	end
	if(num_6~=0)then
	    Next_property[3]:SetVisible(1)
	else
	    Next_property[3]:SetVisible(0)
	end
end

function Equip_StrRebuild_cleanNumandtype()--�����������
    iWord = {"","","","","",""}--�������Ե�����
    iNum = {0,0,0,0,0,0}--�������Ե�����
	iColor = {0,0,0,0,0,0}--�������Ե���ɫ
	
	Cur_property[1]:SetFontText("",0x49d3f0)
	Cur_property[2]:SetFontText("",0x49d3f0)
	Cur_property[3]:SetFontText("",0x49d3f0)
	Next_property[1]:SetFontText("",0x49d3f0)
	Next_property[2]:SetFontText("",0x49d3f0)
	Next_property[3]:SetFontText("",0x49d3f0)
	Cur_property[1]:SetVisible(0)
	Cur_property[2]:SetVisible(0)
	Cur_property[3]:SetVisible(0)
	Next_property[1]:SetVisible(0)
	Next_property[2]:SetVisible(0)
	Next_property[3]:SetVisible(0)
	
end



function Equip_StrRebuild_SetUseButton(ibool)
    if(ibool~=0) then
	    btn_rebuild[3]:SetEnabled(1)
	else 
	    btn_rebuild[3]:SetEnabled(0)
	end
end

function Equip_StrRebuild_SetRebuildButton(ibool)
    if(ibool~=0) then
	    btn_rebuild[2]:SetEnabled(1)
	else 
	    btn_rebuild[2]:SetEnabled(0)
	end
end

function Equip_StrRebuild_SetReturnButton(ibool)
    if(ibool~=0) then
	    btn_rebuild[1]:SetEnabled(1)
	else 
	    btn_rebuild[1]:SetEnabled(0)
	end
end

function Equip_StrRebuildRSetReturn()
    for index = 4,6 do
	    iWord[index] = " "
		iNum[index] = 0
		iColor[index] = 0
		Next_property[index-3]:SetFontText("",0x49d3f0)
		Next_property[index-3]:SetVisible(0)
	end
end




























function SetEquip_StrRebuildIsVisible(flag) 
	if g_str_Rebuild_ui ~= nil then
		if flag == 1 and g_str_Rebuild_ui:IsVisible() == false then
			g_str_Rebuild_ui:SetVisible(1)	
			XEquip_StrRebuild_ClickUp(1)--֪ͨc++��������
		elseif flag == 0 and g_str_Rebuild_ui:IsVisible() == true then
			g_str_Rebuild_ui:SetVisible(0)
			Equip_StrRebuild_clean()
		end
	end
end
