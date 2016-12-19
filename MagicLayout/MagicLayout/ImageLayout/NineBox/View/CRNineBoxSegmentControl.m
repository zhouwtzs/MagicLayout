//
//  CRNineBoxSegmentControl.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/10/20.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineBoxSegmentControl.h"

#import "CRSingColorCollectionViewCell.h"
#import "CRSceneModel.h"
//#define BtnHeight 40
//#define TapHeight 15
//#define SubHeight_1 70
//#define SubHeight_2 90
//#define ViewHeight_1 140
//#define ViewHeight_2 160
//#define Frame_1 CGRectMake(0, SCREENHEIGHT-ViewHeight_1, SCREENWIDTH, ViewHeight_1)
//#define Frame_2 CGRectMake(0, SCREENHEIGHT-ViewHeight_2, SCREENWIDTH, ViewHeight_2)

//测试固定尺寸
#define ViewHeight 145
#define BtnHeight 40


@implementation CRNineBoxSegmentControl
/*
 手势更改，现在子菜单只能通过点击按钮来显示，但是可以通过手势活动来隐藏
 */


{
    CGRect _firstFrame;                     //view创建的时候的frame
    CGRect _oldFrame;                       //view被拖动，frame将要变化的初始值
    NSInteger _btnSelectedIndex;            //当前选中的是那一个按钮
    BOOL _isSingleColor;                    //是否创建singleColor
    BOOL _isScene;                          //是否创建场景
    BOOL _isValueView;                      //是否创建数值view
    BOOL _isShowed;                         //是否正在展示子view
}

NSString * sf = @"sdf";


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildData];
        
        [self createView];
        
        //[self addGestureRecognizer:[self getPanGestureRecognizer]];
        
        [self addGestureRecognizer:[self getSwipeGestureRecognizer]];
    }
    return self;
}

#pragma mark - set btn frame
- (void)setBounds:(CGRect)bounds{
    
    [super setBounds:bounds];
    
    [self setSubBtnFrame];
}

- (void)setSubBtnFrame{
    
    CGSize btnSize = CGSizeMake(self.bounds.size.width/3, BtnHeight);
    
    float buttom = self.bounds.size.height - BtnHeight;
    
    _singleColorBtn.frame = CGRectMake(0, buttom, btnSize.width, BtnHeight);
    
    _sceneBtn.frame = CGRectMake(btnSize.width, buttom, btnSize.width, BtnHeight);
    
    _valueBtn.frame = CGRectMake(btnSize.width*2, buttom, btnSize.width, BtnHeight);
}

#pragma mark - create view
- (void)buildData{
    _firstFrame = self.frame;
    _btnSelectedIndex = 0;
    _isSingleColor = NO;
    _isScene = NO;
    _isValueView = NO;
    _isShowed = NO;
}

- (void)createView{
    
    //self.backgroundColor = [UIColor grayColor];
    
    _singleColorBtn = [self getSegmentSubbtn];
    
    [_singleColorBtn setTitle:@"单色图片" forState:UIControlStateNormal];
    
    [self addSubview:_singleColorBtn];
    
    _sceneBtn = [self getSegmentSubbtn];
    
    [_sceneBtn setTitle:@"场景" forState:UIControlStateNormal];
    
    [self addSubview:_sceneBtn];
    
    _valueBtn = [self getSegmentSubbtn];
    
    [_valueBtn setTitle:@"颜色值" forState:UIControlStateNormal];
    
    [self addSubview:_valueBtn];
    
    [self setSubBtnFrame];
}

