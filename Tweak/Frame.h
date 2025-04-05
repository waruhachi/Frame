#include <UIKit/UIKit.h>

@interface _UIStatusBar : UIView
    - (id)_statusBarWindowForAccessibilityHUD;
@end

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

static BOOL frameXEnabled;
static BOOL frameYEnabled;
static BOOL frameWidthEnabled;
static BOOL frameHeightEnabled;

static CGFloat frameX;
static CGFloat frameY;
static CGFloat frameWidth;
static CGFloat frameHeight;

static NSUserDefaults *preferences;
