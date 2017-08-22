//
//  WASLoginView.m
//  WASLoginDemo
//
//  Created by 王璋杰 on 2017/8/22.
//  Copyright © 2017年 sec. All rights reserved.
//

#import "WASLoginView.h"

@implementation WASLoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor orangeColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    UILabel *label = [UILabel new];
    label.text = @"LOGIN";
    [self addSubview:label];
    label.center = self.center;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
