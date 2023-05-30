import Cocoa
import FlutterMacOS

public class MimsdkdemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mimsdkdemo", binaryMessenger: registrar.messenger)
    let instance = MimsdkdemoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":

      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @_silgen_name("GetFriendList") // 将c函数c_add的imp作为被标注的方法的imp
  func swift_GetFriendList()   // 这个swift方法的imp实际上被指向了c函数c_add

}
