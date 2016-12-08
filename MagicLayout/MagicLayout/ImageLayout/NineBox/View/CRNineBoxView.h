//
//  CRNineBoxView.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRPhotoModel.h"

/*
 @brief 九宫格
 */
@interface CRNineBoxView : UIView

@property (nonatomic, weak) UIImageView * resultImageView;              //当前展示选中的九宫格的subbox

@property (nonatomic, strong) NSMutableDictionary * photoModelDic;

@property (nonatomic, strong) NSMutableDictionary * thumbImageDic;

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

@end
