//
//  main.m
//  Cal
//
//  Created by NimbleSong on 14-10-7.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <stdio.h>
#import "Calendar.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Calendar *cal=[[Calendar alloc]init];
        
        NSDate *date = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
        
        int year =(int) [comps year];
        int month =(int) [comps month];
        
        char isMonth[]="-m";
        
        switch (argc) {
            case 1:
                [cal printcanlendar:month andYear:year];
                break;
            case 2:
                if (atoi(argv[1])<0||atoi(argv[1])>9999) {
                    printf("year %d not in range 1..9999",atoi(argv[1]));
                }else{
                    [cal printcanlendarYear:atoi(argv[1])];
                }
                break;
            case 3:
                if (strcmp(isMonth, argv[1])==0) {
                    if (atoi(argv[2])>0&&atoi(argv[2])<13) {
                        [cal printcanlendar:atoi(argv[2]) andYear:year];
                    }else{
                        printf("%s is neither a month number (1..12) nor a name\n",argv[2]);
                    }
                }else if(atoi(argv[1])>0&&(atoi(argv[1])<13)){
                    [cal printcanlendar:atoi(argv[1]) andYear:atoi(argv[2])];
                }else{
                    printf("%s is neither a month number (1..12) nor a name\n",argv[1]);
                }
                break;
            default:
                printf("Check your input!\n");
                break;
        }
        
    }
    return 0;
}



