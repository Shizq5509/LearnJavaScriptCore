//
//  ViewController.m
//  JavaScriptCore1
//
//  Created by shi.zhengqian on 2018/7/23.
//  Copyright © 2018年 shi.zhengqian. All rights reserved.
//

#import "ViewController.h"
#include <JavaScriptCore/JavaScriptCore.h>
#import "MyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.simple demo
    [self test1];
    
    //2.js var
    [self test2];
    
    //3.block
    [self test3];
    
    //4.JSExport
    [self test4];
    
    //5.memory
}

- (void)test1
{
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    JSContext *ctx = [[JSContext alloc] initWithVirtualMachine:vm];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo1" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    JSValue *value = [ctx evaluateScript:script];
    
    NSLog(@"%d",[value toInt32]);
}

- (void)test2
{
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    JSContext *ctx = [[JSContext alloc] initWithVirtualMachine:vm];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    [ctx evaluateScript:script];
    
    // 访问js对象的三种方式
    NSLog(@"[] %@",ctx[@"a"]);
    NSLog(@"objectForKeyedSubscript %@",[ctx objectForKeyedSubscript:@"a"]);
    NSLog(@"globalObject %@",[ctx.globalObject objectForKeyedSubscript:@"a"]);
    
    // 同样也可以赋值
    ctx[@"a"] = [JSValue valueWithInt32:90 inContext:ctx];
    [ctx setObject:[JSValue valueWithInt32:90 inContext:ctx] forKeyedSubscript:@"a"];
    [ctx.globalObject setObject:[JSValue valueWithInt32:90 inContext:ctx] forKeyedSubscript:@"a"];
    NSLog(@"[] %@",ctx[@"a"]);
    NSLog(@"objectForKeyedSubscript %@",[ctx objectForKeyedSubscript:@"a"]);
    NSLog(@"globalObject %@",[ctx.globalObject objectForKeyedSubscript:@"a"]);
    
    // object对应NSDictionary
    JSValue *b = ctx[@"b"];
    NSLog(@"%@",[b toDictionary]);
    // array对应NSArray
    JSValue *c = ctx[@"c"];
    NSLog(@"%@",[c toArray]);
}

- (void)test3
{
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    JSContext *ctx = [[JSContext alloc] initWithVirtualMachine:vm];
    
    ctx[@"myLog"] = ^(NSString *s){
        NSLog(@"myLog:%@",s);
    };
    
    ctx[@"add"] = ^(NSInteger a, NSInteger b){
        return a+b;
    };
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo3" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [ctx evaluateScript:script];
}

- (void)test4
{
    MyView.vc = self;
    JSContext *ctx = [[JSContext alloc] init];
    ctx[@"MyView"] = [MyView class];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo4" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [ctx evaluateScript:script];
}

@end
