//
//  main.m
//  project1
//
//  Created by Van on 14-10-5.
//  Copyright (c) 2014年 Van. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "printCalendar.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now = [NSDate date];
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSCalendarUnitWeekOfMonth;
        NSDateComponents *comps = [gregorian components:unitFlags fromDate:now];
        [comps setDay:1];
        if (argv[1]) {
            if ([[NSString stringWithFormat:@"%s", argv[1]] isEqualToString:@"cal"]) {
                if(argc == 2){
                    printCalendar *pc =[[printCalendar alloc]init];
                    [pc printCalendarWith:comps :YES];
                }else if (argv[2]){
                    NSString *argv2 = [NSString stringWithFormat:@"%s", argv[2]];
                    if ([argv2 hasPrefix:@"-"]) {
                        if(argc == 3 && [argv2 isEqualToString:@"-m"]){
                            NSLog(@"cal:option requires an argument --m");
                        }else if (argc == 3 && ![argv2 isEqualToString:@"-m"]){
                            NSLog(@"cal: illegal option :%@",argv2);
                        }else if (argv[3] && [argv2 isEqualToString:@"-m"]){
                            if (argc == 4) {
                                NSString *argv3 = [NSString stringWithFormat:@"%s", argv[3]];
                                if([argv3 intValue]<=12 && [argv3 intValue] >0){
                                    printCalendar *pc =[[printCalendar alloc]init];
                                    [pc printCalendarWith:comps :YES];
                                }else{
                                    NSLog(@"cal: %d is neither a month number (1..12) nor a name",[argv3 intValue]);
                                }
                            }
                        }
                    }else if([argv2 intValue]<9999 && [argv2 intValue] >0 && argc == 3){
                        [comps setYear:[argv2 intValue]];
                        printf("              %ld\n", [comps year]);
                        printf("\n");
                        printCalendar *pc =[[printCalendar alloc]init];
                        for (int i=1; i<=12; i++) {
                            [comps setMonth:i];
                            [pc printCalendarWith:comps :NO];
                        }
                        
                    }else if ([argv2 intValue]>9999 && [argv2 intValue] <=0 && argc == 3){
                        NSLog(@"year %d not in range 1..9999",[argv2 intValue]);
                    }else if ([argv2 intValue]>0 && [argv2 intValue] <=12 && argc == 4){
                        NSString *argv3 = [NSString stringWithFormat:@"%s", argv[3]];
                        if([argv3 intValue]>9999 && [argv3 intValue] <=0){
                            NSLog(@"year %d not in range 1..9999",[argv3 intValue]);
                        }else{
                            [comps setMonth:[argv2 intValue]];
                            [comps setYear:[argv3 intValue]];
                            printCalendar *pc =[[printCalendar alloc]init];
                            [pc printCalendarWith:comps :YES];
                        }
                    }else if ([argv2 intValue]<=0 && [argv2 intValue] >12 && argc == 4){
                         NSLog(@"cal: %d is neither a month number (1..12) nor a name",[argv2 intValue]);
                    }else if ( argc>4){
                        NSLog(@"too many argument please man cal!");
                    }
                }
            }else{
                NSLog(@"command not found: %@",[NSString stringWithFormat:@"%s", argv[1]]);
            }
        }

    }
    return 0;
}



















