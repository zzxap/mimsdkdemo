//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <mimsdkdemo/mimsdkdemo_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) mimsdkdemo_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MimsdkdemoPlugin");
  mimsdkdemo_plugin_register_with_registrar(mimsdkdemo_registrar);
}
