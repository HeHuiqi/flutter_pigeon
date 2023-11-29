// Autogenerated from Pigeon (v1.0.19), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "FlutterBridgeApi.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}



@interface FLTNativeApiInterfaceCodecReader : FlutterStandardReader
@end
@implementation FLTNativeApiInterfaceCodecReader
@end

@interface FLTNativeApiInterfaceCodecWriter : FlutterStandardWriter
@end
@implementation FLTNativeApiInterfaceCodecWriter
@end

@interface FLTNativeApiInterfaceCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTNativeApiInterfaceCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTNativeApiInterfaceCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTNativeApiInterfaceCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTNativeApiInterfaceGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTNativeApiInterfaceCodecReaderWriter *readerWriter = [[FLTNativeApiInterfaceCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void FLTNativeApiInterfaceSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTNativeApiInterface> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.NativeApiInterface.getPlatformVersion"
        binaryMessenger:binaryMessenger
        codec:FLTNativeApiInterfaceGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getPlatformVersionWithError:)], @"FLTNativeApiInterface api (%@) doesn't respond to @selector(getPlatformVersionWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSString *output = [api getPlatformVersionWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface FLTFlutterApiInterfaceCodecReader : FlutterStandardReader
@end
@implementation FLTFlutterApiInterfaceCodecReader
@end

@interface FLTFlutterApiInterfaceCodecWriter : FlutterStandardWriter
@end
@implementation FLTFlutterApiInterfaceCodecWriter
@end

@interface FLTFlutterApiInterfaceCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTFlutterApiInterfaceCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTFlutterApiInterfaceCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTFlutterApiInterfaceCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTFlutterApiInterfaceGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    FLTFlutterApiInterfaceCodecReaderWriter *readerWriter = [[FLTFlutterApiInterfaceCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface FLTFlutterApiInterface ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation FLTFlutterApiInterface

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)sessionInvalidWithCompletion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.FlutterApiInterface.sessionInvalid"
      binaryMessenger:self.binaryMessenger
      codec:FLTFlutterApiInterfaceGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
@end
