--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--endregion

local hallCore = require("app.base.hall.HallCore")

local C = class("ZJHRoomScene",SceneBase)
ZJHRoomScene = C
C.zjhHelpLayer = nil
-- 资源名
C.RESOURCE_FILENAME = "base/ZhaJinHuaRoom.csb"

C.RESOURCE_BINDING = {
	--返回按钮
	btn_back = {path="btn_back",events={{event="click",method="OnBack"}}},
    --语言按钮
	btn_language = {path="btn_language",events={{event="click",method="OnBack"}}},
    --帮助按钮
	btn_help = {path="btn_help",events={{event="click",method="OnHelp"}}},
    --记录按钮
	btn_record = {path="btn_record",events={{event="click",method="OnRecord"}}},
	--体验房
	btn_gameItem_0 = {path="right_panel.gameItem_0",events={{event="click",method="OnGameItem_0"}}},
    --初级房
	btn_gameItem_1 = {path="right_panel.gameItem_1",events={{event="click",method="OnGameItem_1"}}},
    --中级房
	btn_gameItem_2 = {path="right_panel.gameItem_2",events={{event="click",method="OnGameItem_2"}}},
    --高级房
	btn_gameItem_3 = {path="right_panel.gameItem_3",events={{event="click",method="OnGameItem_3"}}},

    --顶部UI节点
    top_panel = {path="top_panel"},
    bg_top = {path="top_panel.bg_top"},
    img_head = {path="top_panel.img_head"},
    girl = {path="girl"},

    girlAni = {path="girlAni"},

    label_0 = {path="right_panel.gameItem_0.label_0"},
    label_1 = {path="right_panel.gameItem_0.label_1"},
    label_2 = {path="right_panel.gameItem_1.label_2"},
    label_3 = {path="right_panel.gameItem_1.label_3"},
    label_4 = {path="right_panel.gameItem_2.label_4"},
    label_5 = {path="right_panel.gameItem_2.label_5"},
    label_6 = {path="right_panel.gameItem_3.label_6"},
    label_7 = {path="right_panel.gameItem_3.label_7"},

    txt_id = {path="top_panel.txt_id"},
    label_money = {path="top_panel.label_0"},
}

C.offsetX = (display.width-1136)/2

C.items = {}
C.gameId = 1


function C:initialize()
    --适配宽度代码 1136为设计分辨率宽度
	self.hairOffsetX = GET_PHONE_HAIRE_WIDTH()
	self.resourceNode:setPositionX(self.offsetX)
    self.btn_back:setPositionX(self.btn_back:getPositionX() + self.offsetX)
    self.btn_help:setPositionX(self.btn_help:getPositionX() + self.offsetX)
    self.btn_record:setPositionX(self.btn_record:getPositionX() + self.offsetX)


    self.top_panel:setPositionX(self.top_panel:getPositionX() - self.offsetX)
    --self.img_head:setVisible(false)
    self.btn_language:setVisible(false)
    --self.btn_help:setVisible(false)
    --self.btn_record:setVisible(false)
    self.girl:setVisible(false)

    SET_HEAD_IMG(self.img_head,dataManager.userInfo.headid,dataManager.userInfo.wxheadurl)
    
    --print("-------gameId-------" .. self.gameId)

	for k,v in pairs(dataManager.gamelist) do
		if v.gameid == self.gameId then
			local contain = false
			--过滤重复房间号
			for t,r in pairs(self.items) do
				if r.orderid == v.orderid then
					contain = true
				end
			end
			if not contain then
				table.insert(self.items,v)
			end
		end
	end

    self:loadZJHGirlAnimation()

    self.girlAni:setScaleX(0.88)
    self.girlAni:setScaleY(0.88)

    self.label_0:setString("0.2")       --体验房底注
    self.label_1:setString("20")       --体验房准入
    self.label_2:setString("1")       --初级房底注
    self.label_3:setString("50")       --初级房准入
    self.label_4:setString("5")       --中级房底注
    self.label_5:setString("300")       --中级房准入
    self.label_6:setString("20")       --高级房底注  10 
    self.label_7:setString("1500")       --高级房准入  1500     

    self.txt_id:setString("ID:" .. dataManager.userInfo.playerid)
    self.txt_id:setFontSize(26)
    self.label_money:setString(dataManager.userInfo.money/MONEY_SCALE)
end

--进入场景
function C:onEnterTransitionFinish()
	C.super.onEnterTransitionFinish(self)
	--播放背景音乐
	PLAY_MUSIC(BASE_SOUND_RES.."bg_room_zjh.mp3")
end

--炸金花女孩动画
function C:loadZJHGirlAnimation()
	local strAnimName ="base/animation/skeleton/zjhgirl/zjh_effect_hall_girl_ske"
    local skeletonNode = sp.SkeletonAnimation:create(strAnimName .. ".json", strAnimName .. ".atlas", 1)
    skeletonNode:setAnimation(0,"newAnimation",true)
	self.girlAni:addChild( skeletonNode )
end

--点击返回大厅
function C:OnBack( event )
	require("app.init")
	HallCore.new():run()
end

--帮助
function C:OnHelp( event )
	--print("--------------OnHelp  is  called!!!--------------")
    if self.zjhHelpLayer == nil then
		self.zjhHelpLayer = ZhaJinHuaHelpLayer.new()
		self.zjhHelpLayer:retain()
	end
	self.zjhHelpLayer:show()
end

--记录
function C:OnRecord( event )
	print("--------------OnRecord  is  called!!!--------------")
end

--点击进入体验房
function C:OnGameItem_0( event )
	--print("--------------OnGameItem_0  is  called!!!--------------")
    hallCore:enterGameRoom(self.items[1])
end

--点击进入初级房
function C:OnGameItem_1( event )
	--print("--------------OnGameItem_1  is  called!!!--------------")
    hallCore:enterGameRoom(self.items[2])
end

--点击进入中级房
function C:OnGameItem_2( event )
	--print("--------------OnGameItem_2  is  called!!!--------------")
    hallCore:enterGameRoom(self.items[3])
end

--点击进入高级房
function C:OnGameItem_3( event )
	--print("--------------OnGameItem_3  is  called!!!--------------")
    hallCore:enterGameRoom(self.items[4])
end

return ZJHRoomScene