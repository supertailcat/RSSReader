//
//  ItemsManager.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import <Foundation/Foundation.h>
#import "STCRSSItem.h"
#import "TableViewReloadDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemsManager : NSObject

@property (nonatomic, weak) id<TableViewReloadDelegate> delegate;

+ (instancetype)sharedManager;
- (NSUInteger)getItemsNumber;
- (STCRSSItem *)getItemWithIndex:(NSUInteger)index;
- (void)updateItems;

@end

NS_ASSUME_NONNULL_END
