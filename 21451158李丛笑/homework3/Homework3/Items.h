//
//  Items.h
//  Homework3
//
//  Created by 李丛笑 on 14/11/9.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#ifndef Reminder_Items_h
#define Reminder_Items_h
#import <Foundation/Foundation.h>

@interface Items : NSObject

// 名称
@property (nonatomic, copy) NSString *name;
// 描述
@property (nonatomic, copy) NSString *desc;

+ (id)itemWithName:(NSString *)name desc:(NSString *)desc;


@end

#endif
