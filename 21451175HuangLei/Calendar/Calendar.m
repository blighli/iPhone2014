//
//  Calendar.m
//  Calendar
//
//  Created by guest on 14-10-12.
//  Copyright (c) 2014年 HuangLei. All rights reserved.
//

#import "Calendar.h"

//the number of the days in months and the Feb. of leap year in days[12]
int days[13]={31,28,31,30,31,30,31,31,30,31,30,31,29};
//the names of month
char *monthName[12]={"Jan.","Feb.","Mar.","Apr.","May.","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec"};

@implementation Calendar
{
    int monthDay; // the number of days
}
-(BOOL) isLeapYear:(int) aYear
{
    //if judge the year is leap year ?
    if((aYear%400 == 0) || ((aYear%4 == 0)&&(aYear%100 != 0)))
        return (YES);
    return (NO);
}
-(void) setMonthDay:(int) aMonthDay
{
    //set the number of the days of month
    monthDay = aMonthDay;
}
-(void) setMouth:(int) aMouth Year:(int)aYear
{
    month = aMouth;
    year = aYear;
    if(month == 2)
    {
        //if month is Feb., then judge if the year is leap year ?
        if([self isLeapYear:aYear])
            [self setMonthDay:days[12]];
        else
            [self setMonthDay:days[1]];
    }
    else
        [self setMonthDay:days[month-1]];
}

-(int) firstDayInMonth:(int)aMonth InYear:(int)aYear
{
    //get the first day in a month in a year is which days in week
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:aMonth];
    [comps setYear:aYear];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    [comps release];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return (weekday);
}

- (void) calMonth:(int)aMonth Year:(int)aYear
{
    //return calendar of a month in a year
    if(aMonth > 12||aMonth < 1 ||aYear <= 0)
    {
        //if month>12 or month<1 or year<=0,return error and stop
        printf("Error: there are some errors in month or year\n");
        printf("the month should be 1 to 12 and year should be > 0\n");
        return ;
    }
    [self setMouth:aMonth Year:aYear];
    int weekday = [self firstDayInMonth:aMonth InYear:aYear];
    //printf calendar
    printf("%21s\n",monthName[month-1]);
    printf("Sun. Mon. Tues. Wed. Thur. Fri. Sat.\n");
    for(int i = 1; i < weekday;i++)
    {
        if(i == 3 || i == 5)
            printf("      ");
        else
            printf("     ");
    }
    int number = 1;
    for(int temp=0;number <= 7-weekday+1; number++)
    {
        temp = number+weekday;
        if ( (temp%7 == 5) || (temp%7 == 3))
            printf("%-6d",number);
        else
            printf("%-5d",number);
    }
    printf("\n");
    for (int temp=0,range=0;number <= monthDay ; number++)
    {
        temp = number+weekday;
        if ( (temp%7 == 5) || (temp%7 == 3))
            printf("%-6d",number);
        else
            printf("%-5d",number);
        range++;
        if (range%7==0 && number < monthDay)
            printf("\n");
    }
    printf("\n");
}

