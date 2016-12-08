//
//  CRNineCustomView.m
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineCustomView.h"

#import "UIImage+CRCategory.h"

@implementation CRNineCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentSize = self.bounds.size;
        
        self.showsVerticalScrollIndicator = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.scrollEnabled = NO;
        
        self.bounces = NO;
        
        _infoImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self addSubview:_infoImageView];
        
        _photoInfo = [[CRPhotoModel alloc]init];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    self.contentSize = frame.size;
    
    self.infoImageView.frame = self.bounds;
}

- (void)setBounds:(CGRect)bounds{
    
    [super setBounds:bounds];
    
    self.contentSize = bounds.size;
    
    self.infoImageView.frame = self.bounds;
}

#pragma mark - method
- (void)setPhotoInfo:(CRPhotoModel *)photoInfo{
    
    _photoInfo = photoInfo;
    
    self.infoImageView.image = photoInfo.fitImage;
    
    [UIImage CR_cacheImageWithAsset:photoInfo.phasset completed:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        
        _photoInfo.originalImage = image;
    }];
}


@end
