+//
+//  main.m
+//  calender
+//
+//  Created by laotou on 14-10-14.
+//  Copyright (c) 2014年 laotou. All rights reserved.

#import <Foundation/Foundation.h>
#import "calenderOut.h"





int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        
        int year_now;
        int month_now;
        
        //获取当前时间
        
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit  fromDate:now];
        
        year_now =(int ) component.year;
        month_now = (int ) component.month;
        
        
        if(argc == 1)
        {
            //如果没有参数输出当前时间
            
            [calenderOut year:year_now month:month_now];
            
            
            
        }else if (argc == 3){
            NSString *year_get =[NSString stringWithFormat:@"%s", argv[2]];
            NSString *month_get =[NSString stringWithFormat:@"%s",argv[1]];
            
            
            //3个参数，如果第2个是-m
            
            if(strcmp("-m", argv[1])){
                
                
               	int month = [month_get intValue];
                
                
                if(month<1||month>12)
                {
                    printf("对不起，您输入的月份有误！\n");
                    
                }
                else
                    [calenderOut year:year_now month:month];
                
                
                
                
                
                
            }
            //如果不是，判断年份输入是否正常
            else if([year_get intValue]){
                
                int year = [year_get intValue];
            	int month = [month_get intValue];
                
                if(month<1||month>12||year<1||year>9999)
                {
                    printf("对不起，您输入年份或者月份有误！\n");
                    
                }
            	else
                    [calenderOut year:year month:month];
                
                
            }
            else
            {
                printf("输入代码错误\n");
            }
        }else if(argc == 2){
            
            NSString *year_get =[NSString stringWithFormat:@"%s", argv[1] ];
            int year = [year_get intValue];
            
            if(year<1||year>9999)
        	{
                printf("对不起，您输入年份有误！\n");
            }
            else
                for(int i = 1;i < 13 ;i ++){
                    int month = i;
                    
                    [calenderOut year:year month:month];
                }
        }
        else
            printf("输入错误2\n");
		
    }
    return 0;
    
    
}


