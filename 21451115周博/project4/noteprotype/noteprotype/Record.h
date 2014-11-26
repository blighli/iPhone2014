//
//  Record.h
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * recordName;
@property (nonatomic, retain) NSString * recordUrl;
@property (nonatomic, retain) NSNumber * record_id;
@property (nonatomic, retain) Note *recordOwner;

@end
