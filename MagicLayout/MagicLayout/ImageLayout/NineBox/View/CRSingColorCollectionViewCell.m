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

@end
