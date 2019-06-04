local t = require 'type/enum'
if type(t) ~= 'table' then t = {} end
t.enum_test1 = {'〇', '一', '二', '三'};
t.enum_test2 = {'Zero', 'One', 'Two', 'Three'};
t.enum_性别 = {'男', '女','其他'};
t.enum_内力性质 = {'阴', '阳','调和'};
t.enum_左右 = {'左', '右'};
t.enum_物品类型 = {'装备', '丹药', '剧情', '秘籍'};
t.enum_装备类型 = {'无效', '武器', '防具'};
t.enum_武功类型 = {'无效', '拳掌', '御剑', '耍刀', '特殊'};
t.enum_伤害类型 = {'生命', '内力'};
t.enum_攻击范围 = {'单点', '直线','十字', '矩形'};
t.enum_方向 = {'上↗', '右↘', '左↖', '下↙'};
t.enum_战斗结果 = {'失败', '胜利', '逃跑'};
return t