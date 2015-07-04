//
//  RightTableView.m
//  FirstGit
//
//  Created by lanouhn on 15/7/4.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import "RightTableView.h"

@implementation RightTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    self.backgroundColor = [UIColor clearColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
