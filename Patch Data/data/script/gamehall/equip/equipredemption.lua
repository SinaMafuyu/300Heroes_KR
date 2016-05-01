include("../Data/Script/Common/include.lua")

-- Member
local m_EquipBackgroundImage = {}			-- ÿ����Ʒ��Icon
local m_EquipBackgroundImageCount = {}		-- ������ʾ��Ʒ����
local m_EquipBackgroundImageFrame = {}		-- ÿ����ƷIcon�Ŀ��
local LastSelImageIndex = 0					-- ���һ��ѡ�е���Ʒindex
local m_RedemptionType = 0					-- �����Ʒ����		0 װ��		1 ��ʯ
local EquipReturnButton = nil				-- װ������  CheckButton1
local StoneReturnButton = nil				-- ��ʯ����  CheckButton2
local IsChange1 = false						-- ����CheckButton1�Ƿ��л�ͼƬ
local IsChange2 = true						-- ����CheckButton2�Ƿ��л�ͼƬ

-- Data
local m_EquipInfo = {}						-- C++�е�����
m_EquipInfo.OnlyId = {}						-- ��ƷΨһid
m_EquipInfo.IconPath = {}					-- ��ƷͼƬ·��
m_EquipInfo.Tip = {}						-- ��Ʒtip
m_EquipInfo.IsShowAni = {}					-- �Ƿ񲥷�֡����
m_EquipInfo.ItemCount = {}					-- ��Ʒ����
local m_BuyShopIcon = nil					-- ���Թ���ĵ���ͼƬ
local m_BuyShopIconCount = nil				-- ��ǰ����

-- ��ʼ��
function Init_EquipRedemptionUI( wnd, bisopen)
	g_equip_redemption_ui = CreateWindow(wnd.id, 0, 0, 1280, 800)
	g_equip_redemption_ui:EnableBlackBackgroundTop(1)
	Init_EquipRedemption(g_equip_redemption_ui)
	g_equip_redemption_ui:SetVisible(bisopen)
end

