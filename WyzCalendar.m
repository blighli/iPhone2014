//
//  WyzCalender.m
//  calendar_project1
//
//  Created by alwaysking on 14-10-12.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "WyzCalendar.h"

@implementation WyzCalendar

 int buffer[12][2];
+(void) setCurrentYear:(int)year andMonth:(int)month{
    NSArray *monthArray = [NSArray arrayWithObjects:@"一", @"二",@"三",@"四",@"五",@"六", @"七",@"八",@"九",@"十",@"十一",@"十二",nil];
    month > 10?printf(""):printf(" ");
    printf("    %s月 %d\n",[[monthArray objectAtIndex:(month-1)] UTF8String],year);
    [WyzCalendar calculateYear:year andMonth:month];
    [WyzCalendar showCalendarSetYear:year andMonth:month];
    printf("\n");
}

+(void) setYear:(int)year{
    NSArray *monthArray = [NSArray arrayWithObjects:@"一", @"二",@"三",@"四",@"五",@"六", @"七",@"八",@"九",@"十",@"十一",@"十二",nil];
    NSArray *calendarArray;
    printf("         %d\n\n",year);
    for(int i = 1;i <= 12;i++){
        for (int j = 0; j < 12; j++) {
            [WyzCalendar calculateYear:year andMonth:j+1];
        }
        i > 10?printf(""):printf(" ");
        printf("       %s月\n",[[monthArray objectAtIndex:i - 1] UTF8String]);
        [WyzCalendar showCalendarSetYear:year andMonth:i];
        printf("\n\n");
    }
}

+(void)calculateYear:(int)mYear andMonth:(int)mMonth{
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * dateComponents = [cal components:NSWeekdayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:date];
    [dateComponents setDay:1];
    [dateComponents setYear:mYear];
    [dateComponents setMonth:mMonth];
    [dateComponents setHour:10];
    
    NSDate * date1 = [cal dateFromComponents:dateComponents];
    
    NSDateComponents * dateComponents1 = [cal components:NSWeekdayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:date1];
    
    int mWeek = (int)[dateComponents1 weekday];
    //下月第一天
    NSDateComponents *d1 = [[NSDateComponents alloc] init];
    [d1 setMonth:1];
    NSDate *dat2 = [calendar dateByAddingComponents:d1 toDate:date1 options:0];
    //该月最后一天
    NSDateComponents *d2 = [[NSDateComponents alloc] init];
    [d2 setDay:-1];
    NSDate *dat3 = [calendar dateByAddingComponents:d2 toDate:dat2 options:0];
    dateComponents1 = [calendar components:(NSDayCalendarUnit) fromDate:dat3];
    NSInteger maxDay = [dateComponents1 day];
    buffer[mMonth - 1][0] = (int) mWeek;
    buffer[mMonth - 1][1] = (int) maxDay;
}

+(void) showCalendarSetYear:(int)year andMonth:(int)month{
    int date = 1;
    int currentWeek = buffer[month -1][0];
    NSArray *array =[NSArray arrayWithObjects:@"日",@" 一", @" 二",@" 三",@" 四",@" 五",@" 六",nil];
    for(int i = 0;i < 7;i++){
        printf("%s",[[array objectAtIndex:i] UTF8String]);
    }
    printf("\n");
    if(buffer[month -1][0]-- != 0){
        while(buffer[month -1][0]--){
            printf("   ");
        }
        printf(" ");
    }
    while (buffer[month - 1][1] --) {
        printf("%d", date ++);
        if(currentWeek + 1 == 8){
            printf("\n");
            if(date < 10 ){
                printf(" ");
            }
            currentWeek = 1;
            continue;
        }
        else {
            if(date < 10)
                printf("  ");
            else
                printf(" ");
            currentWeek ++;
        }
        
    }
}
@end
