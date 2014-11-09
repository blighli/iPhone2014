//
//  ControlOut.m
//  yxb144325042杨长湖
//
//  Created by 杨长湖 on 14-10-10.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "Calendar.h"

@implementation Utils

//输出月头：月 年 星期
- (void) showCalenderHead:(int)year andMonth:(int)month{
    char *m[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    printf("     %s %d     \n",m[month-1],year);
    printf("日 一 二 三 四 五 六\n");
}

//获取当前时间 年
- (int) getYearOfNow{
    NSDate *now = [[NSDate alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit fromDate:now];
    return (int)[comps year];
}

//获取当前时间 月
- (int) getMonthOfNow{
    NSDate *now = [[NSDate alloc]init];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [calendar components:NSMonthCalendarUnit fromDate:now];
    return (int)[comps month];
}

//运行 cal
- (void) showCalendarOfThisMonth{
    int year = [self getYearOfNow];
    int month = [self getMonthOfNow];
    [self showCalendarOfYearAndMonth:year andMonth:month];
}

//运行 cal -m 月
- (void) showCalendarOfMonth:(int)month{
    int year = [self getYearOfNow];
    [self showCalendarOfYearAndMonth:year andMonth:month];
}

//运行 cal 月 年
- (void) showCalendarOfYearAndMonth:(int)year andMonth:(int)month{
    Calendar *cal=[[Calendar alloc]init];
    [cal buildCalendar:year andMonth:month];
    [self showCalenderHead:year andMonth:month];
    [cal showCalendar];
}

//运行 cal 年
- (void) showCalendarOfYear:(int)year{
    Calendar *cal[12];
    char *m[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    
    for (int i=0; i<12; i++) {
        cal[i] = [[Calendar alloc]init];
        [cal[i] buildCalendar:year andMonth:(i+1)];
    }
    printf("                             %d\n\n",year);
    //打印3个月，分4次
    for (int i=0; i<4; i++) {
        int n = i*3;
        if (n == 9) {
            printf("        %s                 %s                %s\n",m[n],m[n+1],m[n+2]);
        }
        else{
            printf("        %s                  %s                  %s\n",m[n],m[n+1],m[n+2]);
        }
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        
        [self show3Month:cal[n] :cal[n+1] :cal[n+2]];
        
    }
}

//打印3个月
- (void) show3Month:(Calendar *)cal1 :(Calendar *)cal2 :(Calendar *)cal3{
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
            if ([cal1 getCalendarRC:i andc:j] !=0) {
                [self print:[cal1 getCalendarRC:i andc:j]];
            }else{
                printf("   ");
            }
        }
        printf(" ");
        for (int j=0; j<7; j++) {
            if ([cal2 getCalendarRC:i andc:j] !=0) {
                [self print:[cal2 getCalendarRC:i andc:j]];
            }else{
                printf("   ");
            }
        }
        printf(" ");
        for (int j=0; j<7; j++) {
            if ([cal3 getCalendarRC:i andc:j] !=0) {
                [self print:[cal3 getCalendarRC:i andc:j]];
            }else{
                printf("   ");
            }
        }
        printf("\n");
    }
}

//定义日期输出空格
- (void) print:(int)num{
    if (num < 10) {
        printf(" %d ",num);
    }else{
        printf("%d ",num);
    }
}


@end


