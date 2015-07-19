//
//  ToDoItem.h
//  Project3
//
//  Created by jingcheng407 on 14-11-14.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
