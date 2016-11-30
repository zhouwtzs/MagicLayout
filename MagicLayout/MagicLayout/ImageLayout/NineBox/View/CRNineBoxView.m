//
//  CRNineBoxView.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineBoxView.h"

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
    }
    return self;
}

#pragma mark - subBox
- (UIImageView *)getSubBoxWithFrame:(CGRect)frame{
    
    UIImageView * subImageView = [[UIImageView alloc]initWithFrame:frame];
    
    subImageView.backgroundColor = RGBCOLOR(164, 158, 134);
        
    return subImageView;
}

- (void)createView{
    
    self.backgroundColor = WHITECOLOR(250);
    
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

@end




