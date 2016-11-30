//
//  CRSceneModel.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 @brief 应用场景选择
 */

@interface CRSceneModel : NSObject

@property (nonatomic, strong) UIImage * image;          //场景图片

@property (nonatomic, copy) NSString * sceneName;       //场景名称

@property (nonatomic, strong) UIColor * color;          //颜色


- (instancetype)initWithSceneImage:(UIImage *)image sceneName:(NSString *)name sceneColor:(UIColor *)color;
/*
 得到包含对象的数组
 */
+ (NSArray *)getSceneArray;

/*
  开放名称数组
 */
+ (NSArray *)getAllSceneNameArray;
/*
 开放颜色数组
 */
+ (NSArray *)getColorArray;


@end
