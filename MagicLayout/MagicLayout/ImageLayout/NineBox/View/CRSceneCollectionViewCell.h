//
//  CRSceneCollectionViewCell.h
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/31.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CRSceneModel.h"


/*
 @brief 场景cell
 */
@interface CRSceneCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * sceneImageView;

- (void)setScene:(CRSceneModel *)sceneModel;

@end
