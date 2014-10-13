//
//  main.m
//  calendar_project1
//
//  Created by alwaysking on 14-10-11.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WyzCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        {
            //今天的日期
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps;
            //本年
            comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
            int year = (int)[comps year];
            
            //本月
            comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
            int month = (int)[comps month];
            
            if(argc > 1){
                NSString * str1 = [NSString stringWithUTF8String:argv[1]];
                if([str1 isEqualToString:@"cal"]){
                    if(argc == 2){
                        [WyzCalendar setCurrentYear:year andMonth:month];
                    }
                    else if(argc == 3){
                        NSString * str2 = [NSString stringWithUTF8String:argv[2]];
                        int tip = -1;
                        int yearSum = 0;
                        for (int i = 0;i < [str2 length] ; i++) {
                            char c = [str2 characterAtIndex:i];
                            if(c <= '9' && c >= '0'){
                                tip = i;
                            }
                        }
                        if(tip == -1){
                            NSLog(@"cal: %@ is neither a month number (1..9999) nor a name",str2);
                        }
                        else{
                            for (int i = tip,j = 0; i >= 0; i--,j++) {
                                char c = [str2 characterAtIndex:i];
                                yearSum = yearSum + (c - '0') * pow(10, (double)j);
                            }
                            if (yearSum > 0 && yearSum < 10000 ) {
                                [WyzCalendar setYear:yearSum];
                            }
                            else{
                                NSLog(@"cal: %d is neither a month number (1..9999) nor a name..",yearSum);
                            }
                        }
                        
                    }
                    else if(argc == 4){
                        NSString * str2 = [NSString stringWithUTF8String:argv[2]];
                        NSString * str3 = [NSString stringWithUTF8String:argv[3]];
                        if([str2 isEqualToString:@"-m"]){
                            int tip = -1;
                            int monthSum = 0;
                            for (int i = 0;i < [str3 length] ; i++) {
                                char c = [str3 characterAtIndex:i];
                                if(c <= '9' && c >= '0'){
                                    tip = i;
                                }
                            }
                            if(tip == -1){
                                NSLog(@"cal: %@ is neither a month number (1..12) nor a name",str3);
                            }
                            else{
                                for (int i = tip,j = 0; i >= 0; i--,j++) {
                                    char c = [str3 characterAtIndex:i];
                                    monthSum = monthSum + (c - '0') * pow(10, (double)j);
                                }
                                if (monthSum > 0 && monthSum <= 12 ) {
                                    [WyzCalendar setCurrentYear:year andMonth:monthSum];
                                }
                                else{
                                    NSLog(@"cal: %d is neither a month number (1..12) nor a name..",monthSum);
                                }
                            }
                        }
                        else{
                            int tip = -1;
                            int monthSum = 0;
                            for (int i = 0;i < [str2 length] ; i++) {
                                char c = [str2 characterAtIndex:i];
                                if(c <= '9' && c >= '0'){
                                    tip = i;
                                }
                            }
                            if(tip == -1){
                                NSLog(@"cal: %@ is neither a month number (1..12) nor a name",str3);
                            }
                            else{
                                for (int i = tip,j = 0; i >= 0; i--,j++) {
                                    char c = [str2 characterAtIndex:i];
                                    monthSum = monthSum + (c - '0') * pow(10, (double)j);
                                }
                                if (monthSum > 0 && monthSum <= 12 ) {
                                    
                                    tip = -1;
                                    int yearSum = 0;
                                    for (int i = 0;i < [str3 length] ; i++) {
                                        char c = [str3 characterAtIndex:i];
                                        if(c <= '9' && c >= '0'){
                                            tip = i;
                                        }
                                    }
                                    if(tip == -1){
                                        NSLog(@"cal: %@ is neither a year number (1..12) nor a name",str3);
                                    }
                                    else{
                                        for (int i = tip,j = 0; i >= 0; i--,j++) {
                                            char c = [str3 characterAtIndex:i];
                                            yearSum = yearSum + (c - '0') * pow(10, (double)j);
                                        }
                                        if (yearSum >= 1 && yearSum <= 9999 ) {
                                            [WyzCalendar setCurrentYear:yearSum andMonth:monthSum];
                                        }
                                        else{
                                            NSLog(@"cal: %d is neither a year number (1..12) nor a name..",yearSum);
                                        }
                                    }

                                    
                                }
                                else{
                                    NSLog(@"cal: %d is neither a month number (1..12) nor a name..",monthSum);
                                }
                            }

                        }
                    }
                    
                }
                else{
                    NSLog(@"-bash: %@: command not found",str1);
                }
            }
            
        }
        
    }
    return 0;
}




