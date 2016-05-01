include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")


---------���½����ֽ���(��ҡ���ʯ����������ѫ��VIP�ȼ�)
local Money_Img = {}
local Gold_Img ={}
local Honour_Img = {}
local Contribution_Img = {}
local VIP_Img = {}

local max_money = 0
local max_gold = 0
local max_honour = 0
local max_contribution = 0
local max_vip = 0

local ppy = 0

local Money_shop = nil
local Gold_shop = nil
local Exploit_shop = nil
local Honour_shop = nil
local Vippoint_shop = nil

function InitShow_EquipInfoUI(wnd, bisopen)
	g_show_EquipInfo_ui = CreateWindow(wnd.id, 930, 450+100, 1280, 800)
	InitMainShow_EquipInfo(g_show_EquipInfo_ui)
	g_show_EquipInfo_ui:SetVisible(bisopen)
end
function InitMainShow_EquipInfo(wnd)
	
	--------------���½ǳ�ֵ����
	
	Money_shop = wnd:AddImage(path_shop.."money_shop.png",100,0+ppy,64,64)
	Money_shop:SetTextTip("���\n����ս��������������ɸ������񡢻���")
	Gold_shop = wnd:AddImage(path_shop.."gold_shop.png",100,40+ppy,64,64)
	Gold_shop:SetTextTip("��ʯ\n��ֵ��ã��ɹ���ȫ���̳���Ʒ")
	Exploit_shop = wnd:AddImage(path_shop.."exploit_shop.png",100,80+ppy,64,64)
	Exploit_shop:SetTextTip("��ѫ\n����ս�����")
	Honour_shop = wnd:AddImage(path_shop.."honour_shop.png",100,120+ppy,64,64)
	Honour_shop:SetTextTip("����")
	Vippoint_shop = wnd:AddImage(path_shop.."vippoint_shop.png",100,160+ppy,64,64)
	Vippoint_shop:SetTextTip("VIP��\n��ֵ����")
	--------��ֵ��ť
	local btn_reCharge = wnd:AddButton(path.."button1_hall.png", path.."button2_hall.png", path.."button3_hall.png",75,215+ppy, 179, 56)
	btn_reCharge:AddFont("�� ֵ", 15, 0, 60, 15, 72, 20, 0xbeb9cf)
	btn_reCharge.script[XE_LBUP] = function()
		XClickPlaySound(5)
		XGameSigninToAddMoney(1)
	end
	----------��ҡ���ʯ����������ѫ��VIP��������
	
	for i=1,8 do
		local posX = 135+i*10
		Money_Img[i] = wnd:AddImage(path.."money/0.png",posX,3+ppy,32,32)
		Gold_Img[i] = wnd:AddImage(path.."gold/0.png",posX,43+ppy,32,32)
		Honour_Img[i] = wnd:AddImage(path.."honour/0.png",posX,83+ppy,32,32)
		Contribution_Img[i] = wnd:AddImage(path.."contribution/0.png",posX,123+ppy,32,32)
		VIP_Img[i] = wnd:AddImage(path.."vip/0.png",posX,163+ppy,32,32)
	end
	
	for index,value in pairs(Money_Img) do
		Money_Img[index]:SetVisible(0)
	end
	for index,value in pairs(Gold_Img) do
		Gold_Img[index]:SetVisible(0)
	end
	for index,value in pairs(Honour_Img) do
		Honour_Img[index]:SetVisible(0)
	end
	for index,value in pairs(Contribution_Img) do
		Contribution_Img[index]:SetVisible(0)
	end
	for index,value in pairs(VIP_Img) do
		VIP_Img[index]:SetVisible(0)
	end
	
end
--------------------------------------------------------������
function Equip_ClearMoneyNum(sz)
	max_money = sz
	local flag = 0
	if g_show_EquipInfo_ui:IsVisible()==true then
		flag = 1
	end
	for index,value in pairs(Money_Img) do
		if index <=sz then
			Money_Img[index]:SetVisible(flag)
		else
			Money_Img[index]:SetVisible(0)
		end
	end
