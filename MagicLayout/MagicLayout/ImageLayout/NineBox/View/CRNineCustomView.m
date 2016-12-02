//
//  CRNineCustomView.m
//  MagicLayout
//
//  Created by 周文涛 on 16/12/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineCustomView.h"

#import "UIImage+CreateWithColor.h"

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
        
        _photoInfo = [[CRNinePhotoModel alloc]init];
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

- (void)setFitImage:(UIImage *)image{
    
    _infoImageView.image = image;
    
    _photoInfo.fitImage = image;
    
    float minf = MIN(image.size.width, image.size.height);
    
    CGRect thumbFrame = CGRectMake((image.size.width-minf)*0.5, (image.size.height-minf)*0.5, minf, minf);
    
    _photoInfo.thumbImage = [UIImage shearImage:image withFrame:thumbFrame];
    
    
}


@end
