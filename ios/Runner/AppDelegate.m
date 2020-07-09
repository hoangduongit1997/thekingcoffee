#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    NSString* mapsApiKey = [[NSProcessInfo processInfo] environment][@"AIzaSyATVtP8PADrLH2PMCFHKof0zklDPDD7UEI"];
  if ([mapsApiKey length] == 0) {
    mapsApiKey = @"AIzaSyATVtP8PADrLH2PMCFHKof0zklDPDD7UEI";
  }
  [GMSServices provideAPIKey:mapsApiKey];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
