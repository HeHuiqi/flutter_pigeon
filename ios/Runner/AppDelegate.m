#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "FlutterBridgeApi.h"
#import "FlutterNativeApiImp.h"

@interface AppDelegate ()

@property (nonatomic, strong) FLTFlutterApiInterface *flutterApi;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"window:%@",self.window.rootViewController);
    FlutterViewController *rootVC = (FlutterViewController *)self.window.rootViewController;
    
    //注册Native实现
    FLTNativeApiInterfaceSetup(rootVC.binaryMessenger, [FlutterNativeApiImp new]);
    self.flutterApi = [[FLTFlutterApiInterface alloc] initWithBinaryMessenger:rootVC.binaryMessenger];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];

    //调用fluter方法 必须在主线程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.flutterApi sessionInvalidWithCompletion:^(NSError * _Nullable error) {
            NSLog(@"sessionInvalidWithCompletion==%@",error.localizedDescription);
        }];
    });
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
