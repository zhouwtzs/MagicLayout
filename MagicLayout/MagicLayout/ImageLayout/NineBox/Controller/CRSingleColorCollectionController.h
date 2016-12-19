//
//  CRSingleColorCollectionController.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class CRSingColorCollectionViewCell,CRSingleColorModel;
@protocol CRSingColorCollectionViewGestureDelegate <NSObject>

- (void)CRSingColorCollectionViewCell:(CRSingColorCollectionViewCell *)collectionViewCell panGestureRecognizer:(UIPanGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel;

- (void)CRSingColorCollectionViewCell:(CRSingColorCollectionViewCell *)collectionViewCell longPressGestureRecognizer:(UILongPressGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel;

@end

/*
 @brief 单色图片选择器
 */
@interface CRSingleColorCollectionController : NSObject<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView * singleColorCollectionView;

@property (nonatomic, strong) NSMutableArray<CRSingleColorModel *> * colorsArray;

@property (nonatomic, weak) id<CRSingColorCollectionViewGestureDelegate>delegate;

@property (nonatomic, weak, readonly) CRSingColorCollectionViewCell * gestureCell;

@property (nonatomic, weak, readonly) CRSingleColorModel * cellColorModel;

@end