end
--�����ʯ
function Equip_ClearGoldNum(sz)
	max_gold = sz
	local flag = 0
	if g_show_EquipInfo_ui:IsVisible()==true then
		flag = 1
	end
	for index,value in pairs(Gold_Img) do
		if index <=sz then
			Gold_Img[index]:SetVisible(flag)
		else
			Gold_Img[index]:SetVisible(0)
		end
	end
end
--�������
function Equip_ClearHonourNum(sz)
	max_honour = sz
	local flag = 0
	if g_show_EquipInfo_ui:IsVisible()==true then
		flag = 1
	end
	for index,value in pairs(Honour_Img) do
		if index <=sz then
			Honour_Img[index]:SetVisible(flag)
		else
			Honour_Img[index]:SetVisible(0)
		end
	end
end
--�����ѫ
function Equip_ClearContributionNum(sz)
	max_contribution = sz
	local flag = 0
	if g_show_EquipInfo_ui:IsVisible()==true then
		flag = 1
	end
	for index,value in pairs(Contribution_Img) do
		if index <=sz then
			Contribution_Img[index]:SetVisible(flag)
		else
			Contribution_Img[index]:SetVisible(0)
		end
	end
end
--���VIP����
function Equip_ClearVIPNum(sz)
	max_vip = sz
	local flag = 0
	if g_show_EquipInfo_ui:IsVisible()==true then
		flag = 1
	end
	for index,value in pairs(VIP_Img) do
		if index <=sz then
			VIP_Img[index]:SetVisible(flag)
		else
			VIP_Img[index]:SetVisible(0)
		end
	end
end
--------------------------------------------------------������

------------------------------------------------------------------------��������
--���ý������
function Equip_SendMoneyNumToLua(num,Fth)	
	local num_lua = path.."money/"..num..".png"
	Money_Img[Fth].changeimage(num_lua)
end
--������ʯ����
function Equip_SendGoldNumToLua(num,Fth)
	local num_lua = path.."gold/"..num..".png"
	Gold_Img[Fth].changeimage(num_lua)
end
--������������
function Equip_SendHonourNumToLua(num,Fth)
	local num_lua = path.."honour/"..num..".png"
	Honour_Img[Fth].changeimage(num_lua)
end
--���ù�ѫ����
function Equip_SendContributionNumToLua(num,Fth)
	local num_lua = path.."contribution/"..num..".png"
	Contribution_Img[Fth].changeimage(num_lua)
end
--����VIP��������
function Equip_SendVIPNumToLua(num,Fth)
	local num_lua = path.."vip/"..num..".png"
	VIP_Img[Fth].changeimage(num_lua)
end

function UpdateEquipInfoImgVisible()
--log("\nUpdateEquipInfoImgVisible   MONEY = "..max_money.."GOLD = "..max_gold.."HONOUR = "..max_honour.."CONTRI = "..max_contribution.."VIP = "..max_vip)
	for index,value in pairs(Money_Img) do
		if index <=max_money then
			Money_Img[index]:SetVisible(1)
		else
			Money_Img[index]:SetVisible(0)
		end
	end
	for index,value in pairs(Gold_Img) do
		if index <=max_gold then
			Gold_Img[index]:SetVisible(1)
		else
			Gold_Img[index]:SetVisible(0)
		end
	end
	for index,value in pairs(Honour_Img) do
		if index <=max_honour then
			Honour_Img[index]:SetVisible(1)
		else
			Honour_Img[index]:SetVisible(0)
		end
	end
	for index,value in pairs(Contribution_Img) do
		if index <=max_contribution then
			Contribution_Img[index]:SetVisible(1)
		else
			Contribution_Img[index]:SetVisible(0)
		end
	end
	for index,value in pairs(VIP_Img) do
		if index <=max_vip then
			VIP_Img[index]:SetVisible(1)
		else
			VIP_Img[index]:SetVisible(0)
		end
	end
end
------------------------------------------------------------------------------�������
function SetNumIsVisible(flag)	
	if g_show_EquipInfo_ui ~= nil then
		if flag ==1 and g_show_EquipInfo_ui:IsVisible() == false then
			g_show_EquipInfo_ui:SetVisible(1)
			UpdateEquipInfoImgVisible()
			
		elseif flag == 0 and g_show_EquipInfo_ui:IsVisible() == true then
			g_show_EquipInfo_ui:SetVisible(0)
		end
	end
end

