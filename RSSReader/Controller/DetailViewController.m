//
//  DetailViewController.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "DetailViewController.h"
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKWebView.h>
#import <WebKit/WKUIDelegate.h>
#import "STCRSSItem.h"
#import "DeviceDefine.h"

@interface DetailViewController ()<WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight - NavigationBarHeight) configuration:config];
    _webView.UIDelegate = self;
    
    NSMutableString *plainHTML = [[NSMutableString alloc] init];
    [plainHTML appendString:@"<html>"];
    [plainHTML appendString:@"<head>"];
    [plainHTML appendString:@"<meta charset=\"utf-8\">"];
    [plainHTML appendString:@"<title>"];
    [plainHTML appendString:_item.title];
    [plainHTML appendString:@"</title>"];
    [plainHTML appendString:@"</head>"];
    [plainHTML appendString:@"<body>"];
    [plainHTML appendString:@"<h1>"];
    [plainHTML appendString:_item.title];
    [plainHTML appendString:@"</h1>"];
    [plainHTML appendString:_item.itemDescription];
    [plainHTML appendString:@"</body>"];
    [plainHTML appendString:@"</html>"];
    
    [_webView loadHTMLString:plainHTML baseURL:nil];
    [self.view addSubview:_webView];
}

@end
