//
//  AKEmotion.m
//  BetterWeibo
//
//  Created by Kent on 14-1-11.
//  Copyright (c) 2014年 Kent Peifeng Ke. All rights reserved.
//

#import "AKEmotion.h"

@implementation AKEmotion

@synthesize image = _image;

-(id)initWithCode:(NSString *)code URL:(NSURL *)url image:(NSImage *)image categoryName:(NSString *)category{

    self = [super init];
    if(self){
        self.code = code;
        self.URL = url;
        self.image = image;
        self.categoryName = category;
    
    }
    return self;
}


-(NSImage *)image{
    return _image;

}

-(void)setImage:(NSImage *)image{
    _image = image;
    [_image setSize:NSMakeSize(16, 16)];

}

+(NSArray *)allEmotions{
    static NSMutableArray *emotions;
    if(emotions){
        return emotions;
    }
    
    emotions = [NSMutableArray new];
    
  
    //简体中文
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[草泥马]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7a/shenshou_org.gif"] image:[NSImage imageNamed:@"shenshou_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[神马]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/60/horse2_org.gif"] image:[NSImage imageNamed:@"horse2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[浮云]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/bc/fuyun_org.gif"] image:[NSImage imageNamed:@"fuyun_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[给力]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c9/geili_org.gif"] image:[NSImage imageNamed:@"geili_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[围观]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f2/wg_org.gif"] image:[NSImage imageNamed:@"wg_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[威武]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/vw_org.gif"] image:[NSImage imageNamed:@"vw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[熊猫]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/panda_org.gif"] image:[NSImage imageNamed:@"panda_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[兔子]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/81/rabbit_org.gif"] image:[NSImage imageNamed:@"rabbit_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[奥特曼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/bc/otm_org.gif"] image:[NSImage imageNamed:@"otm_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[囧]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/15/j_org.gif"] image:[NSImage imageNamed:@"j_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[互粉]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/89/hufen_org.gif"] image:[NSImage imageNamed:@"hufen_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[礼物]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c4/liwu_org.gif"] image:[NSImage imageNamed:@"liwu_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[呵呵]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ac/smilea_org.gif"] image:[NSImage imageNamed:@"smilea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[嘻嘻]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0b/tootha_org.gif"] image:[NSImage imageNamed:@"tootha_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[哈哈]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6a/laugh.gif"] image:[NSImage imageNamed:@"laugh.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[可爱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/14/tza_org.gif"] image:[NSImage imageNamed:@"tza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[可怜]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/kl_org.gif"] image:[NSImage imageNamed:@"kl_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[挖鼻屎]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a0/kbsa_org.gif"] image:[NSImage imageNamed:@"kbsa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[吃惊]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f4/cj_org.gif"] image:[NSImage imageNamed:@"cj_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[害羞]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/shamea_org.gif"] image:[NSImage imageNamed:@"shamea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[挤眼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c3/zy_org.gif"] image:[NSImage imageNamed:@"zy_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[闭嘴]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/bz_org.gif"] image:[NSImage imageNamed:@"bz_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[鄙视]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/71/bs2_org.gif"] image:[NSImage imageNamed:@"bs2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[爱你]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/lovea_org.gif"] image:[NSImage imageNamed:@"lovea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[泪]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9d/sada_org.gif"] image:[NSImage imageNamed:@"sada_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[偷笑]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/19/heia_org.gif"] image:[NSImage imageNamed:@"heia_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[亲亲]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8f/qq_org.gif"] image:[NSImage imageNamed:@"qq_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[生病]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b6/sb_org.gif"] image:[NSImage imageNamed:@"sb_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[太开心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/mb_org.gif"] image:[NSImage imageNamed:@"mb_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[懒得理你]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/17/ldln_org.gif"] image:[NSImage imageNamed:@"ldln_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[右哼哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/98/yhh_org.gif"] image:[NSImage imageNamed:@"yhh_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[左哼哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/zhh_org.gif"] image:[NSImage imageNamed:@"zhh_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[嘘]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a6/x_org.gif"] image:[NSImage imageNamed:@"x_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[衰]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/cry.gif"] image:[NSImage imageNamed:@"cry.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[委屈]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/73/wq_org.gif"] image:[NSImage imageNamed:@"wq_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[吐]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9e/t_org.gif"] image:[NSImage imageNamed:@"t_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[打哈欠]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f3/k_org.gif"] image:[NSImage imageNamed:@"k_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[抱抱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/27/bba_org.gif"] image:[NSImage imageNamed:@"bba_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[怒]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7c/angrya_org.gif"] image:[NSImage imageNamed:@"angrya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[疑问]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/5c/yw_org.gif"] image:[NSImage imageNamed:@"yw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[馋嘴]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a5/cza_org.gif"] image:[NSImage imageNamed:@"cza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[拜拜]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/88_org.gif"] image:[NSImage imageNamed:@"88_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[思考]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e9/sk_org.gif"] image:[NSImage imageNamed:@"sk_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[汗]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/24/sweata_org.gif"] image:[NSImage imageNamed:@"sweata_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[困]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7f/sleepya_org.gif"] image:[NSImage imageNamed:@"sleepya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[睡觉]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6b/sleepa_org.gif"] image:[NSImage imageNamed:@"sleepa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[钱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/90/money_org.gif"] image:[NSImage imageNamed:@"money_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[失望]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0c/sw_org.gif"] image:[NSImage imageNamed:@"sw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[酷]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/cool_org.gif"] image:[NSImage imageNamed:@"cool_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[花心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8c/hsa_org.gif"] image:[NSImage imageNamed:@"hsa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/49/hatea_org.gif"] image:[NSImage imageNamed:@"hatea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[鼓掌]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/36/gza_org.gif"] image:[NSImage imageNamed:@"gza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[晕]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/dizzya_org.gif"] image:[NSImage imageNamed:@"dizzya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[悲伤]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1a/bs_org.gif"] image:[NSImage imageNamed:@"bs_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[抓狂]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/62/crazya_org.gif"] image:[NSImage imageNamed:@"crazya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[黑线]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/91/h_org.gif"] image:[NSImage imageNamed:@"h_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[阴险]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/yx_org.gif"] image:[NSImage imageNamed:@"yx_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[怒骂]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/89/nm_org.gif"] image:[NSImage imageNamed:@"nm_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/hearta_org.gif"] image:[NSImage imageNamed:@"hearta_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[伤心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ea/unheart.gif"] image:[NSImage imageNamed:@"unheart.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[猪头]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/pig.gif"] image:[NSImage imageNamed:@"pig.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[ok]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d6/ok_org.gif"] image:[NSImage imageNamed:@"ok_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[耶]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/ye_org.gif"] image:[NSImage imageNamed:@"ye_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[good]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/good_org.gif"] image:[NSImage imageNamed:@"good_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[不要]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c7/no_org.gif"] image:[NSImage imageNamed:@"no_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[赞]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d0/z2_org.gif"] image:[NSImage imageNamed:@"z2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[来]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/come_org.gif"] image:[NSImage imageNamed:@"come_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[弱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/sad_org.gif"] image:[NSImage imageNamed:@"sad_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[蜡烛]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/91/lazu_org.gif"] image:[NSImage imageNamed:@"lazu_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[钟]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d3/clock_org.gif"] image:[NSImage imageNamed:@"clock_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[话筒]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1b/m_org.gif"] image:[NSImage imageNamed:@"m_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[蛋糕]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6a/cake.gif"] image:[NSImage imageNamed:@"cake.gif"] categoryName:@""]];
    
    //繁体中文
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[草泥馬]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7a/shenshou_org.gif"] image:[NSImage imageNamed:@"shenshou_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[神馬]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/60/horse2_org.gif"] image:[NSImage imageNamed:@"horse2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[浮雲]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/bc/fuyun_org.gif"] image:[NSImage imageNamed:@"fuyun_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[給力]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c9/geili_org.gif"] image:[NSImage imageNamed:@"geili_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[圍觀]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f2/wg_org.gif"] image:[NSImage imageNamed:@"wg_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[威武]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/vw_org.gif"] image:[NSImage imageNamed:@"vw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[熊貓]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/panda_org.gif"] image:[NSImage imageNamed:@"panda_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[兔子]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/81/rabbit_org.gif"] image:[NSImage imageNamed:@"rabbit_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[奧特曼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/bc/otm_org.gif"] image:[NSImage imageNamed:@"otm_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[囧]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/15/j_org.gif"] image:[NSImage imageNamed:@"j_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[互粉]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/89/hufen_org.gif"] image:[NSImage imageNamed:@"hufen_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[禮物]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c4/liwu_org.gif"] image:[NSImage imageNamed:@"liwu_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[呵呵]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ac/smilea_org.gif"] image:[NSImage imageNamed:@"smilea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[嘻嘻]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0b/tootha_org.gif"] image:[NSImage imageNamed:@"tootha_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[哈哈]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6a/laugh.gif"] image:[NSImage imageNamed:@"laugh.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[可愛]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/14/tza_org.gif"] image:[NSImage imageNamed:@"tza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[可憐]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/kl_org.gif"] image:[NSImage imageNamed:@"kl_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[挖鼻屎]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a0/kbsa_org.gif"] image:[NSImage imageNamed:@"kbsa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[吃驚]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f4/cj_org.gif"] image:[NSImage imageNamed:@"cj_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[害羞]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/shamea_org.gif"] image:[NSImage imageNamed:@"shamea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[擠眼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c3/zy_org.gif"] image:[NSImage imageNamed:@"zy_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[閉嘴]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/bz_org.gif"] image:[NSImage imageNamed:@"bz_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[鄙視]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/71/bs2_org.gif"] image:[NSImage imageNamed:@"bs2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[愛你]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/lovea_org.gif"] image:[NSImage imageNamed:@"lovea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[淚]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9d/sada_org.gif"] image:[NSImage imageNamed:@"sada_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[偷笑]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/19/heia_org.gif"] image:[NSImage imageNamed:@"heia_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[親親]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8f/qq_org.gif"] image:[NSImage imageNamed:@"qq_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[生病]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b6/sb_org.gif"] image:[NSImage imageNamed:@"sb_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[太開心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/mb_org.gif"] image:[NSImage imageNamed:@"mb_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[懶得理你]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/17/ldln_org.gif"] image:[NSImage imageNamed:@"ldln_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[右哼哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/98/yhh_org.gif"] image:[NSImage imageNamed:@"yhh_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[左哼哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/zhh_org.gif"] image:[NSImage imageNamed:@"zhh_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[噓]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a6/x_org.gif"] image:[NSImage imageNamed:@"x_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[衰]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/af/cry.gif"] image:[NSImage imageNamed:@"cry.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[委屈]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/73/wq_org.gif"] image:[NSImage imageNamed:@"wq_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[吐]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9e/t_org.gif"] image:[NSImage imageNamed:@"t_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[打哈欠]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/f3/k_org.gif"] image:[NSImage imageNamed:@"k_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[抱抱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/27/bba_org.gif"] image:[NSImage imageNamed:@"bba_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[怒]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7c/angrya_org.gif"] image:[NSImage imageNamed:@"angrya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[疑問]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/5c/yw_org.gif"] image:[NSImage imageNamed:@"yw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[饞嘴]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a5/cza_org.gif"] image:[NSImage imageNamed:@"cza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[拜拜]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/70/88_org.gif"] image:[NSImage imageNamed:@"88_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[思考]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e9/sk_org.gif"] image:[NSImage imageNamed:@"sk_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[汗]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/24/sweata_org.gif"] image:[NSImage imageNamed:@"sweata_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[困]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7f/sleepya_org.gif"] image:[NSImage imageNamed:@"sleepya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[睡覺]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6b/sleepa_org.gif"] image:[NSImage imageNamed:@"sleepa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[錢]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/90/money_org.gif"] image:[NSImage imageNamed:@"money_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[失望]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/0c/sw_org.gif"] image:[NSImage imageNamed:@"sw_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[酷]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/cool_org.gif"] image:[NSImage imageNamed:@"cool_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[花心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8c/hsa_org.gif"] image:[NSImage imageNamed:@"hsa_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[哼]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/49/hatea_org.gif"] image:[NSImage imageNamed:@"hatea_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[鼓掌]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/36/gza_org.gif"] image:[NSImage imageNamed:@"gza_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[暈]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/dizzya_org.gif"] image:[NSImage imageNamed:@"dizzya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[悲傷]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1a/bs_org.gif"] image:[NSImage imageNamed:@"bs_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[抓狂]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/62/crazya_org.gif"] image:[NSImage imageNamed:@"crazya_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[黑線]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/91/h_org.gif"] image:[NSImage imageNamed:@"h_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[陰險]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6d/yx_org.gif"] image:[NSImage imageNamed:@"yx_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[怒駡]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/89/nm_org.gif"] image:[NSImage imageNamed:@"nm_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/hearta_org.gif"] image:[NSImage imageNamed:@"hearta_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[傷心]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ea/unheart.gif"] image:[NSImage imageNamed:@"unheart.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[豬頭]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/58/pig.gif"] image:[NSImage imageNamed:@"pig.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[ok]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d6/ok_org.gif"] image:[NSImage imageNamed:@"ok_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[耶]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d9/ye_org.gif"] image:[NSImage imageNamed:@"ye_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[good]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/good_org.gif"] image:[NSImage imageNamed:@"good_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[不要]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c7/no_org.gif"] image:[NSImage imageNamed:@"no_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[贊]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d0/z2_org.gif"] image:[NSImage imageNamed:@"z2_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[來]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/come_org.gif"] image:[NSImage imageNamed:@"come_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[弱]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d8/sad_org.gif"] image:[NSImage imageNamed:@"sad_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[蠟燭]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/91/lazu_org.gif"] image:[NSImage imageNamed:@"lazu_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[鐘]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/d3/clock_org.gif"] image:[NSImage imageNamed:@"clock_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[話筒]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1b/m_org.gif"] image:[NSImage imageNamed:@"m_org.gif"] categoryName:@""]];
    [emotions addObject:[[AKEmotion alloc]initWithCode:@"[蛋糕]" URL:[NSURL URLWithString:@"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6a/cake.gif"] image:[NSImage imageNamed:@"cake.gif"] categoryName:@""]];


    
    return emotions;
    

}

+(NSDictionary *)allEmotionsByCategory{
    
    static NSMutableDictionary *emotionCategory;
    if(emotionCategory){
        return emotionCategory;
    }
    
    emotionCategory = [NSMutableDictionary new];
    NSArray *emotions = [AKEmotion allEmotions];
    
    for(AKEmotion *emotion in emotions){
        if(![emotionCategory.allKeys containsObject:emotion.categoryName]){
            [emotionCategory setObject:[NSMutableArray new] forKey:emotion.categoryName];
        }
        [(NSMutableArray *)[emotionCategory objectForKey:emotion.categoryName] addObject:emotion];
    
    }
    
    return emotionCategory;
    

}

+(NSDictionary *)emotionDictionary{
    
    static NSMutableDictionary * emotionDictionary;
    if(emotionDictionary){
        return emotionDictionary;
    }
    
    emotionDictionary = [NSMutableDictionary new];
    NSArray *emotions = [AKEmotion allEmotions];
    for(AKEmotion *emotion in emotions){
    
        [emotionDictionary setObject:emotion forKey:emotion.code];
    }
    
    return emotionDictionary;

}

@end