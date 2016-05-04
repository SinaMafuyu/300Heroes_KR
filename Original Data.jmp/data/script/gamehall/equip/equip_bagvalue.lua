include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

-------װ������
local wnd_propoty = {}
local font_propoty = {"��  ��  ֵ:","��  ��  ֵ:","�����ظ�:","�����ظ�:","��  ��  ��:","����ǿ��:",
"���״�͸:","������͸:","����͵ȡ:","������Ѫ:","�����ٶ�:","��ȴ����:","��  ��  ��:","��       ��:",
"��������:","��������:","�ƶ��ٶ�:","��       ��:","�˺�����:","�˺�����:"}

local font_ui = {}
local font_num = {"4797 / 4797","1250 / 1250","17","18","650","850","5 | 50%","7 | 80%","20%","50%","1.25","20%","18%","661","530","450","522","105","10%","28%"}
local AttentionLine,Attention = nil


-------װ����ֵ����
function InitBag_ValueUI(wnd, bisopen)
	g_bag_value_ui = CreateWindow(wnd.id, 100,200,320,480)

	---------��һ����
	for i=1,20 do
		local posx = 117+((i+1)%2)*144
		local posy = 250+math.ceil(i/2)*33
		wnd_propoty[i] = g_bag_value_ui:AddFont(font_propoty[i] ,11, 0, posx-100, posy-240, 100, 20, 0x8295cf)
		font_ui[i] = wnd_propoty[i]:AddFont(font_num[i] ,11, 0, 60, 0, 100, 20, 0x6ffefc)
		
	end
	AttentionLine = g_bag_value_ui:AddImage(path_equip.."line_equip.png",105-100,610-240,512,2)
	Attention = g_bag_value_ui:AddFont("��ʾ��\n��������Ӣ��18����ɫ���Ժ�װ������Ԥ����װ��ǿ����������ս����ս����" ,11, 0, 117-100, 620-240, 280, 100, 0x8295cf)
	Attention:SetFontSpace(1,1)
	
	g_bag_value_ui:SetVisible(bisopen)
end
function ReDraw_BagValue(Belong)
	if Belong==0 then
		wnd_propoty[2]:SetFontText("��  ��  ֵ",0x8295cf)
		wnd_propoty[4]:SetFontText("�����ظ�",0x8295cf)
		wnd_propoty[2]:SetVisible(1)
		wnd_propoty[4]:SetVisible(1)
	elseif Belong==1 then
		wnd_propoty[2]:SetFontText("ŭ  ��  ֵ",0x8295cf)
		wnd_propoty[4]:SetFontText("ŭ���ظ�",0x8295cf)
		wnd_propoty[2]:SetVisible(1)
		wnd_propoty[4]:SetVisible(1)
	elseif Belong==2 then
		wnd_propoty[2]:SetFontText("��  ��  ֵ",0x8295cf)
		wnd_propoty[4]:SetFontText("�����ظ�",0x8295cf)
		wnd_propoty[2]:SetVisible(1)
		wnd_propoty[4]:SetVisible(1)
	else
		wnd_propoty[2]:SetVisible(0)
		wnd_propoty[4]:SetVisible(0)
	end
end

function ReDraw_HPMP(hp,mp)
	hp = string.format("%d",hp)
	mp = string.format("%d",mp)
	font_ui[1]:SetFontText(hp,0x6ffefc)
	font_ui[2]:SetFontText(mp,0x6ffefc)
end
function ReDraw_HPMPRecover(hp_recover,mp_recover)
	hp_recover = string.format("%d",hp_recover)
	mp_recover = string.format("%d",mp_recover)
	font_ui[3]:SetFontText(hp_recover,0x6ffefc)
	font_ui[4]:SetFontText(mp_recover,0x6ffefc)
end
function ReDraw_PhyMagicAttack(phycialAttack,magicAttack)
	phycialAttack = string.format("%d",phycialAttack)
	magicAttack = string.format("%d",magicAttack)
	font_ui[5]:SetFontText(phycialAttack,0x6ffefc)
	font_ui[6]:SetFontText(magicAttack,0x6ffefc)
end
function ReDraw_ArmorPhen(armorPhen,magicArmorPhen)
	font_ui[7]:SetFontText(armorPhen,0x6ffefc)
	font_ui[8]:SetFontText(magicArmorPhen,0x6ffefc)
end
function ReDraw_PhyMagDrink(phycialDrink,magicDrink)
	phycialDrink = string.format("%d",phycialDrink).."%"
	magicDrink = string.format("%d",magicDrink).."%"
	
	font_ui[9]:SetFontText(phycialDrink,0x6ffefc)
	font_ui[10]:SetFontText(magicDrink,0x6ffefc)
end
function ReDraw_AttackSpeedCoolDown(attackSpeed,coolDown)
	attackSpeed = string.format("%.2f",attackSpeed)
	coolDown = string.format("%d",coolDown).."%"
	
	font_ui[11]:SetFontText(attackSpeed,0x6ffefc)
	font_ui[12]:SetFontText(coolDown,0x6ffefc)
end
function ReDraw_CriticalArmor(critical,Armor)
	critical = string.format("%d",critical).."%"
	Armor = string.format("%d",Armor)

	font_ui[13]:SetFontText(critical,0x6ffefc)
	font_ui[14]:SetFontText(Armor,0x6ffefc)
end
function ReDraw_AttackRangeMagArmor(attackRange,magicAromr)
	attackRange = string.format("%d",attackRange)
	magicAromr = string.format("%d",magicAromr)

	font_ui[15]:SetFontText(attackRange,0x6ffefc)
	font_ui[16]:SetFontText(magicAromr,0x6ffefc)
end
function ReDraw_MoveSpeedRenxing(moveSpeed,renxing)
	moveSpeed = string.format("%d",moveSpeed)
	renxing = string.format("%d",renxing)
	
	font_ui[17]:SetFontText(moveSpeed,0x6ffefc)
	font_ui[18]:SetFontText(renxing,0x6ffefc)
end
function ReDraw_DmgMoreOrLess(dmgMore,dmgLess)
	dmgMore = string.format("%d",dmgMore).."%"
	dmgLess = string.format("%d",dmgLess).."%"

	font_ui[19]:SetFontText(dmgMore,0x6ffefc)
	font_ui[20]:SetFontText(dmgLess,0x6ffefc)
end

function SetBagValueIsVisible(flag) 
	if g_bag_value_ui ~= nil then
		if flag == 1 and g_bag_value_ui:IsVisible() == false then
			g_bag_value_ui:SetVisible(1)
			XRefreshEquipBagValueInfo()
		elseif flag == 0 and g_bag_value_ui:IsVisible() == true then
			g_bag_value_ui:SetVisible(0)
		end
	end
end
function Bag_ValueSetPosition(x,y)
	g_bag_value_ui:SetPosition(x,y)
end

function Check_Bag_ValueIsVisible()
    if (g_bag_value_ui:IsVisible()) then
	    return true
	else
	    return false
	end
end
