//
//  TodoItem.h
//  todolist
//
//  Created by Van on 14/11/7.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TodoItem : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * item;

@end
