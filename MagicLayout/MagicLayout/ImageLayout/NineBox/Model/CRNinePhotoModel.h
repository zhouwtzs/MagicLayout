//
//  CRNinePhotoModel.h
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 存储图片信息
 */
@interface CRNinePhotoModel : NSObject

@property (nonatomic, strong) UIImage * thumbImage;         //缩略图

@property (nonatomic, strong) UIImage * fitImage;           //合适的图

@property (nonatomic, strong) UIImage * originalImage;      //原图

@end
