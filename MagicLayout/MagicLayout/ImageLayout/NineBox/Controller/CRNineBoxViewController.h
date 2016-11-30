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

/*
 @brief 九宫格视图控制器
 */

@interface CRNineBoxViewController : UIViewController

@property (nonatomic, strong) CRNineBoxView * nineBoxView;

@property (nonatomic, strong) CRPhotoCollectionViewController * photoCollect;

@property (nonatomic, strong) CRNineBoxSegmentControl * segment;


@end
