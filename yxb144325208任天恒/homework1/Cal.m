//
//  Cal.m
//  cal
//
//  Created by rth on 14-10-12.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "Cal.h"

@implementation Cal
-(NSMutableArray *) Year:(NSInteger) year andMonth:(NSInteger) month
{
    NSMutableArray *arrayMonth = [NSMutableArray array];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:1];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calendar dateFromComponents:comps];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSInteger numberOfDaysInMonth = range.length;//一个月的天数
    //NSLog(@"%ld",(long)numberOfDaysInMonth);
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    //NSLog(@"%@",comps);
    //NSLog(@"hahhaha");
    //NSLog(@"%ld",(long)unitFlags);
    //NSLog(@"%ld",(long)week);
    
    for (int i = 0; i<week-1; i++)
        [arrayMonth addObject:@"  "];// 当月开始有几天是属于上个月的就打出几个“”
        //NSLog(@"%@",arrayMonth);
    
    for (int i = 1; i<=numberOfDaysInMonth; i++) {
        if (i<10) {
            [arrayMonth addObject:[NSString stringWithFormat:@" %d", i]];//duiqi
        } else
            [arrayMonth addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return arrayMonth;
}

-(void) showYear:(NSInteger) year andMonth:(NSInteger) month
{
    NSArray *Week = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
    NSArray *monthCal = [self Year:year andMonth:month];
    if (month<=10) {
        for (int i = 0; i<(16-4)/2; i++) {
            printf(" ");
        }
    } else {
        for (int i = 0; i<(16-6)/2; i++) {
            printf(" ");
        }
    }
    printf("%s %li\n",[[Week objectAtIndex:month-1] UTF8String],(long)year);
    printf("日 一 二 三 四 五 六\n");//1
    for (int i = 0;i<[monthCal count];i++) {
        printf("%s ",[[monthCal objectAtIndex:i] UTF8String]);
        if ((i+1)%7 == 0&&i!=[monthCal count]-1) {
            printf("\n");
        }
    }
    printf("\n");
}

-(void) showYear:(NSInteger) year
{
    NSArray *Week = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月", nil];
    NSMutableArray *arrayMonth[13];
    NSInteger maxMonth[4];
    for (int i = 1; i<=12; i++) {
        arrayMonth[i] = [self Year:year andMonth:i];
    }
    for (int i = 0; i<4; i++)
        maxMonth[i] = [self maxa:[arrayMonth[1+3*i] count] andb:[arrayMonth[2+3*i] count] andc:[arrayMonth[3+3*i] count]];
    
    for (int i = 0; i<(64-4)/2; i++) {
        printf(" ");
    }
    printf("%li\n",(long)year);
    
    for (int k = 0; k<4; k++) {
        for (int i = 0; i<(20-4)/2; i++) {
            printf(" ");
        }
        printf("%s ",[[Week objectAtIndex:3*k] UTF8String]);
        
        for (int i = 1; i<=2; i++) {
            if ([[Week objectAtIndex:3*k+i] isEqualToString:@"十二月"]) {
                for (int j = 0; j<16; j++) {
                    printf(" ");
                }
            } else {
                for (int j = 0; j<18; j++) {
                    printf(" ");
                }
            }
            printf("%s ",[[Week objectAtIndex:3*k+i] UTF8String]);

        }
        printf("\n");
        printf("日 一 二 三 四 五 六    日 一 二 三 四 五 六    日 一 二 三 四 五 六\n");//2
        NSInteger row;
        if (maxMonth[k]%7 == 0)
            row = maxMonth[k]/7;
        else
            row = maxMonth[k]/7+1;
        
        for (int i = 0; i<row; i++) {
            for (int j = 0; j<3; j++) {
                for (int q = 0; q<7; q++) {
                    if (i*7+q+1>[arrayMonth[3*k+j+1] count]) {
                        printf("   ");
                    } else
                        printf("%s ",[[arrayMonth[3*k+j+1] objectAtIndex:7*i+q] UTF8String]);
                }
                printf(" ");
            }
            printf("\n");
        }
    }
    
}

-(void) Error
{
    printf("时间输入不正确！\n");
}

-(NSInteger) maxa:(NSInteger) a andb:(NSInteger) b andc:(NSInteger) c
{
    NSInteger max = a;
    
    if (b>max) {
        max = b;
    }
    if (c>max) {
        max = c;
    }
    
    return max;
}
@end


