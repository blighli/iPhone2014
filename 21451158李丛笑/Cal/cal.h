//
//  cal.h
//  Cal
//
//  Created by 李丛笑 on 14-10-12.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

@interface Cal : NSObject

- (int) Firstday: (int)year Month:(int)month;

- (int) DaysofMonth:(int) year Month:(int) month;

- (NSString *) PrintNameofMonth:(int) month;

- (NSString *) PrintDays;

- (NSString *) PrintFirstline:(int) month;

- (NSString *) Print:(int) days Firstday:(int) firstday Week:(int) week;


@end // Cal