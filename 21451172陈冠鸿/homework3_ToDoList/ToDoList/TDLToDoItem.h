//
//  TDLToDoItem.h
//  ToDoList
//
//  Created by Chen.D.guanhong on 14/11/12.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLToDoItem : NSObject
@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;
@end
