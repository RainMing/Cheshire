//
//  RootViewController.m
//  FirstGit
//
//  Created by lanouhn on 15/7/2.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)loadView
{
    self.myTableView = [[RootTableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myTableView;
    [self.myTableView release];
    
    self.navigationItem.title = @"首页";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    //UIBarButtonSystemItemCompose UIBarButtonSystemItemReply  UIBarButtonSystemItemAction  UIBarButtonSystemItemOrganize UIBarButtonSystemItemBookmarks UIBarButtonSystemItemSearch UIBarButtonSystemItemStop UIBarButtonSystemItemCamera UIBarButtonSystemItemTrash    UIBarButtonSystemItemPlay UIBarButtonSystemItemPause UIBarButtonSystemItemRewind UIBarButtonSystemItemFastForward
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(leftItemAction:)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftItemAction:(UIBarButtonItem *)left
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
