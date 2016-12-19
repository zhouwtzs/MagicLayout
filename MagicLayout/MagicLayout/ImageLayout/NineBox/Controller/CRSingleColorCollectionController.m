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
    
    _colorsArray =  [CRSingleColorModel getSingleColorArray] .mutableCopy;
}

#pragma mark - collection view delegate and data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _colorsArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellSize;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRSingColorCollectionViewCell * singleColorCell = [collectionView dequeueReusableCellWithReuseIdentifier:crnineboxsinglecolorcell forIndexPath:indexPath];
    
    [singleColorCell setSingleColor:[_colorsArray objectAtIndex:indexPath.item]];
    
    if (!singleColorCell.pan) {
        
        [singleColorCell addGestureRecognizer:[self getPanGestureRecognizer]];
        
        singleColorCell.pan = [self getPanGestureRecognizer];
    }
    if (!singleColorCell.longPress) {
        
        [singleColorCell addGestureRecognizer:[self getLongPressGesture]];
        
        singleColorCell.longPress = [self getLongPressGesture];
    }
    
    return singleColorCell;
    
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
        
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.singleColorCollectionView];
        
        if (fabs(translation.x) > fabs(translation.y)*0.8) {
            
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

#pragma mark - longPress method

- (void)longPressGesture:(UILongPressGestureRecognizer *)longPress{
    
    //选中图片，实现一个代理
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        
    }else if (longPress.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"longpress end");
    }
}


#pragma mark - pan method

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    CRSingColorCollectionViewCell * cell = (CRSingColorCollectionViewCell *)pan.view;
    
    if (_gestureCell && cell != _gestureCell ) {
        return;
    }
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _gestureCell = cell;
        
        NSIndexPath * indexPath = [_singleColorCollectionView indexPathForCell:cell];
        
        _cellColorModel = [_colorsArray objectAtIndex:indexPath.item];
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        _gestureCell = nil;
        
        _cellColorModel = nil;
    }
    if ([self.delegate respondsToSelector:@selector(CRSingColorCollectionViewCell:panGestureRecognizer:colorModel:)]) {
        
        [self.delegate CRSingColorCollectionViewCell:_gestureCell panGestureRecognizer:pan colorModel:_cellColorModel];
    }
}

@end
