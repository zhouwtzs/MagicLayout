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
    
    _photoAssets = [[NSMutableArray alloc]init];

    [[CRPhotoModel getAllAssetInPhotoAlbumWithAsceding:NO] enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CRPhotoModel * photoModel = [[CRPhotoModel alloc]init];
        
        photoModel.phasset = obj;
        
        [_photoAssets addObject:photoModel];
    }];
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
    
    CRPhotoModel * photoModel = [_photoAssets objectAtIndex:indexPath.item];

    return [self sizeForAsset:photoModel.phasset];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRPhotoCollectionViewCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)crnineboxphotocell forIndexPath:indexPath];
    
    if (!photoCell.pan) {
        
        [photoCell addGestureRecognizer:[self getPanGestureRecognizer]];
        
        photoCell.pan = [self getPanGestureRecognizer];
    }
    if (!photoCell.longPress) {
        
        [photoCell addGestureRecognizer:[self getLongPressGesture]];
        
        photoCell.longPress = [self getLongPressGesture];
    }
    CRPhotoModel * photoModel = [_photoAssets objectAtIndex:indexPath.item];
    
    if (photoModel.fitImage) {
        
        photoCell.imageView.image = photoModel.fitImage;
        
    }else{
    
        [photoCell.imageView CR_setImageWithAsset:photoModel.phasset placeholderImage:nil completed:^(UIImage * _Nonnull image, NSDictionary * _Nullable info) {
            
            photoModel.fitImage = image;
        }];
    }
    return photoCell;
}

//适配尺寸
- (CGSize)sizeForAsset:(PHAsset *)asset{
    
    CGFloat ww = (CGFloat)asset.pixelWidth;
    CGFloat hh = (CGFloat)asset.pixelHeight;
    CGFloat scale = ww/hh;
    CGFloat HH = self.photoCollectionView.bounds.size.height-6;
    
    return CGSizeMake(HH*scale, HH);
}

#pragma mark - gestureRecognizer
- (UILongPressGestureRecognizer *)getLongPressGesture{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    
    longPress.minimumPressDuration = 1.0f;
    
    longPress.delegate = self;
    
    return longPress;
}

- (UIPanGestureRecognizer *)getPanGestureRecognizer{
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    pan.delegate = self;
    
    return pan;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        
        return YES;
        
    }else if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.photoCollectionView];
        
        if (fabs(translation.x) > fabs(translation.y)*0.8) {
            
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

#pragma mark - GestureRecognizer method

//longPress
- (void)longPressGesture:(UILongPressGestureRecognizer *)longPress{
    
    //选中图片，实现一个代理
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (longPress.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"longpress end");
    }
}

//pan
- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    CRPhotoCollectionViewCell * cell = (CRPhotoCollectionViewCell *)pan.view;
    
    if (_gestureCell && cell != _gestureCell ) {
        return;
    }
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _gestureCell = cell;
        
        NSIndexPath * indexPath = [_photoCollectionView indexPathForCell:cell];
        
        _cellPhotoModel = [_photoAssets objectAtIndex:indexPath.item];
    }
    if ([self.delegate respondsToSelector:@selector(CRPhotoCollectionViewCell:panGestureRecognizer:photoModel:)]) {
        
        [self.delegate CRPhotoCollectionViewCell:_gestureCell panGestureRecognizer:pan photoModel:_cellPhotoModel];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        _gestureCell = nil;
        
        _cellPhotoModel = nil;
    }
}


@end
