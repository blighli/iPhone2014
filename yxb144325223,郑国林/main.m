//
//  main.m
//  Perject1
//
//  Created by Mac on 14-10-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"


int main(int argc, const char * argv[]) {
    
    system("clear");
    Calendar *week=[Calendar new];
    int year;
    int month;
    NSString *is_year;
    NSString *is_month;
    
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//初始化为阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit  ;
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    int nowYear=(int)[comps year];
    int nowMonth=(int)[comps month];
    
    NSString *isstr=@"-m";
    /*
     if (argc==1) {
     [week setYear:nowYear];
     [week setMonth:nowMonth];//当没有参数
     }else if(argc==2){
     is_year=[[NSString alloc]initWithUTF8String:argv[1]];
     year=[is_year intValue];
     [week setYear:year];//当命令行中有年份参数
     }
     else if(argc==3){
     is_year=[[NSString alloc]initWithUTF8String:argv[2]];
     is_month=[[NSString alloc]initWithUTF8String:argv[1]];
     if([is_month isEqualToString:isstr])
     {
     [week setYear:nowYear];
     month=[is_year intValue];
     [week setMonth:month];
     if (month>12||month<1)
     {
     NSLog(@"输入错误，请重新输入月份！");
     return (0);
     }
     }
     [week setYear:year];
     [week setMonth:month];//当命令行中有年月参数
     }else {
     NSLog(@"输入格式错误！");
     return (0);
     }   
     */
    switch (argc) {
        case 1:
            [week setYear:nowYear];
            [week setMonth:nowMonth];//当没有参数
            break;
        case 2:
            is_year=[[NSString alloc]initWithUTF8String:argv[1]];
            year=[is_year intValue];
            [week setYear:year];//当命令行中有年份参数
            break;
        case 3:
            is_year=[[NSString alloc]initWithUTF8String:argv[2]];
            is_month=[[NSString alloc]initWithUTF8String:argv[1]];
            if([is_month isEqualToString:isstr])
            {
                [week setYear:nowYear];
                month=[is_year intValue];
                [week setMonth:month];
                if (month>12||month<1)
                {
                    NSLog(@"输入错误，请重新输入月份！");
                    return (0);
                }
            }
            [week setYear:year];
            [week setMonth:month];//当命令行中有年月参数
            break;
        default:
            NSLog(@"输入格式错误！");
            return (0);
            break;
    }
    [week print];
    return 0;
}
