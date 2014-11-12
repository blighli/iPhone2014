//
//  TodoDao.h
//  TodoList
//
//  Created by 陈聪荣 on 14/11/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoDao : NSObject

+ (TodoDao*) sharedManager;
- (NSString *) applicationDocumentDirectoryFile;
- (void) createEditableCopyOfSavefileIfNeeded;


//- (int) create:(NSString*)model;
//- (int) removeAtIndex:(NSUInteger)index;
//- (int) edit:(NSString*)model atIndex:(NSUInteger)index;
- (int) saveAll:(NSMutableArray*) array;
- (NSMutableArray*) findAll;

@end
