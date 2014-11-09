//
//  CalUtil.h
//  homework1
//
//  Created by yingxl1992 on 14-10-11.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthCal : NSObject
{
    NSInteger year;
    NSInteger month;
}
@property NSInteger year;
@property NSInteger month;

-(id)initWithYear:(NSInteger)y AndMonth:(NSInteger)m;

-(int)calDayNums;

-(NSString *)printMonth;

-(NSArray *) calOneMonth:(NSInteger)type;

-(void) outputMonthByYM;

@end
