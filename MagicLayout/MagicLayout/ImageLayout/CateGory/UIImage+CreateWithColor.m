//
//  UIImage+CreateWithColor.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "UIImage+CreateWithColor.h"

@implementation UIImage (CreateWithColor)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    return [UIImage createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)lalallllll{

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(41.5, 23.5)];
    [bezierPath addLineToPoint: CGPointMake(55.5, 13.5)];
    [bezierPath addLineToPoint: CGPointMake(69.5, 20.5)];
    [bezierPath addLineToPoint: CGPointMake(71.5, 51.5)];
    [bezierPath addLineToPoint: CGPointMake(45.5, 52.5)];
    [bezierPath addLineToPoint: CGPointMake(41.5, 23.5)];
    [bezierPath closePath];
    [[UIColor grayColor] setFill];
    [bezierPath fill];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
}

+ (UIImage *)compressImage:(UIImage *)imgSrc withRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    //CGRect rect = rect;
    [imgSrc drawInRect:rect];
    
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return compressedImg;
}

+ (UIImage *)shearImage:(UIImage * )editImage withFrame:(CGRect)imageFrame
{
    CGFloat finalWidth;         //最终的宽度
    CGFloat finalHeignt;        //最终的高度
    CGRect finalRect = imageFrame;
    CGImageRef imageRef = editImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, finalRect);
    UIGraphicsBeginImageContext(CGSizeMake(finalWidth, finalHeignt));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, finalRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

@end
