#include <spawn.h>
#include <roothide.h>
#include <UIKit/UIKit.h>
#include <Preferences/PSSpecifier.h>
#include <Preferences/PSListController.h>

@interface FrameRootListController : PSListController
    - (NSMutableArray *)visibleSpecifiersFromPlist:(NSString *)plist;
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end
