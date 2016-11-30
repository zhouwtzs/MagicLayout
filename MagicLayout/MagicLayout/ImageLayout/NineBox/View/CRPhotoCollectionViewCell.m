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
        
        [self addGestureRecognizer:[self getLongPressGesture]];
        
        [self addGestureRecognizer:[self getPanGestureRecognizer]];
    }
    return self;
}

- (void)createView{
    
    _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:_imageView];
}

#pragma mark - gestureRecognizer
- (UILongPressGestureRecognizer *)getLongPressGesture{
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    
    longPress.minimumPressDuration = 1.0f;
    
    longPress.delegate = self;
    
    _longPress = longPress;
    
    return longPress;
}


- (UIPanGestureRecognizer *)getPanGestureRecognizer{
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    pan.delegate = self;
    
    _pan = pan;
    
    return pan;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer == _longPress) {
        
        return YES;
        
    }else if (gestureRecognizer == _pan) {
        
        CGPoint translation = [_pan translationInView:self];
        
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
        
        NSNotification *notification =[NSNotification notificationWithName:(NSString *)CRPhotoCollectionViewCelllongPress object:self userInfo:@{@"GestureRecognizer":longPress}];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else if (longPress.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"longpress end");
    }
}


#pragma mark - pan method

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    NSNotification *notification =[NSNotification notificationWithName:(NSString *)CRPhotoCollectionViewCellPan object:self userInfo:@{@"GestureRecognizer":pan}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

@end
