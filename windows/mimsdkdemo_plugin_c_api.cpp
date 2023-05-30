#include "include/mimsdkdemo/mimsdkdemo_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "mimsdkdemo_plugin.h"

void MimsdkdemoPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  mimsdkdemo::MimsdkdemoPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
