#include "Frame.h"

%hook _UIStatusBar

- (void)setFrame:(CGRect)frame {
    if ([[self _statusBarWindowForAccessibilityHUD] isKindOfClass:%c(SBControlCenterWindow)]) return %orig(frame);

    if (frameXEnabled) frame.origin.x = frameX;
    if (frameYEnabled) frame.origin.y = frameY;
    if (frameWidthEnabled) frame.size.width = frameWidth;
    if (frameHeightEnabled) frame.size.height = frameHeight;

    return %orig(frame);
}

%end


%ctor {
    preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];

    frameXEnabled = [preferences objectForKey:@"frameXEnabled"] ? [preferences boolForKey:@"frameXEnabled"] : NO;
    frameYEnabled = [preferences objectForKey:@"frameYEnabled"] ? [preferences boolForKey:@"frameYEnabled"] : NO;
    frameWidthEnabled = [preferences objectForKey:@"frameWidthEnabled"] ? [preferences boolForKey:@"frameWidthEnabled"] : NO;
    frameHeightEnabled = [preferences objectForKey:@"frameHeightEnabled"] ? [preferences boolForKey:@"frameHeightEnabled"] : NO;

    NSString *frameXString = [preferences objectForKey:@"frameX"] ? [preferences stringForKey:@"frameX"] : @"";
    NSString *frameYString = [preferences objectForKey:@"frameY"] ? [preferences stringForKey:@"frameY"] : @"";
    NSString *frameWidthString = [preferences objectForKey:@"frameWidth"] ? [preferences stringForKey:@"frameWidth"] : @"";
    NSString *frameHeightString = [preferences objectForKey:@"frameHeight"] ? [preferences stringForKey:@"frameHeight"] : @"";

    frameX = [frameXString floatValue];
    frameY = [frameYString floatValue];
    frameWidth = [frameWidthString floatValue];
    frameHeight = [frameHeightString floatValue];
}
