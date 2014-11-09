//
//  Item.h
//  TodoListWithCoreData
//
//  Created by zhou on 14/11/8.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSNumber * itemID;
@property (nonatomic, retain) NSString * itemName;

@end
