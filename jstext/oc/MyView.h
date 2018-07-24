//
//  MyView.h
//  JavaScriptCore1
//
//  Created by shi.zhengqian on 2018/7/24.
//  Copyright © 2018年 shi.zhengqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <JavaScriptCore/JavaScriptCore.h>

@protocol MyViewExports <JSExport>
- (instancetype)initWithFrame:(CGRect)frame;
- (void)show;
@end

@interface MyView : UIView <MyViewExports>

@property(class,nonatomic,weak) UIViewController    *vc;

@end
