//
//  main.m
//  Project-1
//
//  Created by 葛 云波 on 14-10-18.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"
#define STRING_CMP(a,b) strcmp(a,b)==0?true:false

bool isNumber(const char *s){
    for (int i=0; i<strlen(s); i++) {
        if (s[i]>'9'||s[i]<'0') {
            return false;
        }
    }
    return true;
}

bool isValid(int a,const char *b[]){
    switch (a) {
        case 1:
            return true;
        case 2:
            if(!isNumber(b[1]))
                return false;
            else if(strlen(b[1])>4)
                return false;
            else
                return true;
        case 3:
            if((!isNumber(b[1]))&&(!STRING_CMP(b[1], "-m")))
                return false;
            int month;
            if (isNumber(b[1])) {
                month = atoi(b[1]);
            }
            else
                month = atoi(b[2]);
            if(month<1||month>12)
                return false;
            else
                return true;
        default:
            return false;
    }
}

int main(int argc, const char * argv[]) {
    if
        (!isValid(argc, argv)) {
            NSLog(@"command not found");
            return 1;
        }
    Cal *calendar = [[Cal alloc] init];
    switch (argc) {
        case 1:
            [calendar printCurrentMonthCalendar];
            break;
        case 2:
            [calendar printYearCalendar:atoi(argv[1])];
            break;
        case 3:
            if(isNumber(argv[1]))
            {
                [calendar printCalendarForMonth:atoi(argv[1]) andYear:atoi(argv[2])];
                break;
            }
            else
            {
                [calendar printMonthOfCurrentYearCalendar:atoi(argv[2])];
                break;
            }
        default:
            break;
    }
    return 0;
}
