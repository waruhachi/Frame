#import "Frame.h"

static void loadPreferences(void) {
    preferences = [[NSUserDefaults alloc] initWithSuiteName:@"moe.waru.frame.preferences"];

    enabled = [preferences objectForKey:@"enabled"] ? [preferences boolForKey:@"enabled"] : YES;

    frameX = [preferences objectForKey:@"frameX"] ? [preferences floatForKey:@"frameX"] : 0.0;
    frameY = [preferences objectForKey:@"frameY"] ? [preferences floatForKey:@"frameY"] : 0.0;
    frameWidth = [preferences objectForKey:@"frameWidth"] ? [preferences floatForKey:@"frameWidth"] : 0.0;
    frameHeight = [preferences objectForKey:@"frameHeight"] ? [preferences floatForKey:@"frameHeight"] : 0.0;

    originalFrameX = [preferences objectForKey:@"originalFrameX"] ? [preferences floatForKey:@"originalFrameX"] : 0.0;
    originalFrameY = [preferences objectForKey:@"originalFrameY"] ? [preferences floatForKey:@"originalFrameY"] : 0.0;
    originalFrameWidth = [preferences objectForKey:@"originalFrameWidth"] ? [preferences floatForKey:@"originalFrameWidth"] : 0.0;
    originalFrameHeight = [preferences objectForKey:@"originalFrameHeight"] ? [preferences floatForKey:@"originalFrameHeight"] : 0.0;
}

%hook UIStatusBar_Modern

%new

- (void)updateFrame {
    loadPreferences();

    self.frame = self.frame;

    [self layoutIfNeeded];
}

- (void)viewDidLoad {
    %orig;

    [preferences setFloat:self.frame.origin.x forKey:@"originalFrameX"];
    [preferences setFloat:self.frame.origin.y forKey:@"originalFrameY"];
    [preferences setFloat:self.frame.size.width forKey:@"originalFrameWidth"];
    [preferences setFloat:self.frame.size.height forKey:@"originalFrameHeight"];
    [preferences synchronize];
}

- (void)didMoveToWindow {
    %orig;

    [NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateFrame) name:@"moe.waru.frame.preferences.reload" object: nil];
}

- (void)setFrame:(CGRect)frame {
    loadPreferences();

    if (enabled) {
        frame.origin.x = (originalFrameX + frameX);
        frame.origin.y = (originalFrameY + frameY);
        frame.size.width = (originalFrameWidth + frameWidth);
        frame.size.height = (originalFrameHeight + frameHeight);
    } else {
        frame.origin.x = originalFrameX;
        frame.origin.y = originalFrameY;
        frame.size.width = originalFrameWidth;
        frame.size.height = originalFrameHeight;
    }

    %orig(frame);
}

%end

%hook _UIStatusBar

%new

- (void)updateFrame {
    loadPreferences();

    self.frame = self.frame;

    [self layoutIfNeeded];
}

- (void)didMoveToWindow {
    %orig;

    [NSDistributedNotificationCenter.defaultCenter addObserver:self selector:@selector(updateFrame) name:@"moe.waru.frame.preferences.reload" object: nil];
}

- (void)setFrame:(CGRect)frame {
    loadPreferences();

    if (enabled) {
        frame.origin.x = (originalFrameX + frameX);
        frame.origin.y = (originalFrameY + frameY);
        frame.size.width = (originalFrameWidth + frameWidth);
        frame.size.height = (originalFrameHeight + frameHeight);
    } else {
        frame.origin.x = originalFrameX;
        frame.origin.y = originalFrameY;
        frame.size.width = originalFrameWidth;
        frame.size.height = originalFrameHeight;
    }

    %orig(frame);
}

%end

%ctor {
    loadPreferences();
}
