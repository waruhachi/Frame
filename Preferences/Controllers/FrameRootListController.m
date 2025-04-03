#include "FrameRootListController.h"

@implementation FrameRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

// - (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
//     [super setPreferenceValue:value specifier:specifier];

//     [NSDistributedNotificationCenter.defaultCenter postNotificationName:@"moe.waru.frame.preferences.reload" object:nil];
// }

- (void)respring {
    pid_t pid;

    const char *args[] = { "killall", "SpringBoard", NULL };
    posix_spawn(&pid, jbroot("/usr/bin/killall"), NULL, NULL, (char *const *)args, NULL);
}

@end
