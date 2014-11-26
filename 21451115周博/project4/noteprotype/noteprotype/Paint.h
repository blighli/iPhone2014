//
//  Paint.h
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Paint : NSManagedObject

@property (nonatomic, retain) NSNumber * paint_id;
@property (nonatomic, retain) NSString * paintName;
@property (nonatomic, retain) NSString * paintUrl;
@property (nonatomic, retain) Note *paintOwner;

@end
