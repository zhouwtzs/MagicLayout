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

//0.62f
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
    
    [subImageView addGestureRecognizer:[self getPanGestureRecognizer]];
    
    [subImageView addGestureRecognizer:[self getLongPressGesture]];
    
    subImageView.userInteractionEnabled = YES;
    
    return subImageView;
}

- (void)createView{
    
    self.userInteractionEnabled = YES;
    
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
    
    return  [self indexOfSubimage:_resultImageView];
}

- (NSInteger)indexOfSubimage:(UIImageView *)subImageView{
    
    __block NSInteger index = -1;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj == subImageView) {
            
            index = idx;
            
            *stop = YES;
        }
    }];
    return index;
}

- (UIImageView *)subImageWithIndex:(NSInteger)index{
    
    return [self viewWithTag:800+index];
}

- (void)exchangeInfoAtIndex:(NSInteger)index1 withInfoAtIndex:(NSInteger)index2{
    
    [_infoArray exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    
    [_thumbImageArray exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    
}


- (void)reloadInfoAtIndex:(NSArray *)indexs{
    
    for (NSNumber * index in indexs) {
        
        if ([[_infoArray objectAtIndex:[index integerValue]] isKindOfClass:[CRSingleColorModel class]]) {
            
            CRSingleColorModel * colorModel = [_infoArray objectAtIndex:[index integerValue]];
            
            [self setColorInfo:colorModel ForIndex:[index integerValue]];
            
        }else{
        
            CRPhotoModel * photoModel = [_infoArray objectAtIndex:[index integerValue]];
            
            UIImage * img = [_thumbImageArray objectAtIndex:[index integerValue]];
            
            [self setPhotoInfo:photoModel thumdImage:img ForIndex:[index integerValue]];
        }
    }
}

#pragma mark - set info
- (void)setColorInfo:(CRSingleColorModel *)colorModel ForIndex:(NSInteger)index{
    
    UIImageView * subImageView = [self viewWithTag:800+index];
    
    if (!subImageView) {
        
        return;
    }
    subImageView.image = nil;

    if (!colorModel) {
        
        colorModel = [CRSingleColorModel defaultColorModel];
    }
    
    
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

#pragma mark - GestureRecognizer

- (UIImageView *)getCustomView{
    
    if (_customView) {
        
        return _customView;
    }
    _customView = [[UIImageView alloc]init];
    
    return _customView;
}

- (UILongPressGestureRecognizer *)getLongPressGesture{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    
    longPress.minimumPressDuration = 1.0f;
    
    //longPress.delegate = self;
    
    return longPress;
}

- (UIPanGestureRecognizer *)getPanGestureRecognizer{
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    //pan.delegate = self;
    
    return pan;
}

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
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //custom ready
        UIImageView * subImageView = (UIImageView *)pan.view;
        
        [self getCustomView].frame = subImageView.frame;
        
        _customView.image = subImageView.image;
        
        _customView.backgroundColor = subImageView.backgroundColor;
        
        _selectedView = subImageView;

        _resultImageView = subImageView;
        
        _resultImageView.alpha = 0.62f;
        
        [self addSubview:_customView];
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        //拖动改变位置
        CGPoint translationPoint = [pan translationInView:self];
        
        _customView.transform = CGAffineTransformMakeTranslation(translationPoint.x, translationPoint.y);
        
        //检测当前位置的subimage
        CGPoint locationPoint = [pan locationInView:self];
        
        if (CGRectContainsPoint(self.bounds,locationPoint)) {
            //在边界范围
            UIImageView * subImageView = [self subViewInNineBoxWithPoint:locationPoint];
            
            if (_resultImageView != subImageView) {
                
                _resultImageView.alpha = 1.0f;
                
                subImageView.alpha = 0.62f;
                
                _resultImageView = subImageView;
            }
        }else{
            //已经越出边界
            _resultImageView.alpha = 1.0f;
            
            _resultImageView = nil;
            
            //删除掉该位置的信息
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (_resultImageView) {
            
            NSInteger index1 = [self indexOfSubimage:_selectedView];
            
            NSInteger index2 = [self indexOfSubimage:_resultImageView];
            
            [self exchangeInfoAtIndex:index1 withInfoAtIndex:index2];
            
            [self reloadInfoAtIndex:@[[NSNumber numberWithInteger:index1],[NSNumber numberWithInteger:index2]]];
            
        }else{
            
            //清楚selected的信息
            [self setColorInfo:[CRSingleColorModel defaultColorModel] ForIndex:[self indexOfSubimage:_selectedView]];
        }
        //临时view移除
        [_customView removeFromSuperview];
        
        _customView.transform = CGAffineTransformIdentity;
    }
}



@end




