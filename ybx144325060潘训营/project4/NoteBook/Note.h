//
//  Entity.h
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MagicalRecord/CoreData+MagicalRecord.h"

@interface Note : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * content;

@end

enum {
    NoteTypeText = 1,
    NoteTypePhoto = 2,
    NoteTypeDarwing = 3
};