-(void) calYear:(int)aYear
{
    //return all calendar in year
    if (aYear <= 0)
    {
        //if year<=0, return error
        printf("Error:the year should be >0\n");
        return;
    }
    //printf all calendar in year
    int aMonth;
    [self setMouth:2 Year:aYear];
    printf("%59d\n",year);
    for (aMonth = 1; aMonth <= 10; aMonth=aMonth+3)
    {
        int weekdayFir = [self firstDayInMonth:aMonth InYear:aYear];
        int weekdaySec,weekdayThi;
        
        int monthFir, monthSec, monthThi;
        monthFir = monthSec = monthThi = 1;
        
        int monthFirDay, monthSecDay,monthThiDay;
        monthFirDay = days[aMonth-1];
        monthThiDay = days[aMonth+1];
        if (aMonth == 2)
            monthSecDay = monthDay;
        else
            monthSecDay = days[aMonth];
        
        weekdaySec = (weekdayFir + monthFirDay - 1)%7 + 1;
        weekdayThi = (weekdaySec + monthSecDay - 1)%7 + 1;
        
        printf("%21s",monthName[aMonth-1]);
        printf("%38s",monthName[aMonth]);
        printf("%38s\n",monthName[aMonth+1]);
        for(int i = 0; i < 3;i++)
            printf("Sun. Mon. Tues. Wed. Thur. Fri. Sat.  ");
        printf("\n");
        
        for(int i = 1; i < weekdayFir;i++)
        {
            if(i == 3 || i == 5)
                printf("      ");
            else
                printf("     ");
        }
        for(int temp=0;monthFir <= 7-weekdayFir+1; monthFir++)
        {
            temp = monthFir+weekdayFir;
            if ( (temp%7 == 6) || (temp%7 == 4))
                printf("%-6d",monthFir);
            else
                printf("%-5d",monthFir);
        }
        printf(" ");
        for(int i = 1; i < weekdaySec;i++)
        {
            if(i == 3 || i == 5)
                printf("      ");
            else
                printf("     ");
        }
        for(int temp=0;monthSec <= 7-weekdaySec+1; monthSec++)
        {
            temp = monthSec+weekdaySec;
            if ( (temp%7 == 6) || (temp%7 == 4))
                printf("%-6d",monthSec);
            else
                printf("%-5d",monthSec);
        }
        printf(" ");
        for(int i = 1; i < weekdayThi;i++)
        {
            if(i == 3 || i == 5)
                printf("      ");
            else
                printf("     ");
        }
        for(int temp=0;monthThi <= 7-weekdayThi+1; monthThi++)
        {
            temp = monthThi+weekdayThi;
            if ( (temp%7 == 6) || (temp%7 == 4))
                printf("%-6d",monthThi);
            else
                printf("%-5d",monthThi);
        }
        printf("\n");
        while (monthFir <= monthFirDay || monthSec <= monthSecDay || monthThi <= monthThiDay)
        {
            int range;
            if(monthFir > monthFirDay)
                printf("%c",32);
            range = 0;
            for (int temp=0;monthFir <= monthFirDay && range < 7; monthFir++,range++)
            {
                temp = monthFir+weekdayFir;
                if ( (temp%7 == 6) || (temp%7 == 4))
                    printf("%-6d",monthFir);
                else
                    printf("%-5d",monthFir);
            }
            if(range<7 && monthFir > monthFirDay)
            {
                int temp = 0;
                while (range<7) {
                    temp = monthFir+weekdayFir;
                    if ( (temp%7 == 6) || (temp%7 == 4))
                        printf("      ");
                    else
                        printf("     ");
                    range++;
                    monthFir++;
                }
            }
            if(monthSec > monthSecDay)
                printf("%c",32);
            else
                printf(" ");
            range = 0;
            for (int temp=0;monthSec <= monthSecDay && range < 7; monthSec++,range++)
            {
                temp = monthSec+weekdaySec;
                if ( (temp%7 == 6) || (temp%7 == 4))
                    printf("%-6d",monthSec);
                else
                    printf("%-5d",monthSec);
            }
            if(range<7 && monthSec > monthSecDay)
            {
                int temp = 0;
                while (range<7) {
                    temp = monthSec+weekdaySec;
                    if ( (temp%7 == 6) || (temp%7 == 4))
                        printf("      ");
                    else
                        printf("     ");
                    range++;
                    monthSec++;
                }
            }
            if(monthThi > monthThiDay)
                printf("%c",32);
            else
                printf(" ");
            range = 0;
            for (int temp=0;monthThi <= monthThiDay && range < 7; monthThi++,range++)
            {
                temp = monthThi+weekdayThi;
                if ( (temp%7 == 6) || (temp%7 == 4))
                    printf("%-6d",monthThi);
                else
                    printf("%-5d",monthThi);
            }
            if(range<7 && monthThi > monthThiDay)
            {
                int temp = 0;
                while (range<7) {
                    temp = monthThi+weekdayThi;
                    if ( (temp%7 == 6) || (temp%7 == 4))
                        printf("      ");
                    else
                        printf("     ");
                    range++;
                    monthThi++;
                }
            }
            printf("\n");
        }
    }
    printf("\n");
}
@end
