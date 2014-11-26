//
//  Photo.h
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * photoName;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSNumber * photo_id;
@property (nonatomic, retain) Note *photoOwner;

@end
