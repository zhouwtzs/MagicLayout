//
//  CRDynamicShareManager.m
//  MagicLayout
//
//  Created by 周文涛 on 2016/12/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRDynamicShareManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation CRDynamicShareManager

+ (instancetype)DynamicShareImages:(NSArray *)images text:(NSString *)test location:(NSString *)location{
    
    CRDynamicShareManager * shareManager = [[CRDynamicShareManager alloc]init];
    
    NSMutableDictionary * ShareParams = [NSMutableDictionary dictionary];

    
    
//    [ShareParams SSDKSetupWeChatParamsByText:@"这是一个简单的小测试"
//                                       title:@"测试"
//                                         url:nil
//                                  thumbImage:[images firstObject]
//                                       image:images
//                                musicFileURL:nil
//                                     extInfo:nil
//                                    fileData:nil
//                                emoticonData:nil
//                                        type:SSDKContentTypeAuto
//                          forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
//    
    
    
    
    [ShareParams SSDKSetupShareParamsByText:@"这是一个简单的小测试"
                                     images:images
                                        url:nil
                                      title:@"测试"
                                       type:SSDKContentTypeAuto];
    
  
    
    
    
    
    [ShareSDK share:SSDKPlatformSubTypeQZone
         parameters:ShareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }

     }];
    
    
    
    return shareManager;
}

@end
