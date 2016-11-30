//
//  CRSingleColorModel.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*
 @brief 单色图片选择
 */
@interface CRSingleColorModel : NSObject

@property(nonatomic, copy) NSString * colorName;            //颜色名称

@property(nonatomic, strong) UIColor * color;               //颜色对象

- (instancetype)initWithColor:(UIColor *)color colorName:(NSString *)name;

/*
 得到包含单色图片对象的数组
 */
+ (NSArray *)getSingleColorArray;

@end
