//
//  Parser.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/12.
//

#import <Foundation/Foundation.h>
#import "STCRSSItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface Parser : NSObject

- (void)parseByURL:(NSURL *)url addItemBlock:(void (^)(STCRSSItem *item))addItemBlock reloadItemsBlock:(void (^)(void))reloadItemsBlock;

@end

NS_ASSUME_NONNULL_END
