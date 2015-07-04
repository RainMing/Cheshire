//
//  YRSideViewController.h
//  左右拖动菜单
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RootViewMoveBlock)(UIView *rootView, CGRect orginFrame, CGFloat xoffset);

@interface YRSideViewController : UIViewController

@property (assign , nonatomic) BOOL needSwipeShowMenu; //是否开启滑动手势滑动出菜单
@property (nonatomic , retain) UIViewController *rootViewController;

@property (nonatomic , retain) UIViewController *leftViewController NS_AVAILABLE_IOS(5_0);

@property (nonatomic , retain) UIViewController *rightViewController NS_AVAILABLE_IOS(5_0);

@property (nonatomic , assign) CGFloat leftViewShowWith;//左侧栏的展示大小

@property (nonatomic , assign) CGFloat rightViewShowWith;//右侧栏的展示大小

@property (nonatomic , assign) NSTimeInterval animationDuration;//动画时长

@property (nonatomic , assign) BOOL showBoundsShadow;//是否显示边框阴影

@property (nonatomic , copy) RootViewMoveBlock rootViewMoveBlock;//可在此block中重做动画效果

- (void)setRootViewMoveBlock:(RootViewMoveBlock)rootViewMoveBlock;

- (void)showLeftViewController:(BOOL)animated;//展示左边栏
- (void)showRightViewController:(BOOL)animated;//展示右边栏
- (void)hideSideViewController:(BOOL)animated;//恢复正常位置

@end
