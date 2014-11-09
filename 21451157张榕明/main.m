//
//  main.m
//  canlendar
//
//  Created by drh on 14-10-2.
//  Copyright (c) 2014年 guest. All rights reserved.
//
//calculate the days of a month

#import <Foundation/Foundation.h>
#import "MyCalender.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyCalender *myCalender=[[MyCalender alloc]init];
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *component = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit  fromDate:date];
      
        //输出当月的月历
        if(argc == 1)
           {
               int year, month;
               year = (int ) component.year;
               month =(int ) component.month;
               [myCalender printfCalender: year month:month];
           }
           
           //输出某年的月历
           else if(argc == 2){
               
               NSString * yearString =[NSString stringWithFormat:@"%s", argv[1] ];
               int year = [yearString intValue];
               if(year<1)
               {
                   NSLog(@"请输入正确年份");
               }
               else {
                   for(int month = 1;month < 13 ; month++){
                      [myCalender printfCalender: year month:month];
                       }
               }
            }
                   
                   //输出某年某月的月历
                   else if (argc == 3){
                       
                       NSString *yearString =[NSString stringWithFormat:@"%s", argv[2]];
                       NSString *monthString =[NSString stringWithFormat:@"%s",argv[1]];
                       
                       if(strcmp("-m", argv[1]) == 0){
                           
                           int month = [monthString intValue];
                           
                           int year = [yearString intValue];
                          
                           if(month<1||month>12)
                           {
                               NSLog(@"请输入正确月份");
                              
                           }
                           else
                               [myCalender printfCalender: year month:month];
            
                           

                       }
                       else if([yearString intValue]){
                           
                           int year = [yearString intValue];
                           int month = [monthString intValue];
                           
                           if(month<1||month>12||year<1)
                           {
                               NSLog(@"请输入正确的年份或月份！");
                           }
                           else
                               [myCalender printfCalender: year month:month];
                           

                       }
                       else
                       {
                           NSLog(@"输入有误!");
                       }
                   }
                   //异常
                   else
                       NSLog(@"输入有误!");
               }
               
               return 0;
               
               
           }
           
           
           
