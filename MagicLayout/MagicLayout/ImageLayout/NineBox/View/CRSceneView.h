//
//  CRSceneView.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRSceneCollectionViewController.h"

@interface CRSceneView : UIView<CRSceneCollectionViewControllerDelegate>

@property (nonatomic, strong) CRSceneCollectionViewController * scene;

@property (nonatomic, strong) UIView * colorShowView;       //展示颜色

@property (nonatomic, strong) UILabel * sceneNameLabelEN;   //场景名称  english

@property (nonatomic, strong) UILabel * sceneNameLabelCN;   //场景名称  中文

@property (nonatomic, strong) UILabel * colorVlaueLabel;    //颜色数值

@property (nonatomic, strong) NSMutableArray * photos;      //被上帝选中的孩子

@end
