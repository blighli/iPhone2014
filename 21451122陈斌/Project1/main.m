//
//  main.m
//  Calender
//
//  Created by cstlab on 14-10-14.
//  Copyright (c) 2014年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calender.h"

const char *WeekDay = "日 一 二 三 四 五 六";
const char *Month[] = {"", "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
Boolean is_input_legal(int year,int month){
    Boolean is_input_legal=true;
    if(year<1||year>9999) is_input_legal=false;
    if (month<1||month>12) is_input_legal=false;
    return is_input_legal;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *date = [NSDate date];
        NSCalendar *c = [NSCalendar currentCalendar];
        NSDateComponents* components = [c components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
        Calender *ca=[[Calender alloc]init];
        switch (argc) {
            case 2:
                [ca setyear:(int)[components year] month:(int)[components month]];
                printf("      %s %d      \n",Month[[components month]],(int)[components year]);
                printf("%s\n",WeekDay);
                [ca printTargetMonth];
                break;
            case 3:
                
            case 4:
                if (strcmp(argv[2], "-m")==0) {
                    int target_year=(int)[components year];
                    int target_month=atoi(argv[3]);
                    if (is_input_legal(target_year, target_month)) {
                        [ca setyear:target_year month:target_month];
                        printf("      %s %d      \n",Month[target_month],target_year);
                        printf("%s\n",WeekDay);
                        [ca printTargetMonth];
                    }else
                        printf("Illegal Input!\n");
                }else{
                    int target_month=atoi(argv[2]);
                    int target_year=atoi(argv[3]);
                    if (is_input_legal(target_year,target_month)) {
                        [ca setyear:target_year month:target_month];
                        printf("      %s %d      \n",Month[target_month],target_year);
                        printf("%s\n",WeekDay);
                        [ca printTargetMonth];
                    }else
                        printf("Illegal Input!\n");
                }
                break;
            default:
                break;
        }
    }
    return 0;
}
