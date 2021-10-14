//
//  ItemsManager.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "ItemsManager.h"
#import "Parser.h"
#import "SubscribeManager.h"

@interface ItemsManager ()

@property (atomic, strong) NSMutableArray *itemArray;
@property (nonatomic, weak) STCRSSItem *currentItem;

@end

@implementation ItemsManager

+ (instancetype)sharedManager {
    static id sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [self new];
        [sharedInst itemsInit];
    });
    return sharedInst;
}

- (void)itemsInit {
    self.itemArray = [NSMutableArray array];
    self.currentItem = nil;
    [self updateItems];
}

- (NSUInteger)getItemsNumber {
    return _itemArray.count;
}

- (STCRSSItem *)getItemWithIndex:(NSUInteger)index {
    return (index <= _itemArray.count - 1) ? _itemArray[index] : nil;
}

- (void)addItem:(STCRSSItem *)item {
    [_itemArray addObject:item];
}

- (void)updateItems {
    //todo
    [_itemArray removeAllObjects];
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Parser *parser = [[Parser alloc] init];
        NSArray *urls = [[SubscribeManager sharedManager] getURLs];
        for (NSString *url in urls) {
            [parser parseByURL:[[NSURL alloc] initWithString:url] addItemBlock:^(STCRSSItem *item) {
                [self addItem:item];
            } reloadItemsBlock:^{
                [self didUpdateItems];
            }];
        }
    });
}

- (void)didUpdateItems {
    NSSortDescriptor *publicationDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"publicationDate" ascending:NO];
    _itemArray = [[_itemArray sortedArrayUsingDescriptors:@[publicationDateDesc]] mutableCopy];
    [self.delegate reloadTableView];
}
@end
