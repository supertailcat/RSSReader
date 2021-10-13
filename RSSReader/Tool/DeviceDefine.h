//
//  DeviceDefine.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define AppWidth [DeviceDefine getAppCGRect].size.width
#define AppHeight [DeviceDefine getAppCGRect].size.height

#define WindowWidth self.view.window.frame.size.width
#define WindowHeight self.view.window.frame.size.height

#define CurrentWidth self.view.frame.size.width
#define CurrentHeight self.view.frame.size.height

#define StatusBarHeight [DeviceDefine getStatusBarHight]
#define NavigationBarHeight self.navigationController.navigationBar.frame.size.height

@interface DeviceDefine : NSObject

+ (CGFloat)getStatusBarHight;
+ (CGRect)getAppCGRect;

@end
