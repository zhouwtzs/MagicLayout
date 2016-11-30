 //
//  CRPhotoCollectionViewController.h
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/*
 @brief 照片选择器
 */
@interface CRPhotoCollectionViewController : NSObject<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * photoCollectionView;

@property (nonatomic, strong) NSMutableArray * photoAssets;

@end
