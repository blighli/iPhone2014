//
//  CoreDataHelper.h
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Note.h"

@interface CoreDataHelper : NSObject

// method for note
+ (NSMutableArray *)getAllNote:(NSManagedObjectContext *)context;
+ (Note *)getNoteWithID:(NSNumber *)noteID inContext:(NSManagedObjectContext *)context;
+ (void)deleteNote:(Note *)note inContext:(NSManagedObjectContext *)context;

// method for all Entity
+ (NSNumber *)gernerateUidForEntity:(NSString *)entityName
                           inContex:(NSManagedObjectContext *)context;

+ (NSManagedObject *)CreateEntityFactory:(NSString *)entityName
                               inContext:(NSManagedObjectContext *)context;
@end
