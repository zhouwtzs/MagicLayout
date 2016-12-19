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


@interface CRNineBoxViewController ()<CRPhotoCollectionViewGestureDelegate,CRColorSegmentControlDelegate>

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
    
    _segment.delegate = self;
    
    [self.view addSubview:_segment];
    
    //九宫格
    _nineBoxView = [[CRNineBoxView alloc]initWithFrame:nineBoxRect];
    
    [self.view insertSubview:_nineBoxView belowSubview:_photoCollect.photoCollectionView];
    
    _translucentCover = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64)];
    
    _translucentCover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
}

#pragma mark - CRColorSegmentControlDelegate

- (void)CRColorSegmentSelected:(CGRect)CGRect longPressGestureRecognizer:(UILongPressGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel{

}

- (void)CRColorSegmentSelected:(CGRect)rect panGestureRecognizer:(UIPanGestureRecognizer *)pan colorModel:(CRSingleColorModel *)colorModel{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        CGRect toSelfRect = [_segment convertRect:rect toView:self.view];
        
        if (!_customImageView) {
            
            _customImageView = [[CRNineCustomView alloc]initWithFrame:toSelfRect];
        }
        _customImageView.frame = toSelfRect;
        
        _customImageView.colorInfo = colorModel;
        
        _customImageView.photoInfo = nil;
        
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
            
            [self fillResultImageView:_nineBoxView.resultImageView photoModel:nil];
            
            NSUInteger index = [_nineBoxView indexOfResultImageView];
            
            [_nineBoxView.photoModelDic setObject:colorModel forKey:[NSString stringWithFormat:@"index%d",(int)index]];
            
            CGRect rect = [self.view convertRect:_nineBoxView.resultImageView.bounds fromView:_nineBoxView.resultImageView];  //resultimageview 的frame
            
            [UIView animateWithDuration:0.25 animations:^{
                
                _customImageView.frame = rect;
                
            } completion:^(BOOL finished) {
                
                _nineBoxView.resultImageView.alpha = 1.0f;
                
                _nineBoxView.backgroundColor = colorModel.color;
                
                [_customImageView removeFromSuperview];
                
                _customImageView.transform = CGAffineTransformIdentity;
            }];

        }else{  //直接移除临时图片
            [_customImageView removeFromSuperview];
            
            _customImageView.transform = CGAffineTransformIdentity;
        }
    }

    
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
        
        _customImageView.colorInfo = nil;
        
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

//移除覆盖的半透明view
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

//拖动结束之后，如果当前的customview的size与九宫格的词尺寸不相同，需要进行微调，添加一个动画
- (void)fillResultImageView:(UIImageView *)imageView photoModel:(CRPhotoModel *)photoModel{
    
    
    
    NSUInteger index = [_nineBoxView indexOfResultImageView];
    
    [_nineBoxView.photoModelDic setObject:photoModel forKey:[NSString stringWithFormat:@"index%d",(int)index]];
    
    CGRect rect = [self.view convertRect:imageView.bounds fromView:imageView];  //resultimageview 的frame
    
    UIImage * thumbImage = [UIImage shearCenterImage:_customImageView.infoImageView];
    
    
    //[_nineBoxView.thumbImageDic setObject:thumbImage forKey:[NSString stringWithFormat:@"index%d",(int)index]];
    
    CGRect customRect = _customImageView.frame;
    
    CGFloat scale = customRect.size.width/customRect.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _customImageView.frame = rect;

        if (fabs(scale-1) > 0.05){//size差距过大，需要进行动画
            
            CGSize minSize = [self minSizeContrast:rect.size oldSize:customRect.size];

            _customImageView.infoImageView.bounds = CGRectMake(0, 0, minSize.width, minSize.height);
            
            _customImageView.infoImageView.center = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
        }
        
    } completion:^(BOOL finished) {
        
        imageView.image = thumbImage;
        
        imageView.alpha = 1.0f;
        
        [_customImageView removeFromSuperview];
        
        _customImageView.transform = CGAffineTransformIdentity;
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
