//
//  RootViewController.m
//  UIWebview-JavaScript
//
//  Created by Hubert on 16/5/16.
//  Copyright © 2016年 Hubert. All rights reserved.
//

#import "RootViewController.h"
#import "CommunicationSimpleViewController.h"
#import "UIWebviewToJavaScriptVC.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// communication simple
- (IBAction)CommunicationSimple:(id)sender {
    CommunicationSimpleViewController *comSimple = [[CommunicationSimpleViewController alloc] init];
    [self.navigationController pushViewController:comSimple animated:YES];
}

// UIWebView To JavaScript
- (IBAction)UIWebViewToJavaScript:(id)sender {
    UIWebviewToJavaScriptVC *vc = [[UIWebviewToJavaScriptVC alloc] initWithNibName:@"UIWebviewToJavaScriptVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
