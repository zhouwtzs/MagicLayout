//
//  CRSingColorCollectionViewCell.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRSingleColorModel.h"


const static NSString * CRSingColorCollectionViewCellLongPress = @"CRSingColorCollectionViewCellLongPress";
const static NSString * CRSingColorCollectionViewCellPan = @"CRSingColorCollectionViewCellPan";


@interface CRSingColorCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UIPanGestureRecognizer * pan;

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

- (void)setSingleColor:(CRSingleColorModel *)colorModel;

@end
