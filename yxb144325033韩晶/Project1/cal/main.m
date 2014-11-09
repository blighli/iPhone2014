//
//  main.m
//  cal
//
//  Created by hanxue on 14-10-11.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString * temp;
        
       // NSMutableString * today = @"234";
        // insert code here...
        NSLog(@"Hello, World!");
        Calendar *cal = [Calendar alloc];
        NSLog([[NSString alloc] initWithCString:argv[0] encoding:NSASCIIStringEncoding]);
        //NSString *firstDate = [[NSString alloc] initWithString:(const char*)argv[1] enconding:NSASCIIStringEncoding];
        NSString *firstData ;
        NSString *secondDate;
        //Calculator *cal=[Calculator all]
        int number =argc;
        switch (number) {
            case 1:
                temp =[cal getTodayDate];
                temp = [temp stringByAppendingString:@"-1 00:00:00 +0"];
                [cal printCal:temp andDecYear:false];
                //NSLog(temp);
                
                //NSLog([cal getTodayDate]);
                break;
                
            case 2:
                firstData = [[NSString alloc] initWithCString:argv[1] encoding:NSASCIIStringEncoding];
                [cal printByYear:firstData];
                break;
                
            case 3:
                firstData = [[NSString alloc] initWithCString:argv[1] encoding:NSASCIIStringEncoding];
                secondDate = [[NSString alloc] initWithCString:argv[2] encoding:NSASCIIStringEncoding];
                
                //NSLog(firstData);
                temp = [cal getTodayDateHaveTwoData:firstData andSecond:secondDate];
                if (temp == NULL) {
                    NSLog(@" 输入错误");
                    return 0;
                }
                temp = [temp stringByAppendingString:@"-1 00:00:00 +0"];
                //NSLog(temp);
                [cal printCal:temp andDecYear:false];
                break;
                
            default:
                break;
        }
    }
    return 0;
}

