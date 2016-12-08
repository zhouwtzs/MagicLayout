//
//  CRSceneModel.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSceneModel.h"
#import "UIImage+CRCategory.h"

@implementation CRSceneModel

- (instancetype)initWithSceneImage:(UIImage *)image sceneName:(NSString *)name sceneColor:(UIColor *)color{
    
    self = [super init];
    
    if (self) {
        
        self.image = image;
        
        self.sceneName = name;
        
        self.color = color;
    }
    return self;
}

+ (NSArray *)getSceneArray{
    
    NSMutableArray * resultArray = [[NSMutableArray alloc]init];
    
    NSArray * nameArray = [CRSceneModel getAllSceneNameArray];
    
    NSArray * colorArray = [CRSceneModel getColorArray];
    
    for (int i = 0; i < 48; i++) {
        
        int line = i/12+1;
        
        int list= i%12+1;
        
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.%d",line,list]];
        
        CRSceneModel * model = [[CRSceneModel alloc]initWithSceneImage:image sceneName:[nameArray objectAtIndex:i] sceneColor:[colorArray objectAtIndex:i]];
    
        [resultArray addObject:model];
    }
    return resultArray;
}


+ (NSArray *)getAllSceneNameArray{
    
//    return @[@"Licorice(甘草)",@"Lead(石墨)",@"Tungsten(钨)",@"Iron(铁)",@"Steel(钢)",@"Tin(锡)",@"Nickel(镍)",@"Aluminum(铝)",@"Magnesium(镁)",@"Silver(银)",@"Mercury(水银)",@"Snow(雪)",@"Cayenne(辣椒)",@"Mocha(摩卡)",@"Asparagus(莴笋)",@"Fern(蕨叶)",@"Clover(苜蓿)",@"Moss(苔藓)",@"Teal(水鸭蓝)",@"Ocean(海洋)",@"Midnight(午夜)",@"Eggplant(茄子)",@"Plum(紫红)",@"Marnoon(栗色)",@"Maraschino(樱桃)",@"Tangerine(橘子)",@"Lemon(柠檬)",@"Lime(酸橙)",@"Spring(萌芽)",@"Sea Foam(海泡石)",@"Turquoise(绿松石)",@"Aqua(蓝宝石)",@"Blueberry(蓝莓)",@"Grape(葡萄)",@"Magenta(品红)",@"Strawberry(草莓)",@"Salmon(鲑鱼)",@"Cantaloupe(哈密瓜)",@"Banana(香蕉)",@"Honeydew(甜瓜)",@"Flora(植物)",@"Spindrift(浪花)",@"Ice(蓝冰)",@"Sky(天空)",@"Crchid(兰花)",@"Lavender(薰衣草)",@"Bubblegum(泡泡糖)",@"Carnation(康乃馨)"];
    return @[
             @"Licorice#甘草",@"Lead#石墨",@"Tungsten#钨",@"Iron#铁",@"Steel#钢",@"Tin#锡",@"Nickel#镍",@"Aluminum#铝",@"Magnesium#镁",@"Silver#银",@"Mercury#水银",@"Snow#雪",
             @"Cayenne#辣椒",@"Mocha#摩卡",@"Asparagus#莴笋",@"Fern#蕨叶",@"Clover#苜蓿",@"Moss#苔藓",@"Teal#水鸭蓝",@"Ocean#海洋",@"Midnight#午夜",@"Eggplant#茄子",@"Plum#紫红",@"Marnoon#栗色",
             @"Maraschino#樱桃",@"Tangerine#橘子",@"Lemon#柠檬",@"Lime#酸橙",@"Spring#萌芽",@"Sea Foam#海泡石",@"Turquoise#绿松石",@"Aqua#蓝宝石",@"Blueberry#蓝莓",@"Grape#葡萄",@"Magenta#品红",@"Strawberry#草莓",
             @"Salmon#鲑鱼",@"Cantaloupe#哈密瓜",@"Banana#香蕉",@"Honeydew#甜瓜",@"Flora#植物",@"Spindrift#浪花",@"Ice#蓝冰",@"Sky#天空",@"Crchid#兰花",@"Lavender#薰衣草",@"Bubblegum#泡泡糖",@"Carnation#康乃馨"];
    
}

+ (NSArray *)getColorArray{
    
    return @[
             RGBCOLOR(0, 0, 0),RGBCOLOR(33, 33, 33),RGBCOLOR(66, 66, 66),RGBCOLOR(95, 94, 94),RGBCOLOR(121, 121, 121),RGBCOLOR(145, 145, 145),RGBCOLOR(146, 146, 146),RGBCOLOR(169, 169, 169),RGBCOLOR(192, 192, 192),RGBCOLOR(214, 214, 214),RGBCOLOR(235, 235, 235),RGBCOLOR(255, 255, 255),
             RGBCOLOR(148, 17, 0),RGBCOLOR(147, 82, 0),RGBCOLOR(146, 145, 0),RGBCOLOR(79, 144, 0),RGBCOLOR(36, 143, 0),RGBCOLOR(39, 143, 81),RGBCOLOR(46, 145, 146),RGBCOLOR(33, 83, 146),RGBCOLOR(26, 25, 146),RGBCOLOR(83, 27, 147),RGBCOLOR(148, 33, 147),RGBCOLOR(148, 23, 81),
             RGBCOLOR(244, 28, 0),RGBCOLOR(246, 147, 0),RGBCOLOR(251, 251, 0),RGBCOLOR(142, 250, 0),RGBCOLOR(70, 249, 0),RGBCOLOR(75, 250, 147),RGBCOLOR(87, 253, 255),RGBCOLOR(65, 251, 255),RGBCOLOR(52, 50, 255),RGBCOLOR(149, 55, 255),RGBCOLOR(248, 64, 255),RGBCOLOR(245, 48, 147),
             RGBCOLOR(246, 126, 121),RGBCOLOR(249, 212, 121),RGBCOLOR(252, 252, 120),RGBCOLOR(213, 252, 121),RGBCOLOR(115, 250, 121),RGBCOLOR(115, 252, 214),RGBCOLOR(115, 253, 255),RGBCOLOR(118, 214, 255),RGBCOLOR(122, 128, 255),RGBCOLOR(215, 131, 255),RGBCOLOR(249, 133, 255),RGBCOLOR(248, 128, 216)];
}

@end
