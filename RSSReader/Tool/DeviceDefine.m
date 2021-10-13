//
//  DeviceDefine.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/13.
//

#import "DeviceDefine.h"

@implementation DeviceDefine

+ (CGRect)getAppCGRect {
    if (@available(iOS 9.0, *)) {
        return CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight);
    } else {
        return [UIScreen mainScreen].applicationFrame;
    }
}

+ (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

@end
