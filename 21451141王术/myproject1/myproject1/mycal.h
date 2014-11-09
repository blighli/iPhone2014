//
//  mycal.h
//  myproject1
//
//  Created by  ws on 14-10-3.
//  Copyright (c) 2014年  ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mycal : NSObject
@property NSInteger month;
@property NSInteger year;
@property NSInteger weekday;
@property NSInteger maxDays;
-(NSInteger) firstWeekDay:(long)month theYear:(long)year;
-(NSInteger) theMaxDay:(long)month theYear:(long)year;
-(void) print;
@end
