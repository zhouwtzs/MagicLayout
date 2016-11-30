//
//  CRValueForPicterView.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/21.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 @brief 根据颜色的值来得到一张单色图片
 */
@class CRSubValueView;
@interface CRValueForPicterView : UIView

@property (nonatomic, assign) BOOL showing;                 //正在展示

@property (nonatomic, strong) UIView * showColorView;       //展示

@property (nonatomic, strong) CRSubValueView * redSubVlaueView;

@property (nonatomic, strong) CRSubValueView * greenSubVlaueView;

@property (nonatomic, strong) CRSubValueView * blueSubVlaueView;

@property (nonatomic, strong) UIView * editView;            //编辑

@property (nonatomic, weak) UITextField * firstResponderText;

@end