-- ��ʼ��UI
function Init_EquipRedemption(wnd)
	-- BackGround Is FatherNode
	local BackGround = wnd:AddImage( path_equip .. "storageBack_equip.png", 1280/2-412/2, 800/2-497/2+37, 412, 497)
	
	EquipReturnButton = BackGround:AddImage( path_equip .. "checkB3_equip.png", 0, -35, 128, 64)
	EquipReturnButton:AddFont( "װ������", 15, 8, 0, 0, 110, 50, 0xffffff)
	StoneReturnButton = BackGround:AddImage( path_equip .. "checkB1_equip.png", 99, -35, 128, 64)
	StoneReturnButton:AddFont( "��ʯ����", 15, 8, 0, 0, 110, 50, 0xffffff)
	
	-- װ�����
	EquipReturnButton.script[XE_ONHOVER] = function()
		if IsChange1 then
			EquipReturnButton.changeimage( path_equip .. "checkB2_equip.png" )
		end
	end
	EquipReturnButton.script[XE_ONUNHOVER] = function()
		if IsChange1 then
			EquipReturnButton.changeimage( path_equip .. "checkB1_equip.png" )
		end
	end
	EquipReturnButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		-- SendMsg
		m_RedemptionType = 0
		XSendShuHuiBagMsg( m_RedemptionType )
		
		IsChange1 = false
		IsChange2 = true
		EquipReturnButton.changeimage( path_equip .. "checkB3_equip.png" )
		StoneReturnButton.changeimage( path_equip .. "checkB1_equip.png" )
		
		-- ��ѡ��״̬��ͼƬ��ԭ
		if LastSelImageIndex ~= 0 then
			m_EquipBackgroundImageFrame[LastSelImageIndex].changeimage( path_equip .. "kuang_equip.png")
			LastSelImageIndex = 0
		end
	end
	
	-- ��ʯ���
	StoneReturnButton.script[XE_ONHOVER] = function()
		if IsChange2 then
			StoneReturnButton.changeimage( path_equip .. "checkB2_equip.png" )
		end
	end
	StoneReturnButton.script[XE_ONUNHOVER] = function()
		if IsChange2 then
			StoneReturnButton.changeimage( path_equip .. "checkB1_equip.png" )
		end
	end
	StoneReturnButton.script[XE_LBUP] = function()
		XClickPlaySound(5)
		-- SendMsg
		m_RedemptionType = 1
		XSendShuHuiBagMsg( m_RedemptionType )
		
		IsChange2 = false
		IsChange1 = true
		StoneReturnButton.changeimage( path_equip .. "checkB3_equip.png" )
		EquipReturnButton.changeimage( path_equip .. "checkB1_equip.png" )
		
		-- ��ѡ��״̬��ͼƬ��ԭ
		if LastSelImageIndex ~= 0 then
			m_EquipBackgroundImageFrame[LastSelImageIndex].changeimage( path_equip .. "kuang_equip.png")
			LastSelImageIndex = 0
		end
	end
	
	for i=1, 35 do
	
		local posx = 54*((i-1)%7)+20
		local posy = math.ceil(i/7)*54-7
		
		m_EquipBackgroundImage[i] = BackGround:AddImage( path_equip .. "bag_equip.png", posx, posy, 50, 50)
		m_EquipBackgroundImageCount[i] = m_EquipBackgroundImage[i]:AddFont( "0", 12, 6, -50, -33, 100, 17, 0xffffff)
		m_EquipBackgroundImageCount[i]:SetVisible(0)
		m_EquipBackgroundImageCount[i]:SetFontBackground()
		m_EquipBackgroundImageFrame[i] = m_EquipBackgroundImage[i]:AddImage( path_equip .. "kuang_equip.png", 0, 0, 50, 50)
		m_EquipBackgroundImageFrame[i]:SetTouchEnabled(0)
		
		m_EquipBackgroundImage[i].script[XE_LBUP] = function()
			-- �������
			XClickPlaySound(5)
			local tempnum = tonumber( m_EquipInfo.OnlyId[i] )
			if tempnum > 0 and i ~= LastSelImageIndex then
				m_EquipBackgroundImageFrame[i].changeimage( path_equip .. "kuang3_equip.png")
				if LastSelImageIndex ~= 0 then
					m_EquipBackgroundImageFrame[LastSelImageIndex].changeimage( path_equip .. "kuang_equip.png")
				end
				LastSelImageIndex = i
			end
		end
		
	end
	
	local PromptingFont = BackGround:AddFont( "��ʾ��\n�� ÿ�ι�����Ҫ����һ�Ź���ȯ\n�� ���ɴ洢35���ɹ��ص���(ʱЧ���߳���)\n�� ����б��еĵ��߿��ܻ᲻����������뼰ʱ��ص���", 12, 0, 15, 345, 250, 100, 0x8295cf)
	
	local BuyReturn = BackGround:AddButton( path_setup .. "btn1_mail.png", path_setup .. "btn2_mail.png", path_setup .. "btn3_mail.png", 285, 425, 100, 32)
	BuyReturn:AddFont( "����", 15, 8, 0, 0, 100, 32)
	BuyReturn.script[XE_LBUP] = function()
		-- �������
		XClickPlaySound(5)
		if LastSelImageIndex == 0 then
			-- û��ѡ��
			XShowMessageBoxFormLua( "��ѡ��һ����Ʒ������أ�")
		else
			-- ѡ����
			XClickRedemptionButton( m_EquipInfo.OnlyId[LastSelImageIndex], m_RedemptionType)
		end
	end
	
	m_BuyShopIcon = BackGround:AddImage( "..\\UI\\Icon\\equip\\shuhui.dds", 298, 360, 50, 50)
	XSetSomeOneItemTip( m_BuyShopIcon.id, 10)
	m_BuyShopIcon:AddImage( path_equip .. "kuang3_equip.png", 0, 0, 50, 50)
	m_BuyShopIconCount = m_BuyShopIcon:AddFont( "x1", 15, 0, 50, 33, 50, 20, 0xffffff)
	m_BuyShopIcon.script[XE_LBUP] = function()
		XClickPlaySound(5)
		-- �ڶ�����������Ч��
		XShopClickBuyItem( 1, 0, 10)
	end
	
	local CloseUI = BackGround:AddButton( path_shop .. "close1_rec.png", path_shop .. "close2_rec.png", path_shop .. "close3_rec.png", 365, 10, 35, 35)
	CloseUI.script[XE_LBUP] = function()
		-- �ر�UI
		XClickPlaySound(5)
		SetEquipRedemptionIsVisible(0)
	end
	
