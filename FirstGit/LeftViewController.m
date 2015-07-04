//
//  LeftViewController.m
//  FirstGit
//
//  Created by lanouhn on 15/7/4.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftTableView = [[LeftTableView alloc]initWithFrame:CGRectMake(KINSTANCE_X, KINSTANCE_Y, THE_MENU_WIDTH , THE_MENU_HEIGHT)];
    
    [self.view addSubview:_leftTableView];
    
}

- (void)dealloc
{
    [_leftTableView release];
    [super dealloc];
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
