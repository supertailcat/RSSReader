//
//  SubscribeManager.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubscribeManager : NSObject

+ (instancetype)sharedManager;
- (NSUInteger)URLsCount;
- (NSString *)URLsAtIndex:(NSUInteger)index;
- (void)addURL:(NSString *)URL atIndex:(NSUInteger)index;
- (void)removeURLAtIndex:(NSInteger)index;
- (void)modifyURL:(NSString *)URL atIndex:(NSUInteger)index;
- (void)exchangeURLAtIndex:(NSUInteger)index1 withURLAtIndex:(NSUInteger)index2;

@end

NS_ASSUME_NONNULL_END
