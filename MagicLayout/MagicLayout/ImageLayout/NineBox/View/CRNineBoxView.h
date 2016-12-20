//
//  CRNineBoxView.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRPhotoModel.h"
#import "CRSingleColorModel.h"

/*
 @brief 九宫格
 */
@interface CRNineBoxView : UIView

@property (nonatomic, weak) UIImageView * resultImageView;              //当前展示选中的九宫格的subbox

/*
 用来存储九宫格中颜色／图片信息，初始状态存储CRSingleColorModel 基础，白色
 */
@property (nonatomic, strong, readonly) NSMutableArray * infoArray;

/*
 用来存储九宫格中的图片信息，初始值为白色单像素图片
 */
@property (nonatomic, strong, readonly) NSMutableArray * thumbImageArray;

/**
 返回当前的point九宫格的第几个subview
 @param point 制定的坐标
 @return 0-8
 */
- (NSInteger)indexOfSubBoxWithPoint:(CGPoint)point;

/**
 返回point所在的subview
 @param point 制定的坐标
 @return subview
 */
- (UIImageView *)subViewInNineBoxWithPoint:(CGPoint)point;

/**
 返回当前选中的subview是第几个
 @return index
 */
- (NSInteger)indexOfResultImageView;


/*
 设置展示view的图片
 */
- (void)setPhotoInfo:(CRPhotoModel *)photoInfo thumdImage:(UIImage *)thumbImage ForIndex:(NSInteger)index;

/*
 设置展示view的颜色
 */
- (void)setColorInfo:(CRSingleColorModel *)colorModel ForIndex:(NSInteger)index;


@end
