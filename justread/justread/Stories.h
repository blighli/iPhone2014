//
//  Stories.h
//  justread
//
//  Created by Van on 14/12/5.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stories : NSObject

@property (nonatomic) NSNumber *id;
@property (nonatomic) NSString *share_url;
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray *images;
@property (nonatomic) NSString *ga_prefix;
@property (nonatomic) NSString *date;

@end
