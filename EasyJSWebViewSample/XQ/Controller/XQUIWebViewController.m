//
//  XQUIWebViewController.m
//  XQJSOCInterface
//
//  Created by LaiXuefei on 2017/3/22.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQUIWebViewController.h"
#import "EasyJSWebView.h"
#import "XQJSInterface.h"
#import "EasyJSWebViewProxyDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface XQUIWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) EasyJSWebView *myWebView;

@end

@implementation XQUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];

    WEAK_SELF_OBJ(self);

    //当JSContex变化时，需要重新注入交互方法，比如reload情况，避免交互失效
    [[NSNotificationCenter defaultCenter]addObserverForName:NOTIF_JSCONTEXT_CHANGED object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        STRONG_SELF_OBJ(weakSelf)
        JSContext *context = (JSContext *)note.object;
        JSContext *currentContext = [weakSelf.myWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

        //若是当前webview，才重新inject，因为是通知，避免其他webview reload影响
        if (context == currentContext) {
            [strongSelf.myWebView injectJS];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)setUI{
    //rightBarButtonItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                              target:self
                                                                              action:@selector(reload)];
    self.navigationItem.rightBarButtonItem = rightItem;

    // webview
    self.myWebView = [[EasyJSWebView alloc] initWithFrame:CGRectZero];
    self.myWebView.translatesAutoresizingMaskIntoConstraints = NO;
    self.myWebView.delegate = self;

    //add interface obj
    XQJSInterface *interface = [self javascriptInterface];
    [self.myWebView addJavascriptInterfaces:interface WithName:INTERFACE_NAME];

    [self.view insertSubview:self.myWebView atIndex:0];

    //AutoLayout
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_myWebView);
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:
                             @"H:|-0-[_myWebView]-0-|" options:0 metrics:nil views:viewsDict];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:
                             @"V:|-0-[_myWebView]-0-|" options:0 metrics:nil views:viewsDict];
    [self.view addConstraints:hConstraints];
    [self.view addConstraints:vConstraints];

    //load
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"xq_test" ofType:@"html"] isDirectory:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
}

#pragma mark - methods
- (XQJSInterface *)javascriptInterface {
    XQJSInterface *interface = [[XQJSInterface alloc] init];
    return interface;
}

- (void)reload{
    [self.myWebView reload];
}

@end
