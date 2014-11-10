//
//  Calender.h
//  Calender
//
//  Created by cstlab on 14-10-14.
//  Copyright (c) 2014年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface
Calender : NSObject{
    int _year;
    int _month;
}
- (void) setyear: (int)year month:(int)month;
- (void) printTargetMonth;
- (void) printTargetYear;
@end


