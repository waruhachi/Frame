#include "FrameRootListController.h"

@implementation FrameRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self visibleSpecifiersFromPlist:@"Root"];
	}

	return _specifiers;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	[super setPreferenceValue:value specifier:specifier];
	[self reloadSpecifiers];
}

- (NSMutableArray *)visibleSpecifiersFromPlist:(NSString *)plist {
    NSUserDefaults *preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];
	NSMutableArray *specifiers = [[self loadSpecifiersFromPlistName:plist target:self] mutableCopy];

	for (PSSpecifier *specifier in [specifiers reverseObjectEnumerator]) {
		NSString *dependency = [specifier propertyForKey:@"dependsOn"];
		if (dependency) {
			if ([dependency containsString:@"*"]) {
				NSArray *dependencies = [dependency componentsSeparatedByString:@"*"];
				BOOL allDependenciesMet = YES;
				for (NSString *dep in dependencies) {
					if (![[preferences stringForKey:dep] boolValue]) {
						allDependenciesMet = NO;
						break;
					}
				}
				if (!allDependenciesMet) {
					[specifiers removeObject:specifier];
				}
			} else {
				if ([dependency containsString:@"!"]) {
					dependency = [dependency stringByReplacingOccurrencesOfString:@"!" withString:@""];
					if ([[preferences stringForKey:dependency] boolValue]) {
						[specifiers removeObject:specifier];
					}
				} else {
					if (![[preferences stringForKey:dependency] boolValue]) {
						[specifiers removeObject:specifier];
					}
				}
			}
		}
	}

	return specifiers;
}

- (void)respring {
    #if TARGET_OS_SIMULATOR
        return;
    #else
        pid_t pid;

        const char *args[] = { "killall", "SpringBoard", NULL };
        posix_spawn(&pid, jbroot("/usr/bin/killall"), NULL, NULL, (char *const *)args, NULL);
    #endif
}

@end
