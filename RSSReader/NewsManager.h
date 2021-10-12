//
//  NewsManager.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import <Foundation/Foundation.h>
#import "RSSNews.h"
#import "TableViewReloadDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsManager : NSObject

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, weak) RSSNews *currentNews;
@property (nonatomic, weak) id<TableViewReloadDelegate> delegate;

+ (instancetype)sharedManager;
- (NSUInteger)getNewsNumber;
- (RSSNews *)getNewsWithIndex:(NSUInteger)index;
- (void)updateNews;

@end

NS_ASSUME_NONNULL_END
