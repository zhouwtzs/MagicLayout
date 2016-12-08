//
//  UIImageView+AssetPhoto.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/3.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (AssetPhoto)

- (void)CR_setImageWithAsset:(PHAsset *)asset placeholderImage:(UIImage * __nullable)placeholder completed:(void (^__nullable)(UIImage * image,NSDictionary *__nullable info))completion;

@end

NS_ASSUME_NONNULL_END
