//
//  CRSceneCollectionViewController.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/21.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSceneCollectionViewController.h"

#import "CRSceneModel.h"
#import "CRSceneCollectionViewCell.h"

#define cellSize CGSizeMake(40, 80)
#define headSize CGSizeMake(_sceneCollectionView.bounds.size.width*0.5-cellSize.width*0.5, 80)

@implementation CRSceneCollectionViewController

NSString * crnineboxscenecell = @"crnineboxscenecell";

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self createCollectionView];

    }
    return self;
}

#pragma mark - create view
- (void)createCollectionView{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.minimumInteritemSpacing = 1;
    
    flowLayout.minimumLineSpacing = 0;
    
    _sceneCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    
    _sceneCollectionView.delegate = self;
    
    _sceneCollectionView.backgroundColor = WHITECOLOR(236);
    
    _sceneCollectionView.dataSource = self;
    
    _sceneCollectionView.decelerationRate = 0.6;
    
    _sceneCollectionView.showsHorizontalScrollIndicator = NO;
    
    [_sceneCollectionView registerClass:[CRSceneCollectionViewCell class] forCellWithReuseIdentifier:crnineboxscenecell];
 
    _isEndScroll = YES;
    
    [self performSelector:@selector(scrollViewAdjustOffset:) withObject:nil afterDelay:0.5];
    
    _colorArray = [CRSceneModel getSceneArray].mutableCopy;
}

#pragma mark - collection view delegate and data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _colorArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return headSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return headSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CRSceneCollectionViewCell * sceneCell = [collectionView dequeueReusableCellWithReuseIdentifier:crnineboxscenecell forIndexPath:indexPath];
    
    [sceneCell setScene:[_colorArray objectAtIndex:indexPath.item]];
    
    return sceneCell;
}
#pragma mark - scrollview delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //NSLog(@"end scroll");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _isEndScroll = NO;
    
    if ((NSInteger)(scrollView.contentOffset.x)%(NSInteger)(cellSize.width) > 1 && _isBeginDrag) {
        _isBeginDrag = NO;
        
        [self performSelector:@selector(scrollViewAdjustOffset:) withObject:nil afterDelay:0.1];

    }
    _isEndScroll = YES;
}

- (void)scrollViewAdjustOffset:(NSIndexPath *)indexPath{
    
    if (_isEndScroll) {
    
        NSInteger index = (_sceneCollectionView.contentOffset.x+cellSize.width*0.5)/cellSize.width;
        
        if (indexPath) {
            index = indexPath.item;
        }
        CGPoint point = CGPointMake(index*cellSize.width, 0);
        
        //NSLog(@"%d",(int)index);
        [_sceneCollectionView setContentOffset:point animated:YES];
        
        //选中的这个cell突出显示
        CRSceneCollectionViewCell * cell = (CRSceneCollectionViewCell *)[_sceneCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        _selectedCell = cell;
        //本来就是weak，这里就不需要再进行typeof转换了
        [UIView animateWithDuration:0.3 animations:^{
            
            _selectedCell.sceneImageView.transform = CGAffineTransformMakeTranslation(0, -10);
        }];
        
        CRSceneModel * sceneModel = [_colorArray objectAtIndex:index];
        
        if ([self.delegate respondsToSelector:@selector(sceneCollectionViewControllerDidEndScroll:selectedIndex:)]) {
            
            [self.delegate sceneCollectionViewControllerDidEndScroll:self selectedIndex:index];
        }
        if ([self.delegate respondsToSelector:@selector(sceneCollectionViewControllerDidEndScroll:sceneModel:)]) {
            
            [self.delegate sceneCollectionViewControllerDidEndScroll:self sceneModel:sceneModel];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _isBeginDrag = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _selectedCell.sceneImageView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - cell selected method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [UIView animateWithDuration:0.3 animations:^{
        
        _selectedCell.sceneImageView.transform = CGAffineTransformIdentity;
    }];
    
    [self scrollViewAdjustOffset:indexPath];
}

@end
