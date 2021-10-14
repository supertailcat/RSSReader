//
//  SubscribeManager.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/13.
//

#import "SubscribeManager.h"

@interface SubscribeManager ()

@property (nonatomic, strong) NSMutableArray *URLsArray;

@end

@implementation SubscribeManager

+ (instancetype)sharedManager {
    static id sharedInst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInst = [self new];
        [sharedInst initURLs];
    });
    return sharedInst;
}

- (void)initURLs {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"Subscribe.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSString *userDataPath = [[NSBundle mainBundle] pathForResource:@"DefaultSubscribe" ofType:@"plist"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:userDataPath];
        _URLsArray = [dic objectForKey:@"URL List"];
        [dic writeToFile:plistPath atomically:YES];
    } else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        _URLsArray = [dic objectForKey:@"URL List"];
    }
    
}

- (NSUInteger)URLsCount {
    return _URLsArray.count;
}

- (NSString *)URLsAtIndex:(NSUInteger)index {
    return (index <= _URLsArray.count - 1) ? _URLsArray[index] : nil;
}

- (void)addURL:(NSString *)URL atIndex:(NSUInteger)index {
    if (index < _URLsArray.count) {
        [_URLsArray insertObject:URL atIndex:index];
    } else {
        [_URLsArray insertObject:URL atIndex:_URLsArray.count];
    }
    [self save];
}

- (void)removeURLAtIndex:(NSInteger)index {
    [_URLsArray removeObjectAtIndex:index];
    [self save];
}

- (void)modifyURL:(NSString *)URL atIndex:(NSUInteger)index {
    _URLsArray[index] = URL;
    [self save];
}

- (void)exchangeURLAtIndex:(NSUInteger)index1 withURLAtIndex:(NSUInteger)index2 {
    [_URLsArray exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    [self save];
}

- (void)save {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"Subscribe.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_URLsArray forKey:@"URL List"];
    if ([dic writeToFile:plistPath atomically:YES]) {
        NSLog(@"SUCCEED!");
    }
}

@end
