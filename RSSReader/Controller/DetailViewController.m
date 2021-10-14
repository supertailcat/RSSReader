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
    
    [_webView loadHTMLString:plainHTML baseURL:nil];
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
    // 设置字体
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='PingFangSC-Medium';";
    [webView evaluateJavaScript:fontFamilyStr completionHandler:nil];
    //设置颜色
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:nil];
    //修改字体大小
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"completionHandler:nil];
//    //修改图片大小
//    NSString *screenWidth = [[NSString alloc] initWithFormat:@"%f", ScreenWidth];
//    NSMutableString *js = [NSMutableString string];
//    [js appendString:@"var script = document.createElement('script');"
//    "script.type = 'text/javascript';"
//    "script.text = \"function ResizeImages(){ "
//    "var myimg,oldwidth;"
//     "var maxwidth = "];
//    [js appendString:screenWidth];
//    [js appendString:@";"
//    "for(i=0;i <document.images.length;i++){"
//    "myimg = document.images[i];"
//    "oldwidth = myimg.width;"
//    "myimg.width = maxwidth;"
//    "}"
//    "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();"];
//    [ webView evaluateJavaScript:js completionHandler:nil];
    
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
