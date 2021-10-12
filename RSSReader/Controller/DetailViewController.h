//
//  DetailViewController.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import <UIKit/UIKit.h>

@class RSSNews;

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, weak) RSSNews *news;

@end

NS_ASSUME_NONNULL_END
