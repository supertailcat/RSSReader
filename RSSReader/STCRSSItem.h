//
//  RSSItem.h
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STCRSSItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *itemDescription;
@property (nonatomic, strong) NSString *publicationDate;

@end

NS_ASSUME_NONNULL_END
