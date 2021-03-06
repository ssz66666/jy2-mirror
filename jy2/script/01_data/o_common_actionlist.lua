--[[1002

]]
local t = {
'o_common_actionlist',
{
	{
		['name']=0x1002000b,
		['showname']='淡入',
		['prefix']='011',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=1,
					[3]=0,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x1002000c,
		['showname']='淡出',
		['prefix']='012',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=0,
					[3]=1,
					[4]=1,
				},
			},
		},
	},
	{
		['name']=0x1002000a,
		['showname']='向下移出',
		['prefix']='010',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[3]={
						['y']=-640,
					},
					[4]=0.3,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=0,
					[3]=1,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020009,
		['showname']='向上移出',
		['prefix']='009',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[3]={
						['y']=640,
					},
					[4]=0.3,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=0,
					[3]=1,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020008,
		['showname']='向右移出',
		['prefix']='008',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[3]={
						['x']=640,
					},
					[4]=0.3,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=0,
					[3]=1,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020007,
		['showname']='向左移出',
		['prefix']='007',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[3]={
						['x']=-640,
					},
					[4]=0.3,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=0,
					[3]=1,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020006,
		['showname']='从下移入',
		['prefix']='006',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[2]={
						['y']=-640,
					},
					[4]=0.5,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=1,
					[3]=0,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020005,
		['showname']='从上移入',
		['prefix']='005',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[2]={
						['y']=640,
					},
					[4]=0.5,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=1,
					[3]=0,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020004,
		['showname']='从右移入',
		['prefix']='004',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[2]={
						['x']=640,
					},
					[4]=0.5,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=1,
					[3]=0,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020003,
		['showname']='从左移入',
		['prefix']='003',
		['动画']={
			[1]={
				['动画']={n=3,[1] = '通用_图片移动',
					[2]={
						['x']=-640,
					},
					[4]=0.5,
				},
				['并行播放']=true,
			},
			[2]={
				['动画']={n=3,[1] = '通用_图片透明度变化',
					[2]=1,
					[3]=0,
					[4]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020002,
		['showname']='震动',
		['prefix']='002',
		['动画']={
			[1]={
				['动画']={n=2,[1] = '通用_图片震动',
					[2]=15,
					[3]=0.3,
				},
			},
		},
	},
	{
		['name']=0x10020001,
		['showname']='静止',
		['id']=1,
		['prefix']='001',
		['动画']={
		},
	},
}}
return t