import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mimsdkdemo/mimsdkdemo_method_channel.dart';

void main() {
  MethodChannelMimsdkdemo platform = MethodChannelMimsdkdemo();
  const MethodChannel channel = MethodChannel('mimsdkdemo');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
