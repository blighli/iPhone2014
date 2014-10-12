//
//  Printcalendar.m
//  HomeworkOne
//
//  Created by HJ on 14-10-8.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Printcalendar.h"
char *HZmounth[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

@implementation Printcalendar
//打印一个月的日历
-(void)Printmounthcalendar: (int) year1 : (int)mounth1
{
    printf("     %s %d\n",HZmounth[mounth1-1],year1);
    int weekday = [self weekday:year1 :mounth1];
    int day = [self day:year1 :mounth1];
    int count = 1;
    //NSLog(@"%d",weekday);
    printf("日 一 二 三 四 五 六\n");
    for (int i = 1; i < weekday; i++) {
        printf("   ");
    }
    
    do
    {
        if (count < 10) {
            printf(" ");
        }

        printf("%d ",count);
        if ((count+weekday-1)%7 == 0) {
            printf("\n");
        }
        count++;
    }while(count <= day);
    printf("\n\n");
}
//打印一年的日历
-(void)Printyearcalendar: (int) year1
{
    int count,i,line = 12;
    int weekday=1;
    printf("                               %d\n\n",year1);
    
    for (line = 3; line <= 12; line=line+3) {
        if (line < 10) {
            for ( i = line-2; i<=line; i++) {
                printf("        %s          ",HZmounth[i-1]);
            }
        }else{
            printf("        %s          ",HZmounth[9]);
            printf("       %s          ",HZmounth[10]);
            printf("      %s          ",HZmounth[11]);
        }
        
        printf("\n日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        for ( i = line-2; i<=line; i++) {
            weekday = [self weekday:year1 :i];
            for (int i = 1; i < weekday; i++) {
                printf("   ");
            }
            //printf(" ");
            for (count = 1;(weekday+count)<9 ; count++) {
                if (count < 10) {
                    printf(" ");
                }
                printf("%d ",count);
            }
            printf(" ");
            // NSLog(@"%d",weekday);
        }
        printf("\n");
        for ( i = 1; i<=6; i++)
        {
            for (int j=line-2; j<=line; j++) {
                weekday = [self weekday:year1 :j];
                int day = [self day:year1 :j];
                for (int l=1; l<8; l++) {
                    if ((i*7-weekday+l+1) < 10) {
                        printf(" ");
                    }
                    if ((i*7-weekday+l+1)<=day) {
                        printf("%d ",(i*7-weekday+l+1));
                    }else{
                        printf("   ");
                    }
                }
                printf(" ");
                
            }
                printf("\n");

        }
          //printf("\n");
    }

    //for (int i =1; i <= 12 ; i++) {
    //    [self Printmounthcalendar:year1 : i];
    //}
}

//计算每个月的第一天是星期几
-(int)weekday: (int)year1 : (int)mounth1
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:mounth1];
    [comps setYear:year1];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    //[comps release];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = (int)[weekdayComponents weekday];
    //NSLog(@"%d",weekday);
    return weekday;
}

//计算一个月有几天
-(int)day:(int) year1 : (int) mounth1
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //[comps setDay:1];
    [comps setMonth:mounth1];
    [comps setYear:year1];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    
    NSRange days = [gregorian rangeOfUnit:NSDayCalendarUnit
                              inUnit:NSMonthCalendarUnit
                              forDate:date];
    return (int)days.length;
}
@end

