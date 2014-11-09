//
//  main.m
//  yxb144325042杨长湖
//
//  Created by 杨长湖 on 14-10-9.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
#import "Utils.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
       Utils *utils = [[Utils alloc]init];
        switch (argc) {
            case 1:
                [utils showCalendarOfThisMonth];
                break;
            case 2:
                if (atoi(argv[1])>9999 || atoi(argv[1])<1) {
                    printf(" cal: year %s not in range 1..9999\n",argv[1]);
                }
                else{
                    [utils showCalendarOfYear:atoi(argv[1])];
                }
                break;
            case 3:
                if (!strcasecmp("-m", argv[1])) {
                    if (atoi(argv[2])<=12 && atoi(argv[2])>=1) {
                        [utils showCalendarOfMonth:atoi(argv[2])];
                    }
                    else {
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                    }
                }
                else{
                    if (atoi(argv[1])>12 || atoi(argv[1])<1) {
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                    }
                    else if (atoi(argv[2])>9999 || atoi(argv[2])<1) {
                        printf(" cal: year %s not in range 1..9999\n",argv[2]);
                    }
                    else {
                        [utils showCalendarOfYearAndMonth:atoi(argv[2]) andMonth:atoi(argv[1])];
                    }
                }
                break;
            default:
//                NSLog(@"no massage");
                break;
        }
        
        
        
        
        
    }
    return 0;
}
