//
//  main.m
//  Cal
//
//  Created by 顾准新 on 14-10-10.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCal.h"

void printException()
{
    printf("Wrong arguments\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        MyCal *mc=[[MyCal alloc] init];
        NSDate *now = [NSDate date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        
        int year = (int)[dateComponent year];
        int month = (int)[dateComponent month];
        switch (argc) {
            case 1:
                [mc setCalWithYear:year Month:month];
                [mc printCal];
                break;
            case 2:
                year=atoi(argv[1]);
                if(year>0 && year<9999){
                    [mc pritnYear];
                }else{
                    printException();
                }
                break;
            case 3:
               // if(str)
                if(strlen(argv[1])==2 && (argv[1][0]=='-' && argv[1][1]=='m'))
                {
                    if(year>0 && year<9999){
                        [mc setCalWithYear:year Month:month];
                        [mc printCal];
                    }else{
                        printException();
                    }
                }
                month = atoi(argv[1]);
                if(month>0 && month<13)
                {
                    [mc setCalWithYear:year Month:month];
                    [mc printCal];
                }else
                {
                    printException();
                }
                
                break;
            default:
                printException();
                break;
        }
      
        
        
        
        
    }
    return 0;
}
