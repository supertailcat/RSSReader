//
//  RSSItem.m
//  RSSReader
//
//  Created by 于沛尧 on 2021/10/11.
//

#import "STCRSSItem.h"

@implementation STCRSSItem

-(void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_linkURL forKey:@"linkURL"];
    [coder encodeObject:_itemDescription forKey:@"itemDescription"];
    [coder encodeObject:_publicationDate forKey:@"publicationDate"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self=[super init])
        {
            self.title = [coder decodeObjectForKey:@"title"];
            self.linkURL = [coder decodeObjectForKey:@"linkURL"];
            self.itemDescription = [coder decodeObjectForKey:@"itemDescription"];
            self.publicationDate = [coder decodeObjectForKey:@"publicationDate"];
        }
        return (self);
}

@end
