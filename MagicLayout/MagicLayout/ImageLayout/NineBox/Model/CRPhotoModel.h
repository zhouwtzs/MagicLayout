//
//  CRPhotoModel.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/*
 @brief 照片选择器的数据类型
 */
@interface CRPhotoModel : NSObject

@property (nonatomic, strong) UIImage * originalImage;      //预览图

@property (nonatomic, strong) UIImage * fitImage;           //合适的图，拖动时的尺寸

@property (nonatomic, strong) PHAsset * phasset;            //资源对象



+ (BOOL)canLibrary;

/**
 得到相册内的所有图片资源

 @param ascending 排列顺序，是否升序排列

 @return 相册数组
 */
+ (NSArray<PHAsset *> *)getAllAssetInPhotoAlbumWithAsceding:(BOOL)ascending;

@end
