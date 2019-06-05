--[[1003

]]
local t = {
'o_fight_model',
{
	{
		['name']=0x10030001,
		['showname']='主角',
		['id']=1,
		['prefix']='001',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=0,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=5,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x0,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=9,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x0,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=0,
				[3]=0,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030002,
		['showname']='阿紫',
		['id']=1,
		['prefix']='002',
		['postfix']='毒气',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=100,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=101,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=167,
				[3]=0x49000001,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=102,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=583,
				[3]=107,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x49000007,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=103,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x10030003,
		['showname']='白猿',
		['id']=1,
		['prefix']='003',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=200,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=201,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000029,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=203,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030004,
		['showname']='打手',
		['id']=1,
		['prefix']='004',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=300,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=301,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=667,
				[3]=0x49000015,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=303,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030005,
		['showname']='岛主',
		['id']=1,
		['prefix']='005',
		['postfix']='九阳',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=400,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=401,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=583,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=500,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=402,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1500,
				[3]=113,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=500,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=403,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x10030006,
		['showname']='老虎',
		['id']=1,
		['prefix']='006',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=500,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=501,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=500,
				[3]=0x49000008,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=503,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030007,
		['showname']='东方',
		['id']=1,
		['prefix']='007',
		['postfix']='绣花针',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=600,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=602,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=167,
				[3]=0x4900001e,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1333,
				[3]=115,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x49000013,
			},
			[5]={n=2,[1] = '战斗系统_显示伤害',
				[2]=1750,
			},
			[6]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x4900001f,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=603,
			},
		},
		['绝招使用率']=1,
	},
	{
		['name']=0x10030008,
		['showname']='延庆',
		['id']=1,
		['prefix']='008',
		['postfix']='爆炸',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=700,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=701,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=167,
				[3]=0x49000003,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=702,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=583,
				[3]=110,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=703,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x10030009,
		['showname']='剑客',
		['id']=1,
		['prefix']='009',
		['postfix']='嵩山剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=800,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=801,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=333,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=802,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=105,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000016,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=583,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=803,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x1003000a,
		['showname']='怪蛇',
		['id']=1,
		['prefix']='010',
		['postfix']='毒气',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=900,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=902,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=107,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x49000007,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=903,
			},
		},
		['绝招使用率']=1,
	},
	{
		['name']=0x1003000b,
		['showname']='和尚',
		['id']=1,
		['prefix']='011',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1000,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1001,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=333,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1003,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x1003000c,
		['showname']='高僧',
		['id']=1,
		['prefix']='012',
		['postfix']='爆炸',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1100,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1101,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=166,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1102,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=110,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1103,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x1003000d,
		['showname']='巨雕',
		['id']=1,
		['prefix']='013',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1200,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1201,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000026,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=500,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1203,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x1003000e,
		['showname']='莫愁',
		['id']=1,
		['prefix']='014',
		['postfix']='毒气',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1300,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1301,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1302,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=107,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x49000007,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1303,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x1003000f,
		['showname']='秋水',
		['id']=1,
		['prefix']='015',
		['postfix']='青城剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1400,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1401,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=1000,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1402,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x4900000a,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1333,
				[3]=108,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
			[5]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000007,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1403,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x10030010,
		['showname']='朱蛤',
		['id']=1,
		['prefix']='016',
		['postfix']='毒气',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1500,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1502,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x49000020,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=107,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x49000007,
			},
			[5]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1503,
			},
		},
		['绝招使用率']=1,
	},
	{
		['name']=0x10030011,
		['showname']='弟子',
		['id']=1,
		['prefix']='017',
		['postfix']='嵩山剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1600,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1601,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=667,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1602,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1250,
				[3]=105,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000016,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=583,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1603,
			},
		},
		['绝招使用率']=0.2,
	},
	{
		['name']=0x10030012,
		['showname']='师太',
		['id']=1,
		['prefix']='018',
		['postfix']='青城剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1700,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1701,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1702,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x4900000a,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1250,
				[3]=108,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
			[5]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000007,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1703,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x10030013,
		['showname']='鳄神',
		['id']=1,
		['prefix']='019',
		['postfix']='爆炸',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1800,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1801,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1802,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=110,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1803,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x10030014,
		['showname']='毛贼',
		['id']=1,
		['prefix']='020',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1900,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1901,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=500,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=1903,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030015,
		['showname']='恶贼',
		['id']=1,
		['prefix']='021',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2000,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2001,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=833,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2003,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030016,
		['showname']='恶霸',
		['id']=1,
		['prefix']='022',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2100,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2101,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=500,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2103,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030017,
		['showname']='乔峰',
		['id']=1,
		['prefix']='023',
		['postfix']='降龙',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2200,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2201,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=917,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2202,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=2000,
				[3]=0x4900001f,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=417,
				[3]=117,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x49000014,
			},
			[5]={n=2,[1] = '战斗系统_播放音效',
				[2]=917,
				[3]=0x4900000b,
			},
			[6]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2203,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x10030018,
		['showname']='教主',
		['id']=1,
		['prefix']='024',
		['postfix']='吸星大法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2300,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2301,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=833,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2302,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=1083,
				[3]=0x49000022,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=500,
				[3]=106,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2303,
			},
		},
		['绝招使用率']=0.2,
		['绝招类型']='北冥神功',
	},
	{
		['name']=0x10030019,
		['showname']='神仙',
		['id']=1,
		['prefix']='025',
		['postfix']='青城剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2400,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2401,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=917,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2402,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x4900000a,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=2083,
				[3]=108,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=417,
			},
			[5]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000007,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2403,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x1003001a,
		['showname']='武当',
		['id']=1,
		['prefix']='026',
		['postfix']='太极',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2500,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2501,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=333,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=167,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2502,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=833,
				[3]=112,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900001e,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=1000,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2503,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x1003001b,
		['showname']='崆峒',
		['id']=1,
		['prefix']='027',
		['postfix']='七伤',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2600,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2601,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=750,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2602,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1833,
				[3]=111,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000d,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=750,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2603,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x1003001c,
		['showname']='童姥',
		['id']=1,
		['prefix']='028',
		['postfix']='九阳',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2700,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2701,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=750,
				[3]=0x49000019,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2702,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=417,
				[3]=0x4900001e,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1167,
				[3]=113,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x4900000d,
			},
			[5]={n=2,[1] = '战斗系统_显示伤害',
				[2]=500,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2703,
			},
		},
		['绝招使用率']=0.2,
	},
	{
		['name']=0x1003001d,
		['showname']='淫贼',
		['id']=1,
		['prefix']='029',
		['postfix']='狂风刀法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2800,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2801,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=333,
				[3]=0x4900000a,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2802,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=667,
				[3]=100,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x49000016,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=133,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2803,
			},
		},
		['绝招使用率']=0.2,
	},
	{
		['name']=0x1003001e,
		['showname']='老僧',
		['id']=1,
		['prefix']='030',
		['postfix']='太玄',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2900,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2902,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1583,
				[3]=116,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=167,
				[3]=0x4900001f,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=333,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=2903,
			},
		},
		['绝招使用率']=1,
	},
	{
		['name']=0x1003001f,
		['showname']='馆主',
		['id']=1,
		['prefix']='031',
		['postfix']='五行拳',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3000,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3001,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=750,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3002,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1833,
				[3]=104,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=0,
				[3]=0x49000016,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3003,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x10030020,
		['showname']='小兵',
		['id']=1,
		['prefix']='032',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3100,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3101,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3103,
			},
		},
		['绝招使用率']=0,
	},
	{
		['name']=0x10030021,
		['showname']='杨过',
		['id']=1,
		['prefix']='033',
		['postfix']='玄铁',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3200,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3201,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=667,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3202,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1000,
				[3]=114,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=167,
				[3]=0x49000021,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=0,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3203,
			},
		},
		['绝招使用率']=0.3,
	},
	{
		['name']=0x10030022,
		['showname']='华山',
		['id']=1,
		['prefix']='034',
		['postfix']='嵩山剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3300,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3301,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=500,
				[3]=0x4900000a,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3302,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=166,
				[3]=0x4900001f,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1000,
				[3]=105,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000016,
			},
			[5]={n=2,[1] = '战斗系统_显示伤害',
				[2]=583,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3303,
			},
		},
		['绝招使用率']=0.8,
	},
	{
		['name']=0x10030023,
		['showname']='无忌',
		['id']=1,
		['prefix']='035',
		['postfix']='九阳',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3400,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3401,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=750,
				[3]=0x4900000b,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=83,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3402,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=333,
				[3]=0x4900001e,
			},
			[3]={n=2,[1] = '战斗系统_播放光影',
				[2]=1167,
				[3]=113,
			},
			[4]={n=2,[1] = '战斗系统_播放音效',
				[2]=250,
				[3]=0x4900000d,
			},
			[5]={n=2,[1] = '战斗系统_显示伤害',
				[2]=500,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3403,
			},
		},
		['绝招使用率']=0.4,
	},
	{
		['name']=0x10030024,
		['showname']='伯通',
		['id']=1,
		['prefix']='036',
		['postfix']='空明',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3500,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3502,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=750,
				[3]=109,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000021,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3503,
			},
		},
		['绝招使用率']=1,
		['绝招类型']='左右互搏',
	},
	{
		['name']=0x10030025,
		['showname']='灵珊',
		['id']=1,
		['prefix']='037',
		['postfix']='嵩山剑法',
		['待机动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3600,
			},
		},
		['攻击动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3601,
			},
			[2]={n=2,[1] = '战斗系统_播放音效',
				[2]=750,
				[3]=0x49000019,
			},
			[3]={n=2,[1] = '战斗系统_显示伤害',
				[2]=250,
			},
		},
		['绝招动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3602,
			},
			[2]={n=2,[1] = '战斗系统_播放光影',
				[2]=1500,
				[3]=105,
			},
			[3]={n=2,[1] = '战斗系统_播放音效',
				[2]=83,
				[3]=0x49000016,
			},
			[4]={n=2,[1] = '战斗系统_显示伤害',
				[2]=583,
			},
		},
		['失败动作']={
			[1]={n=2,[1] = '战斗系统_播放人物动作',
				[3]=3603,
			},
		},
		['绝招使用率']=0.3,
	},
}}
return t