//
//  main.m
//  Calendar
//
//  Created by emily on 14-10-3.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSDate.h>
#import <Foundation/NSCalendar.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //declaration
        
        NSArray *week=@[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        NSArray *monName = @[@"?",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
        
        void print_month(NSInteger, NSInteger, NSInteger, NSInteger);
        void print_year(NSInteger);
        int days_of_month(NSInteger, NSInteger);
        //int leap(NSInteger, NSInteger);
        
        NSDate *date = [[NSDate alloc] init];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        //this year
        comps = [calendar components:(NSYearCalendarUnit)fromDate:date];
        NSInteger yearCurrent = [comps year];
        
        //this month
        comps = [calendar components:(NSMonthCalendarUnit)fromDate:date];
        NSInteger monthCurrent = [comps month];
        
        //the numbers of the days of current month
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
        NSUInteger days = range.length;
        
        char buffer[30];
        NSLog(@"Please input the command:");

        while(scanf("%[^\n]", buffer) != EOF){
            NSString *comStr = [NSString stringWithUTF8String:buffer];    //将缓冲区赋给NSString变量
        
            NSString *str1 = [comStr stringByReplacingOccurrencesOfString:@" " withString:@""];//get rid of the spaces in command
            NSString *str = [str1 substringToIndex:3];
            
            if ([str1 isEqualToString:@"cal"]) {
                //command: cal
                NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                
                [dateFormatter setTimeZone:[calendar timeZone]];
                [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", monthCurrent, 1, yearCurrent];
                date = [dateFormatter dateFromString:firstDay];
                
                comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                NSInteger weekday = [comps weekday];
                
                print_month(monthCurrent, yearCurrent, weekday-1, days);
                printf("\n");
            }
            else if (![str isEqualToString:@"cal"]) {
                printf("input error!,try again according to the specification\n");
            }
            else
            {
                id command = [str1 substringFromIndex:3];//command after "cal"
                NSInteger number = [command integerValue];
            
                if (number > 0 && number <= 9999) {
                    //command: cal 2014
                    printf("\t\t\t%i\n", (int)number);
                    for(int i=1;i<=12;){
                        printf("\n        %s月                 %s月              %s月\n",[[monName objectAtIndex:i] UTF8String],[[monName objectAtIndex:i+1]UTF8String],[[monName objectAtIndex:i+2]UTF8String]);
                        for(int w=0;w<21;w++)
                            printf(" %s",[[week objectAtIndex:w%7] UTF8String]);
                        printf("\n");
                        NSInteger date1=1,date2=1,date3=1;
                        
                        NSDateFormatter *dateForm= [[NSDateFormatter alloc] init];
                        [dateForm setTimeZone:[calendar timeZone]];
                        [dateForm setDateFormat:@"MM/dd/yyyy"];
                        for(int circle=1;circle<=5;circle++){
                            
                            NSString *firstDay1 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i, 1, yearCurrent];
                            date = [dateForm dateFromString:firstDay1];
                            
                            comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                            NSInteger weekday1 = [comps weekday];
                            
                            // 获取月份有多少天
                            NSRange range1 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
                            
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
                            
                            NSString *firstDay2 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i+1, 1, yearCurrent];
                            date = [dateForm dateFromString:firstDay2];
                            
                            comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                            NSInteger weekday2 = [comps weekday];
                            
                            // 获取月份有多少天
                            NSRange range2 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
                            
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
                            
                            NSString *firstDay3 = [NSString stringWithFormat:@"%02d/%02d/%04ld", i+2, 1, yearCurrent];
                            date = [dateForm dateFromString:firstDay3];
                            
                            comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                            NSInteger weekday3= [comps weekday];
                            
                            // 获取月份有多少天
                            NSRange range3= [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
                            
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
                }
                else
                {
                    id command1 = [command substringToIndex:2];
                    id command2 = [command substringFromIndex:2];
                    
                
                    NSInteger n1 = [command1 integerValue];
                    NSInteger n2 = [command2 integerValue];
                    NSLog(@"n1 = %li, n2 = %li", n1, n2);
                    if (n1 >= 1 && n1 <= 12 && n2 > 0 && n2 <= 9999) {
                        //command: cal ** ****
                        days = days_of_month(n2, n1);
    
                        NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[calendar timeZone]];
                        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                        NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", n1, 1, n2];
                        date = [dateFormatter dateFromString:firstDay];
                        
                        comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                        NSInteger weekday = [comps weekday];
                        
                        print_month(n1, n2, weekday-1, days);
                    }
                    else if ([command1 isEqualToString:@"-m"] && n2 >= 1 && n2 <= 12) {
                        //command: cal -m **
                        NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[calendar timeZone]];
                        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                        NSString *firstDay = [NSString stringWithFormat:@"%02ld/%02d/%04ld", n2, 1, yearCurrent];
                        date = [dateFormatter dateFromString:firstDay];
                        
                        comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                        NSInteger weekday = [comps weekday];
                        
                        days = days_of_month(yearCurrent, n2);
                        print_month(n2, yearCurrent, weekday-1, days);
                        }
                    else {
                        printf("input error!,try again according to the specification\n");
                    }
                }
            }
            NSLog(@"please input the command:");
            getchar();
        }
    }
    return 0;
}


int days_of_month(NSInteger year, NSInteger month)
{
    int z = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            z = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            z = 30;
            break;
        case 2:
        {
            if ((year%4 == 0 && year%100 != 0)||(year%400 == 0)) z=29;
            else z = 28;break;
        }
        default:
            break;
    }
    return z;
}

void print_month(NSInteger month, NSInteger year, NSInteger firstday, NSInteger days)
{
    NSArray *monName = @[@"?",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
    NSString *str = [monName objectAtIndex: month];
    
    NSLog(@"\n\t\t  %@ 月  %li\t\t\n", str, year);
    printf("   日  一  二   三  四  五  六\n");
    int i,j;
    for (i = 1; i <= firstday; ++i) {
        printf("%4c",' ');
    }
    for (j = 1; j <= days; ++j) {
        if ((j+firstday)%7 == 1)
            printf("\n%4i",j);
        else
            printf("%4i", j);
    }
    printf("\n");
}
