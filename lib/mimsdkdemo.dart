
import 'mimsdkdemo_platform_interface.dart';

class Mimsdkdemo {
  Future<String?> getPlatformVersion() {
    return MimsdkdemoPlatform.instance.getPlatformVersion();
  }
}
