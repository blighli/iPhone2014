//
//  main.m
//  Cal
//
//  Created by 李丛笑 on 14-10-9.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])


int main(int argc, const char * argv[]) {
    
    int year ;
    int month;
    int days[12];
    int firstday[12];
    Cal *cal = [[Cal alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    switch (argc) {
        case 1:
            year = [comps year];
            month = [comps month];
            days[month] = [cal DaysofMonth:year Month:month];
            firstday[month] = [cal Firstday:year Month:month];
            NSLog(@"    %@ %d",[cal PrintNameofMonth:month],year);
            NSLog(@"%@",[cal PrintDays]);
            NSLog(@"%@",[cal PrintFirstline:firstday[month]]);
            for(int i = 2;i<7;i++){
                NSLog(@"%@",[cal Print:days[month] Firstday:firstday[month] Week:i]);
            }
            break;
        case 2:
            year = atoi(argv[1]);
            if(year<1||year>9999)
                NSLog(@"year %d not in range 1..9999",year);
            else{
            NSLog(@"                             %d",year);
            NSLog(@" ");
            for(int i=0;i<13;i++){
                days[i] = [cal DaysofMonth:year Month:i];
                firstday[i] = [cal Firstday:year Month:i];
            }
            for(int k=0;k<12;k=k+3){
                if (k<9) {
                     NSLog(@"       %@                 %@                 %@",[cal PrintNameofMonth:k+1],[cal PrintNameofMonth:k+2],[cal PrintNameofMonth:k+3]);
                }
                else{
                    NSLog(@"       %@                 %@                %@",[cal PrintNameofMonth:k+1],[cal PrintNameofMonth:k+2],[cal PrintNameofMonth:k+3]);
                }
                NSLog(@"%@  %@  %@",[cal PrintDays],[cal PrintDays],[cal PrintDays]);
                NSLog(@"%@ %@ %@",[cal PrintFirstline:firstday[k+1]],[cal PrintFirstline:firstday[k+2]],[cal PrintFirstline:firstday[k+3]]);
                for (int i=2; i<7; i++) {
                    NSLog(@"%@ %@ %@",[cal Print:days[k+1] Firstday:firstday[k+1] Week:i],[cal Print:days[k+2] Firstday:firstday[k+2] Week:i],[cal Print:days[k+3] Firstday:firstday[k+3] Week:i]);
                }
            }
            }
            break;
        case 3:
            if (strcmp(argv[1], "-m")==0) {
                if (atoi(argv[2])>0 && atoi(argv[2])<13) {
                    year = [comps year];
                    month = atoi(argv[2]);
                    days[month] = [cal DaysofMonth:year Month:month];
                    firstday[month] = [cal Firstday:year Month:month];
                    NSLog(@"    %@ %d",[cal PrintNameofMonth:month],year);
                    NSLog(@"%@",[cal PrintDays]);
                    NSLog(@"%@",[cal PrintFirstline:firstday[month]]);
                    for(int i = 2;i<7;i++){
                        NSLog(@"%@",[cal Print:days[month] Firstday:firstday[month] Week:i]);
                    }

                }
                else{
                    NSLog(@"cal: %d is neither a month number (1..12) nor a name",atoi(argv[2]));
                }
            }
            else if (atoi(argv[1])>0 && atoi(argv[1])<13){
                if (atoi(argv[2])>0 && atoi(argv[2])<10000) {
                    year = atoi(argv[2]);
                    month = atoi(argv[1]);
                    days[month] = [cal DaysofMonth:year Month:month];
                    firstday[month] = [cal Firstday:year Month:month];

                    NSLog(@"    %@ %d",[cal PrintNameofMonth:month],year);
                    NSLog(@"%@",[cal PrintDays]);
                    NSLog(@"%@",[cal PrintFirstline:firstday[month]]);
                    for(int i = 2;i<7;i++){
                        NSLog(@"%@",[cal Print:days[month] Firstday:firstday[month] Week:i]);
                    }

                }
                else{
                    NSLog(@"cal: year %d not in range 1..9999",atoi(argv[2]));
                }
            }
            else{
                    NSLog(@"cal: %@ is neither a month number (1..12) nor a name",[[NSString alloc]initWithUTF8String:argv[1]]);
                }
            break;
        default:
            break;
    }
   
    return 0;
}
