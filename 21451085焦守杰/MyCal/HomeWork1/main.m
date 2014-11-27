//
//  main.m
//  HomeWork1
//
//  Created by 焦守杰 on 14-10-4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
int main(int argc, const char * argv[]) {
    Calendar *cal=[[Calendar alloc]init];
 //   [cal showMonthCalendar:1];
    NSDate *date=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *comps=[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
 fromDate:date];
    int year=[comps year];
    int month=[comps month];
    char c[]="-m";
    switch (argc) {
        case 1:
            [cal showMonthCalendar:year: month];
            break;
        case 2:
            if(atoi(argv[1])<=0||atoi(argv[1])>9999){
                printf("year %s not in range 1..9999\n",argv[1]);
                return 1;
            }
                
            [cal showYearCalendar:atoi(argv[1])];
            break;
        case 3:
      //      NSString *s=[NSString stringWithCString:argv[1]];
            if(!strcmp(c, argv[1])){
        //        printf("+++++%s",argv[1]);
                if(atoi(argv[2])>12||atoi(argv[2])<1){
                    printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
                    return 1;
                }
                [cal showMonthCalendar:year:atoi(argv[2])];
            }else{
       //          printf("+++++%s",argv[1]);
                if(atoi(argv[1])>12||atoi(argv[1])<1){
                    printf("%s is neither a month number (1..12) nor a name\n",argv[1]);
                    return 1;
                }
                if(atoi(argv[2])<=0||atoi(argv[2])>9999){
                    printf("year %s not in range 1..9999\n",argv[2]);
                    return 1;
                }
                [cal showMonthCalendar:atoi(argv[2]):atoi(argv[1])];
            }
            break;
        default:
            break;
    }
    return 0;
}

