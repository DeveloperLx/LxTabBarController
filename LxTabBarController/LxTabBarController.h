//
//  DeveloperLx
//  LxTabBarController.h
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LxTabBarControllerInteractionStopReason) {
    LxTabBarControllerInteractionStopReasonFinished,
    LxTabBarControllerInteractionStopReasonCancelled,
    LxTabBarControllerInteractionStopReasonFailed,
};

#define LxTabBarControllerDidSelectViewControllerNotification   @"LxTabBarControllerDidSelectViewControllerNotification"

@interface LxTabBarController : UITabBarController

@property (nonatomic,assign) BOOL panToSwitchGestureRecognizerEnabled;
@property (nonatomic,assign) BOOL recognizeOtherGestureSimultaneously;
@property (nonatomic,readonly) BOOL isTranslating;
@property (nonatomic,copy) void (^panGestureRecognizerBeginBlock)();
@property (nonatomic,copy) void (^panGestureRecognizerStopBlock)(LxTabBarControllerInteractionStopReason stopReason);

@end
