//
//  ToDoItem.h
//  ToDoList
//
//  Created by 葛 云波 on 14/11/10.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property NSString* itemName;
@property BOOL completed;
@property (readonly) NSData* creationDate;

@end
