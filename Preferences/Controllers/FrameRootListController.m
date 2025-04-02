#include "FrameRootListController.h"

@implementation FrameRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    NSUserDefaults *preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];
    [preferences setObject:value forKey:specifier.properties[@"key"]];

    [super setPreferenceValue:value specifier:specifier];

    [NSDistributedNotificationCenter.defaultCenter postNotificationName:@"moe.waru.frame.preferences.reload" object:nil];

}

- (void)reset {
    NSUserDefaults *preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];

    [preferences setFloat:0.0 forKey:@"frameX"];
    [preferences setFloat:0.0 forKey:@"frameY"];
    [preferences setFloat:0.0 forKey:@"frameWidth"];
    [preferences setFloat:0.0 forKey:@"frameHeight"];
    [preferences synchronize];

    [self reloadSpecifiers];

    [NSDistributedNotificationCenter.defaultCenter postNotificationName:@"moe.waru.frame.preferences.reload" object:nil];
}
@end
