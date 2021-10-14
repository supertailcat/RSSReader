//
//  Parser.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/12.
//

#import "Parser.h"
#import <RSSAtomKit/RSSAtomKit.h>
#import <RSSAtomKit/RSSPerson.h>

@implementation Parser

- (void)parseByURL:(NSURL *)url addItemBlock:(void (^)(STCRSSItem *item))addItemBlock reloadItemsBlock:(void (^)(void))reloadItemsBlock {
    RSSAtomKit *atomKit = [[RSSAtomKit alloc] initWithSessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    [atomKit parseFeedFromURL:url completionBlock:^(RSSFeed *feed, NSArray *items, NSError *error) {
        if (error) {
            NSLog(@"Error for %@: %@", url, error);
            return;
        }
        for (RSSItem *item in items) {
            STCRSSItem *stcItem = [[STCRSSItem alloc] init];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
            stcItem.title = item.title;
            stcItem.linkURL = item.linkURL;
            stcItem.itemDescription = item.author.email;
            stcItem.publicationDate = [[dateFormatter stringFromDate:item.publicationDate] stringByAppendingString:feed.title];
            addItemBlock(stcItem);
        }
        reloadItemsBlock();
    } completionQueue:nil];
}

@end
