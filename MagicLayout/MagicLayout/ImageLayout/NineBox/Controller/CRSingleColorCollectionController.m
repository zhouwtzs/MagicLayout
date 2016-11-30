//
//  CRSingleColorCollectionController.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSingleColorCollectionController.h"

#import "CRSingColorCollectionViewCell.h"
#import "CRSingleColorModel.h"

#define cellSize CGSizeMake(70, 80)

@implementation CRSingleColorCollectionController

NSString * crnineboxsinglecolorcell = @"crnineboxsinglecolorcell";

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self createCollectionView];
    }
    return self;
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.minimumInteritemSpacing = 1;
    
    _singleColorCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    
    _singleColorCollectionView.delegate = self;
    
    _singleColorCollectionView.backgroundColor = WHITECOLOR(143);
    
    _singleColorCollectionView.dataSource = self;
    
    _singleColorCollectionView.decelerationRate = 0.6;
    
    _singleColorCollectionView.showsHorizontalScrollIndicator = NO;
    
    [_singleColorCollectionView registerClass:[CRSingColorCollectionViewCell class] forCellWithReuseIdentifier:crnineboxsinglecolorcell];
}

#pragma mark - collection view delegate and data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [CRSingleColorModel getSingleColorArray].count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellSize;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRSingColorCollectionViewCell * singleColorCell = [collectionView dequeueReusableCellWithReuseIdentifier:crnineboxsinglecolorcell forIndexPath:indexPath];
    
    [singleColorCell setSingleColor:[[CRSingleColorModel getSingleColorArray] objectAtIndex:indexPath.item]];
    
    return singleColorCell;
    
}

@end
