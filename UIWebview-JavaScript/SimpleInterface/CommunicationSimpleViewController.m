//
//  CommunicationSimpleViewController.m
//  UIWebview-JavaScript
//
//  Created by Hubert on 16/5/16.
//  Copyright © 2016年 Hubert. All rights reserved.
//

#import "CommunicationSimpleViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface CommunicationSimpleViewController ()<UIWebViewDelegate>{
    UIWebView *webview;
    UITextField *text;
}
@end

@implementation CommunicationSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self interface];
    [self JavaScriptToOCSimple];
}

//interface
- (void)interface{
    webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    webview.backgroundColor=[UIColor lightGrayColor];
    NSString *htmlPath=[[NSBundle mainBundle] resourcePath];
    htmlPath=[htmlPath stringByAppendingPathComponent:@"indexTest.html"];//indexTest.html
    NSURL *localURL=[[NSURL alloc]initFileURLWithPath:htmlPath];
    [webview loadRequest:[NSURLRequest requestWithURL:localURL]];
    webview.delegate = self;
    [self.view addSubview:webview];
    
    
    text = [[UITextField alloc] initWithFrame:CGRectMake(15, 35, 110, 20)];
    text.backgroundColor = [UIColor grayColor];
    text.keyboardType = UIKeyboardTypeDecimalPad;
    //[webview.scrollView addSubview:text];
    
    UIButton *sendMessage = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, 100, 50)];
    [sendMessage setTitle:@"传值到页面" forState:UIControlStateNormal];
    [sendMessage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendMessage addTarget:self action:@selector(sendValueFromOCToJS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendMessage];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    return YES;
}


//simple1 js 调用 oc
- (void)JavaScriptToOCSimple{
    JSContext *context = [webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"CallFunction"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
    };
}

//simple2 传值到UIWeb端
- (void)sendValueFromOCToJS{
    NSString *tempString = [NSString stringWithFormat:@"document.getElementById('wd').value='%@';",@"修炼爱情"];
    [webview stringByEvaluatingJavaScriptFromString:tempString];
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
