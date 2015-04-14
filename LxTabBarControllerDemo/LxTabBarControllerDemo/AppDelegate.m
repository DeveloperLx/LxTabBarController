//
//  DeveloperLx
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LxTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController * vc1 = [[ViewController alloc]init];
    vc1.title = @"vc1";
    UINavigationController * nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    ViewController * vc2 = [[ViewController alloc]init];
    vc2.title = @"vc2";
    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    ViewController * vc3 = [[ViewController alloc]init];
    vc3.title = @"vc3";
    UINavigationController * nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    ViewController * vc4 = [[ViewController alloc]init];
    vc4.title = @"vc4";
    UINavigationController * nc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    LxTabBarController * tabBarController = [[LxTabBarController alloc]init];
    tabBarController.viewControllers = @[nc1,nc2,nc3,nc4];
    self.window.rootViewController = tabBarController;
    
    return YES;
}

@end
