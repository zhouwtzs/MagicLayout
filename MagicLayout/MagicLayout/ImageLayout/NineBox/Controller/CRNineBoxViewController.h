//
//  CRNineBoxViewController.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRPhotoCollectionViewController.h"
#import "CRNineBoxSegmentControl.h"
#import "CRNineBoxView.h"
#import "CRDynamicShareManager.h"

/*
 @brief 九宫格视图控制器
 */

@interface CRNineBoxViewController : UIViewController

//九宫格view
@property (nonatomic, strong) CRNineBoxView * nineBoxView;

//照片选择器
@property (nonatomic, strong) CRPhotoCollectionViewController * photoCollect;

//单色图片选择器
@property (nonatomic, strong) CRNineBoxSegmentControl * segment;

//渐变色选择器(未开放)
//清空按钮(未实现)

//发布按钮
@property (nonatomic, strong) UIBarButtonItem * rightBarButton;

@property (nonatomic, strong) CRDynamicShareManager * shareManager;

@end
