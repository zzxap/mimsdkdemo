import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mimsdkdemo_method_channel.dart';

abstract class MimsdkdemoPlatform extends PlatformInterface {
  /// Constructs a MimsdkdemoPlatform.
  MimsdkdemoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MimsdkdemoPlatform _instance = MethodChannelMimsdkdemo();

  /// The default instance of [MimsdkdemoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMimsdkdemo].
  static MimsdkdemoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MimsdkdemoPlatform] when
  /// they register themselves.
  static set instance(MimsdkdemoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
