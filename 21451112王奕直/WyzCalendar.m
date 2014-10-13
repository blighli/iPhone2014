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
    NSArray *array =[NSArray arrayWithObjects:@"日",@" 一", @" 二",@" 三",@" 四",@" 五",@" 六",nil];
    NSMutableArray *calendarArr;
    printf("                              %d\n\n",year);
    for (int i = 0; i < 12; i++) {
        [WyzCalendar calculateYear:year andMonth:i+1];
    }
    int count = 0;
    for(int i = 0;i < 4;i++){
        int dayCount[3] = {1,1,1};
        int firstWeek[3];
        firstWeek[0] = buffer[i * 3][0];
        firstWeek[1] = buffer[i * 3 + 1][0];
        firstWeek[2] = buffer[i * 3 + 2][0];
        for (int j = 0; j < 8; j++) {
            switch (j) {
                case 0:
                    printf("\t%s月\t\t      ",[[monthArray objectAtIndex:i * 3] UTF8String]);
                    i * 3 + 2 > 10?printf(""):printf(" ");
                    printf("%s月\t\t   ",[[monthArray objectAtIndex:i * 3 + 1] UTF8String]);
                    i * 3 + 3 > 10?printf(""):printf(" ");
                    printf("%s月\n",[[monthArray objectAtIndex:i * 3 + 2] UTF8String]);
                    break;
                case 1:
                    for (int k = 0; k < 3; k++) {
                        for(int l = 0;l < 7;l++){
                            printf("%s",[[array objectAtIndex:l] UTF8String]);
                        }
                        printf("  ");
                    }
                    printf("\n");
                    break;
                case 2:
                    for (int k = 0; k < 3; k++) {
                        while(buffer[i * 3 + k][0]-- > 1){
                            printf("   ");
                        }
                        printf(" ");
                        for (int l = 0; l <= 7 - firstWeek[(i * 3 + k) % 3]; l++) {
                            buffer[i * 3 + k][1]--;
                            printf("%d  ",dayCount[( i * 3 + k) % 3]++);
                        }
                    }
                    printf("\n");
                    break;
                default:
                    for (int k = 0; k < 3; k++) {
                        for(int l = 0;l < 7;l++){
                            if (buffer[i * 3 + k][1]-- > 0) {
                                l == 0 && dayCount[(i * 3 + k) %3 ] < 10?printf(" "):printf("");
                                printf("%d ",dayCount[(i * 3 + k) % 3]++);
                                dayCount[(i * 3 + k)%3] > 9||(dayCount[(i * 3 + k) % 3] == 9 && l == 6)?printf(""):printf(" ");
                            }
                            else{
                                printf("   ");
                            }
                        }
                        printf(" ");
                    }
                    printf("\n");
                    break;
            }
        }
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