end

-- SetVisible
function SetEquipRedemptionIsVisible(flag)
	if g_equip_redemption_ui ~= nil then
		ReSetButtonState()
		if flag == 1 and g_equip_redemption_ui:IsVisible() == false then
			-- ��
			g_equip_redemption_ui:CreateResource()
			XSendShuHuiBagMsg( m_RedemptionType )		-- 0 װ��  1 ��ʯ
			g_equip_redemption_ui:SetVisible(1)
		elseif flag == 0 and g_equip_redemption_ui:IsVisible() == true then
			-- �ر�
			g_equip_redemption_ui:SetVisible(0)
			for i=1, #m_EquipBackgroundImage do
				-- ÿ�ιرհ�����б��е�ͼƬ���һ��
				m_EquipBackgroundImage[i].changeimage( path_equip .. "bag_equip.png")
			end
			g_equip_redemption_ui:DeleteResource()
		end
	end
end

-- �õ���ؽ����Ƿ�ɼ�
function GetEquipRedemptionVisible()
	if g_equip_redemption_ui ~= nil and g_equip_redemption_ui:IsVisible() then
		return 1
	else
		return 0
	end
end

-- ����UI״̬
function ReSetButtonState()
	ClearEquipRedemptionAllData()
	IsChange1 = false
	IsChange2 = true
	m_RedemptionType = 0
	if EquipReturnButton ~= nil and StoneReturnButton ~= nil then
		EquipReturnButton.changeimage( path_equip .. "checkB3_equip.png" )
		StoneReturnButton.changeimage( path_equip .. "checkB1_equip.png" )
	end
end

-- �õ���ص���Ʒ����
function GetEquipRedemptionInfo( cOnlyId, cIconPath, cTip, cIndex, cIsShowAni, cItemCount)
	m_EquipInfo[cIndex] = cIndex-1
	m_EquipInfo.OnlyId[cIndex] = cOnlyId
	m_EquipInfo.IconPath[cIndex] = cIconPath
	m_EquipInfo.Tip[cIndex] = cTip
	m_EquipInfo.IsShowAni[cIndex] = cIsShowAni
	m_EquipInfo.ItemCount[cIndex] = cItemCount
end

-- �������
function ClearEquipRedemptionAllData()
	m_EquipInfo = {}
	m_EquipInfo.OnlyId = {}
	m_EquipInfo.IconPath = {}
	m_EquipInfo.Tip = {}
	m_EquipInfo.IsShowAni = {}
	m_EquipInfo.ItemCount = {}
	if LastSelImageIndex ~= 0 then
		m_EquipBackgroundImageFrame[LastSelImageIndex].changeimage( path_equip .. "kuang_equip.png")
		LastSelImageIndex = 0
	end
	LastSelImageIndex = 0
end

-- ����
function RefeashEquipRedemption_Call()
	for i=1, #m_EquipBackgroundImage do
		if m_EquipInfo.IconPath[i] == nil or m_EquipInfo.IconPath[i] == "" then
			m_EquipBackgroundImage[i].changeimage( path_equip .. "bag_equip.png")
			XSetImageTip( m_EquipBackgroundImage[i].id, 0)
		else
			m_EquipBackgroundImage[i].changeimage( "..\\" .. m_EquipInfo.IconPath[i])
			XSetImageTip( m_EquipBackgroundImage[i].id, m_EquipInfo.Tip[i])
		end
		XEnableImageAnimate( m_EquipBackgroundImage[i].id, m_EquipInfo.IsShowAni[i], 6, 25, -3)
		
		if m_EquipInfo.ItemCount[i] > "1" then
			m_EquipBackgroundImageCount[i]:SetFontText( m_EquipInfo.ItemCount[i], 0xffffff)
			m_EquipBackgroundImageCount[i]:SetVisible(1)
		else
			m_EquipBackgroundImageCount[i]:SetVisible(0)
		end
	end
end

-- ����ÿ����Ʒ�ĸ���
function SetRedemptionItemCount( iCount)
	m_BuyShopIconCount:SetFontText( "x" .. iCount, 0xffffff)
end