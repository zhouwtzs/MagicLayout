//
//  CRNineBoxView.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineBoxView.h"

#import "UIImage+CRCategory.h"

#define FLOAT_SPACE 5.0f


@implementation CRNineBoxView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self createView];
        
        [self createData];
    }
    return self;
}

#pragma mark - subBox
- (void)createData{
    
    _infoArray = [[NSMutableArray alloc]init];
    
    _thumbImageArray = [[NSMutableArray alloc]init];
    
    CRSingleColorModel * colorModel = [[CRSingleColorModel alloc]initWithColor:[UIColor whiteColor] colorName:@"白色"];
    
    UIImage * image = [UIImage createImageWithColor:[UIColor whiteColor]];

    for (NSInteger i = 0; i < 9; i++) {
        
        [_infoArray addObject:colorModel];
        
        [_thumbImageArray addObject:image];
    }
}

- (UIImageView *)getSubBoxWithFrame:(CGRect)frame{
    
    UIImageView * subImageView = [[UIImageView alloc]initWithFrame:frame];
    
    subImageView.backgroundColor = [UIColor whiteColor];
        
    return subImageView;
}

- (void)createView{
    
    self.backgroundColor = RGBCOLOR(164, 158, 134);
    
    float ww = (self.bounds.size.width-FLOAT_SPACE*4)/3;
    
    for (int i = 0; i < 9; i++) {
        
        CGRect frame = CGRectMake(i%3*(ww+FLOAT_SPACE)+FLOAT_SPACE, i/3*(ww+FLOAT_SPACE)+FLOAT_SPACE, ww, ww);

        UIImageView * subImageView = [self getSubBoxWithFrame:frame];
        
        subImageView.tag = 800+i;
        
        [self addSubview:subImageView];
    }
}

#pragma mark - method
- (NSInteger)indexOfSubBoxWithPoint:(CGPoint)point{

    float ww = self.bounds.size.width/3;
    
    NSInteger index = (int)(point.y/ww)*3+(int)(point.x/ww);
    
    return index;
}


- (UIImageView *)subViewInNineBoxWithPoint:(CGPoint)point{
    
    float ww = self.bounds.size.width/3;
    
    NSInteger index = (int)(point.y/ww)*3+(int)(point.x/ww);
    
    return (UIImageView *) [self viewWithTag:800+index];
}

- (NSInteger)indexOfResultImageView{
    
    __block NSInteger index = 0;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj == _resultImageView) {
            
            index = idx;
            
            *stop = YES;
        }
    }];
    return index;
}
#pragma mark - set info
- (void)setColorInfo:(CRSingleColorModel *)colorModel ForIndex:(NSInteger)index{
    
    UIImageView * subImageView = [self viewWithTag:800+index];
    
    if (!subImageView) {
        
        return;
    }
    subImageView.image = nil;
    
    subImageView.backgroundColor = colorModel.color;
    
    [_infoArray replaceObjectAtIndex:index withObject:colorModel];
    
    UIImage * thumbImage = [UIImage createImageWithColor:colorModel.color];
    
    [_thumbImageArray replaceObjectAtIndex:index withObject:thumbImage];
}

- (void)setPhotoInfo:(CRPhotoModel *)photoInfo thumdImage:(UIImage *)thumbImage ForIndex:(NSInteger)index{
    
    UIImageView * subImageView = [self viewWithTag:800+index];
    
    if (!subImageView) {
        
        return;
    }
    subImageView.backgroundColor = [UIColor whiteColor];
    
    subImageView.image = thumbImage;
    
    [_infoArray replaceObjectAtIndex:index withObject:photoInfo];
    
    [_thumbImageArray replaceObjectAtIndex:index withObject:thumbImage];
}


@end




