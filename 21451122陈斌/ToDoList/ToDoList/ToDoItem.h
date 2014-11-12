//
//  ToDoItem.h
//  ToDoList
//
//  Created by lqynydyxf on 14/11/8.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
