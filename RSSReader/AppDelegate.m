//
//  AppDelegate.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SubscribeViewController.h"
#import "MineViewController.h"
#import "FavoriteViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //1.创建Tab所属的ViewController
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    UITabBarItem* homeTabItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] tag:1];
    homeVC.tabBarItem = homeTabItem;
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.navigationBar.translucent = NO;
    
    //订阅
    SubscribeViewController *subscribeVC = [[SubscribeViewController alloc] init];
    subscribeVC.title = @"订阅";
    UITabBarItem* subscribeTabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:2];
    subscribeTabItem.title = subscribeVC.title;
    subscribeVC.tabBarItem = subscribeTabItem;
    UINavigationController *subscribeNav = [[UINavigationController alloc] initWithRootViewController:subscribeVC];
    subscribeNav.navigationBar.translucent = NO;
    
    //收藏
    FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] init];
    favoriteVC.title = @"收藏";
    UITabBarItem* favoriteTabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
    favoriteTabItem.title = favoriteVC.title;
    favoriteVC.tabBarItem = favoriteTabItem;
    UINavigationController *favoriteNav = [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    favoriteNav.navigationBar.translucent = NO;
    
    //我的
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.title = @"我的";
    UITabBarItem* mineTabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:4];
    mineTabItem.title = mineVC.title;
    mineVC.tabBarItem = mineTabItem;
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNav.navigationBar.translucent = NO;
    
    //2、创建一个数组，放置多有控制器
    NSArray *vcArray = [NSArray arrayWithObjects:homeNav, subscribeNav, favoriteNav, mineNav, nil];
    
    //3、创建UITabBarController，将控制器数组设置给UITabBarController
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    //设置多个Tab的ViewController到TabBarViewController
    tabBarVC.viewControllers = vcArray;
    
    //4、将UITabBarController设置为Window的RootViewController
    self.window.rootViewController = tabBarVC;
    //显示Window
    [self.window makeKeyAndVisible];
    return YES;
}

@end
