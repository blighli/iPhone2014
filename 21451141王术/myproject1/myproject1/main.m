//
//  main.m
//  myproject1
//
//  Created by  ws on 14-10-1.
//  Copyright (c) 2014年  ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mycal.h"
//去除NSLog时间戳
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc==1){//cal 输出当月月历
            //获得当前日期
            NSDate *date = [NSDate date];
            //   NSLog(@"%@",date);
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            //  NSLog(@"%@",calendar);
            NSDateComponents *comps;
            //本年
            comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
            //[comps setYear:b];
            NSInteger year = [comps year];
            
            //本月
            comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
            //[comps setMonth:a];
            
            NSInteger month = [comps month];
            //本月第一天的星期
            mycal *cal=[[mycal alloc] init];
            [cal firstWeekDay:month theYear:year];
            //下月第一天
            //本月最后一天
            [cal theMaxDay:month theYear:year];
            [cal print];
            
        }
    }
    
    return 0;
}
