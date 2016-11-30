//
//  CRNineBoxViewController.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRNineBoxViewController.h"

#import "CRSingColorCollectionViewCell.h"
#import "CRPhotoCollectionViewCell.h"

#import "UIImage+CreateWithColor.h"

#define WEAK_COVER      typeof(_translucentCover) __weak weakCover = _translucentCover
#define WEAK_CUSTOM     typeof(_customImageView) __weak weakCustom = _customImageView;


@interface CRNineBoxViewController ()

@property (nonatomic, strong) UIImageView * customImageView;            //显示当前拖拽的view上的图片

@property (nonatomic, strong) UIView * translucentCover;                //半透明遮盖物

@property (nonatomic, weak) UIImageView * resultImageView;              //当前展示选中的九宫格的subbox

@end

@implementation CRNineBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.title = @"魔版";
        
    [self createView];
    
    [self addNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create view
- (void)createView{
    
    CGRect photoCollectRect         =  CGRectMake(0, 64, SCREENWIDTH, 80);
    CGRect segmentRect              =  CGRectMake(0, SCREENHEIGHT-145, SCREENWIDTH, 145);
    CGRect nineBoxRect              =  CGRectMake(SCREENWIDTH*0.1, 144+SCREENWIDTH*0.1, SCREENWIDTH*0.8, SCREENWIDTH*0.8);
    
    //创建图片选择器
    _photoCollect = [[CRPhotoCollectionViewController alloc]init];
    
    [self.view addSubview:_photoCollect.photoCollectionView];
    
    _photoCollect.photoCollectionView.frame = photoCollectRect;
    
    //创建单色图片选择器
    _segment = [[CRNineBoxSegmentControl alloc]initWithFrame:segmentRect];
    
    [self.view addSubview:_segment];
    
    //九宫格
    _nineBoxView = [[CRNineBoxView alloc]initWithFrame:nineBoxRect];
    
    [self.view insertSubview:_nineBoxView belowSubview:_photoCollect.photoCollectionView];
    
    _translucentCover = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    
    _translucentCover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
}

- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleColorLongPress:) name:(NSString *)CRSingColorCollectionViewCellLongPress object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleColorPan:) name:(NSString *)CRSingColorCollectionViewCellPan object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoLongPress:) name:(NSString *)CRPhotoCollectionViewCelllongPress object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoPan:) name:(NSString *)CRPhotoCollectionViewCellPan object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRSingColorCollectionViewCellPan];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRSingColorCollectionViewCellLongPress];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRPhotoCollectionViewCellPan];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRPhotoCollectionViewCelllongPress];
}

#pragma single color notification

- (void)singleColorLongPress:(NSNotification *)notification{
    
    CRSingColorCollectionViewCell * collectionViewCell = (CRSingColorCollectionViewCell *)notification.object;
    
    UILongPressGestureRecognizer * longPress = [notification.userInfo objectForKey:@"GestureRecognizer"];
    
    if (!longPress) {
        
        return;
    }
    /*
     检索当前九宫格是否有空位，如果有空位，那幕对空位进行部位，如果没有空位，谈框进行提示
     */

}

- (void)singleColorPan:(NSNotification *)notification{
    
    CRSingColorCollectionViewCell * collectionViewCell = (CRSingColorCollectionViewCell *)notification.object;
    
    UIPanGestureRecognizer * pan = [notification.userInfo objectForKey:@"GestureRecognizer"];
    
    if (!pan) {
        
        return;
    }
    UIImage * image = [UIImage createImageWithColor:collectionViewCell.contentView.backgroundColor];
    
    CGRect cellColorRect = pan.view.bounds;
    
    cellColorRect.size.height -= 14;        //空出显示文字的laber
    
    [self panAnimationPan:pan image:image customBounds:cellColorRect];
}

- (void)photoLongPress:(NSNotification *)notification{
    
}

- (void)photoPan:(NSNotification *)notification{
    
    CRPhotoCollectionViewCell * collectionViewCell = (CRPhotoCollectionViewCell *)notification.object;
    
    UIPanGestureRecognizer * pan = [notification.userInfo objectForKey:@"GestureRecognizer"];
    
    if (!pan) {
        
        return;
    }
    UIImage * image = collectionViewCell.imageView.image;
    
    [self panAnimationPan:pan image:image customBounds:collectionViewCell.imageView.bounds];
}

