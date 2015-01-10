//
//  ImageInfo.m
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "ImageInfo.h"
@implementation ImageInfo
-(id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.thumbURL = [dictionary objectForKey:@"image_url"];
        self.width = [[dictionary objectForKey:@"image_width"]floatValue];
        self.height = [[dictionary objectForKey:@"image_height"]floatValue];
        self.title = [dictionary objectForKey:@"desc"];
        self.love = [dictionary objectForKey:@"love"];
    }
    return self;
}

+(instancetype)photoWithProperties:(NSDictionary *)photoInfo{
    return [[ImageInfo alloc] initWithDictionary:photoInfo];
}
@end
