//
//  CRSceneCollectionViewCell.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/31.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSceneCollectionViewCell.h"

@implementation CRSceneCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self createView];
    }
    return self;
}

- (void)createView{
    
    CGRect frame = CGRectMake(0, 15, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    
    _sceneImageView = [[UIImageView alloc]initWithFrame:frame];
    
    _sceneImageView.image = [UIImage imageNamed:@"CoverIMG"];
    
    [self.contentView addSubview:_sceneImageView];
}

- (void)setScene:(CRSceneModel *)sceneModel{
    
    _sceneImageView.backgroundColor = [UIColor colorWithPatternImage:sceneModel.image];
    
}

@end
