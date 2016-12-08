//
//  ViewController.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/7.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+CRCategory.h"


#define isHis() ([UIScreen mainScreen].bounds.size.width <  [UIScreen mainScreen].bounds.size.height)


#define www (isHis()?100:200)


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createImage];
    
    [self test];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark createImage
- (void)createImage{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:imageView];

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.image = [UIImage imageNamed:@"testImage"];
    
    imageView.layer.borderWidth = 2.0f;
    
    imageView.layer.borderColor = [UIColor cyanColor].CGColor;
    
    [self performSelector:@selector(doImageView:) withObject:imageView afterDelay:2];
    
}

- (void)doImageView:(UIImageView *)imageView2{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    [self.view addSubview:imageView];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.image = [UIImage imageNamed:@"testImage"];
    
    imageView.layer.borderWidth = 2.0f;
    
    imageView.layer.borderColor = [UIColor cyanColor].CGColor;

    NSLog(@"%@",NSStringFromCGSize(imageView.image.size));
    
    //imageView.image = image;
    
    CGSize size = imageView.image.size;
    
    CGFloat ff = MIN(size.height, size.width);
    
    
    
}


- (void)test{
    
    //NSLog(@"TestViewController");
    
}


@end
