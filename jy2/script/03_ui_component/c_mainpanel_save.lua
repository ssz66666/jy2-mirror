--[[300b

]]

local G = require "gf"
local t = G.com()
function t:init()
    for i, v in ipairs({'标题', '取消'}) do
        self[v] = self.obj.getChildByName(v);
    end
    self.存档 = {
        self.obj.getChildByName('存档一'),
        self.obj.getChildByName('存档二'),
        self.obj.getChildByName('存档三'),
    }
    self.isSave = false;
end
function t:获取存档信息()
	local perms = {
        [7] = G.o_meta,
		[8] = G.new_meta
    };
    local savename = {'记录一', '记录二', '记录三'}
    for id = 1, #self.存档 do
        local path = G.GetSavePath('R_J2_' .. id .. '.sav');
        if G.IsFileExist(path) then
            local zipbuf = G.LoadFile(path);
            local buf = G.unzip(zipbuf);
            local success, obj = pcall(eris.unpersist, perms, buf)
            -- local obj = eris.unpersist(perms, buf);
            if success then
                self.存档[id].getChildByName('信息').text = string.format('%s  %2d级 %s[br]%s', savename[id] or '', obj.lv or 0, obj.force or '无门派', obj.date or '');
            else
                self.存档[id].getChildByName('信息').text = string.format('%s  已损坏[br]', savename[id] or '');
            end
        else
            self.存档[id].getChildByName('信息').text = string.format('%s  未使用[br]', savename[id] or '');
        end
    end
end
function t:显示读档界面()
    self:获取存档信息()
    self.标题.text = "读取记录"
    self.isSave = false;
    self.obj.visible = true
    if self.obj.parent then
        local c = self.obj.parent.c_mainpanel
        if c then
            c.透明遮挡.visible = true
        end
    end
end
function t:显示存档界面()
    self:获取存档信息()
    self.标题.text = "保存记录"
    self.isSave = true;
    self.obj.visible = true
    if self.obj.parent then
        local c = self.obj.parent.c_mainpanel
        if c then
            c.透明遮挡.visible = true
        end
    end
end
function t:saveFile(id)
    if not id then return end
    local o_role_主角 = G.QueryName(0x10050001).主角
	local perms = {
		[G.o_meta] = 7,
		[G.new_meta] = 8
	};
    local path = G.GetSavePath('R_J2_' .. id .. '.sav');
    local obj = {
        name = o_role_主角.姓名,
        lv = o_role_主角.等级,
        force = o_role_主角.门派,
        date = os.date('%Y.%m.%d  %H:%M:%S'),
        savedata = G.save_ofile(),
    };
	local buf = eris.persist(perms, obj)
	buf = G.zip(buf)
	G.WriteFile(path, buf)
end
function t:loadFile(id)
    if not id then return end
	local perms = {
        [7] = G.o_meta,
		[8] = G.new_meta
	};
    local path = G.GetSavePath('R_J2_' .. id .. '.sav');
    if G.IsFileExist(path) then
		local zipbuf = G.LoadFile(path);
        local buf = G.unzip(zipbuf);
        local success, obj = pcall(eris.unpersist, perms, buf)
        if success and obj.savedata then
            self:load_ofile(obj.savedata);
            return true;
        end
    end
    return false;
end
function t:load_ofile(obj)
	G.newinst_cache = obj[1]
	G.extinst = obj[2]
	for o_name,v in pairs(obj[1]) do
		local db = require(o_name)
		G.QueryInit(o_name)
		if G.extinst[o_name] then
			for i=1,#G.extinst[o_name] do
				table.insert(G.cacheInst[o_name],G.extinst[o_name][i])
			end
		end
	end
end
function t:click(tar)
    if tar == self.取消 then
        self.obj.visible = false;
        G.trig_event('存档_操作结束', '取消')
    else
        for id = 1, #self.存档 do
            if tar == self.存档[id] then
                if self.isSave then
                    self:saveFile(id);
                    self:获取存档信息()
                    G.trig_event('存档_操作结束', '存档')
                else
                    if self:loadFile(id) then
                        G.trig_event('存档_操作结束', '读档');
                        self.obj.visible = false;
                    end
                end
                break;
            end
        end
    end
    if self.obj.visible == false then
        if self.obj.parent then
            local c = self.obj.parent.c_mainpanel
            if c then
                c.透明遮挡.visible = false
            end
        end
    end
end
function t:rollOver(tar)
    for id = 1, #self.存档 do
        if tar == self.存档[id] then
            tar.getChildAt(0).visible = true
            break;
        end
    end
end
function t:rollOut(tar)
    for id = 1, #self.存档 do
        if tar == self.存档[id] then
            tar.getChildAt(0).visible = false
            break;
        end
    end
end
return t