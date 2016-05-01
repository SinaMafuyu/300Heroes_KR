include("../Data/Script/Common/include.lua")
include("../Data/Script/Common/window.lua")

function ShopDeleteResource()
	g_game_shop_ui:DeleteResource()
	--g_shop_head_ui:DeleteResource()
	g_shop_recommend_ui:DeleteResource()
	g_shop_hero_ui:DeleteResource()	
	g_shop_Sec_hero_ui:DeleteResource()
	g_shop_Sec_heroSkin_ui:DeleteResource()
	g_shop_Sec_heroPhen_ui:DeleteResource()
	g_shop_battleEquip_ui:DeleteResource()	
	g_shop_Sec_Equip_ui:DeleteResource()
	g_shop_Sec_BestEquip_ui:DeleteResource()
	g_shop_stoneStr_ui:DeleteResource()
	g_shop_Sec_Stone_ui:DeleteResource()	
	g_shop_Sec_EquipStr_ui:DeleteResource()
	g_shop_expendable_ui:DeleteResource()
	g_shop_honour_ui:DeleteResource()
	g_shop_vip_ui:DeleteResource()
	g_show_EquipInfo_ui:DeleteResource()	
end
function ShopCreateResource()
	
	g_game_shop_ui:CreateResource()
	--g_shop_head_ui:CreateResource()
	g_shop_recommend_ui:CreateResource()
	g_shop_hero_ui:CreateResource()	
	g_shop_Sec_hero_ui:CreateResource()
	g_shop_Sec_heroSkin_ui:CreateResource()
	g_shop_Sec_heroPhen_ui:CreateResource()
	g_shop_battleEquip_ui:CreateResource()
	g_shop_Sec_Equip_ui:CreateResource()
	g_shop_Sec_BestEquip_ui:CreateResource()
	g_shop_stoneStr_ui:CreateResource()
	g_shop_Sec_Stone_ui:CreateResource()	
	g_shop_Sec_EquipStr_ui:CreateResource()
	g_shop_expendable_ui:CreateResource()
	g_shop_honour_ui:CreateResource()
	g_shop_vip_ui:CreateResource()
	g_show_EquipInfo_ui:CreateResource()

end

function InitGame_ShopUI(wnd, bisopen)
	g_game_shop_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	InitMainGame_Shop(g_game_shop_ui)
	g_game_shop_ui:SetVisible(bisopen)
end

function CheckIfShopEditIsFouse()
    if( IsShop_VipInputFocus() or IsShop_Sec_StoneInputFocus() or IsShop_Sec_HeroSkinInputFocus() or IsShop_Sec_HeroPhenInputFocus() or IsShop_Sec_HeroInputFocus() or 
	    IsShop_Sec_EquipStrInputFocus() or IsShop_Sec_EquipInputFocus() or IsShop_Sec_BestEquipInputFocus() or IsShop_ExpendInputFocus() ) then
	    return true
	end
	return false
end

function InitMainGame_Shop(wnd)
	
	--��ͼ����
	wnd:AddImage(path_shop.."BK_shop.png",0,0,1280,800)	
	--�ϱ���
	wnd:AddImage(path.."upBK_hall.png",0,0,1280,54)
	wnd:AddImage(path.."upLine2_hall.png",0,54,1280,35)
	for i=1,6 do
		wnd:AddImage(path.."linecut_hall.png",163+110*i,60,2,32)
	end
	
	InitShop_RecommendUI(G_login_ui, 0)				--�Ƽ�
	InitShop_HeroUI(G_login_ui, 0)					--Ӣ��
	InitShop_BattleEquipUI(G_login_ui, 0)			--ս��װ��
	InitShop_StoneStrUI(G_login_ui, 0)				--��ʯ��ǿ��
	InitShop_ExpendableUI(G_login_ui, 0)			--����Ʒ
	InitShop_HonourUI(G_login_ui, 0)				--�����빦ѫ
	InitShop_VipUI(G_login_ui, 0)					--VIP�̳�

	InitShop_HeadUI(G_login_ui, 0)					--�˵���
	InitShow_EquipInfoUI(G_login_ui,0)				--���½����VIP���֡������ʯ������UI
end


function SetGameShopIsVisible(flag) 
	
	if g_game_shop_ui ~= nil then
		if flag == 1 and g_game_shop_ui:IsVisible() == false then
		
			ShopCreateResource()
		
			g_game_shop_ui:SetVisible(1)		
			SetShop_HeadIsVisible(1)			
			
			SetFourpartUIVisiable(5)	
			
			SetShop_RecommendIsVisible(1)		
			SetShop_HeroIsVisible(0)			
			SetShop_BattleEquipIsVisible(0)		
			SetShop_StoneStrIsVisible(0)		
			SetShop_ExpendableIsVisible(0)		
			SetShop_HonourIsVisible(0)			
			SetShop_VipIsVisible(0)				
			
			SetNumIsVisible(0)					--�̳ǽ���Ľ����ʯ��vip���ֵ���ֵ
		elseif flag == 0 and g_game_shop_ui:IsVisible() == true then
			
			ShopDeleteResource()
		
			g_game_shop_ui:SetVisible(0)		
			SetShop_HeadIsVisible(0)
			-----------���������̳�����
			SetShop_RecommendIsVisible(0)
			SetShop_HeroIsVisible(0)
			SetShop_BattleEquipIsVisible(0)
			SetShop_StoneStrIsVisible(0)
			SetShop_ExpendableIsVisible(0)
			SetShop_HonourIsVisible(0)
			SetShop_VipIsVisible(0)
			SetNumIsVisible(0)
			XSetShopUiVisible(0)
		end
	end
end

function GetGameShopIsVisible()  
    if g_game_shop_ui~=nil and g_game_shop_ui:IsVisible()==true then
		return 1
    else
        return 0
    end
end