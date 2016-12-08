//
//  CRPhotoCollectionViewCell.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRPhotoCollectionViewCell.h"

#import "UIButton+SelectedButton.h"

@implementation CRPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createView];
    
    }
    return self;
}

- (void)createView{
    
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:_imageView];
}


@end
