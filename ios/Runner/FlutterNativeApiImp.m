//
//  FlutterNativeApiImp.m
//  Runner
//
//  Created by hbwb25942 on 2023/11/28.
//

#import "FlutterNativeApiImp.h"
#import <UIKit/UIKit.h>
@implementation FlutterNativeApiImp

// 实现接口
- (NSString *)getPlatformVersionWithError:(FlutterError * _Nullable __autoreleasing *)error {
    
    NSString *result = [NSString stringWithFormat: @"iOS %@",UIDevice.currentDevice.systemVersion];
    
    return result;

}

@end
