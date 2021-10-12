//
//  Parser.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/12.
//

#import "Parser.h"
#import <RSSAtomKit/RSSAtomKit.h>

@implementation Parser

- (void)parseByURL:(NSURL *)url addNewsBlock:(void (^)(RSSNews *news))addNewsBlock reloadNewsBlock:(void (^)(void))reloadNewsBlock {
    RSSAtomKit *atomKit = [[RSSAtomKit alloc] initWithSessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    [atomKit parseFeedFromURL:url completionBlock:^(RSSFeed *feed, NSArray *items, NSError *error) {
        if (error) {
            NSLog(@"Error for %@: %@", url, error);
            return;
        }
        for (RSSItem *item in items) {
            RSSNews *news = [[RSSNews alloc] init];
            news.title = item.title;
            news.itemDescription = item.itemDescription;
            addNewsBlock(news);
        }
        reloadNewsBlock();
    } completionQueue:nil];
}

@end
