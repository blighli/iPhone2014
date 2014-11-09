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
        if(argc == 1)//输出当前的月历
        {
        int year;
        int month;
        int weekday;
        int day ;
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:now];
        
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
            NSString *yStr =[NSString stringWithFormat:@"%s", argv[2] ];
            NSString *mStr =[NSString stringWithFormat:@"%s", argv[1]];
            //判断
            if([mStr isEqualToString:@"-m"] ){//当年某月的月历
                
                int year;
               
                NSDate *now = [NSDate date];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:now];
            
                year =(int ) component.year;
                
                NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, 10];
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *date=[dateFormatter dateFromString:dateString];
                
                
                NSDateComponents *pon = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:date];
                
                [Month year:(int)pon.year month:(int)pon.month weekday:(int)pon.weekday];
                
                
            }else{//某年某月的月历
            
                int year = [yStr intValue];
            int month = [mStr intValue];
            
          
            NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *date=[dateFormatter dateFromString:dateString];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *pon = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:date];
            
            [Month year:(int)pon.year month:(int)pon.month weekday:(int)pon.weekday];
            }
        }else if(argc == 2){//某年的月历
            NSString *yStr = [NSString stringWithFormat:@"%s",argv[1]];
            int year = [yStr intValue];
            
             for(int i = 1;i < 13 ;i ++){
                 int month = i;

                 NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
                 NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 
                 NSDate *date=[dateFormatter dateFromString:dateString];
                 
                 NSCalendar *calendar = [NSCalendar currentCalendar];
                 NSDateComponents *pon = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:date];
                 
                 [Month year:(int)pon.year month:(int)pon.month weekday:(int)pon.weekday];
            }
        }
    }
    return 0;
    
}




