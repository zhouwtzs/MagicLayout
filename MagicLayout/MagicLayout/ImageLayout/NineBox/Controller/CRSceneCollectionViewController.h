//
//  CRSceneCollectionViewController.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/21.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CRSceneCollectionViewCell,CRSceneCollectionViewController,CRSceneModel;

@protocol CRSceneCollectionViewControllerDelegate <NSObject>

@optional
- (void)sceneCollectionViewControllerDidEndScroll:(CRSceneCollectionViewController *)sceneCollection selectedIndex:(NSInteger)index;

- (void)sceneCollectionViewControllerDidEndScroll:(CRSceneCollectionViewController *)sceneCollection sceneModel:(CRSceneModel *)sceneModel;

@end

@interface CRSceneCollectionViewController : NSObject<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * sceneCollectionView;

@property (nonatomic, strong) NSMutableArray<CRSceneModel *>* colorArray;

@property (nonatomic, readonly, assign) BOOL isEndScroll;

@property (nonatomic, readonly, assign) BOOL isBeginDrag;

@property (nonatomic, weak) CRSceneCollectionViewCell * selectedCell;

@property (nonatomic, weak) id<CRSceneCollectionViewControllerDelegate> delegate;

@end
