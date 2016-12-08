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
#import "CRNineCustomView.h"

#import "UIImage+CRCategory.h"


@interface CRNineBoxViewController ()<CRPhotoCollectionViewGestureDelegate>

@property (nonatomic, strong) CRNineCustomView * customImageView;       //显示当前拖拽的view上的图片

@property (nonatomic, strong) UIView * translucentCover;                //半透明遮盖物

@end

@implementation CRNineBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.title = @"魔版";
    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 200, 200)];
//    
//    imageView.backgroundColor = [UIColor redColor];
//    
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    UIImage * image = [UIImage imageNamed:@"test.jpg"];
//    
//    //imageView.image = image;
//    
//    //imageView.image = [UIImage compressImage:image withScale:0.8] ;
//    
//    imageView.image = [UIImage shearImage:image withFrame:CGRectMake(50, 50, 50, 50)];
//    
//    [self.view addSubview:imageView];
    
    [self createView];

    [self addNotification];
    
}

- (void)pressBtn:(UIButton *)btn{
    
    
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
    
    _photoCollect.delegate = self;
    
    [self.view addSubview:_photoCollect.photoCollectionView];
    
    _photoCollect.photoCollectionView.frame = photoCollectRect;
    
    //创建单色图片选择器
    _segment = [[CRNineBoxSegmentControl alloc]initWithFrame:segmentRect];
    
    [self.view addSubview:_segment];
    
    //九宫格
    _nineBoxView = [[CRNineBoxView alloc]initWithFrame:nineBoxRect];
    
    [self.view insertSubview:_nineBoxView belowSubview:_photoCollect.photoCollectionView];
    
    _translucentCover = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    
    _translucentCover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
}

- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleColorLongPress:) name:(NSString *)CRSingColorCollectionViewCellLongPress object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(singleColorPan:) name:(NSString *)CRSingColorCollectionViewCellPan object:nil];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRSingColorCollectionViewCellPan];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:(NSString *)CRSingColorCollectionViewCellLongPress];
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

#pragma mark - CRPhotoCollectionViewGestureDelegate
- (void)CRPhotoCollectionViewCell:(CRPhotoCollectionViewCell *)collectionViewCell longPressGestureRecognizer:(UILongPressGestureRecognizer *)pan photoModel:(CRPhotoModel *)photoModel{
    
    
}

- (void)CRPhotoCollectionViewCell:(CRPhotoCollectionViewCell *)collectionViewCell panGestureRecognizer:(UIPanGestureRecognizer *)pan photoModel:(CRPhotoModel *)photoModel{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        CGRect toSelfRect = [pan.view convertRect:collectionViewCell.bounds toView:self.view];
        
        if (!_customImageView) {
            
            _customImageView = [[CRNineCustomView alloc]initWithFrame:toSelfRect];
        }
        _customImageView.frame = toSelfRect;
        
        _customImageView.color = nil;
        
        _customImageView.photoInfo = photoModel;
                
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
            
            if (_nineBoxView.resultImageView != subBox) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    _nineBoxView.resultImageView.alpha = 1.0f;
                }];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    subBox.alpha = 0.62f;
                    
                    _nineBoxView.resultImageView = subBox;

                }completion:nil];
            }
        }else{
            //不再区域内，设置为空
            [UIView animateWithDuration:0.25 animations:^{
                
                _nineBoxView.resultImageView.alpha = 1.0f;
                
                _nineBoxView.resultImageView = nil;
            }completion:nil];
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        [self hidTranslucentCoverAnimated:YES];
        
        if (_nineBoxView.resultImageView) {  //添加填充动画
            
            [self fillResultImageView:_nineBoxView.resultImageView photoModel:_customImageView.photoInfo];
        }else{  //直接移除临时图片
            [_customImageView removeFromSuperview];
            
            _customImageView.transform = CGAffineTransformIdentity;
        }
    }

}

