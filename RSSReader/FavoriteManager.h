//
//  FavoriteManager.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/14.
//

#import <Foundation/Foundation.h>

@class STCRSSItem;

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteManager : NSObject

+ (instancetype)sharedManager;
- (STCRSSItem *)getFavoriteItemWithIndex:(NSUInteger)index;
- (NSArray *)getFavoriteItems;
- (NSUInteger)getFavoriteItemsNumber;
- (void)addFavoriteItem:(STCRSSItem *)item complicationBlock:(void (^)(BOOL))addItemBlock;
- (void)removeFavoriteItemAtIndex:(NSUInteger)index;
- (void)exchangeFavoriteItemAtIndex:(NSUInteger)index1 withFavoriteItemAtIndex:(NSUInteger)index2;

@end

NS_ASSUME_NONNULL_END
