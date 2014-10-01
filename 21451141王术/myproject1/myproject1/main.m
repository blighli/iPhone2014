//
//  main.m
//  myproject1
//
//  Created by  ws on 14-10-1.
//  Copyright (c) 2014年  ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //获得当前日期
        while (1) {
            int a,b;
            scanf("%d%d",&a,&b);
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        //本年
        //comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
            [comps setYear:b];
        NSInteger year = [comps year];
            
        //本月
        //comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
       [comps setMonth:a];
            
       NSInteger month = [comps month];
        //本月第一天的星期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat:@"MM月 yyyy"];
        NSString *timeyn=[formatter stringFromDate:date];
        NSLog(@"     %ld月%ld",(long)month,(long)year);
        NSLog(@"日 一 二 三 四 五 六");
//        NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",(long)month,1,(long)year];
        //NSLog(@"%@",formatter);
        //date = [formatter dateFromString:firstDay];
        comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
        NSInteger weekday = [comps weekday];
        NSLog(@"%ld",(long)weekday);
        //下月第一天
        NSDateComponents *c1 = [[NSDateComponents alloc] init];
        [c1 setMonth:1];
        NSDate *date2 = [calendar dateByAddingComponents:c1 toDate:date options:0];
        //本月最后一天
        NSDateComponents *c2 = [[NSDateComponents alloc] init];
        [c2 setDay:-1];
        NSDate *date3 = [calendar dateByAddingComponents:c2 toDate:date2 options:0];
        comps = [calendar components:(NSDayCalendarUnit) fromDate:date3];
        NSInteger maxDays = [comps day];
        NSLog(@"%ld",(long)maxDays);
        }
        
    }
    return 0;
}
