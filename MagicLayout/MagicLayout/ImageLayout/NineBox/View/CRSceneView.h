//
//  CRSceneView.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRSceneCollectionViewController.h"

@class CRSceneModel;
@protocol CRScentViewDelegate <NSObject>

- (void)CRSceneViewColorShowView:(UIView *)colorView panGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRSceneModel *)sceneModel;

- (void)CRSceneViewColorShowView:(UIView *)colorView longPressGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRSceneModel *)sceneModel;

@end

/*
 场景颜色，不同颜色对应不同场景
 */
@interface CRSceneView : UIView<CRSceneCollectionViewControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) CRSceneCollectionViewController * scene;

@property (nonatomic, strong) UIView * colorShowView;       //展示颜色

@property (nonatomic, strong) UILabel * sceneNameLabelEN;   //场景名称  english

@property (nonatomic, strong) UILabel * sceneNameLabelCN;   //场景名称  中文

@property (nonatomic, strong) UILabel * colorVlaueLabel;    //颜色数值

//@property (nonatomic, strong) NSMutableArray * photos;      //被上帝选中的孩子

@property (nonatomic, weak) CRSceneModel * sceneModel;      //被选招的孩子

@property (nonatomic, weak)id<CRScentViewDelegate> delegate;

@end
