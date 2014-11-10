//
//  CalUtil.h
//  homework1
//
//  Created by yingxl1992 on 14-10-11.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCal : NSObject

-(NSString *)addSpace:(NSInteger)n string:(NSString *)str len:(NSInteger)len;

-(int)calDayNums:(NSInteger)year month:(NSInteger)month;

-(NSString *)printMonth:(NSInteger)month;

-(NSArray *) calOneMonth: (NSInteger)y month:(NSInteger)month type:(NSInteger)type;

-(void) outputMonthByYM:(NSInteger)year month:(NSInteger)month;

-(void) outputYear:(NSInteger) year;

@end
