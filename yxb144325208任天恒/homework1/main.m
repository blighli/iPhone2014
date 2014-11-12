//
//  main.m
//  cal
//
//  Created by rth on 14-10-12.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Cal *cal = [[Cal alloc] init];
        //argc=3; //test用
        NSDate *date = [NSDate date];   //获取当前时间
        NSDateComponents *componenet;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        componenet = [calendar components:(NSYearCalendarUnit) fromDate:date];   //获取当前年份
        NSInteger calYear = [componenet year];
        componenet = [calendar components:(NSMonthCalendarUnit) fromDate:date];  //获取当前月份
        NSInteger calMonth = [componenet month];
        
        
        if(2<=argc<=4){
            NSString *data1 = [NSString stringWithUTF8String:argv[1]];//char转化为nsstring
            //NSString *data1=@"cal";//test用
            if ([data1 isEqualToString:@"cal"]) {
                if (argc==2) {  //运行cal
                    [cal showYear:calYear andMonth:calMonth];
                }
                else if(argc==3){ //运行cal 2014
                    NSString *data2 = [NSString stringWithUTF8String:argv[2]];
                    //NSString *data2=@"2014";//test用
                    if (1<=[data2 integerValue]&&[data2 integerValue]<=9999)
                        [cal showYear:[data2 integerValue]];
                    else
                        [cal Error];//提示输入错误
                }
                else if (argc==4){
                    NSString *data2 = [NSString stringWithUTF8String:argv[2]];
                    NSString *data3 = [NSString stringWithUTF8String:argv[3]];
                    //NSString *data2=@"9"; //test用
                    //NSString *data3=@"2014"; //test用
                    //NSLog(@"%ld",(long)data3.integerValue);

                    if([data2 isEqualToString:@"-m"]) { //运行cal -m 10
                        [cal showYear:calYear andMonth:[data3 integerValue]];
                    }
                    else if (1<=[data2 intValue]&&[data2 intValue]<=12) {   //运行cal 10 2014
                        if (1<=[data3 integerValue]&&[data3 integerValue]<=9999) //(如果是“abc”的话，integerValue就为0)
                            [cal showYear:[data3 integerValue] andMonth:[data2 integerValue]];
                        else
                            [cal Error];
                    } else
                        [cal Error];
                }
                
            } else
                [cal Error];
        } else
            [cal Error];
        
    }
    return 0;
}
