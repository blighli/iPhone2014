//
//  main.m
//  Project1
//
//  Created by Cocoa on 14-10-7.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

int isCal(NSString *str) {
    if ([str isEqual:@"cal"]) {
        return 1;
    }else{
        printf("输入有误\n");
        return 0;
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDateComponents *currentDateComponents = [[[NSCalendar alloc]
                                                    initWithCalendarIdentifier: NSGregorianCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:[NSDate date]];
        if (argc == 2){
            NSString *argvOne = [NSString stringWithUTF8String:argv[1]];
            
            if (isCal(argvOne) == 1) {
//                NSLog(@"运行cal,输出当月的月历");
                Cal *calendar = [[Cal alloc]init];
                
                NSInteger year = currentDateComponents.year;
                NSInteger month = currentDateComponents.month;
                
                printf("            %ld月  %ld年\n",month,year);
                [calendar printCalendar:2014 andMonth:11];
            }
        }
        else if (argc == 3){
            NSString *argvOne = [NSString stringWithUTF8String:argv[1]];
            NSString *argvTwo = [NSString stringWithUTF8String:argv[2]];
            
            if (isCal(argvOne) == 1) {
                if ([argvTwo hasPrefix:@"-"]) {
                    if ([argvTwo isEqualToString:@"-m"]) {
                        printf("option requires an argument\n");
                    }
                }
                else{
                    NSLog(@"运行cal 2014,输出2014年的月历");
                    NSInteger year =[[NSString stringWithUTF8String:argv[2]] integerValue];
                    Cal *calendar =[[Cal alloc]init];
                    if (year>0 && year<10000) {
                        printf("              %ld年\n",year);
                        for (int i=1; i<=12; i++) {
                            printf("                %d月\n",i);
                            [calendar printCalendar:year andMonth:i];
                        }
                    }
                    else {
                        printf("year %ld not in range 1..9999\n",year);
                    }
                }
            }
        }
        else if (argc == 4){
            NSString *argvOne   = [NSString stringWithUTF8String:argv[1]];
            NSString *argvTwo   = [NSString stringWithUTF8String:argv[2]];
            NSInteger argvThree = [[NSString stringWithUTF8String:argv[3]] integerValue];
            
            if (isCal(argvOne) == 1) {
                Cal *calendar =[[Cal alloc]init];
                if ([argvTwo hasPrefix:@"-"]) {
                    if ([argvTwo isEqualToString:@"-m"]&&(argvThree>=1 && argvThree<=12)){
                        if (argvThree>=1 && argvThree<= 12) {
                            NSInteger year = currentDateComponents.year;
                            printf("            %ld月  %ld年\n",argvThree,year);
                            [calendar printCalendar:year andMonth:argvThree];
                        }
                        else{
                            printf("13 is neither a month number (1..12) nor a name\n");
                        }
                    }
                    else {
                        printf("illegal option\n");
                        printf("usage: cal [[month] year]\n");
                        printf("       cal [-m month] [year]\n");
                    }
                }
                else{
                    NSInteger month = [[NSString stringWithUTF8String:argv[2]] integerValue];
                    NSInteger year = argvThree;
                    if (month>=1 && month<=12) {
                        printf("            %ld月  %ld年\n",month,year);
                        [calendar printCalendar:year andMonth:month];
                    }
                    else{
                        printf("13 is neither a month number (1..12) nor a name\n");
                    }
                }
            }
        }
        else{
            printf("Please add arguments in Product->Scheme with cal\n");
        }
    }
    return 0;
}

