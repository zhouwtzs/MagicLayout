//
//  CRPhotoCollectionViewController.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRPhotoCollectionViewController.h"

#import "CRPhotoCollectionViewCell.h"
#import "CRPhotoModel.h"
#import "UIImageView+AssetPhoto.h"

@implementation CRPhotoCollectionViewController

NSString * crnineboxphotocell = @"crnineboxphotocell";

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
    
    flowLayout.minimumInteritemSpacing = 3;
    
    flowLayout.minimumLineSpacing = 3.0f;
    
    _photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    
    _photoCollectionView.delegate = self;
    
    _photoCollectionView.dataSource = self;
    
    _photoCollectionView.decelerationRate = 0.5;
    
    _photoCollectionView.showsHorizontalScrollIndicator = NO;
    
    [_photoCollectionView registerClass:[CRPhotoCollectionViewCell class] forCellWithReuseIdentifier:crnineboxphotocell];
    
    _photoAssets = [[NSMutableArray alloc]initWithArray:[CRPhotoModel getAllAssetInPhotoAlbumWithAsceding:NO]];
    
}

#pragma mark - collection view delegate and data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _photoAssets.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 3, 0, 3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //这里应该根据图片的尺寸来进行调整
    
    PHAsset * asset = [_photoAssets objectAtIndex:indexPath.item];
    
    return [self sizeForAsset:asset];    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRPhotoCollectionViewCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)crnineboxphotocell forIndexPath:indexPath];
    
    PHAsset * asset = [_photoAssets objectAtIndex:indexPath.item];
    
    photoCell.imageView.backgroundColor = [UIColor darkGrayColor];

    [photoCell.imageView CR_setImageWithAsset:asset placeholderImage:nil completed:nil];
    
    return photoCell;
}

- (CGSize)sizeForAsset:(PHAsset *)asset{
    
    CGFloat ww = (CGFloat)asset.pixelWidth;
    CGFloat hh = (CGFloat)asset.pixelHeight;
    CGFloat scale = ww/hh;
    CGFloat HH = self.photoCollectionView.bounds.size.height-6;
    
    return CGSizeMake(HH*scale, HH);
}

#pragma mark - UIGestureRecognizer

@end
