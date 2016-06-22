//
//  JavaScriptCoreTOC.h
//  UIWebview-JavaScript
//
//  Created by Hubert on 16/6/22.
//  Copyright © 2016年 Hubert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TJSExport <JSExport>


/** handleFactorialCalculateWithNumber 作为js方法的别名 */
JSExportAs(calculateForJS, - (void)handleFactorialCalculateWithNumber:(NSString *)number
           );


@end



@interface JavaScriptCoreTOC : UIViewController<UIWebViewDelegate,TJSExport>

@property (strong, nonatomic)  JSContext    *context;
@property (nonatomic,strong)   UIWebView    *webView;


@end