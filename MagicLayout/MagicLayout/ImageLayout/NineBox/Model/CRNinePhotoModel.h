//
//  CRNinePhotoModel.h
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/*
 存储图片信息
 */
@interface CRNinePhotoModel : NSObject

@property (nonatomic, strong) UIImage * thumbImage;         //缩略图,显示在九宫格之上

@property (nonatomic, strong) UIImage * fitImage;           //合适的图，拖动时的尺寸

@property (nonatomic, strong) UIImage * originalImage;      //预览图，大图

@end
