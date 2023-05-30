#ifndef FLUTTER_PLUGIN_MIMSDKDEMO_PLUGIN_H_
#define FLUTTER_PLUGIN_MIMSDKDEMO_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace mimsdkdemo {

class MimsdkdemoPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  MimsdkdemoPlugin();

  virtual ~MimsdkdemoPlugin();

  // Disallow copy and assign.
  MimsdkdemoPlugin(const MimsdkdemoPlugin&) = delete;
  MimsdkdemoPlugin& operator=(const MimsdkdemoPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace mimsdkdemo

#endif  // FLUTTER_PLUGIN_MIMSDKDEMO_PLUGIN_H_