#pragma pan animation
- (void)panAnimationPan:(UIPanGestureRecognizer *)pan image:(UIImage *)image customBounds:(CGRect)bounds{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
    
        CGRect toSelfRect = [pan.view convertRect:bounds toView:self.view];
        
        if (!_customImageView) {
            
            _customImageView = [[CRNineCustomView alloc]initWithFrame:toSelfRect];
        }
        _customImageView.frame = toSelfRect;
        
        _customImageView.color = nil;
        
        _customImageView.photoInfo.fitImage = image;
        
        //_customImageView.phot
        
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
            
            if (_nineBoxView.resultImageView != subBox) {
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    _nineBoxView.resultImageView.alpha = 1.0f;
                }];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    subBox.alpha = 0.62f;
                    
                }completion:^(BOOL finished) {
                    
                    _nineBoxView.resultImageView = subBox;
                }];
            }
        }else{
            //不再区域内，设置为空
            [UIView animateWithDuration:0.25 animations:^{
                
                _nineBoxView.resultImageView.alpha = 1.0f;
                
            }completion:^(BOOL finished) {
                
                _nineBoxView.resultImageView = nil;
            }];
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        [self hidTranslucentCoverAnimated:YES];
        
        if (_nineBoxView.resultImageView) {  //添加填充动画
            
            [self fillResultImageView:_nineBoxView.resultImageView photoModel:_customImageView.photoInfo];
        }else{  //直接移除临时图片
            [_customImageView removeFromSuperview];
            
            _customImageView.transform = CGAffineTransformIdentity;
        }
    }
    
}


#pragma mark - self view animation
//上层覆盖一个半透明的view，引起视觉差
- (void)showTranslucentCoverAnimated:(BOOL)animated{

    if (animated) {
        
        _translucentCover.alpha = 0.0f;
        
        [UIView animateWithDuration:0.15 animations:^{
            
            _translucentCover.alpha = 1.0f;
        }];
    }
    [self.view addSubview:_translucentCover];
}

- (void)hidTranslucentCoverAnimated:(BOOL)animated{
    
    if (animated) {
        
        [UIView animateWithDuration:0.15 animations:^{
            
            _translucentCover.alpha = 0;
            
        }completion:^(BOOL finished) {
            
            [_translucentCover removeFromSuperview];
        }];
    }else{
        [_translucentCover removeFromSuperview];
    }
}

- (void)fillResultImageView:(UIImageView *)imageView photoModel:(CRPhotoModel *)photoModel{
    
    NSUInteger index = [_nineBoxView indexOfResultImageView];
    
    [_nineBoxView.photoModelDic setObject:photoModel forKey:[NSString stringWithFormat:@"index%d",(int)index]];
    
    CGRect rect = [self.view convertRect:imageView.bounds fromView:imageView];  //resultimageview 的frame
    UIImage * thumbImage = [UIImage shearImage:photoModel.fitImage withFrame:rect];
    
    
    //[_nineBoxView.thumbImageDic setObject:thumbImage forKey:[NSString stringWithFormat:@"index%d",(int)index]];
    
    CGRect customRect = _customImageView.frame;
    
    customRect.origin.x += _customImageView.transform.tx;
    
    customRect.origin.y += _customImageView.transform.ty;
    
    CGFloat scale = customRect.size.width/customRect.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _customImageView.frame = rect;

        if (fabs(scale-1) < 0.05){
            
            CGSize minSize = [self minSizeContrast:rect.size oldSize:customRect.size];

            _customImageView.infoImageView.bounds = CGRectMake(0, 0, minSize.width, minSize.height);
            
            _customImageView.infoImageView.center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
        }
        
    } completion:^(BOOL finished) {
        
        imageView.image = thumbImage;
        
        imageView.alpha = 1.0f;
        
        [_customImageView removeFromSuperview];
        
    }];
}


//为了能更好的填充视图，需要判断视图最小是多大
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