#pragma pan animation
- (void)panAnimationPan:(UIPanGestureRecognizer *)pan image:(UIImage *)image customBounds:(CGRect)bounds{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
    
        CGRect toSelfRect = [pan.view convertRect:bounds toView:self.view];
        
        if (!_customImageView) {
            
            _customImageView = [[UIImageView alloc]init];
        }
        _customImageView.frame = toSelfRect;
        
        //UIImage * image = [UIImage createImageWithColor:collectionViewCell.contentView.backgroundColor];
        
        _customImageView.image = image;
        
        [self.view addSubview:_customImageView];
        
        [self showTranslucentCoverAnimated:YES];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [pan translationInView:pan.view];
        
        _customImageView.transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
        //判断手指是否在九宫格之内
        CGPoint pointInNineBox = [pan locationInView:_nineBoxView];
        
        if (CGRectContainsPoint(_nineBoxView.bounds, pointInNineBox)) {
            //判断手指具体在哪一个view
            UIImageView * subBox = [_nineBoxView subViewInNineBoxWithPoint:pointInNineBox];
            
            if (_resultImageView != subBox) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    _resultImageView.alpha = 1.0f;
                }];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    subBox.alpha = 0.62f;
                    
                }completion:^(BOOL finished) {
                    
                    _resultImageView = subBox;
                }];
            }
        }else{
            //不再区域内，设置为空
            [UIView animateWithDuration:0.25 animations:^{
                
                _resultImageView.alpha = 1.0f;
                
            }completion:^(BOOL finished) {
                
                _resultImageView = nil;
            }];
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        [self hidTranslucentCoverAnimated:YES];
        
        if (_resultImageView) {  //添加填充动画
            
            [self fillResultImageView:_resultImageView];
        }else{  //直接移除临时图片
            [_customImageView removeFromSuperview];
            
            _customImageView.transform = CGAffineTransformIdentity;
        }
    }
    
}


#pragma mark - self view animation
- (void)showTranslucentCoverAnimated:(BOOL)animated{

    if (animated) {
        
        _translucentCover.alpha = 0.0f;
        
        WEAK_COVER;
        
        [UIView animateWithDuration:0.15 animations:^{
            weakCover.alpha = 1.0f;
        }];
    }
    [self.view addSubview:_translucentCover];
}

- (void)hidTranslucentCoverAnimated:(BOOL)animated{
    
    if (animated) {
        
        WEAK_COVER;
        
        [UIView animateWithDuration:0.15 animations:^{
            weakCover.alpha = 0;
        }completion:^(BOOL finished) {
            [weakCover removeFromSuperview];
        }];
    }else{
        [_translucentCover removeFromSuperview];
    }
}

- (void)fillResultImageView:(UIImageView *)imageView{
    
    CGRect rect = [self.view convertRect:imageView.bounds fromView:imageView];  //resultimageview 的frame
    
    CGPoint center = [self.view convertPoint:imageView.center fromView:_nineBoxView];
    
    CGRect customRect = _customImageView.frame;
    
    customRect.origin.x += _customImageView.transform.tx;
    
    customRect.origin.y += _customImageView.transform.ty;
    
    _customImageView.frame = customRect;

    _customImageView.transform = CGAffineTransformIdentity;
    
    CGFloat scale = customRect.size.width/customRect.size.height;
    
    if (fabs(scale-1) < 0.05) {
        //fame相同，直接调整
        WEAK_CUSTOM;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            weakCustom.frame = rect;
            
        } completion:^(BOOL finished) {
            
            imageView.image = weakCustom.image;
            
            imageView.alpha = 1.0f;
            
            [weakCustom removeFromSuperview];
        }];
    }else{
        //farme不相同，需要进行适配
        WEAK_CUSTOM;
        CGSize minSize = [self minSizeContrast:rect.size oldSize:customRect.size];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            weakCustom.bounds = CGRectMake(0, 0, minSize.width, minSize.height);
            
            weakCustom.center = center;
                                    
        } completion:^(BOOL finished) {
            
            //_customImageView.layer.bounds = CGRectMake(0, 0, minSize.width, minSize.height);
        }];
    }
}


- (CGSize)minSizeContrast:(CGSize)contrast oldSize:(CGSize)oldSize{
    
    CGSize minSize = oldSize;
    
    CGFloat scale = oldSize.width/oldSize.height;
    
    if (minSize.width < contrast.width) {
        
        minSize.width = contrast.width;
        
        minSize.height = minSize.width/scale;
    }
    if (minSize.height < contrast.height) {
        
        minSize.height = contrast.height;
        
        minSize.width = minSize.height*scale;
    }
    return minSize;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end