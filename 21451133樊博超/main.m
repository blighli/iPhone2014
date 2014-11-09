//
//  main.m
//  homework1.0
//
//  Created by 樊博超 on 14-10-12.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonthCalender.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

                MonthCalender * mc =[[MonthCalender alloc] init];
                NSDateComponents * components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        switch (argc) {
            case 1 :
                {
                    //cal
                    NSInteger month = [components month];
                    NSInteger year = [components year];
                    [mc drawbyMonth:month andyear:year];
                }
                break;
            case 2:
                {
                    NSString *com1 = [[NSString alloc] initWithUTF8String:argv[1]];
                    int year = [com1 intValue];
                    if (year < 1 || year > 9999) {
                        printf("The year should be between 1 and 9999\n");
                    }else{
                            //cal 2014
                        [mc drawbyYear:year];
                    }
                }
                break;
            case 3:
                {
                    NSString *com1 = [[NSString alloc] initWithUTF8String:argv[1]];
                    NSString *com2 = [[NSString alloc] initWithUTF8String:argv[2]];
                    if([com1 isEqualToString:@"-m"]){
                        //-m
                        NSInteger month = [com2 integerValue];
                        if (month >= 1 && month <= 12) {
                            NSInteger year = [components year];
                            [mc drawbyMonth:month andyear:year];
                        }else{
                            printf("The month should be between 1 and 12\n");
                        }
                    }else{
                        
                        NSInteger month = [com1 integerValue];
                        if (month >= 1 && month <= 12) {
                            //cal 10 2014
                            NSInteger year = [com2 integerValue];
                            if (year < 1 || year > 9999) {
                              printf("The year should be between 1 and 9999\n");
                            }else{
                                [mc drawbyMonth:month andyear:year];
                            }
                        }else{
                            printf("The month should be between 1 and 12\n");
                        }
                    }
                }
                break;
            default:
                printf("Parameter number error!\n");
                break;
        }

    }
    return 0;
}
