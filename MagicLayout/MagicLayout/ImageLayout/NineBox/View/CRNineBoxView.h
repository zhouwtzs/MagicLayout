//
//  CRNineBoxView.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 @brief 九宫格
 */
@interface CRNineBoxView : UIView


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


@end
