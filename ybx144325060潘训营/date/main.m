//
//  main.m
//  mydate
//
//  Created by apple on 14-10-17.
//  Copyright (c) 2014年 潘训营. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "MyDate.h"



int main(int argc, const char* argv[]) {
    @autoreleasepool {
        
        MyDate* myDate = [ [MyDate alloc] init];
        NSDate* date = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
        
        int y,m;
        
        switch (argc) {
            case 1:
                [myDate printMonth: (int)[components year] : (int)[components month]];
                break;
            case 2:
                y = atoi(argv[1]);
                
                if(y<1 || y > 9999) {
                    printf("cal: year 0 not in range 1..9999\n");
                }else {
                    [myDate printYear:y];
                }
                break;
        
            case 3:
                if(strcmp(argv[1], "-m") == 0) {
                    m = atoi(argv[2]);
                    
                    if( m < 1 || m > 12) {
                        printf("cal: month 0 not in range 1..12\n");
                    }
                    else {
                        [myDate printMonth: (int)[components year] : m];
                    }
                }
                else {
                    y = atoi(argv[2]);
                    m = atoi(argv[1]);
                
                    if((y < 1 || y > 9999) || (m < 1 || m > 12)) {
                        printf("cal: year 0 not in range 1..9999 or month 0 not in range 1..12\n");
                    }
                    else {
                        [myDate printMonth: y :m];
                    }
                }
                break;
            default:
                printf("cal: illegal option\n");
                break;
        }
    }
    return 0;
}
