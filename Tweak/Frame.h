#import <UIKit/UIKit.h>

@interface _UIStatusBar : UIView
    - (void)updateFrame;
@end

@interface UIStatusBar_Modern : UIView
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

static BOOL enabled = YES;

static CGFloat frameX;
static CGFloat frameY;
static CGFloat frameWidth;
static CGFloat frameHeight;

static CGFloat originalFrameX;
static CGFloat originalFrameY;
static CGFloat originalFrameWidth;
static CGFloat originalFrameHeight;

static NSUserDefaults *preferences;
