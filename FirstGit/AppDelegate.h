//
//  AppDelegate.h
//  FirstGit
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSideViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , retain) YRSideViewController *sideViewController;

@property (nonatomic , retain) LeftViewController *leftVC;
@property (nonatomic , retain) RightViewController *rightVC;

@end

