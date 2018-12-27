#import "SimpleSharePlugin.h"
#import <simple_share/simple_share-Swift.h>

@implementation SimpleSharePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleSharePlugin registerWithRegistrar:registrar];
}
@end
