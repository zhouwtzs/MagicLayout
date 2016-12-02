//
//  UIImage+CRCategory.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "UIImage+CRCategory.h"

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

@end

@implementation UIImage (ShapeChange)

+ (UIImage *)compressImage:(UIImage *)imgSrc withScale:(CGFloat)scale{
    
    CGSize size = CGSizeMake(imgSrc.size.width*scale, imgSrc.size.height*scale);
    
    UIGraphicsBeginImageContext(size);
    //CGRect rect = rect;
    [imgSrc drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return compressedImg;
}

+ (UIImage *)shearImage:(UIImage * )editImage withFrame:(CGRect)imageFrame
{
    CGImageRef imageRef = editImage.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, imageFrame);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    return smallImage;
}

@end


@implementation UIImage (ImageCache)

- (void)CR_cacheImageWithAsset:(PHAsset *)asset completed:(void (^__nullable)(NSDictionary *__nullable info))completion{
    
    typeof(self) __weak weakSelf = self;
    
    //请求大图界面，当切换图片时，取消上一张图片的请求，对于iCloud端的图片，可以节省流量
    static PHImageRequestID requestID = -1;
    if (requestID >= 1) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    //option.resizeMode = PHImageRequestOptionsResizeModeFast;//控制照片尺寸
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//控制照片质量
    option.networkAccessAllowed = NO;
    
    /*
     info字典提供请求状态信息:
     PHImageResultIsInCloudKey：图像是否必须从iCloud请求
     PHImageResultIsDegradedKey：当前UIImage是否是低质量的，这个可以实现给用户先显示一个预览图
     PHImageResultRequestIDKey和PHImageCancelledKey：请求ID以及请求是否已经被取消
     PHImageErrorKey：如果没有图像，字典内的错误信息
     */
    
    requestID = [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        weakSelf = 
        
    }];
}

@end

