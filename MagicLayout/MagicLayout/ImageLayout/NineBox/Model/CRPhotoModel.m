//
//  CRPhotoModel.m
//  MagicLayout
//
//  Created by 周文涛 on 16/9/22.
//  Copyright © 2016年 周文涛. All rights reserved.
//

#import "CRPhotoModel.h"


@implementation CRPhotoModel


+ (BOOL)canLibrary{
    
    PHAuthorizationStatus staus = [PHPhotoLibrary authorizationStatus];
    
    if (staus == PHAuthorizationStatusRestricted || staus == PHAuthorizationStatusDenied) {
        
        return NO;
    }
    return YES;
}

+ (NSArray<PHAsset *> *)getAllAssetInPhotoAlbumWithAsceding:(BOOL)ascending{
    
    if (![CRPhotoModel canLibrary]) {
        
        return @[];
    }
    NSMutableArray<PHAsset *> * assets = [[NSMutableArray alloc]init];
    
    PHFetchOptions * option = [[PHFetchOptions alloc]init];
    
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    
    PHFetchResult * result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAsset * asset = (PHAsset *)obj;
        
        //NSLog(@"照片名%@",[asset valueForKey:@"filename"]);
        
        [assets addObject:asset];
        
    }];
    return assets;
}



@end
