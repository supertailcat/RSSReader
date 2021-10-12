//
//  RSSNews.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSNews : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *itemDescription;

@end

NS_ASSUME_NONNULL_END