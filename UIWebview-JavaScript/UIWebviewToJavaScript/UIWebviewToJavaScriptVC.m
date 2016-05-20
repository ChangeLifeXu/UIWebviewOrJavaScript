//
//  UIWebviewToJavaScriptVC.m
//  UIWebview-JavaScript
//
//  Created by Hubert on 16/5/16.
//  Copyright © 2016年 Hubert. All rights reserved.
//

#import "UIWebviewToJavaScriptVC.h"

@interface UIWebviewToJavaScriptVC ()
{
    IBOutlet UIWebView *webView;
}
@end

@implementation UIWebviewToJavaScriptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadHtml:@"UIWebViewJS"];
}

// exe methods or sned vaue
- (IBAction)exeMethodsOrSendValue:(id)sender {
    [webView stringByEvaluatingJavaScriptFromString:@"showAlert(\"执行已经存在的方法和传值\");"];
}

//刷新html
- (IBAction)RefreshHTML:(id)sender {
    [self loadHtml:@"UIWebViewJS"];
}

//插入html getElementsByTagName 根据html自带标签定位元素
- (IBAction)TheLabelInsertHTML:(id)sender {
    //插入整个页面内容
    //document.getElementsByTagName('body')[0];"
    
    //替换第一个P元素内容
    NSString *tempString = [NSString stringWithFormat:@"document.getElementsByTagName('p')[0].innerHTML ='%@';",@"替换第一个P元素内容"];
    [webView stringByEvaluatingJavaScriptFromString:tempString];
}

//修改input值 getElementsByName根据标签名称获取定位元素
- (IBAction)InsertInput:(id)sender {
    NSString *tempString = [NSString stringWithFormat:@"document.getElementsByName('wd')[0].value='%@';",@"修炼爱情"];
    [webView stringByEvaluatingJavaScriptFromString:tempString];
}

//插入html 根据getElementById 定位元素
- (IBAction)GetElementByIdInsertHTML:(id)sender {
    //替换第id为idtest的DIV元素内容
    NSString *tempString = [NSString stringWithFormat:@"document.getElementById('idTest').innerHTML ='%@';",@"插入元素内容"];
    [webView stringByEvaluatingJavaScriptFromString:tempString];
}

//插入js并且执行传值
- (IBAction)InsertJS:(id)sender {
    NSString *insertString = [NSString stringWithFormat:
                              @"var script = document.createElement('script');"
                              "script.type = 'text/javascript';"
                              "script.text = \"function jsFunc() { "
                              "var a=document.getElementsByTagName('body')[0];"
                              "alert('%@');"
                              "}\";"
                              "document.getElementsByTagName('head')[0].appendChild(script);", @"插入js并执行传值"];
    [webView stringByEvaluatingJavaScriptFromString:insertString];
    [webView  stringByEvaluatingJavaScriptFromString:@"jsFunc();"];
}

//修改图片地址
- (IBAction)ChangeImage:(id)sender {
    NSString *tempString2 = [NSString stringWithFormat:@"document.getElementsByTagName('img')[0].src ='%@';",@"light_advice.png"];
    [webView stringByEvaluatingJavaScriptFromString:tempString2];
}

//提交
- (IBAction)commitRequest:(id)sender {
    [webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit();"];
}

//定位
- (IBAction)Location:(id)sender {
    [self loadHtml:@"UIWebViewJS_location"];
}

//修改字体
- (IBAction)ChangeFontSize:(id)sender {
    NSString *tempString2 = [NSString stringWithFormat:@"document.getElementsByTagName('p')[0].style.fontSize='%@';",@"19px"];
    [webView stringByEvaluatingJavaScriptFromString:tempString2];
}

//上传图片 浏览文件
- (IBAction)sendImage:(id)sender {
    [self loadHtml:@"UIWebViewJS_file"];
}

- (void)loadHtml:(NSString *)name{
    NSString *filePatch = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
    NSURL *url = [NSURL URLWithString:filePatch];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
