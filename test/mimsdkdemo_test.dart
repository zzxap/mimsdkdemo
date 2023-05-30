import 'package:flutter_test/flutter_test.dart';
import 'package:mimsdkdemo/mimsdkdemo.dart';
import 'package:mimsdkdemo/mimsdkdemo_platform_interface.dart';
import 'package:mimsdkdemo/mimsdkdemo_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMimsdkdemoPlatform
    with MockPlatformInterfaceMixin
    implements MimsdkdemoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MimsdkdemoPlatform initialPlatform = MimsdkdemoPlatform.instance;

  test('$MethodChannelMimsdkdemo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMimsdkdemo>());
  });

  test('getPlatformVersion', () async {
    Mimsdkdemo mimsdkdemoPlugin = Mimsdkdemo();
    MockMimsdkdemoPlatform fakePlatform = MockMimsdkdemoPlatform();
    MimsdkdemoPlatform.instance = fakePlatform;

    expect(await mimsdkdemoPlugin.getPlatformVersion(), '42');
  });
}
