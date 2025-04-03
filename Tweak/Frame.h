#import <UIKit/UIKit.h>

@interface _UIStatusBar : UIView
@end

// @interface UIStatusBar_Modern : UIView
// @end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

static BOOL enabled;

static CGFloat frameX;
static CGFloat frameY;
static CGFloat frameWidth;
static CGFloat frameHeight;

static NSUserDefaults *preferences;
