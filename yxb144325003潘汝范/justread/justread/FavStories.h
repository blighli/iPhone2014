//
//  FavStories.h
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FavStories : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * ga_prefix;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * images;
@property (nonatomic, retain) NSString * share_url;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type;

@end
