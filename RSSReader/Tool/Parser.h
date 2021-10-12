//
//  Parser.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/12.
//

#import <Foundation/Foundation.h>
#import "RSSNews.h"

NS_ASSUME_NONNULL_BEGIN

@interface Parser : NSObject

- (void)parseByURL:(NSURL *)url addNewsBlock:(void (^)(RSSNews *news))addNewsBlock reloadNewsBlock:(void (^)(void))reloadNewsBlock;

@end

NS_ASSUME_NONNULL_END
