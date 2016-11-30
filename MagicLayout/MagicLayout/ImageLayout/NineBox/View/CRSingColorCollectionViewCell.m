//
//  CRSingColorCollectionViewCell.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSingColorCollectionViewCell.h"

@implementation CRSingColorCollectionViewCell

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
    
    CGRect rect = CGRectMake(0, self.contentView.bounds.size.height-14, self.contentView.bounds.size.width, 14);
    
    _nameLabel = [[UILabel alloc] initWithFrame:rect];
    
    _nameLabel.backgroundColor = WHITECOLOR(255);
    
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    _nameLabel.font = [UIFont systemFontOfSize:11];
    
    _nameLabel.textColor = WHITECOLOR(0);
    
    [self.contentView addSubview:_nameLabel];
}

- (void)setSingleColor:(CRSingleColorModel *)colorModel{
    
    _nameLabel.text = colorModel.colorName;
    
    self.contentView.backgroundColor = colorModel.color;
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
        
        NSNotification *notification =[NSNotification notificationWithName:(NSString *)CRSingColorCollectionViewCellLongPress object:self userInfo:@{@"GestureRecognizer":longPress}];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];

    }else if (longPress.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"longpress end");
    }
}


#pragma mark - pan method

- (void)panGesture:(UIPanGestureRecognizer *)pan{
    
    NSNotification *notification =[NSNotification notificationWithName:(NSString *)CRSingColorCollectionViewCellPan object:self userInfo:@{@"GestureRecognizer":pan}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}


@end
