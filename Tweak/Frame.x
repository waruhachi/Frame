#import "Frame.h"

// %hook UIStatusBar_Modern

// - (void)setFrame:(CGRect)frame {
//     if (enabled) {
//         if (frameX > 0) {
//             frame.origin.x = frameX;
//         }
//         if (frameY > 0) {
//             frame.origin.y = frameY;
//         }
//         if (frameWidth > 0) {
//             frame.size.width = frameWidth;
//         }
//         if (frameHeight > 0) {
//             frame.size.height = frameHeight;
//         }
//     }

//     %orig(frame);
// }

// %end

%hook _UIStatusBar

- (void)setFrame:(CGRect)frame {
    if (enabled) {
        if (frameX != 0) {
            frame.origin.x = frameX;
        }
        if (frameY != 0) {
            frame.origin.y = frameY;
        }
        if (frameWidth != 0) {
            frame.size.width = frameWidth;
        }
        if (frameHeight != 0) {
            frame.size.height = frameHeight;
        }
    }

    %orig(frame);
}

%end

%ctor {
    preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];

    enabled = [preferences objectForKey:@"enabled"] ? [preferences boolForKey:@"enabled"] : NO;

    NSString *frameXString = [preferences objectForKey:@"frameX"] ? [preferences stringForKey:@"frameX"] : @"";
    NSString *frameYString = [preferences objectForKey:@"frameY"] ? [preferences stringForKey:@"frameY"] : @"";
    NSString *frameWidthString = [preferences objectForKey:@"frameWidth"] ? [preferences stringForKey:@"frameWidth"] : @"";
    NSString *frameHeightString = [preferences objectForKey:@"frameHeight"] ? [preferences stringForKey:@"frameHeight"] : @"";

    frameX = [frameXString floatValue];
    frameY = [frameYString floatValue];
    frameWidth = [frameWidthString floatValue];
    frameHeight = [frameHeightString floatValue];
}
