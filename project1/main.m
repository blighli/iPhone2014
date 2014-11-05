//
//  main.m
//  cal
//
//  Created by zhou on 14-10-9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        if (argc == 1) {
            
            NSDate * date = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc]
                                    initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
            
            
            [Cal showCal:(int)[dateComponents month]
                  ofYear:(int)[dateComponents year]];
        }
        else if (argc == 2)
        {
            int year = atoi(argv[1]);
            [Cal showCal:0 ofYear:year];
            
        }
        else if(argc == 3)
        {
            if (0 == strcmp(argv[1],"-m")) {
                int month = atoi(argv[2]);
                
                if(month <0||month>12)
                {
                    printf("invaliate month");
                    return 0;
                }
                
                NSDate * date = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc]
                                        initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit fromDate:date];
                
                [Cal showCal:month
                      ofYear:(int)[dateComponents year]];
            }
            else
            {
                int month = atoi(argv[1]);
                int year = atoi(argv[2]);
                
                if(month <0||month>12)
                {
                    printf("illegal month input\n\r");
                    printf("useage: 1. cal\n\t2. cal [month] [year]\n\t3. cal -m [month]\n\t4. cal [year]\n");
                    return 0;
                }
                [Cal showCal:month ofYear:year];
            }
        }
        
        else
        {
            printf("invaliate use\n");
            printf("useage: 1. cal\n\t2. cal 10 2014\n\t3. cal -m 10\n\t4. cal 2014\n");
        }
    }
    return 0;
}

