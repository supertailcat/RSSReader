//
//  NewsManager.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "NewsManager.h"
#import "Parser.h"

@implementation NewsManager

+ (instancetype)sharedManager {
    static id sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [self new];
        [sharedInst newsInit];
    });
    return sharedInst;
}

- (void)newsInit {
    self.newsArray = [NSMutableArray array];
    self.currentNews = nil;
    [self updateNews];
}

- (NSUInteger)getNewsNumber {
    return _newsArray.count;
}

- (RSSNews *)getNewsWithIndex:(NSUInteger)index {
    return (index < _newsArray.count - 1) ? _newsArray[index] : nil;
}

- (void)addNews:(RSSNews *)news {
    [_newsArray addObject:news];
}

- (void)updateNews {
    //todo
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Parser *parser = [[Parser alloc] init];
        [parser parseByURL:[[NSURL alloc] initWithString:@"https://www.zhihu.com/rss"] addNewsBlock:^(RSSNews *news) {
            [self addNews:news];
        } reloadNewsBlock:^{
            [self didUpdateNews];
        }];
    });
}

- (void)didUpdateNews {
    [self.delegate reloadTableView];
}
@end
