//
//  CRNineBoxSegmentControl.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRSingleColorCollectionController.h"
#import "CRSceneView.h"
#import "CRValueForPicterView.h"
/*
 @brief 九宫格定制segment control
 建议在初次创建的时候就对frame进行初始化，如果需要在后期改变view的size，建议通过setBounds进行更改，setFrame可能会无效
 */
@interface CRNineBoxSegmentControl : UIView

@property (nonatomic, strong) UIButton * singleColorBtn;

@property (nonatomic, strong) UIButton * sceneBtn;

@property (nonatomic, strong) UIButton * valueBtn;


@property (nonatomic, strong) CRSingleColorCollectionController * singleColor;

@property (nonatomic, strong) CRSceneView * scene;

@property (nonatomic, strong) CRValueForPicterView * valuePicter;

@end
