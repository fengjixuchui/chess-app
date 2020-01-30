local C = class("ZjhPopupClass",ViewBaseClass)
local PLAYER_INFO_CSB = "games/zjh/PlayerInfo.csb"
C.posArr = {cc.p(404,340),cc.p(860,300),cc.p(800,500),cc.p(336,500),cc.p(276,300)}

function C:show( info, seatId )
	if info == nil then
		return
	end

	if seatId < 1 or seatId > 5 then
		return
	end

    --点击关闭
    local cover = ccui.Layout:create()
    cover:setTouchEnabled(true)
    cover:setContentSize(cc.size(display.width, display.height))
    cover:setAnchorPoint(cc.p(0, 0))
    cover:setPosition(0,0)
    cover:addTo(self.node)

    local panel = cc.CSLoader:createNode(PLAYER_INFO_CSB)
    panel:addTo(self.node)

    cover:onClick(function()
        cover:removeFromParent(true)
        panel:removeFromParent(true)
    end)
    
    --绑定数据
    local root = panel:getChildByName("pop_info_panel")
    local headImg = root:getChildByName("head_img")
    local frameImg = root:getChildByName("frame_img")
    local vipImg = root:getChildByName("vip_img")
    local vipLabel = vipImg:getChildByName("label")
    local idLabel = root:getChildByName("id_label")
    local nameLabel = root:getChildByName("name_label")
    local cityLabel = root:getChildByName("city_label")
    local creditLabel = root:getChildByName("credit_fnt")
    local nameLabel = root:getChildByName("name_label")
    --头像
    local headRes = GET_HEADID_RES(info["headid"])
    headImg:loadTexture(headRes)
    --头像框
    --vip
    vipImg:setVisible(false)
    --id
    idLabel:setString(tostring(info["playerid"]))
    --name
    local name = info["nickname"] or tostring(info["playerid"])
    nameLabel:setString(name)
    --city
    local city = info["city"] or info["nickname"]
    cityLabel:setString(city)
    --money
    local money = info["money"]
    creditLabel:setString(utils:moneyString(money,3))

    local pos = self.posArr[seatId]
    panel:setPosition(pos)

    panel:setScale(0.1)
	local seq = transition.sequence({
			CCScaleTo:create(0.1, 1.1),
			CCScaleTo:create(0.1, 1),
			CCDelayTime:create(3),
			CCFadeOut:create(0.1),
			CCCallFunc:create(function ()
                cover:removeFromParent(true)
				panel:removeFromParent(true);
			end)
		})
    panel:runAction(seq)
end

return C