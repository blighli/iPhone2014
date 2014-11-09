//
//  mycal.m
//  myproject1
//
//  Created by  ws on 14-10-3.
//  Copyright (c) 2014年  ws. All rights reserved.
//

#import "mycal.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation mycal
//这个月的第一天是星期几，用NSInterger类型表示（1表示星期天，2星期一）
-(NSInteger) firstWeekDay:(long)month theYear:(long)year{
    _month=month;
    _year=year;
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    //设置日期格式
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",(long)_month,1,(long)_year];
    date = [formatter dateFromString:firstDay];
    comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    _weekday = [comps weekday];
    return _weekday;
}
//这个月总共多少天
-(NSInteger) theMaxDay:(long)month theYear:(long)year{
    _month=month;
    _year=year;
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",(long)_month,1,(long)_year];
    date = [formatter dateFromString:firstDay];
    //下月第一天
    NSDateComponents *c1 = [[NSDateComponents alloc] init];
    [c1 setMonth:1];
    NSDate *date2 = [calendar dateByAddingComponents:c1 toDate:date options:0];
    //本月最后一天
    NSDateComponents *c2 = [[NSDateComponents alloc] init];
    [c2 setDay:-1];
    NSDate *date3 = [calendar dateByAddingComponents:c2 toDate:date2 options:0];
    comps = [calendar components:(NSDayCalendarUnit) fromDate:date3];
    _maxDays = [comps day];
    return _maxDays;
    
    
}
//输出日历
-(void) print{
    NSArray *yue=@[@"wu",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
    NSLog(@"     %@月 %ld",yue[_month],(long)_year);
    NSLog(@"日 一 二 三 四 五 六");
    for(int i=1;i<_weekday;i++){
        printf("   ");
    }
    NSInteger k=_weekday-1;
    for(int i=1;i<=_maxDays;i++){
        printf("%2i ",i);
        k++;
        if(k==7){
            printf("\n");
            k=0;
        }
        
        
    }
    printf("\n");
    
}

@end
