//
//  main.m
//  project1
//
//  Created by xuyouyang on 14-10-12.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calender.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Calender *cal = [[Calender alloc]init];
        NSDate *now = [NSDate date];
        // 当前年(东8区)
        NSInteger nowyear =  [[now dateWithCalendarFormat:nil timeZone: [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]] yearOfCommonEra];
        // 当前月(东8区）
        NSInteger nowmonth = [[now dateWithCalendarFormat:nil timeZone: [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]] monthOfYear];
        
        switch (argc) {
            case 1:
            {
                [cal showCalenderWithYear:nowyear andMonth:nowmonth];
                break;
            }
            case 2:
            {
                if (atoi(argv[1]) <= 0 || atoi(argv[1])>9999) {
                    printf("cal:year %s not in range 1..9999", argv[1]);
                    return 1;
                }
                [cal showCalenderWithYear:atoi(argv[1])];
                break;
            }
            case 3:
            {
                char s[] = "-m";
                if(!strcmp(s, argv[1])){
                    if(atoi(argv[2])>12||atoi(argv[2])<1){
                        printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
                        return 1;
                    }
                    [cal showCalenderWithYear:nowyear andMonth:atoi(argv[2])];
                } else {
                    if(atoi(argv[1]) < 1 || atoi(argv[1]) > 12){
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                        return 1;
                    }
                    if(atoi(argv[2]) <= 0 || atoi(argv[2]) > 9999){
                        printf("cal: year %s not in range 1..9999\n",argv[2]);
                        return 1;
                    }
                    [cal showCalenderWithYear:atoi(argv[2]) andMonth:atoi(argv[1])];
                }
                break;
            }
            // 处理参数个数错误
            default:
                printf("usage:\n");
                printf("\tcal [-m month]\n");
                printf("\tcal [month] [year]\n");
                break;
        }
    }
    return 0;
}
