#import "MimsdkdemoPlugin.h"
#import "libMIMSDK_iOS.h"
@implementation MimsdkdemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"mimsdkdemo"
            binaryMessenger:[registrar messenger]];
  MimsdkdemoPlugin* instance = [[MimsdkdemoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {

     //这里可以直接调用libMIMSDK_iOS 里的方法

    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
