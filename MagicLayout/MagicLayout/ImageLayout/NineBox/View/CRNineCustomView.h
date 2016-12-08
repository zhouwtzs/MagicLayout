//
//  CRNineCustomView.h
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRPhotoModel.h"

/*
 手势拖动时，创建的临时view
 继承scrollView是为了保证图片不会显示imageview之外的部分
 由于同时用于单色图片和照片，使用时需要判断，优先判断color是否为nil
 */

@interface CRNineCustomView : UIScrollView

@property (nonatomic, strong) UIImageView * infoImageView;      //展示

@property (nonatomic, strong) CRPhotoModel * photoInfo;         //存储图片信息

@property (nonatomic, strong) UIColor * color;                  //存储单色图片


@end
