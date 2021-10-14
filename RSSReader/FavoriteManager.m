//
//  FavoriteManager.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/14.
//

#import "FavoriteManager.h"
#import "STCRSSItem.h"

@interface FavoriteManager ()

@property (nonatomic, strong) NSMutableArray<STCRSSItem *> *itemsArray;

@end

@implementation FavoriteManager

+ (instancetype)sharedManager {
    static id sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [self new];
        [sharedInst initFavoriteItems];
    });
    return sharedInst;
}

- (void)initFavoriteItems {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favoritePath = [documentsDirectory stringByAppendingPathComponent:@"Favorite.archiver"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:favoritePath]) {
        _itemsArray = [NSMutableArray array];
    } else {
        _itemsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:favoritePath];
    }
}

- (STCRSSItem *)getFavoriteItemWithIndex:(NSUInteger)index {
    return (index <= _itemsArray.count - 1) ? _itemsArray[index] : nil;
}

- (NSArray *)getFavoriteItems {
    return _itemsArray;
}

- (NSUInteger)getFavoriteItemsNumber {
    return _itemsArray.count;
}



- (void)addFavoriteItem:(STCRSSItem *)item complicationBlock:(void (^)(BOOL))addItemBlock {
    [_itemsArray insertObject:item atIndex:0];
    addItemBlock([self saveToFile]);
}

- (void)removeFavoriteItemAtIndex:(NSUInteger)index {
    [_itemsArray removeObjectAtIndex:index];
    [self saveToFile];
}

- (void)exchangeFavoriteItemAtIndex:(NSUInteger)index1 withFavoriteItemAtIndex:(NSUInteger)index2 {
    [_itemsArray exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    [self saveToFile];
}

- (BOOL)saveToFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *favoritePath = [documentsDirectory stringByAppendingPathComponent:@"Favorite.archiver"];
    return [NSKeyedArchiver archiveRootObject:_itemsArray toFile:favoritePath];
}

@end
