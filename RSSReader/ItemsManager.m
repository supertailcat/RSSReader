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

@property (atomic, strong) NSMutableArray *itemsArray;//应该有比atomic更好的方法，可以考虑创建一个队列用于add

@end

@implementation ItemsManager

+ (instancetype)sharedManager {
    static id sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [self new];
        [sharedInst initItems];
    });
    return sharedInst;
}

- (void)initItems {
    self.itemsArray = [NSMutableArray array];
    [self updateItems];
}

- (NSUInteger)itemsCount {
    return _itemsArray.count;
}

- (STCRSSItem *)itemAtIndex:(NSUInteger)index {
    return (index <= _itemsArray.count - 1) ? _itemsArray[index] : nil;
}

- (void)addItem:(STCRSSItem *)item {
    [_itemsArray addObject:item];
}

- (void)updateItems {
    //todo
    [_itemsArray removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Parser *parser = [[Parser alloc] init];
        for(int index = 0; index < [[SubscribeManager sharedManager] URLsCount]; index++) {
            [parser parseByURL:[[NSURL alloc] initWithString:[[SubscribeManager sharedManager] URLsAtIndex:index]] addItemBlock:^(STCRSSItem *item) {
                [self addItem:item];
            } reloadItemsBlock:^{
                [self didUpdateItems];
            }];
        }
    });
}

- (void)didUpdateItems {
    NSSortDescriptor *publicationDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"publicationDate" ascending:NO];
    _itemsArray = [[_itemsArray sortedArrayUsingDescriptors:@[publicationDateDesc]] mutableCopy];
    [self.delegate reloadTableView];
}
@end
