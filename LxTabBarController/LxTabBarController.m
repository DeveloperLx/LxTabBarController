//
//  DeveloperLx
//  LxTabBarController.m
//

#import "LxTabBarController.h"

typedef NS_ENUM(NSInteger, LxTabBarControllerSwitchType) {
    LxTabBarControllerSwitchTypeUnknown,
    LxTabBarControllerSwitchTypeLast,
    LxTabBarControllerSwitchTypeNext,
};

static CGFloat const TRANSITION_DURATION = 0.2;
static LxTabBarControllerSwitchType _switchType = LxTabBarControllerSwitchTypeUnknown;

@interface Transition : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation Transition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return TRANSITION_DURATION;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [transitionContext.containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    CGRect fromViewControllerViewFrame = fromViewController.view.frame;
    CGRect toViewControllerViewFrame = toViewController.view.frame;
    
    switch (_switchType) {
        case LxTabBarControllerSwitchTypeLast:
        {
            toViewControllerViewFrame.origin.x = -toViewControllerViewFrame.size.width;
            fromViewControllerViewFrame.origin.x = fromViewController.view.frame.size.width;
        }
            break;
        case LxTabBarControllerSwitchTypeNext:
        {
            toViewControllerViewFrame.origin.x = toViewControllerViewFrame.size.width;
            fromViewControllerViewFrame.origin.x = -fromViewController.view.frame.size.width;
        }
            break;
        case LxTabBarControllerSwitchTypeUnknown:
        {
            return;
        }
            break;
        default:
            break;
    }
    
    toViewController.view.frame = toViewControllerViewFrame;
    [UIView animateWithDuration:TRANSITION_DURATION animations:^{
        fromViewController.view.frame = fromViewControllerViewFrame;
        toViewController.view.frame = transitionContext.containerView.bounds;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end

#pragma mark - LxTabBarController

@interface LxTabBarController () <UITabBarControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation LxTabBarController
{
    UIPanGestureRecognizer * _panToSwitchGestureRecognizer;
    UIPercentDrivenInteractiveTransition * _interactiveTransition;
}
@synthesize isTranslating = _isTranslating;

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.delegate = self;
    
    _panToSwitchGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizerTriggerd:)];
    _panToSwitchGestureRecognizer.delegate = self;
    _panToSwitchGestureRecognizer.cancelsTouchesInView = NO;
    _panToSwitchGestureRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_panToSwitchGestureRecognizer];
}

- (void)setPanToSwitchGestureRecognizerEnabled:(BOOL)panToSwitchGestureRecognizerEnabled
{
    _panToSwitchGestureRecognizer.enabled = panToSwitchGestureRecognizerEnabled;
}

- (BOOL)panToSwitchGestureRecognizerEnabled
{
    return _panToSwitchGestureRecognizer.enabled;
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return [animationController isKindOfClass:[Transition class]]?_interactiveTransition:nil;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC
{
    return [[Transition alloc]init];
}

- (void)panGestureRecognizerTriggerd:(UIPanGestureRecognizer *)pan
{
    CGFloat progress = [pan translationInView:pan.view].x / pan.view.bounds.size.width;
    
    if (progress > 0) {
        _switchType = LxTabBarControllerSwitchTypeLast;
    }
    else if (progress < 0) {
        _switchType = LxTabBarControllerSwitchTypeNext;
    }
    else {
        _switchType = LxTabBarControllerSwitchTypeUnknown;
    }
    
    progress = MIN(1.0, MAX(0.0, fabs(progress)));
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isTranslating = YES;
            _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            switch (_switchType) {
                case LxTabBarControllerSwitchTypeLast:
                {
                    self.selectedIndex = MAX(0, self.selectedIndex - 1);
                    self.selectedViewController = self.viewControllers[self.selectedIndex];
                    if (self.panGestureRecognizerBeginBlock) {
                        self.panGestureRecognizerBeginBlock();
                    }
                }
                    break;
                case LxTabBarControllerSwitchTypeNext:
                {
                    self.selectedIndex = MIN(self.viewControllers.count, self.selectedIndex + 1);
                    self.selectedViewController = self.viewControllers[self.selectedIndex];
                    if (self.panGestureRecognizerBeginBlock) {
                        self.panGestureRecognizerBeginBlock();
                    }
                }
                    break;
                case LxTabBarControllerSwitchTypeUnknown:
                {
                
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [_interactiveTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateFailed:
        {
            _isTranslating = NO;
            if (self.panGestureRecognizerBeginBlock) {
                self.panGestureRecognizerBeginBlock(LxTabBarControllerInteractionStopReasonFailed);
            }
        }
            break;
        default:
        {
            if (fabs(progress) > 0.5) {
                [_interactiveTransition finishInteractiveTransition];
                if (self.panGestureRecognizerBeginBlock) {
                    self.panGestureRecognizerBeginBlock(LxTabBarControllerInteractionStopReasonFinished);
                }
            }
            else {
                [_interactiveTransition cancelInteractiveTransition];
                if (self.panGestureRecognizerBeginBlock) {
                    self.panGestureRecognizerBeginBlock(LxTabBarControllerInteractionStopReasonCancelled);
                }
            }
            _interactiveTransition = nil;
            _isTranslating = NO;
        }
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panToSwitchGestureRecognizer) {
        return !self.isTranslating; //
    }
    else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == _panToSwitchGestureRecognizer || otherGestureRecognizer == _panToSwitchGestureRecognizer) {
        return self.recognizeOtherGestureSimultaneously;
    }
    else {
        return NO;
    }
}

- (BOOL)isTranslating
{
    return _isTranslating;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger viewControllerIndex = [tabBarController.viewControllers indexOfObject:viewController];
    if (viewControllerIndex > self.selectedIndex) {
        _switchType = LxTabBarControllerSwitchTypeNext;
    }
    else if (viewControllerIndex < self.selectedIndex) {
        _switchType = LxTabBarControllerSwitchTypeLast;
    }
    else {
        _switchType = LxTabBarControllerSwitchTypeUnknown;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [[NSNotificationCenter defaultCenter]postNotificationName:LxTabBarControllerDidSelectViewControllerNotification object:viewController];
}

@end
