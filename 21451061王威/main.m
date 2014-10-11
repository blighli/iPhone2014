//
//  main.m
//  CustomCalendar
//
//  Created by 王威 on 14-10-10.
//  Copyright (c) 2014年 com.MySuperCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomCalendar.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

BOOL isMonthValid(long month)
{
    if (1 > month || month > 12) {
        NSLog(@"month %ld not in range 1...12", month);
        return NO;
    }
    return YES;
}

BOOL isYearValid(long yearToValid)
{
    if (yearToValid < 1 || yearToValid >9999) {
        NSLog(@"year %ld not in range 0...9999", yearToValid);
        return NO;
    }
    return YES;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CustomCalendar* calendar = [[CustomCalendar alloc] init];
        if (argc == 2) {
            long year = [[NSString stringWithUTF8String:argv[1]] integerValue];
            if (isYearValid(year) == NO) {
                exit(0);
            }
            for (int curMon = 1; curMon <= 12; curMon++) {
                [calendar setMonth:curMon Year:year];
                NSLog(@"%@", calendar);
            }
            exit(0);
        }
        else if (argc == 3)
        {
            NSString* format = [NSString stringWithUTF8String:argv[1]];
            if ([format hasPrefix:@"-"])
            {
                if ([format isEqualTo:@"-m"]) {
                    long month = [[NSString stringWithUTF8String:argv[2]] integerValue];
                    if (isMonthValid(month) == NO) {
                        exit(0);
                    }
                    [calendar setMonthWithCurrentYear:month];
                }else{
                    NSLog(@"cal: illegal option -%@", format);
                    NSLog(@"usage: cal [[month]] [year]");
                    NSLog(@"       cal [-m month]");
                }
                
            }else
            {
                long month = [[NSString stringWithUTF8String:argv[1]] integerValue];
                if (isMonthValid(month) == NO) {
                    exit(0);
                }
                long year = [[NSString stringWithUTF8String:argv[2]] integerValue];
                if (isYearValid(year) == NO) {
                    exit(0);
                }
                [calendar setMonth:month Year:year];
            }
        }
        NSLog(@"%@", calendar);
    }
    return 0;
}
