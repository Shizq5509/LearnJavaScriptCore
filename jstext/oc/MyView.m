//
//  MyView.m
//  JavaScriptCore1
//
//  Created by shi.zhengqian on 2018/7/24.
//  Copyright © 2018年 shi.zhengqian. All rights reserved.
//

#import "MyView.h"

@implementation MyView
static id _vc = nil;
- (instancetype)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (void)show
{
    [self.class.vc.view addSubview:self];
}

+(void)setVc:(UIViewController *)vc
{
    _vc = vc;
}
+(UIViewController *)vc
{
    return (UIViewController *)_vc;
}

@end
