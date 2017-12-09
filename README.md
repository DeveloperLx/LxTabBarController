# LxTabBarController
	Inherited from UITabBarController. To change UITabBarController interactive mode, LxTabBarController add a powerful gesture that you can switch view controller by sweeping screen from left to right or right to left.
	
*	![demo](demo.gif)


Installation
------------
    You only need drag LxTabBarController.h and LxTabBarController.m to your project.
Podfile
------------
    pod 'LxTabBarController', '~> 1.0.0'
    
Support
------------
    Minimum support iOS version: iOS 7.0

Usage
----------
`Use LxTabBarController as same as UITabBarController.`

```objc
    ViewController * vc1 = [[ViewController alloc]init];
    UINavigationController * nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    ViewController * vc2 = [[ViewController alloc]init];
    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    ViewController * vc3 = [[ViewController alloc]init];
    UINavigationController * nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    ViewController * vc4 = [[ViewController alloc]init];
    UINavigationController * nc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    LxTabBarController * tabBarController = [[LxTabBarController alloc]init];
    tabBarController.viewControllers = @[nc1,nc2,nc3,nc4];
```
BE CAREFUL!
-----------

	The gesture for switching tab has risk to cause conflict to other gestures, you can set tabBarController.panToSwitchGestureRecognizerEnabled = NO to forbid it.
    
License
-----------
    LxTabBarController is available under the Apache License 2.0. See the LICENSE file for more info.
