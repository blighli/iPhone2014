//
//  main.m
//  CalDate
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyDate.h"


//将字符串转换为int
int stringToInt(const char* str) {
    int result = 0;
    for(int i=0; str[i]; i++) {
        if(str[i] >= '0' && str[i] <= '9') {
            result = result*10 + (str[i]-'0');
        }
        else {
            return -1;
        }
    }
    return result;
}


int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSDate* date = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
        
        MyDate* myDate = [ [MyDate alloc] init];
        
        int year;
        int month;
        
        switch (argc) {
            case 1: //cal
                [myDate setYear:(int)[components year] andMonth:(int)[components month]];
                [myDate printMonth];
                
                break;
            case 2: //cal 2014
                year = stringToInt(argv[1]);
                month = (int)[components month];
                
                if([myDate isLegalYear:year] == NO) {
                    [myDate errorCode:ERROR_YEAR andErrorYear:argv[1] andErrorMonth:""];                //error
                }
                else {
                    [myDate setYear:year andMonth:month];
                    [myDate printYear];
                }
                
                break;
            case 3: //cal -m 10 or cal 10 2014
                if(strcmp(argv[1], "-m") == 0) { //cal -m
                    year = (int)[components year];
                    month = stringToInt(argv[2]);
                    
                    if([myDate isLegalMonth:month] == NO) {
                        [myDate errorCode:ERROR_MONTH andErrorYear:"" andErrorMonth:argv[2]];           //error
                    }
                    else {
                        [myDate setYear:year andMonth:month];
                        [myDate printMonth];
                    }
                }
                else { //cal 10 2014
                    year = stringToInt(argv[2]);
                    month = stringToInt(argv[1]);
                    
                    BOOL flagYear = [myDate isLegalYear:year];
                    BOOL flagMonth = [myDate isLegalMonth:month];
                    if(flagYear == NO && flagMonth == NO) {
                        [myDate errorCode:ERROR_YEAR_MONTH andErrorYear:argv[2] andErrorMonth:argv[1]]; //error
                    }
                    else if(flagYear == NO) {
                        [myDate errorCode:ERROR_YEAR andErrorYear:argv[2] andErrorMonth:argv[1]];       //error
                    }
                    else if(flagMonth == NO) {
                        [myDate errorCode:ERROR_MONTH andErrorYear:argv[2] andErrorMonth:argv[1]];      //error
                    }
                    else {
                        [myDate setYear:year andMonth:month];
                        [myDate printMonth];
                    }
                }
                
                break;
            default: //error
                [myDate errorCode:ERROR_OTHER andErrorYear:"" andErrorMonth:""];                        //error
                
                break;
        }
    }
    return 0;
}
