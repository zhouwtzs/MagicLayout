 //
//  CRPhotoCollectionViewController.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class CRPhotoCollectionViewCell,CRPhotoModel;
@protocol CRPhotoCollectionViewGestureDelegate <NSObject>

- (void)CRPhotoCollectionViewCell:(CRPhotoCollectionViewCell *)collectionViewCell panGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRPhotoModel *)photoModel;

- (void)CRPhotoCollectionViewCell:(CRPhotoCollectionViewCell *)collectionViewCell longPressGestureRecognizer:(UILongPressGestureRecognizer *)pan photoModel:(CRPhotoModel *)photoModel;

@end

/*
 @brief 照片选择器
 */
@interface CRPhotoCollectionViewController : NSObject<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView * photoCollectionView;

@property (nonatomic, strong) NSMutableArray<CRPhotoModel *> * photoAssets;

@property (nonatomic, weak)id<CRPhotoCollectionViewGestureDelegate> delegate;

@property (nonatomic, strong) UIPanGestureRecognizer * pan;

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

@property (nonatomic, weak, readonly) CRPhotoCollectionViewCell * gestureCell;   //当前手势操作的cell

@property (nonatomic, weak, readonly) CRPhotoModel * cellPhotoModel;             //对应的CRPhotoModel


@end
