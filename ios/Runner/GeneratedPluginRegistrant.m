//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<camcode/CamcodePlugin.h>)
#import <camcode/CamcodePlugin.h>
#else
@import camcode;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<hexcolor/HexcolorPlugin.h>)
#import <hexcolor/HexcolorPlugin.h>
#else
@import hexcolor;
#endif

#if __has_include(<open_file/OpenFilePlugin.h>)
#import <open_file/OpenFilePlugin.h>
#else
@import open_file;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

#if __has_include(<printing/PrintingPlugin.h>)
#import <printing/PrintingPlugin.h>
#else
@import printing;
#endif

#if __has_include(<shared_preferences_ios/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences_ios/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [CamcodePlugin registerWithRegistrar:[registry registrarForPlugin:@"CamcodePlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [HexcolorPlugin registerWithRegistrar:[registry registrarForPlugin:@"HexcolorPlugin"]];
  [OpenFilePlugin registerWithRegistrar:[registry registrarForPlugin:@"OpenFilePlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PrintingPlugin registerWithRegistrar:[registry registrarForPlugin:@"PrintingPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
