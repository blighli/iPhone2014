//
//  main.m
//  ZhouXiang
//
//  Created by 周翔 on 14-10-16.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShowCalendar.h"

int main(int argc, const char * argv[])

{
    
    @autoreleasepool
    
    {
      
        ShowCalendar *myCalendar = [[ShowCalendar alloc]init];
        
        NSDate *date = [[NSDate alloc] init];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *compts = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:date];
        
        NSInteger month = [compts month];
        
        NSInteger year = [compts year];
        
        
        
        
        //输出当年当月的日历
        if(argc == 1)
            
        {

            [myCalendar printOneMonthCalendar:month Year:year];
            
        }
        
        //输出一年的日历
        else if(argc == 2)
            
        {
            
            int str = atoi(argv[1]);
            
            if (str<1||str>9999)
                
            {
                
                NSLog(@"你输入的年份不在1~9999内");
                      
            }
                      
            else
                      
            {
                
                [myCalendar printWholeYearCalendar:month Year:year];
                
            }
                      
        }
        
                      
        //输出当年某个月或某年某月的日历
        else if (argc == 3)
                      
        {

            
            if(!strcmp(argv[1], "-m"))
                
            {
               
                int str = atoi(argv[2]);
                
                if(str<1||str>12)
                    
                {
                    
                    NSLog(@"你输入的月份不正确");
                    
                }
                
                //输出当年某月的日历
                else
                    
                {
                    
                    [myCalendar printOneMonthCalendar:month Year:year];
                    
                }
                
            }
            
            else
            
            {
                
                int str = atoi(argv[1]);
                
                int str1 = atoi(argv[2]);
                
                if((str<1||str>12)||(str1<1||str1>9999))
                
                {
                    
                    NSLog(@"你输入的月份或者月份不正确");
                    
                }
                
                
                //输出某年某月的额日历
                else
                
                {
                    
                    [myCalendar printOneMonthCalendar:month Year:year];
                    
                }
                
            }
        }
        
        else
            
        {
            
            NSLog(@"你输入的指令有误，请检查更正");
            
        }
            
            
        }
            
    
    
    return 0;
    
}
