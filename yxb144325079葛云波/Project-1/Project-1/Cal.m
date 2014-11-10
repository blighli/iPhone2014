//
//  Cal.m
//  Project-1
//
//  Created by 葛 云波 on 14-10-18.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "Cal.h"
@interface Cal()
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSCalendar *calendar;
@property(nonatomic,strong) NSDateComponents *dateCompents;
@property(nonatomic,assign) NSCalendarUnit calendarUnit;
@end

@implementation Cal

-(id)init{
    
    if (self=[super init]) {
        self.date=[NSDate date];
        self.calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        self.calendarUnit=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
        self.dateCompents=[self.calendar components:self.calendarUnit fromDate:self.date];
    }
    return self;
}

-(void)printCalendarForMonth:(NSInteger)m andYear:(NSInteger)y
{
    int month[13] = {0,31,28,31,30,31,30,31,31,30,31,30,31};
    NSInteger MyYear = y;
    NSInteger MyMonth = m;
    if (y%400==0||(y%4==0&&y%400!=0)) {
        month[2] = 29;
    }
    //用蔡勒公式计算出给定年给定月的第一天是星期几
    if (m==1||m==2) {
        y--;
        m += 12;
    }
    NSInteger a = y/100;
    NSInteger b = y%100;
    NSInteger WeekDay =  (a/4)-2*a+b+b/4+13*(m+1)/5;
    while(WeekDay<0)
        WeekDay += 7;
    WeekDay %= 7;
    switch (MyMonth) {
        case 1:
            printf("     一月 %ld         \n",MyYear);
            break;
        case 2:
            printf("     二月 %ld         \n",MyYear);
            break;
        case 3:
            printf("     三月 %ld         \n",MyYear);
            break;
        case 4:
            printf("     四月 %ld         \n",MyYear);
            break;
        case 5:
            printf("     五月 %ld         \n",MyYear);
            break;
        case 6:
            printf("     六月 %ld         \n",MyYear);
            break;
        case 7:
            printf("     七月 %ld         \n",MyYear);
            break;
        case 8:
            printf("     八月 %ld         \n",MyYear);
            break;
        case 9:
            printf("     九月 %ld         \n",MyYear);
            break;
        case 10:
            printf("     十月 %ld         \n",MyYear);
            break;
        case 11:
            printf("     十一月 %ld         \n",MyYear);
            break;
        case 12:
            printf("     十二月 %ld         \n",MyYear);
            break;
        default:
            break;
    }
    printf("日 一 二 三 四 五 六\n");
    for (int i=0; i<WeekDay; i++) {
        printf("   ");
    }
    for (int i=1; i<=month[MyMonth]; i++) {
        if (WeekDay==7) {
            WeekDay=0;
            printf("\n");
        }
        printf("%2d ",i);
        WeekDay++;
    }
    printf("\n");
}
-(void)printCurrentMonthCalendar{
    [self printCalendarForMonth:self.dateCompents.month andYear:self.dateCompents.year];
}
-(void)printMonthOfCurrentYearCalendar:(NSInteger)month{
    [self printCalendarForMonth:month andYear:self.dateCompents.year];
}
-(void)printYearCalendar:(NSInteger)year{
    for (int i=1; i<=12; i++)
        [self printCalendarForMonth:i andYear:year];
}

@end
