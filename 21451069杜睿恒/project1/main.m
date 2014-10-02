//
//  main.m
//  canlendar
//
//  Created by drh on 14-10-2.
//  Copyright (c) 2014年 guest. All rights reserved.
//

#import <Foundation/Foundation.h>

int daysOfMonth(int month, int year){
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [cal dateFromComponents:comps];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit
                              inUnit: NSMonthCalendarUnit
                             forDate: date];
    int numberOfMonth = range.length;
    return numberOfMonth;
}

int weekDayofDay(int month, int year){
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [cal dateFromComponents:comps];
    int count = [cal ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    return count;
}

void printMonthAndYear(int month,int year){
    printf("    %d月 %d 年\n",month, year);
}

void printMonthAndWeek(int line, int weekDay, int numberOfDays){
    switch (line) {
        case -1:
            printf("日 一 二 三 四 五 六  ");
            break;
        case 0:
        {
            int printDay = 1;
            for(int i =0 ; i<7 ;i++){
                if(i<weekDay-1)
                    printf("   ");
                else
                    printf(" %d ", printDay++);
            }
            break;
        }
        default:
        {
            int printDay =(line-1) * 7 + 9 - weekDay ;
            for(int i =0 ; i<7 ;i++){
                if(printDay >numberOfDays)
                    printf("   ");
                else{
                    if(printDay < 10)
                        printf(" %d ", printDay);
                    else
                        printf("%d ", printDay);
                    printDay++;
                }
            }

            break;
        }
    }
}

int main (int argc, const char *argv[])
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDate *date = [NSDate date];
    //if input "cal"
	if(argc ==1 ){
        NSDateComponents *compt = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
        int year = [compt year];
        int month = [compt month];
        int days = daysOfMonth(month,year);
        int weekday = weekDayofDay(month,year);
        printMonthAndYear(month,year);
        for(int i=-1; i<6; i++){
            printMonthAndWeek(i, weekday, days);
            printf("\n");
        }
	}
	//input "cal 2014"
	else if(argc ==2 ){
        int year=atoi(argv[1]);
        if(year<1||year>9999)
        {
            printf("对不起，您输入的年份 %d 不在1到9999之间。\n",year);
        }
        else
        {
            printf("\t\t\t   %d年\n", year);
            int dayOfMonth[12], weekdayOfMonth[12];
            for(int i=0; i<12; i++){
                dayOfMonth[i] = daysOfMonth(i+1,year);
                weekdayOfMonth[i] = weekDayofDay(i+1,year);
            }
            for(int i=0; i<4; i++){
                for(int j=0; j<3; j++){
                    printf("\t%d 月\t\t    ",i*3+j+1);
                }
                printf("\n");
                for(int k=-1; k<6; k++){
                    for(int j=0; j<3; j++){
                        printMonthAndWeek(k, weekdayOfMonth[i*3+j],
                                      dayOfMonth[i*3+j]);
                        printf("\t");
                    }
                    printf("\n");
                }
            }
        }
	}
	
	else if(argc ==3 ){
        if(!strcmp(argv[1],"-m")){
            int month = atoi(argv[2]);
            if(month>0 && month <13){
                NSDateComponents *compt = [cal components:
                    (NSYearCalendarUnit|NSMonthCalendarUnit|
                    NSDayCalendarUnit) fromDate:date];
                int year = [compt year];
                int days = daysOfMonth(month,year);
                int weekday = weekDayofDay(month,year);
                printMonthAndYear(month,year);
                for(int i=-1; i<6; i++){
                    printMonthAndWeek(i, weekday, days);
                    printf("\n");
                }
            }
            else{
                printf("对不起，您输入的月份有误！\n");
            }
        }
        else{
            int month = atoi(argv[1]);
            int year = atoi(argv[2]);
            if (year>0 && year <=9999 && month>0 && month <13) {
                int days = daysOfMonth(month,year);
                int weekday = weekDayofDay(month,year);
                printMonthAndYear(month,year);
                for(int i=-1; i<6; i++){
                    printMonthAndWeek(i, weekday, days);
                    printf("\n");
                }
            }
            else{
                printf("对不起，您输入的年份或月份有误！\n");
            }
        }
    
    }
	else{
		printf("对不起，您的输入有误!\n使用方法:cal [month] [year] ;cal -m month\n举例如下:\n  cal:输出当前月份日历 \n  cal 2014:输出2014年所有月份日历\n  cal 10 2014:输出2014年10月日历\n  cal -m 10:输出当年10月日历\n");
	}
    // [pool drain];  
    
    return 0;  
}
