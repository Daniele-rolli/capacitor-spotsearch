#import <Capacitor/Capacitor.h>

CAP_PLUGIN(SpotSearch, "SpotSearch",
  CAP_PLUGIN_METHOD(enableIndexing, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(indexItems, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(deleteItems, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(deleteDomain, CAPPluginReturnPromise);
)
