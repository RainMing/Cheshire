//
//  AppDelegate.m
//  FirstGit
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 main.m. All rights reserved.
//**************** Xcode 版本6.1  模拟器 iPhone6 ****** iOS Deployment Target 8.1  **********

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    RootViewController *rootVC = [[RootViewController alloc]init];
    UINavigationController *rootNV = [[UINavigationController alloc]initWithRootViewController:rootVC];
    _leftVC = [[LeftViewController alloc]init];
    _rightVC = [[RightViewController alloc]init];
    
    _sideViewController = [[ YRSideViewController alloc]init];
    _sideViewController.rootViewController = rootNV;
    _sideViewController.leftViewController = _leftVC;
    _sideViewController.rightViewController = _rightVC;
    
    _sideViewController.tabBarItem.title = @"首页";
    _sideViewController.tabBarItem.image = [UIImage imageNamed:@"Home_page1.png"];
    
    //创建一个存放控制器的数组
    NSArray *controllers = @[_sideViewController];
    
    //创建一个标签试图控制器
    UITabBarController *tabarVCS = [[UITabBarController alloc]init];
    tabarVCS.viewControllers = controllers;
    
    
    
    
    
    self.window.rootViewController = tabarVCS;
    [rootVC release];
    [rootNV release];
    [tabarVCS release];
    
    return YES;
}

- (void)dealloc
{
    [_sideViewController release];
    [_leftVC release];
    [_rightVC release];
    [super dealloc];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
