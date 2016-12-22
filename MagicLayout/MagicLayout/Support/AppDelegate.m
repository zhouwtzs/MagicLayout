//
//  AppDelegate.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/7.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "AppDelegate.h"

#import "CRNineBoxViewController.h"
#import "CRGuideViewController.h"
#import "CRAdvertisementView.h"
#import "UIImage+CRCategory.h"

#import "CRShareIdenHeader.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>             //QQ
#import <TencentOpenAPI/QQApiInterface.h>           //QQ空间

#import "WXApi.h"                           //微信

#import "WeiboSDK.h"                        //微博


#define USING_AD 0              //是否加载广告页面
#define USING_LOADING 0         //是否加载引导页


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#if USING_AD
    //是否使用广告
    self.advertisementWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.advertisementWindow.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self createAdvertisementViewController];
#endif
#if USING_LOADING
    //是否加载引导页
    [self createGuideView];
    
#endif
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self createRootViewController];
    
    [ShareSDK registerApp:CR_SHARE_AppKey
     
          activePlatforms:@[@(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeSMS)]
     
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType) {
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         
                         default:
                             break;
                     }
                     
                 } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                     
                     switch (platformType) {
                         case SSDKPlatformTypeQQ:
                             
                             [appInfo SSDKSetupQQByAppId:CR_SHARE_QQ_AppID
                                                  appKey:CR_SHARE_QQ_AppKey
                                                authType:SSDKAuthTypeBoth];
                             
                             break;
                        case SSDKPlatformTypeSinaWeibo:
                             
                             [appInfo SSDKSetupSinaWeiboByAppKey:CR_SHARE_WB_AppID
                                                       appSecret:CR_SHARE_QQ_AppKey
                                                     redirectUri:CR_SHARE_WB_RedirectUri
                                                        authType:SSDKAuthTypeBoth];
                             
                             break;
                        case SSDKPlatformTypeWechat:
                             
                             [appInfo SSDKSetupWeChatByAppId:CR_SHARE_WX_AppID
                                                   appSecret:CR_SHARE_WX_AppSecret];
                             
                             break;
                             
                         default:
                             break;
                     }
                     
                 }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - self method
//创建主试图
- (void)createRootViewController{
    
    CRNineBoxViewController * nineBoxVC = [[CRNineBoxViewController alloc]init];
    
    UINavigationController * rootNaviagtion = [[UINavigationController alloc]initWithRootViewController:nineBoxVC];
    
    rootNaviagtion.navigationBar.barTintColor = RGBCOLOR(70, 177, 255);
        
    self.window.rootViewController = rootNaviagtion;
    
}
//创建广告试图
- (void)createAdvertisementViewController{
    
}

//加载引导页
- (void)createGuideView{
    
}

@end
