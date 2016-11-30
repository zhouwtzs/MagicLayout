//
//  UIButton+SelectedButton.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/3.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "UIButton+SelectedButton.h"

@implementation UIButton (SelectedButton)

+ (UIButton *)selectedButton{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.bounds = CGRectMake(0, 0, 25, 25);
    
    [button setBackgroundImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    
    return button;
}

@end