- (UIButton *)getSegmentSubbtn{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:WHITECOLOR(146) forState:UIControlStateNormal];
    
    [btn setTitleColor:RGBCOLOR(76, 121, 246) forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //[btn setBackgroundImage:nil forState:UIControlStateNormal];
    
    //[btn setBackgroundImage:nil forState:UIControlStateSelected];
    
    [btn setBackgroundColor:WHITECOLOR(248)];
        
    [btn addTarget:self action:@selector(clickSubSegmentBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)addSingleColorCollectionView{
    
    CGRect rect = CGRectMake(0, 105, SCREENWIDTH, 90);
    
    _singleColor = [[CRSingleColorCollectionController alloc]init];
    
    _singleColor.delegate =self;
    
    [self insertSubview:_singleColor.singleColorCollectionView belowSubview:_singleColorBtn];
    
    //_singleColor.singleColorCollectionView.backgroundColor = [UIColor blueColor];
    
    _singleColor.singleColorCollectionView.frame = rect;
    
    _isSingleColor = YES;
}

- (void)addSceneCollectionView{
 
    CGRect rect = CGRectMake(0, 105, SCREENWIDTH, 90);
    
    _scene = [[CRSceneView alloc]initWithFrame:rect];
    
    [self insertSubview:_scene belowSubview:_singleColorBtn];
    
    //_scene.sceneCollectionView.backgroundColor = [UIColor blueColor];
    
    _isScene = YES;
}

- (void)addValuePicterView{
    
    CGRect rect = CGRectMake(0, 105, SCREENWIDTH, 100);
    
    _valuePicter = [[CRValueForPicterView alloc]initWithFrame:rect];
    
    //_valuePicter.backgroundColor = [UIColor blueColor];
    
    _valuePicter.showing = NO;
    
    [self insertSubview:_valuePicter belowSubview:_singleColorBtn];
    
    _isValueView = YES;
}

#pragma mark - click btn
- (void)clickSubSegmentBtn:(UIButton *)btn{
    
    //点击的是已经选中的按钮，此时其它按钮应该是未选中状态，只需要对当前按钮进行操作
    if (btn.selected) {
        
        btn.selected = NO;
        
        if (btn == _singleColorBtn) {
            
            [self hiddenSingleColorCollrctionView];
            
        }else if (btn == _sceneBtn){
        
            [self hiddenSceneCollectionView];
            
        }else{
            
            [self hiddenValueView];
        }
    }else{
        //点击的是未选中的按钮，现将当前按钮设置为选中，再将其他按钮取消选中
        
        btn.selected = YES;
        
        void (^hiddenSingleColor)(void) =^{
        
            if (_singleColorBtn.selected) {
                
                _singleColorBtn.selected = NO;
                
                [self hiddenSingleColorCollrctionView];
            }
        };
        void (^hiddenScene)(void) = ^{
        
            if (_sceneBtn.selected) {
            
                _sceneBtn.selected = NO;
                
                [self hiddenSceneCollectionView];
            }
        };
        void (^hiddenValue)(void) =^{
            
            if (_valueBtn.selected) {
                
                _valueBtn.selected = NO;
                
                [self hiddenValueView];
            }
        };
        
        if (btn == _singleColorBtn) {
            
            [self showSingleColorCollectionView];
            
            hiddenScene();
            
            hiddenValue();
            
            _btnSelectedIndex = 0;
            
        }else if (btn == _sceneBtn){
            
            [self showSceneCollectionView];
            
            hiddenSingleColor();
            
            hiddenValue();
        
            _btnSelectedIndex = 1;
            
        }else{
            
            [self showValueView];
            
            hiddenSingleColor();
            
            hiddenScene();
            
            _btnSelectedIndex = 2;
        }
    }
}

#pragma mark - btn selected view
- (void)showSingleColorCollectionView{

    if (!_isSingleColor) {
        
        [self addSingleColorCollectionView];
    
    }else{
        
        [self insertSubview:_singleColor.singleColorCollectionView belowSubview:_singleColorBtn];
    }
    [UIView animateWithDuration:0.15 animations:^{
        
        _singleColor.singleColorCollectionView.transform = CGAffineTransformMakeTranslation(0, -90);
        
    } completion:^(BOOL finished) {
       
        _isShowed = YES;
        
        _btnSelectedIndex = 0;
    }];
    
}

- (void)showSceneCollectionView{

    if (!_isScene) {
        
        [self addSceneCollectionView];
    }else{
        
        [self insertSubview:_scene belowSubview:_singleColorBtn];
    }
    [UIView animateWithDuration:0.15 animations:^{
        
        _scene.transform = CGAffineTransformMakeTranslation(0, -90);
        
    } completion:^(BOOL finished) {
        
        _isShowed = YES;
        
        _btnSelectedIndex = 1;
    }];
}

- (void)showValueView{
    
    if (!_isValueView) {
        
        [self addValuePicterView];
    }else{
        
        [self insertSubview:_valuePicter belowSubview:_singleColorBtn];
    }
    [UIView animateWithDuration:0.15 animations:^{
        
        _valuePicter.transform = CGAffineTransformMakeTranslation(0, -90);
        
    } completion:^(BOOL finished) {
        
        _isShowed = YES;
        
        _valuePicter.showing = YES;
        
        _btnSelectedIndex = 2;
    }];
}

- (void)hiddenSingleColorCollrctionView{
    //会改变_isShowed
    
    _singleColorBtn.selected = NO;
    
    [UIView animateWithDuration:0.15 animations:^{
        
        _isShowed = NO;
        
        _singleColor.singleColorCollectionView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenSceneCollectionView{

    _sceneBtn.selected = NO;
    
    [UIView animateWithDuration:0.15 animations:^{
        
        _isShowed = NO;
        
        _scene.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenValueView{
    
    _valueBtn.selected = NO;
    
    [UIView animateWithDuration:0.15 animations:^{
        
        _isShowed = NO;
        
        _valuePicter.showing = NO;
        
        _valuePicter.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - gesture recogniser
- (UISwipeGestureRecognizer *)getSwipeGestureRecognizer{
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizerOnView:)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    return swipe;
}

- (void)swipeGestureRecognizerOnView:(UISwipeGestureRecognizer *)swipe{
    
    if (!_isShowed) {
        
        return;
    }
    if (_btnSelectedIndex == 0) {
        
        [self hiddenSingleColorCollrctionView];
        
    }else if (_btnSelectedIndex == 1) {
        
        [self hiddenSceneCollectionView];
        
    }else{
        
        [self hiddenValueView];
    }
}

#pragma mark - view animation
- (void)showSubView:(UIView *)view animal:(BOOL)animal{
    
}

- (void)hidSubView:(UIView *)view animal:(BOOL)animal{

}

#pragma mark - CRSingColorCollectionViewGestureDelegate
- (void)CRSingColorCollectionViewCell:(CRSingColorCollectionViewCell *)collectionViewCell longPressGestureRecognizer:(UILongPressGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel{
}

- (void)CRSingColorCollectionViewCell:(CRSingColorCollectionViewCell *)collectionViewCell panGestureRecognizer:(UIPanGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel{
    
    NSString * string = [NSString stringWithFormat:@"基础颜色＃%@",colorModel.colorName];
    
    CRSingleColorModel * model = [[CRSingleColorModel alloc]initWithColor:colorModel.color colorName:string];
    
    CGRect rect = [collectionViewCell convertRect:collectionViewCell.bounds toView:self];
    
    rect.size.height -= 14;
    
    if ([self.delegate respondsToSelector:@selector( CRColorSegmentSelected:panGestureRecognizer:colorModel:)]) {
        [self.delegate CRColorSegmentSelected:rect panGestureRecognizer:pan colorModel:model];
    }
}

#pragma mark - CRScentViewDelegate
- (void)CRSceneViewColorShowView:(UIView *)colorView longPressGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRSceneModel *)sceneModel{

}

- (void)CRSceneViewColorShowView:(UIView *)colorView panGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRSceneModel *)sceneModel{

    NSString * string = [NSString stringWithFormat:@"场景颜色＃%@",sceneModel.sceneName];
    
    CRSingleColorModel * model = [[CRSingleColorModel alloc]initWithColor:sceneModel.color colorName:string];
    
    CGRect rect = [colorView convertRect:colorView.bounds toView:self];
    
    if ([self.delegate respondsToSelector:@selector( CRColorSegmentSelected:panGestureRecognizer:colorModel:)]) {
        [self.delegate CRColorSegmentSelected:rect panGestureRecognizer:pan colorModel:model];
    }
}

#pragma mark - CRValueForPicterViewDelegate
- (void)CRValueForPicterViewColorShowView:(UIView *)colorView longPressGestureRecognizer:(UIPanGestureRecognizer *)pan{

}

- (void)CRValueForPicterViewColorShowView:(UIView *)colorView panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    
    CRSingleColorModel * model = [[CRSingleColorModel alloc]initWithColor:colorView.backgroundColor colorName:@"自定义颜色"];
    
    CGRect rect = [colorView convertRect:colorView.bounds toView:self];
    
    if ([self.delegate respondsToSelector:@selector( CRColorSegmentSelected:panGestureRecognizer:colorModel:)]) {
        [self.delegate CRColorSegmentSelected:rect panGestureRecognizer:pan colorModel:model];
    }
}

@end
