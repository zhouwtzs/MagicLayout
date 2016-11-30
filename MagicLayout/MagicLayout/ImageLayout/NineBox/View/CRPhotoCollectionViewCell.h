//
//  CRPhotoCollectionViewCell.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>


const static NSString * CRPhotoCollectionViewCelllongPress = @"CRPhotoCollectionViewCelllongPress";
const static NSString * CRPhotoCollectionViewCellPan = @"CRPhotoCollectionViewCellPan";

@interface CRPhotoCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView * imageView;

@property (nonatomic, strong) UIPanGestureRecognizer * pan;

@property (nonatomic, strong) UILongPressGestureRecognizer * longPress;

@end
