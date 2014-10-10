//
//  main.m
//  date
//
//  Created by 周舟 on 14-10-10.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Month.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc == 1)
        {
        int year;
        int month;
        int weekday;
        int day ;
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:now];
        NSLog(@"%@", component);
        year =(int ) component.year;
        month = (int ) component.month;
        weekday = (int) component.weekday;
        day = (int) component.day;
        
        NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *date=[dateFormatter dateFromString:dateString];
        
        
        NSDateComponents *pon = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:date];
        
        [Month year:(int)pon.year month:(int)pon.month weekday:(int)pon.weekday];
        }else if (argc == 3){
            int year =(int) argv[2];
            int month = (int) argv[1];
            NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *date=[dateFormatter dateFromString:dateString];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *pon = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:date];
            
            [Month year:(int)pon.year month:(int)pon.month weekday:(int)pon.weekday];
        }
    }
    return 0;
    
}




