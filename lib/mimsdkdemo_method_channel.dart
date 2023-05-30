import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mimsdkdemo_platform_interface.dart';
import 'sdkBusiness.dart';
/// An implementation of [MimsdkdemoPlatform] that uses method channels.
class MethodChannelMimsdkdemo extends MimsdkdemoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mimsdkdemo');

  @override
  Future<String?> getPlatformVersion() async {
    //在这里调用ffi
   initSdk();
   getVerify("13699881000");
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
