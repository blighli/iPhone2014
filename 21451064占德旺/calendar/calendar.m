//
//  calendar.m
//  cal
//
//  Created by Devon on 14-10-6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calendar.h"

#define WEEKDAY "日 一 二 三 四 五 六"

@implementation DATE2WEEKDAY
@end

@implementation MONTHDAY

-(id)init
{
    for(int i = 0; i < 31; i++)
        date2weekday[i] = [[DATE2WEEKDAY alloc] init];
    return (self);
}

-(int)DateAtIndex:(int)index
{
    return date2weekday[index].date;
}

-(void)setDateAtIndex:(int)index value:(int)v
{
    date2weekday[index].date = v;
}

-(int)WeekdayAtIndex:(int)index
{
    return date2weekday[index].weekday;
}

-(void)setWeekdayAtIndex:(int)index value:(int)v
{
    date2weekday[index].weekday = v;
}

@end

@implementation Calendar

char *MONTHSTR[ 12 ] = {
    "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
};

int YEAR[ 3 ][ 12 ] = {
    { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
    { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
    { 31, 29, 31, 30, 31, 30, 31, 31, 19, 31, 30, 31 }
};

+(int)displaymonth:(int)year month:(int)month
{
    int line = 0;                     /* 行 */
    
    MONTHDAY *monthday = [[MONTHDAY alloc] init];
    
    int days;
    
    /* 显示用 */
    char BUFF[6][28];
    for(int i = 0;i < 6;i++){
        for(int j = 0;j < 20;j++)
            BUFF[i][j] = ' ';
        BUFF[i][20] = '\0';
    }
    
    /* 判断输入的参数，简单判断 */
    if ((year < 1) || (year > 9999))
    {
        return -1;
    }
    
    /* 判断输入的参数，简单判断 */
    if ((month < 1) || (month > 12))
    {
        return -1;
    }
    
    /* 判断输入的年份，调用适用的历法 */
    if (year < 1752) {
        /* 儒略历(Julian Calendar) 1 - 1751 */
        days = [Calendar JulianCalendar:year month:month weekday:monthday];
    } else if (year == 1752) {
        /* 特殊的1752年 */
        days = [Calendar Special1752:year month:month weekday:monthday];
    } else if (year > 1752) {
        /* 格里历(GregorianCalendar) 1753 - ... */
        days = [Calendar GregorianCalendar:year month:month weekday:monthday];
    }
    
    /* 初始化 */
    line = 0;
    
    /* 设置每行显示的内容 */
    for (int i = 0; i < days; i++)
    {
        int temp = [monthday DateAtIndex:i] / 10;
        BUFF[ line ][ [monthday WeekdayAtIndex:i] * 3 ]
        =  temp > 0 ? (temp + '0') : ' ';
        BUFF[ line ][ [monthday WeekdayAtIndex:i] * 3 + 1 ]
        = [monthday DateAtIndex:i] % 10 + '0';
        
        if ([monthday WeekdayAtIndex:i] == 6)
        {
            line++;
        }
    }
    
    /* 显示 */
    printf( "     %s %4d\n", MONTHSTR[ month - 1], year );
    printf( "%s\n", WEEKDAY );
    
    for (int i = 0; i < 6; i++)
    {
        printf( "%s\n", BUFF[ i ] );
    }
    
    return 0;

}

+(int)displayyear:(int)year
{
    int line = 0;                  /* 行 */
    MONTHDAY *monthday[12];       /* 年 */
    
    for(int i = 0; i < 12; i++)
        monthday[i] = [[MONTHDAY alloc] init];
    
    /* 显示用 */
    char BUFF[12][6][28];
    for(int i = 0;i < 12;i++){
        for(int j = 0;j < 6;j++){
            for(int k = 0;k < 20;k++)
                BUFF[i][j][k] = ' ';
            BUFF[i][j][20] = '\0';
        }
    }
    /* 判断输入的参数，简单判断 */
    if ((year < 1) || (year > 9999))
    {
        return -1;
    }
    
    /* 判断输入的年份，调用适用的历法 */
    if (year < 1752) {
        /* 儒略历(Julian Calendar) 1 - 1751 */
        for (int i = 0; i < 12; i++)
        {
            monthday[i].days = [Calendar JulianCalendar:year month:i+1 weekday:monthday[i]];
        }
    } else if (year == 1752) {
        /* 特殊的1752年 */
        for (int i = 0; i < 12; i++)
        {
            monthday[ i ].days = [Calendar Special1752:year month:i+1 weekday:monthday[i]];
        }
    } else if (year > 1752) {
        /* 格里历(GregorianCalendar) 1753 - ... */
        for (int i = 0; i < 12; i++)
        {
            monthday[ i ].days = [Calendar GregorianCalendar:year month:i+1 weekday:monthday[i]];
        }
    }
    
    for (int month = 0; month < 12; month++)
    {
        /* 初始化 */
        line = 0;
        
        /* 设置每行显示的内容 */
        for (int i = 0; i < monthday[ month ].days; i++)
        {
            int temp = [monthday[month] DateAtIndex:i] / 10;
            BUFF[ month ][ line ][ [monthday[month] WeekdayAtIndex:i] * 3 ]
            =  temp > 0 ? (temp + '0') : ' ';
            BUFF[ month ][ line ][ [monthday[month] WeekdayAtIndex:i] * 3 + 1 ]
            = [monthday[month] DateAtIndex:i] % 10 + '0';
            
            if ([monthday[month] WeekdayAtIndex:i] == 6)
            {
                line++;
            }
        }
    }
    
    printf( "                                 %d\n\n", year );
    
    for (int i = 0; i < 4; i++)
    {
        printf( "        %-25.15s%-25.15s%-25.15s\n",
               MONTHSTR[ i * 3 ], MONTHSTR[ i * 3 + 1 ], MONTHSTR[ i * 3 + 2 ] );
        
        printf( "%-30.27s%-30.27s%-30.27s\n",
               WEEKDAY, WEEKDAY, WEEKDAY );
        
        for (int j = 0; j < 6; j++)
        {
            printf( "%s   %s   %s\n",
                   BUFF[ i * 3 ][ j ],
                   BUFF[ i * 3 + 1 ][ j ],
                   BUFF[ i * 3 + 2 ][ j ] );
        }
    }
    return 0;

}

+(int)JulianCalendar:(int)year month:(int)month weekday:(MONTHDAY*)monthday
{
    int leap = 0;      /* 适用的月份数据    */
    int firstday = 6;  /* 每月1日的星期数   */
    
    /* 是否为闰年，设置适用的月份数据 */
    if ((year % 4) == 0)
    {
        leap = 1;
    }
    
    /* 计算每年的1月1日的星期数 */
    /* 计算累加天数，1月1日: 前一年平年星期数累加一，前一年闰年星期数加二 */
    /* year年1月1日 */
    firstday = (5 + (5 * year - 1) / 4) % 7;
    
    /* 计算month月1日的星期数 */
    for (int i = 0; i < month - 1; i++)
    {
        firstday += YEAR[ leap ][ i ];
    }
    
    /* year年month月1日 */
    firstday = firstday % 7;
    
    /* month月 */
    for (int i = 0; i < YEAR[ leap ][ month - 1 ]; i++)
    {
        [monthday setDateAtIndex:i value:(i+1)];
        [monthday setWeekdayAtIndex:i value:(firstday + i) % 7];
    }
    
    /* 返回当月天数 */
    return YEAR[ leap ][ month - 1 ];
}

+(int)GregorianCalendar:(int)year month:(int)month weekday:(MONTHDAY*)monthday
{
    int leap = 0;      /* 适用的月份数据    */
    int firstday = 1;  /* 每月1日的星期数   */
    
    int days = 0;      /* 累加天数          */
    
    /* 是否为闰年，设置适用的月份数据 */
    if ((((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0))
    {
        leap = 1;
    }
    
    /* 计算每年的1月1日的星期数 */
    /* 初始化 */
    days = 0;
    
    /* 计算累加天数，1月1日: 前一年平年星期数累加一，前一年闰年星期数加二 */
    for (int n = 1753; n < year; n++)
    {
        if ((((n % 4) == 0) && ((n % 100) != 0)) || ((n % 400) == 0))
        {
            days += 2; /* 闰年 */
        } else {
            days++;    /* 平年 */
        }
    }
    
    /* year年1月1日 */
    firstday = (firstday + days) % 7;
    
    /* 计算month月1日的星期数 */
    for (int i = 0; i < month - 1; i++)
    {
        firstday += YEAR[ leap ][ i ];
    }
    
    /* year年month月1日 */
    firstday = firstday % 7;
    
    /* month月 */
    for (int i = 0; i < YEAR[ leap ][ month - 1 ]; i++)
    {
        [monthday setDateAtIndex:i value:(i+1)];
        [monthday setWeekdayAtIndex:i value:(firstday + i) % 7];
    }
    
    /* 返回当月天数 */
    return YEAR[ leap ][ month - 1 ];
}

+(int)Special1752:(int)year month:(int)month weekday:(MONTHDAY*)monthday
{
    int leap = 2;      /* 适用的月份数据 特殊年份    */
    int firstday = 3;  /* 每月1日的星期数            */
    
    /* 计算month月1日的星期数 */
    for (int i = 0; i < month - 1; i++)
    {
        firstday += YEAR[ leap ][ i ];
    }
    
    /* 1752年month月1日 */
    firstday = firstday % 7;
    
    /* 9月份特殊处理 */
    if (month == 9)
    {
        /* month月 */
        for (int i = 0; i < YEAR[ leap ][ month - 1 ]; i++)
        {
            if(i < 2) [monthday setDateAtIndex:i value:(i+1)];
            else [monthday setDateAtIndex:i value:(i+12)];
            [monthday setWeekdayAtIndex:i value:(firstday + i) % 7];
        }
        
        /* 返回当月天数 */
        return YEAR[ leap ][ month - 1 ];
    }
    
    /* 其他月份的处理 */
    for (int i = 0; i < YEAR[ leap ][ month - 1 ]; i++)
    {
        [monthday setDateAtIndex:i value:(i+1)];
        [monthday setWeekdayAtIndex:i value:(firstday + i) % 7];
    }
    
    /* 返回当月天数 */
    return YEAR[ leap ][ month - 1 ];
}

@end

