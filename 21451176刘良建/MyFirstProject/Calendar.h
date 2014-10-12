//
//  Calendar.h
//  NSdate
//
//  Created by JANESTAR on 14-10-11.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject

   
+(int)DaysInYear:(int)year inMonth:(int)month;
+(void)print_One:(int)year inMonth:(int)month;
+(void)print_All:(int)year;
@end
