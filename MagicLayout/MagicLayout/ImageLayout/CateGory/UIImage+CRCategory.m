//
//  UIImage+CRCategory.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/28.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "UIImage+CRCategory.h"

#define VIEW_W(v) (v.bounds.size.width)
#define VIEW_H(v) (v.bounds.size.height)


@implementation UIImage (CreateWithColor)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    return [UIImage createImageWithColor:color size:CGSizeMake(150.0f, 150.0f)];
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
    CGFloat finalWidth = imageFrame.size.width;         //最终的宽度
    CGFloat finalHeignt = imageFrame.size.width;        //最终的高度
    if (editImage == nil) {
        return nil;
    }
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

+ (UIImage *)shearCenterImage:(UIImageView *)imageView{
    
    float side = MIN(VIEW_H(imageView), VIEW_W(imageView));
    
    CGRect centerRect = CGRectMake((VIEW_W(imageView)-side)*0.5, (VIEW_H(imageView)-side)*0.5, side, side);
    
    return [UIImage shearViewImage:imageView withFrame:centerRect];
}

+ (UIImage *)shearViewImage:(UIImageView *)imageView withFrame:(CGRect)frame
{
    if (!imageView.image || !imageView.image) {
        return nil;
    }
    //图片与图片视图的比例
    //NSLog(@"%lf,%lf",imageView.image.size.width,imageView.image.size.height);
    float scale =  imageView.image.size.width/imageView.bounds.size.width;
    
    CGRect shearRect = CGRectMake(frame.origin.x * scale * imageView.transform.a ,
                                  frame.origin.y * scale * imageView.transform.d,
                                  frame.size.width * scale * imageView.transform.a,
                                  frame.size.height * scale * imageView.transform.d);
    
    return [UIImage shearImage:imageView.image withFrame:shearRect];
}

@end


@implementation UIImage (ImageCache)

+ (void)CR_cacheImageWithAsset:(PHAsset *)asset completed:(void (^__nullable)(UIImage * _Nullable image, NSDictionary *__nullable info))completion{
    
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
    
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(SCREENWIDTH, SCREENHEIGHT) contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (completion) {
            completion(result, info);
        }
    }];
}

@end

