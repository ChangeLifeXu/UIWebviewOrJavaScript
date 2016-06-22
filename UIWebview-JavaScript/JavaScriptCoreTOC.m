//
//  JavaScriptCoreTOC.m
//  UIWebview-JavaScript
//
//  Created by Hubert on 16/6/22.
//  Copyright © 2016年 Hubert. All rights reserved.
//

#import "JavaScriptCoreTOC.h"

@interface JavaScriptCoreTOC ()

@end

@implementation JavaScriptCoreTOC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height)];
    self.webView.backgroundColor=[UIColor lightGrayColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];

    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"JSCallOC.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Undocumented access to UIWebView's JSContext
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"app"] = self;
    
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] = ^(NSString *str){
        NSLog(@"测试");
    };
    
    self.context[@"alert"] = ^(NSString *alertStr){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:alertStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    };
    
    //多参数调用
    self.context[@"mutiParams"] = ^(NSString *a, NSString *b, NSString *c){
        NSLog(@"%@  %@  %@",a,b,c);
    };
}

#pragma mark - JSExport Methods

- (void)handleFactorialCalculateWithNumber:(NSString *)number
{
    NSNumber *result = [self calculateFactorialOfNumber:@([number integerValue])];
    [self.context[@"showResult"] callWithArguments:@[result]];
}

#pragma mark - Factorial Method

- (NSNumber *)calculateFactorialOfNumber:(NSNumber *)number
{
    NSInteger i = [number integerValue];
    if (i < 0)
    {
        return [NSNumber numberWithInteger:0];
    }
    if (i == 0)
    {
        return [NSNumber numberWithInteger:1];
    }
    
    NSInteger r = (i * [(NSNumber *)[self calculateFactorialOfNumber:[NSNumber numberWithInteger:(i - 1)]] integerValue]);
    
    return [NSNumber numberWithInteger:r];
}


@end
