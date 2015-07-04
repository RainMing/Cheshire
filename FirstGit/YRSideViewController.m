//
//  YRSideViewController.m
//  左右拖动菜单
//
//  Created by lanouhn on 15/7/3.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import "YRSideViewController.h"
#import "YRSideView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width //定义一个宽度为主屏宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height//定义一个高度为主屏的高度


@interface YRSideViewController ()<UIGestureRecognizerDelegate>
{
    UIView *_baseView; //目前是_baseView
    UIView *_currentView;//其实就是rootViewController.view
    
    UIPanGestureRecognizer *_panGesturRecognizer;
    
    CGPoint _startPanPoint;
    CGPoint _lastPanPoint;
    
    BOOL _panMovingRightOrLeft;//向左还是向右 true 向右，false 向左
    
    UIButton *_coverButton;
}


@end

@implementation YRSideViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leftViewShowWith = 267;
        _rightViewShowWith = 267;
        _animationDuration = 0.35;
        _showBoundsShadow = true;
        
        _panGesturRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_panGesturRecognizer setDelegate:self];
        
        _panMovingRightOrLeft = false;
        _lastPanPoint = CGPointZero;
        
        _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [_coverButton addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)loadView
{
    YRSideView  *aView = [[YRSideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = aView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _baseView = self.view;
    
    [_baseView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1]];
    
    self.needSwipeShowMenu = true;
    
    
   
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.rootViewController) {
        NSAssert(false, @"you must set rootViewController !!");
    }
    NSLog(@"%@", _currentView);
    if (_currentView != _rootViewController.view) {
        [_currentView removeFromSuperview];
        _currentView = _rootViewController.view;
        [_baseView addSubview:_currentView];
        _currentView.frame = _baseView.bounds;
    }
    
}

- (void)setRootViewController:(UIViewController *)rootViewController
{
    if (_rootViewController != rootViewController) {
        if (_rootViewController) {
            [_rootViewController removeFromParentViewController];
        }
        _rootViewController = rootViewController;
        if (_rootViewController) {
            [self addChildViewController:_rootViewController];
        }
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (_leftViewController != leftViewController) {
        if (_leftViewController) {
            [_leftViewController removeFromParentViewController];
        }
        _leftViewController = leftViewController;
        if (_leftViewController) {
            [self addChildViewController:_leftViewController];
        }
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    if (_rightViewController != rightViewController) {
        if (_rightViewController) {
            [_rightViewController removeFromParentViewController];
        }
        _rightViewController = rightViewController;
        if (_rightViewController) {
            [self addChildViewController:_rightViewController];
        }
    }
}


- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu
{
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu) {
        [_baseView addGestureRecognizer:_panGesturRecognizer];
    }else{
        [_baseView removeGestureRecognizer:_panGesturRecognizer];
    }
}

- (void)showShadow:(BOOL)show
{
    _currentView.layer.shadowOpacity = show ? 0.8f : 0.0f;
    if (show) {
        
        _currentView.layer.cornerRadius = 4.0f;
        _currentView.layer.shadowOffset = CGSizeZero;
        _currentView.layer.shadowRadius = 4.0f;
        _currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
}

#pragma mark - ShowOrHideTheView
- (void)willShowLeftViewController
{
    if (!_leftViewController || _leftViewController.view.superview) {
        return;
    }
    _leftViewController.view.frame = _baseView.bounds;
    
    [_baseView insertSubview:_leftViewController.view belowSubview:_currentView];
    
    if (_rightViewController && _rightViewController.view.superview) {
        
        [_rightViewController.view removeFromSuperview];
    }
}

- (void)willShowRightViewController
{
    if (!_rightViewController || _rightViewController.view.superview) {
        return;
    }
    _rightViewController.view.frame = _baseView.bounds;
    [_baseView insertSubview:_rightViewController.view belowSubview:_currentView];
    
    if (_leftViewController && _leftViewController.view.superview) {
        [_leftViewController.view removeFromSuperview];
    }
}

- (void)showLeftViewController:(BOOL)animated
{
    if (!_leftViewController) {
        return;
    }
    [self willShowLeftViewController];
    
    NSTimeInterval animatedTime = 0;
    if (animated ) {
        animatedTime = ABS(_leftViewShowWith - _currentView.frame.origin.x) / _leftViewShowWith * _animationDuration;
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:_leftViewShowWith];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];
    
}

- (void)showRightViewController:(BOOL)animated
{
    if (!_rightViewController) {
        return;
    }
    [self willShowRightViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_rightViewShowWith + _currentView.frame.origin.x) / _rightViewShowWith * _animationDuration;
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:-_rightViewShowWith];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];
}

