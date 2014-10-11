//
//  main.m
//  cal
//
//  Created by lixu on 14-10-6.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char* ch="-m";
        NSDate *date = [NSDate date];
        //NSLog(@"%d",argc);
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        
        //判断输入的格式，重新定义date
        if (argc==3) {
            
            long int monthset;
            long int yearset;
            comps=[calendar components:(NSYearCalendarUnit) fromDate:date];
            NSInteger year=[comps year];
            if (!(strcmp(argv[1],ch))) {
                monthset=atoi(argv[2]);
                if (monthset<=0||monthset>12) {
                    printf("Error!!!请输入合法的月份\n");
                    return 1;
                }
                yearset=year;
            }else{
                monthset=atoi(argv[1]);
                if (monthset<=0||monthset>12) {
                    printf("Error!!!请输入合法的月份\n");
                    return 1;
                }
                yearset=atoi(argv[2]);
            }
            
            //NSLog(@"%d",monthset );
            NSDateComponents *comp = [[NSDateComponents alloc]init];
            [comp setMonth:monthset];
            [comp setDay:02];
            [comp setYear:yearset];
            NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
            date = [myCal dateFromComponents:comp];
            //NSLog(@"myDate1 = %@",date);
        }
        comps=[calendar components:(NSYearCalendarUnit) fromDate:date];
        NSInteger year=[comps year];
        
        comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
        NSInteger month = [comps month];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [formatter setTimeZone:timeZone];
        [formatter setDateFormat:@"M/d/yyyy"];
        NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",month,1,year];
        date = [formatter dateFromString:firstDay];
        
        
        comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
        NSInteger weekday = [comps weekday]-1 ;
        
        
        //NSLog(@"%ld",weekday);
        //NSLog(@"%@",firstDay);
        if (argc==2) {
                year=atoi(argv[1]);
                printf("               %ld\n",year);
            
                NSDateComponents *comp = [[NSDateComponents alloc]init];
                long int yearset=atoi(argv[1]);
                for (long int monthset=1; monthset<=12; ++monthset) {
                    
                    
                    [comp setMonth:monthset];
                    [comp setDay:02];
                    [comp setYear:yearset];
                    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
                    date = [myCal dateFromComponents:comp];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
                    [formatter setTimeZone:timeZone];
                    [formatter setDateFormat:@"M/d/yyyy"];
                    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",monthset,1,year];
                    date = [formatter dateFromString:firstDay];
                
                
                    comp= [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
                    NSInteger weekday = [comp weekday]-1;
                    //printf("%ld",weekday);
                    putMonth(monthset);
                    printf("\n");
                    CalMOutput(weekday, monthset, yearset);
                    printf("\n\n");
                }
            
            
            //CalOutput(weekday,month,year);
            //NSLog(@" do some thing");
        }else{
            putMonth(month);
            printf(" %ld\n",year);
            CalMOutput(weekday,month,year);
            
        }
    }
    

    return 0;
}

#pragma 打印月份日历，包含两个参数，一个是第一天的星期，天数。
int CalMOutput(long int firstWeekday,long int month,long int year){
    int daysNum=30;
    if (month==2) {
        if ((year%400==0)||(year%100==0&&year%4!=0)) {
            daysNum=29;
        }else{
            daysNum=28;
        }
    }
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
         daysNum=31;
    }
    printf("日   一    二   三    四   五   六 \n");
    for ( int j=0; j<firstWeekday; ++j) {
        printf("     ");
    }

    for (int i=1; i<=daysNum; ++i) {
        printf("%2d   ",i);
        if ((i+firstWeekday)%7==0) {
            printf("\n");
        }
    }
    
    printf("\n");
    return 0;
}

int putMonth(long int month){
    switch (month) {
        case 1:
            printf("            一月  ");break;
        case 2:
            printf("            二月  ");break;
        case 3:
            printf("            三月  ");break;
        case 4:
            printf("            四月  ");break;
        case 5:
            printf("            五月  ");break;
        case 6:
            printf("            六月  ");break;
        case 7:
            printf("            七月  ");break;
        case 8:
            printf("            八月  ");break;
        case 9:
            printf("            九月  ");break;
        case 10:
            printf("            十月  ");break;
        case 11:
            printf("            十一月  ");break;
        case 12:
            printf("            十二月  ");break;
            
        default:
            printf("error");
            break;
    }
    return 0;
    
}