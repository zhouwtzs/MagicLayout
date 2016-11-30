//
//  UIImage+CreateWithColor.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateWithColor)

/**
 创建一个单色图片
 @param color 图片颜色
 @return image
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 创建一个单色图片
 @param color color
 @param size  size
 @return image
 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 压缩图片
 @param imgSrc 原始图片
 @param rect   rect
 @return 返回腿片
 */
+ (UIImage *)compressImage:(UIImage *)imgSrc withRect:(CGRect)rect;


/**
 裁剪图片
 @param editImage  原始图片
 @param imageFrame frame
 @return 处理完成的图片
 */
+ (UIImage *)shearImage:(UIImage * )editImage withFrame:(CGRect)imageFrame;


@end
