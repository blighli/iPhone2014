//
//  Calendar.h
//  Calendar
//
//  Created by guest on 14-10-12.
//  Copyright (c) 2014年 HuangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
@private
    int year;
    int month;
}
- (void) calYear: (int) aYear;//return all calendar in year
- (void) calMonth:(int) aMonth Year: (int) aYear; //return calendar of month in year
@end
