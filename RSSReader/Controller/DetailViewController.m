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
#import "RSSNews.h"

@interface DetailViewController ()<WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.navigationController.tabBarController.tabBar.frame.size.height) configuration:config];
    _webView.UIDelegate = self;
    NSMutableString *plainHTML = [[NSMutableString alloc] init];
    [plainHTML appendString:@"<html>"];
    [plainHTML appendString:@"<head>"];
    [plainHTML appendString:@"<meta charset=\"utf-8\">"];
    [plainHTML appendString:@"<title>"];
    [plainHTML appendString:_news.title];
    [plainHTML appendString:@"</title>"];
    [plainHTML appendString:@"</head>"];
    [plainHTML appendString:@"<body>"];
    [plainHTML appendString:@"<h1>"];
    [plainHTML appendString:_news.title];
    [plainHTML appendString:@"</h1>"];
    [plainHTML appendString:_news.itemDescription];
    [plainHTML appendString:@"</body>"];
    [plainHTML appendString:@"</html>"];
    
    [_webView loadHTMLString:plainHTML baseURL:nil];
    
    [self.view addSubview:_webView];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [self getCookie];
    NSLog(@"\n\n\n\n");
}

@end