- (void)hideSideViewController:(BOOL)animated
{
    [self showShadow:false];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_currentView.frame.origin.x / (_currentView.frame.origin.x > 0 ? _leftViewShowWith : _rightViewShowWith)) * _animationDuration;
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:0];
    } completion:^(BOOL finished) {
        [_coverButton removeFromSuperview];
        [_leftViewController.view removeFromSuperview];
        [_rightViewController.view removeFromSuperview];
    }];
}

- (void)hideSideViewController
{
    [self hideSideViewController:true];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == _panGesturRecognizer) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:_baseView];
        if ([panGesture velocityInView:_baseView].x < 600 && ABS(translation.x) / ABS(translation.y) > 1) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (_panGesturRecognizer.state == UIGestureRecognizerStateBegan) {
        _startPanPoint = _currentView.frame.origin;
        if (_currentView.frame.origin.x == 0) {
            [self showShadow:_showBoundsShadow];
        }
        CGPoint velocity = [pan velocityInView:_baseView];
        if (velocity.x > 0) {
            if (_currentView.frame.origin.x >= 0 && _leftViewController && !_leftViewController.view.superview) {
                [self willShowLeftViewController];
            }
        }else if (velocity.x < 0){
            if (_currentView.frame.origin.x <= 0 && _rightViewController && !_rightViewController.view.superview) {
                [self willShowRightViewController];
            }
        }
        return;
    }
    
    CGPoint currentPostion = [pan translationInView:_baseView];
    CGFloat xoffset = _startPanPoint.x + currentPostion.x;
    if (xoffset > 0) {//向右
        if (_leftViewController && _leftViewController.view.superview) {
            xoffset = xoffset > _leftViewShowWith ? _leftViewShowWith : xoffset;
        }else{
            xoffset = 0;
        }
    }else if (xoffset < 0){//向左滑
        if (_rightViewController && _rightViewController.view.superview) {
            xoffset = xoffset < -_rightViewShowWith ? _rightViewShowWith : xoffset;
        }else{
            xoffset = 0;
        }
    }
    
    if (xoffset != _currentView.frame.origin.x) {
        [self layoutCurrentViewWithOffset:xoffset];
    }
    
    if (_panGesturRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_currentView.frame.origin.x != 0 && _currentView.frame.origin.x != _leftViewShowWith && _currentView.frame.origin.x != -_rightViewShowWith) {
            if (_panMovingRightOrLeft && _currentView.frame.origin.x > 20) {
                [self showLeftViewController:true];
            }else if (!_panMovingRightOrLeft && _currentView.frame.origin.x < -20){
                [self showRightViewController:true];
            }else{
                [self hideSideViewController];
            }
        }else if (_currentView.frame.origin.x == 0)
        {
            [self showShadow:false];
        }
        _lastPanPoint = CGPointZero;
    }else{
        CGPoint velocity = [pan velocityInView:_baseView];
        if (velocity.x > 0) {
            _panMovingRightOrLeft = true;
        }else if (velocity.x < 0){
            _panMovingRightOrLeft = false;
        }
    }
}

//重写此方法可以改变动画效果,PS._currentView就是RootViewController.view
- (void)layoutCurrentViewWithOffset:(CGFloat)xoffset
{
    if (_showBoundsShadow) {
        _currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
    if (self.rootViewMoveBlock) {//如果有自定义动画，使用自定义动画
        self.rootViewMoveBlock(_currentView , _baseView.bounds , xoffset);
        return;
    }
    /*平移的动画
     [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y, _baseView.bounds.size.width, _baseView.frame.size.height)];
     return;
     */
    
    //平移带缩放效果的动画
    static CGFloat h2w = 0;
    if (h2w == 0) {
        h2w = _baseView.frame.size.height / _baseView.frame.size.width;
    }
    CGFloat scale = ABS(600 - ABS(xoffset)) / 600;
    
    scale = MAX(0.8, scale);
    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat totalWidth = _baseView.frame.size.width;
    CGFloat totalHeight = _baseView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        totalHeight = _baseView.frame.size.width;
        totalWidth = _baseView.frame.size.height;
    }
    
    if (xoffset > 0) {//向右滑的
        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }else{//向左滑的
        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
