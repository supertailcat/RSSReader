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
#import <WebKit/WKNavigationDelegate.h>
#import "STCRSSItem.h"
#import "DeviceDefine.h"
#import "ItemsManager.h"
#import "FavoriteManager.h"

@interface DetailViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight - NavigationBarHeight) configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
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
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"mode"] isEqualToString:@"simple"]) {
        [_webView loadHTMLString:plainHTML baseURL:nil];
    } else {
        [_webView loadRequest:[NSURLRequest requestWithURL:_item.linkURL]];
    }
    [self.view addSubview:_webView];
    
    UIBarButtonItem *favoriteBtn = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(addToFavorite:)];
    self.navigationItem.rightBarButtonItem = favoriteBtn;
}

- (void)addToFavorite:(UIButton *)btn {
    [[FavoriteManager sharedManager] addFavoriteItem:_item complicationBlock:^(BOOL success){
        NSString *title = @"提示";
        NSString *message = @"收藏失败";
        if (success) {
            message = @"收藏成功";
        }
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"mode"] isEqualToString:@"origin"]) {
        return;
    }
    //设置字体
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='PingFangSC-Medium';";
    [webView evaluateJavaScript:fontFamilyStr completionHandler:nil];
    //设置颜色
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:nil];
    //修改字体大小
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
    
}

//#pragma mark ------ < KVO > ------
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    /**  < 法2 >  */
//    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        CGRect webFrame = _webView.frame;
//
//        webFrame.size.height = _webView.scrollView.contentSize.height;
//        _webView.frame = webFrame;
//        NSLog(@"%@",@(_webView.scrollView.contentSize.height));
//    }
//}
@end
