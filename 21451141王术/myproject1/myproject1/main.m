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
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps;
            //本年
            comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
            NSInteger year = [comps year];
            //本月
            comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
            NSInteger month = [comps month];
            //本月第一天是星期几
            mycal *cal=[[mycal alloc] init];
            [cal firstWeekDay:month theYear:year];
            //该月共多少天
            [cal theMaxDay:month theYear:year];
            //输出日历
            [cal print];
            
        }
        else if(argc==3){//“cal 月 年“与”cal -m 月“的处理
            NSString *a=[[NSString alloc] initWithCString:(const char*)argv[2] encoding:NSASCIIStringEncoding];
            NSString *b=[[NSString alloc] initWithCString:(const char*)argv[1] encoding:NSASCIIStringEncoding];
            NSInteger year=[a integerValue];
            NSInteger month=[b integerValue];
            //年份异常处理
            if (year<=0||year>9999) {
                NSLog(@"mycal: year %ld not in range 1..9999",year);
                return 0;
            }
            //月异常处理
            if (month<0||month>12) {
                NSLog(@"mycal: %ld is neither a month number (1..12) nor a name",month);
                return 0;
            }
            //cal -m 的处理
            if (month==0) {
                NSString *c=@"-m";
                if([b isEqualToString:c]){
                    month=year;
                    year=2014;
                }
                else{
                    NSLog(@"mycal: %ld is neither a month number (1..12) nor a name",month);
                return 0;
                }
            }
            //本月第一天是星期几
            mycal *cal=[[mycal alloc] init];
            [cal firstWeekDay:month theYear:year];
            //该月共多少天
            [cal theMaxDay:month theYear:year];
            //输出日历
            [cal print];

        }
    }
    
    return 0;
}
