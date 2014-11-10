//
//  MyDate.m
//  mydate
//
//  Created by apple on 14-10-17.
//  Copyright (c) 2014年 潘训营. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "MyDate.h"


@implementation MyDate

const char* m[] = {"", "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};



- (void) printMonth: (int)year : (int)month
{
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents:components];
    
    int one = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    NSRange r = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    int totalday = (int)r.length;
    
    printf("     %s %d\n",m[month],year);
    printf("日 一 二 三 四 五 六\n");
    
    int line = 0;
    for (int day = 1; day <= totalday; day++) {
        if (day == 1) {
            for(int i = 1; i < one ;i++) {
                if(i==1) printf("  ");
                else printf("   ");
            }
            if((day+one-1)%7 == 1) printf("%2d",day);
            else printf("%3d",day);
            if(one == 7) {
                printf("\n");
                line++;
            }
        }else {
            if((day+one-1)%7 == 1) printf("%2d",day);
            else printf("%3d",day);
            if((day+one-1)%7 == 0) {
                printf("\n");
                line++;
            }
        }
    }
    if((totalday+one)% 7 !=0) {
        int mod = (totalday+one-1)%7;
        while(mod != 0) {
            if(mod == 1) printf(" ");
            else printf("   ");
            mod = (mod+1)%7;
        }
        printf("\n");
        line++;
    }
    while (line<6) {
        printf("\n");
        line++;
    }
}


- (void) printYear: (int)year
{
    printf("                              %d                              \n", year);
    
    for (int i=1; i<=12; i+=3) {
        NSMutableString* f[10] ;
        for (int j=0; j<10; j++) {
           f[j] = [[NSMutableString alloc] init];
        }
        if(i==1) {
            [f[0] appendString:@"        一月          "];
            [f[0] appendString:@"        二月          "];
            [f[0] appendString:@"        三月        \n"];
        }
        else if(i==4) {
            [f[0] appendString:@"        四月          "];
            [f[0] appendString:@"        五月          "];
            [f[0] appendString:@"        六月        \n"];
        }else if(i==7) {
            [f[0] appendString:@"        七月          "];
            [f[0] appendString:@"        八月          "];
            [f[0] appendString:@"        九月        \n"];
        }else if(i==10) {
            [f[0] appendString:@"        十月          "];
            [f[0] appendString:@"        十一月        "];
            [f[0] appendString:@"        十二月      \n"];
        }
        
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        
        NSDateComponents* components = [[NSDateComponents alloc] init];
        [components setYear:year];
        [components setMonth:i];
        [components setDay:1];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDate* date = [calendar dateFromComponents:components];
        
        int one1 = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
        NSRange r1 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
        int totalday1 = (int)r1.length;
        
        [components setMonth:i+1];
        date = [calendar dateFromComponents:components];
        int one2 = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
        NSRange r2 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
        int totalday2 = (int)r2.length;
        
        [components setMonth:i+2];
        date = [calendar dateFromComponents:components];
        int one3 = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
        NSRange r3 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
        int totalday3 = (int)r3.length;
        
        int day1 = 1;
        int day2 = 1;
        int day3 = 1;
        for (int line = 1; line <= 6; line++) {
            
            int d = 1;
            
            //1
            for(d = 1; d <= 7 && day1<=totalday1; d++) {
                if (day1 == 1) {
                    for(int i = 1; i < one1 ;i++) {
                        if(i==1) printf("  ");
                        else printf("   ");
                        d++;
                    }
                    if((day1+one1-1)%7 == 1) printf("%2d",day1);
                    else printf("%3d",day1);
                    day1++;
                }else {
                    if((day1+one1-1)%7 == 1) printf("%2d",day1);
                    else printf("%3d",day1);
                    day1++;
                }
            }
            while(d<=7) {
                if(d==1) printf("  ");
                else printf("   ");
                d++;
            }
            printf("  ");
            
            //2
            for(d = 1; d <= 7 && day2<=totalday2; d++) {
                if (day2 == 1) {
                    for(int i = 1; i < one2 ;i++) {
                        if(i==1) printf("  ");
                        else printf("   ");
                        d++;
                    }
                    if((day2+one2-1)%7 == 1) printf("%2d",day2);
                    else printf("%3d",day2);
                    day2++;
                }else {
                    if((day2+one2-1)%7 == 1) printf("%2d",day2);
                    else printf("%3d",day2);
                    day2++;
                }
            }
            while(d<=7) {
                if(d==1) printf("  ");
                else printf("   ");
                d++;
            }
            printf("  ");
            
            //3
            for(d = 1; d <= 7 && day3<=totalday3; d++) {
                if (day3 == 1) {
                    for(int i = 1; i < one3 ;i++) {
                        if(i==1) printf("  ");
                        else printf("   ");
                        d++;
                    }
                    if((day3+one3-1)%7 == 1) printf("%2d",day3);
                    else printf("%3d",day3);
                    day3++;
                }else {
                    if((day3+one3-1)%7 == 1) printf("%2d",day3);
                    else printf("%3d",day3);
                    day3++;
                }
            }
            while(d<=7) {
                if(d==1) printf("  ");
                else printf("   ");
                d++;
            }
            printf("\n");
        }
    }
}


@end
