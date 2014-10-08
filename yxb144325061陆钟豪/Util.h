//
//  Util.h
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* createMidTitle(NSString* title, NSInteger lenOfTitle, NSInteger length);
NSInteger calcuteDays_old(NSInteger year, NSInteger month, NSInteger day);
NSInteger calcuteWeekday_old(NSInteger year, NSInteger month, NSInteger day);
NSRange calcuteRangeOfMonth_old(NSInteger year, NSInteger month);

#define MIN_YEAR 1
#define MAX_YEAR 9999
#define MIN_MONTH 1
#define MAX_MONTH 12
#define MONTH_WEEK_LINE 6
#define HEIGHT_MONTH_CAL 8
#define WIDTH_MONTH_CAL 20
#define WIDTH_YEAR_CAL 64
#define COL_YEAR_CAL 3
#define ROW_YEAR_CAL 4
