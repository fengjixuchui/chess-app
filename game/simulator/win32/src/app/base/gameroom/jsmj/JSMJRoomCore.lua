--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--endregion

local C = class("JSMJRoomCore",CoreBase)
JSMJRoomCore = C

C.MODULE_PATH = "app.base.gameroom.jsmj"
C.SCENE_CONFIG = {scenename = "JSMJRoomScene", filename = "JSMJRoomScene"}

function C:run(transition, time, more)
	C.super.run(self,transition, time, more)
	self.scene:initialize()
end

---回到大厅
function C:showZJHRoomLayer()
	require("app.init")
	HallCore.new():run()
end

return JSMJRoomCore
