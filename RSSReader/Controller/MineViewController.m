//
//  MineViewController.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "MineViewController.h"
#import "DeviceDefine.h"

@interface MineViewController ()

@property (nonatomic, strong) UIButton *modeBtn;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight / 4, ScreenWidth, ScreenHeight / 2)];
    NSString *title = @"原文模式";
    NSString *mode = [[NSUserDefaults standardUserDefaults] objectForKey:@"mode"];
    if ([mode isEqualToString:@"simple"]) {
        title = @"简略模式";
    }
    [_modeBtn setTitle:title forState:UIControlStateNormal];
    [_modeBtn setBackgroundColor:[UIColor orangeColor]];
    [_modeBtn addTarget:self action:@selector(changeMode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_modeBtn];
}

- (void)viewDidAppear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.hidesBottomBarWhenPushed = NO;
}

- (void)changeMode:(UIButton *)btn {
    NSString *mode = [[NSUserDefaults standardUserDefaults] objectForKey:@"mode"];
    NSString *title = [mode isEqualToString:@"simple"] ? @"原文模式" : @"简略模式";
    [_modeBtn setTitle:title forState:UIControlStateNormal];
    mode = [mode isEqualToString:@"simple"] ? @"origin" : @"simple" ;
    [[NSUserDefaults standardUserDefaults] setObject:mode forKey:@"mode"];
}
@end
