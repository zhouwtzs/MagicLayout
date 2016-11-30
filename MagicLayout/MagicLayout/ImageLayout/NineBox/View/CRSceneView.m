//
//  CRSceneView.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/11/1.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRSceneView.h"

#import "CRSceneModel.h"

@implementation CRSceneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createView];
    }
    return self;
}

- (void)createView{
    
    self.backgroundColor = WHITECOLOR(236);

    [self createCollectionView];
    
    float hh = self.bounds.size.height;
    
    CGRect colocRect = CGRectMake(5, (hh-40)*0.5, 40, 40);
    CGRect leftLabelRect = CGRectMake(0, 4, SCREENWIDTH*0.5, 11);
    CGRect rightLabelRect = CGRectMake(SCREENWIDTH*0.5, 4, SCREENWIDTH*0.5, 11);
    CGRect valueRect = CGRectMake(self.bounds.size.width-45, (hh-60)*0.5+10, 40, 60);
    
    _colorShowView = [[UIView alloc]initWithFrame:colocRect];
    
    _colorShowView.layer.borderWidth = 1;
    
    _colorShowView.layer.borderColor = WHITECOLOR(200).CGColor;
    
    [self addSubview:_colorShowView];
    
    _sceneNameLabelEN = [self nameLabel:leftLabelRect];
    
    [self addSubview:_sceneNameLabelEN];
    
    _sceneNameLabelCN = [self nameLabel:rightLabelRect];
    
    [self addSubview:_sceneNameLabelCN];
    
    _colorVlaueLabel = [self nameLabel:valueRect];
    
    _colorVlaueLabel.numberOfLines = 3;
    
    _colorVlaueLabel.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_colorVlaueLabel];
    
    [self sceneCollectionViewControllerDidEndScroll:_scene selectedIndex:0];
}

- (void)createCollectionView{
    
    CGRect collectionRect = CGRectMake(50, 0, SCREENWIDTH-100, self.bounds.size.height);
    
    _scene = [[CRSceneCollectionViewController alloc]init];
    
    _scene.delegate = self;
    
    _scene.sceneCollectionView.frame = collectionRect;
    
    [self addSubview:_scene.sceneCollectionView];
}

- (UILabel *)nameLabel:(CGRect)frame{
    
    UILabel * label= [[UILabel alloc]initWithFrame:frame];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor darkGrayColor];
    
    label.font = [UIFont systemFontOfSize:11];
    
    return label;
}

- (void)sceneCollectionViewControllerDidEndScroll:(CRSceneCollectionViewController *)sceneCollection selectedIndex:(NSInteger)index{
    
    UIColor * customColor = [[CRSceneModel getColorArray] objectAtIndex:index];
    
    _colorShowView.backgroundColor = customColor;
    
    NSString * name = [[CRSceneModel getAllSceneNameArray] objectAtIndex:index];
    
    NSInteger loc = [name rangeOfString:@"#"].location;
    
    _sceneNameLabelEN.text = [name substringToIndex:loc];
    
    _sceneNameLabelCN.text = [name substringFromIndex:loc+1];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    
    [customColor getRed:&red green:&green blue:&blue alpha:nil];
    
    NSString * colorString = [NSString stringWithFormat:@"R:%d\nG:%d\nB:%d",(int)(red*255),(int)(green*255),(int)(blue*255)];
    
    _colorVlaueLabel.text = colorString;
    
}


@end
