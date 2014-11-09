//
//  main.m
//  lg
//
//  Created by YilinGui on 14-10-12.
//  Copyright (c) 2014年 LG. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate *now = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        
        NSArray *month=[NSArray arrayWithObjects:@"一 月", @"二 月", @"三 月", @"四 月", @"五 月", @"六 月", @"七 月", @"八 月", @"九 月", @"十 月", @"十一 月", @"十二 月", nil];
        NSArray *week=[NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
        
        if(argc==2&&!strcmp(argv[1], "cal")){//对于cal格式的
            // 获取当前年
           
            comps = [cal components:(NSYearCalendarUnit) fromDate:now];
            NSInteger cur_year = [comps year];
            // 获取当前月
            comps = [cal components:(NSMonthCalendarUnit) fromDate:now];
            NSInteger cur_month = [comps month];
            printf("     %s   %ld\n", [[month objectAtIndex:cur_month-1] UTF8String], (long)cur_year);
            for(int i=0;i<7;i++){
                printf("%s ",[[week objectAtIndex:i] UTF8String]);
            }
            printf("\n");
            // 获取当前月第一天是星期几
            NSDateFormatter *date_f= [[NSDateFormatter alloc] init];
            
            [date_f setTimeZone:[cal timeZone]];
            [date_f setDateFormat:@"MM/dd/yyyy"];
            NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", (long)cur_month, 1, (long)cur_year];
            now = [date_f dateFromString:firstDay];

            comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
            NSInteger weekday = [comps weekday];
            
            // 获取当前月份有多少天
            NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
            
            for(int j=1;j<=range.length+weekday-1;j++){
                if(j<weekday){
                    printf("   ");
                }
                else {
                    printf("%2ld ",(long)(j-weekday)+1);
                    if(j%7==0)printf("\n");
                }
            }
            printf("\n");
        }
        else if(argc==4&&!strcmp(argv[1], "cal")){//对于 cal -m 或者年月格式的
            NSString *arg2 = [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
            NSString *arg3 = [NSString stringWithCString:argv[3] encoding:NSUTF8StringEncoding];
            NSInteger interarg2=[arg2 integerValue];
            NSInteger intergrg3=[arg3 integerValue];
            //printf("%ld\n",intergrg3);
            if(!strcmp(argv[2], "-m")&&intergrg3>0&&intergrg3<=12){
                comps = [cal components:(NSYearCalendarUnit) fromDate:now];
                NSInteger cur_year = [comps year];
               
                NSInteger cur_month = intergrg3;
                printf("     %s   %ld\n", [[month objectAtIndex:cur_month-1] UTF8String], (long)cur_year);
                for(int i=0;i<7;i++){
                    printf("%s ",[[week objectAtIndex:i] UTF8String]);
                }
                printf("\n");
                // 获取当前月第一天是星期几
                NSDateFormatter *date_f= [[NSDateFormatter alloc] init];
                
                [date_f setTimeZone:[cal timeZone]];
                [date_f setDateFormat:@"MM/dd/yyyy"];
                NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", (long)cur_month, 1, (long)cur_year];
                now = [date_f dateFromString:firstDay];
                
                comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
                NSInteger weekday = [comps weekday];
                
                // 获取当前月份有多少天
                NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
                
                
                for(int j=1;j<=range.length+weekday-1;j++){
                    if(j<weekday){
                        printf("   ");
                    }
                    else {
                        printf("%2ld ",(long)(j-weekday)+1);
                        if(j%7==0)printf("\n");
                    }
                }
                printf("\n");

            }else if(interarg2>0&&interarg2<=12&&intergrg3>0&&intergrg3<=9999){
                NSInteger cur_year = intergrg3;
                comps = [cal components:(NSMonthCalendarUnit) fromDate:now];
                NSInteger cur_month = interarg2;
                printf("     %s   %ld\n", [[month objectAtIndex:cur_month-1] UTF8String], (long)cur_year);
                for(int i=0;i<7;i++){
                    printf("%s ",[[week objectAtIndex:i] UTF8String]);
                }
                printf("\n");
                // 获取当前月第一天是星期几
                NSDateFormatter *date_f= [[NSDateFormatter alloc] init];
                
                [date_f setTimeZone:[cal timeZone]];
                [date_f setDateFormat:@"MM/dd/yyyy"];
                NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", (long)cur_month, 1, (long)cur_year];
                now = [date_f dateFromString:firstDay];
                
                comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
                NSInteger weekday = [comps weekday];
                
                // 获取当前月份有多少天
                NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
                
                for(int j=1;j<=range.length+weekday-1;j++){
                    if(j<weekday){
                        printf("   ");
                    }
                    else {
                        printf("%2ld ",(long)(j-weekday)+1);
                        if(j%7==0)printf("\n");
                    }
                }
                printf("\n");

            }else printf("输入不合法!\n");
        }else if(argc==3&&!strcmp(argv[1],"cal")){//对于cal 2014格式的
            NSString *arg2 = [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
            NSInteger interarg2=[arg2 integerValue];
            if(interarg2>0){
                
                NSInteger cur_year = interarg2;
                printf("                              %ld\n",(long)cur_year);
                for(int i=1;i<=12;){
                    printf("\n        %s                  %s               %s\n",[[month objectAtIndex:i-1] UTF8String],[[month objectAtIndex:i]UTF8String],[[month objectAtIndex:i+1]UTF8String]);
                    for(int w=0;w<21;w++)printf("%s ",[[week objectAtIndex:w%7] UTF8String]);
                    printf("\n");
                    NSInteger date1=1,date2=1,date3=1;
                    
                    NSDateFormatter *date_f= [[NSDateFormatter alloc] init];
                    [date_f setTimeZone:[cal timeZone]];
                    [date_f setDateFormat:@"MM/dd/yyyy"];
                    for(int circle=1;circle<=5;circle++){
                        // 获取第一天是星期几
                        
                        NSString *firstDay1 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i, 1, (long)cur_year];
                        now = [date_f dateFromString:firstDay1];
                        
                        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
                        NSInteger weekday1 = [comps weekday];
                        
                        // 获取月份有多少天
                        NSRange range1 = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
                        
                        for(int control=1;control<=7;control++){
                            
                            if(date1<weekday1){
                                printf("   ");
                                date1=date1+1;
                            }
                            else if(date1<range1.length+weekday1){
                                printf("%2ld ",(long)(date1-weekday1)+1);
                                date1++;
                            }else printf("   ");

                        }
                        // 获取第一天是星期几
                        
                        NSString *firstDay2 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i+1, 1, (long)cur_year];
                        now = [date_f dateFromString:firstDay2];
                        
                        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
                        NSInteger weekday2 = [comps weekday];
                        
                        // 获取月份有多少天
                        NSRange range2 = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
                        
                        for(int control=1;control<=7;control++){
                            
                            if(date2<weekday2){
                                printf("   ");
                                date2++;
                            }
                            else if(date2<range2.length+weekday2){
                                printf("%2ld ",(long)(date2-weekday2)+1);
                                date2++;
                            }else printf("   ");
                            
                        }
                        // 获取第一天是星期几
                        
                        NSString *firstDay3 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i+2, 1, (long)cur_year];
                        now = [date_f dateFromString:firstDay3];
                        
                        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:now];
                        NSInteger weekday3= [comps weekday];
                        
                        // 获取月份有多少天
                        NSRange range3= [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
                        
                        for(int control=1;control<=7;control++){
                            
                            if(date3<weekday3){
                                printf("   ");
                                date3++;
                            }
                            else if(date3<weekday3+range3.length){
                                printf("%2ld ",(long)(date3-weekday3)+1);
                                date3++;
                            }else printf("   ");
                            
                        }
                        printf("\n");
                    }
                    
                    i=i+3;
                }
            }else printf("输入不合法!\n");

        }else printf("输入格式不合法!\n");
    }
    return 0;
}
