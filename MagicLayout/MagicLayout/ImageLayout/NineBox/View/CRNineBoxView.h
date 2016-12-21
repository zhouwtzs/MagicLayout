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

#pragma mark - 从外部选中到九宫格
@property (nonatomic, weak) UIImageView * resultImageView;              //当前展示选中的九宫格的subbox

 //用来存储九宫格中颜色／图片信息，初始状态存储CRSingleColorModel 基础，白色
@property (nonatomic, strong, readonly) NSMutableArray * infoArray;

 //用来存储九宫格中的图片信息，初始值为白色单像素图片
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

- (UIImageView *)subImageWithIndex:(NSInteger)index;

- (NSInteger)indexOfSubimage:(UIImageView *)subImageView;

- (void)exchangeInfoAtIndex:(NSInteger)index1 withInfoAtIndex:(NSInteger)index2;

- (void)reloadInfoAtIndex:(NSArray *)indexs;

#pragma mark - 内部拖动

//内部拖动的customView
@property (nonatomic, strong) UIImageView * customView;

//拖动手势，拖动内部的view 进行位置变换
@property (nonatomic, strong) UIPanGestureRecognizer * panGes;

//拖动手势替换用的临时view
@property (nonatomic, strong) UIImageView * selectedView;

//长按显示详细信息
@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

//单击，双击事件
@property (nonatomic, strong) UITapGestureRecognizer * tap;

@end
