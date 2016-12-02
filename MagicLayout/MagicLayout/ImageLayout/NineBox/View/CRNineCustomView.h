//
//  CRNineCustomView.h
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRNinePhotoModel.h"

@interface CRNineCustomView : UIScrollView

@property (nonatomic, strong) UIImageView * infoImageView;      //展示

@property (nonatomic, strong) CRNinePhotoModel * photoInfo;     //存储图片信息


- (void)setFitImage:(UIImage *)image;

@end
