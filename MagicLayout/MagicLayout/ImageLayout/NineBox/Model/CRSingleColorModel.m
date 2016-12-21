//
//  CRSingleColorModel.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSingleColorModel.h"

#define SINGLECOLOR(color,name) ([[CRSingleColorModel alloc]initWithColor:COLOR(color) colorName:name])

@implementation CRSingleColorModel

- (instancetype)initWithColor:(UIColor *)color colorName:(NSString *)name{
    
    self = [super init];
    
    if (self) {
        
        self.color = color;
        
        self.colorName = name;
    }
    return self;
}

+ (instancetype)defaultColorModel{
    
    return SINGLECOLOR(whiteColor, @"白色");
}

+ (NSArray<CRSingleColorModel *> *)getSingleColorArray{
    
    return @[SINGLECOLOR(blackColor,@"黑色"),
             SINGLECOLOR(darkGrayColor, @"深灰色"),
             SINGLECOLOR(lightGrayColor, @"浅灰色"),
             SINGLECOLOR(whiteColor, @"白色"),
             SINGLECOLOR(grayColor, @"灰色"),
             SINGLECOLOR(redColor, @"红色"),
             SINGLECOLOR(greenColor, @"绿色"),
             SINGLECOLOR(blueColor, @"蓝色"),
             SINGLECOLOR(cyanColor, @"青色"),
             SINGLECOLOR(yellowColor, @"黄色"),
             SINGLECOLOR(magentaColor, @"品红色"),
             SINGLECOLOR(orangeColor, @"橙色"),
             SINGLECOLOR(purpleColor, @"紫色"),
             SINGLECOLOR(brownColor, @"棕色"),
             SINGLECOLOR(clearColor, @"透明"),
             ];
}

@end
