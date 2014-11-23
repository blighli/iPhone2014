//
//  Note.h
//  AverNote
//
//  Created by Mz on 14-11-22.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MagicalRecord/CoreData+MagicalRecord.h"

@interface Note : NSManagedObject

@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;

@end

enum {
    NoteTypeText = 1,
    NoteTypePhoto = 2,
    NoteTypeDarwing = 3
};