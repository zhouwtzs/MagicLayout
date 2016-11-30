//
//  UIImageView+AssetPhoto.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/3.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "UIImageView+AssetPhoto.h"

@implementation UIImageView (AssetPhoto)

- (void)CR_setImageWithAsset:(PHAsset *)asset placeholderImage:(UIImage * __nullable)placeholder completed:(void (^__nullable)(NSDictionary *__nullable info))completion{
    
    typeof(self) __weak weakSelf = self;
    
    //1.先加载缓冲图
    if (placeholder) {
        
        self.image = placeholder;
    }
    
    //2.得到asset对应的图片
    CGSize size = self.bounds.size;
    
    size.width  *= 2.0f;
    size.height *= 2.0f;
    
    //请求大图界面，当切换图片时，取消上一张图片的请求，对于iCloud端的图片，可以节省流量
    static PHImageRequestID requestID = -1;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN(SCREENWIDTH, 500);
    if (requestID >= 1 && size.width/width==scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;//控制照片尺寸
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    option.networkAccessAllowed = NO;
    
    /*
     info字典提供请求状态信息:
     PHImageResultIsInCloudKey：图像是否必须从iCloud请求
     PHImageResultIsDegradedKey：当前UIImage是否是低质量的，这个可以实现给用户先显示一个预览图
     PHImageResultRequestIDKey和PHImageCancelledKey：请求ID以及请求是否已经被取消
     PHImageErrorKey：如果没有图像，字典内的错误信息
     */

    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey];
        //不要该判断，即如果该图片在iCloud上时候，会先显示一张模糊的预览图，待加载完毕后会显示高清图
        // && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue]
        if (downloadFinined && completion) {
            completion(info);
        }
        if (image) {
            
            weakSelf.image = image;
        }
    }];
}

@end
