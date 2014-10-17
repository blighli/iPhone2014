//
//  MyCalender.m
//  lzxlzx
//
//  Created by hu on 14-10-16.
//  Copyright (c) 2014年 hu. All rights reserved.
//
#import "MyCalender.h"

@implementation MyCalender
-(void)printfCalender: (int)year month:(int)month
{
    NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date=[dateFormatter dateFromString:dateString];
    
    
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit  fromDate:date];
    
    int temp_year =(int)components.year;
    int temp_month =(int)components.month;
    int temp_weekday =(int)components.weekday;
    
    
    int days=0;
    
    if(temp_month == 2) {
        if((temp_year%4==0&&temp_year%100!=0)||(temp_year%400==0)) {
            days = 28;
        } else {
            days = 29;
        }
    } else if(temp_month == 4 || temp_month == 6 || temp_month == 9 || temp_month == 11) {
        days = 30;
    } else {
        days = 31;
    }
    
    NSLog(@"    %d月 %d 年",temp_month, temp_year);
    
    printf(" 日 一  二 三  四 五 六");
    printf("\n");
    int j = temp_weekday;
    while(--temp_weekday){
        printf("   ");
    }
    for(int i = 1;i <= days; i ++)
    {
        printf(" %2d",i);
        j++;
        if(j>7)
        {
            printf("\n");
            j=1;
        }
        
        
    }
    printf("\n");
}
@end
