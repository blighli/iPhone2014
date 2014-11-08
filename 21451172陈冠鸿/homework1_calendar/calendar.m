//
//  show_cal.m
//  cal
//
//  Created by Chen.D.guanhong on 14-10-17.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string.h>
#import <stdio.h>

#define MAXDAYS 42  //7 * 6 = 42
#define MONDAY 1  //1900年1月1日是星期一
#define SPACE -1    //负数不会被打印
#define MONTHS_PER_COL  3  //年历一行打印三个月

const char month_name[13][10] = {"","January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" };

const int days_in_month[2][13] = {
    { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
    { 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
};

const char *weekday = "  SUN  MON  TUE  WED  THU  FRI  SAT";

int empty[MAXDAYS] = {
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
    SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE
};


int day_in_week(int day, int month, int year);
bool is_leap(int year);
int leap_years_since1900(int year);
int day_in_year(int day, int month, int year);
void day_array(int month, int year, int *days);

//打印月历
void show_month(int month, int year)
{
    printf("          %d      %s\n", year,month_name[month]);
    printf("%s\n",weekday);
    int cal[MAXDAYS];
    day_array(month, year, cal);
    for (int col = 1; col <= 6; col++)
    {
        for (int row = 1; row <= 7; row++)
        {
            int value = cal[(row - 1) + (col - 1) * 7];
            if (value > 0)
                printf("%5d", value);
            else
                printf("     ");
        }
        printf("\n");
    }
    return;
}

//用日期填充6*7阵列
void day_array(int month, int year, int *days) {
    int daynum, dw, dm;
    memcpy(days, empty, MAXDAYS * sizeof(int));
    dm = days_in_month[is_leap(year)][month];
    dw = day_in_week(1, month, year) ;
    daynum = 1;
    while (dm--) {
        days[dw] = daynum++;
        dw++;
    }
}
//求出实参日期是星期几
int day_in_week(int day, int month, int year) {
    int temp = (year - 1900) * 365 + leap_years_since1900(year)
    + day_in_year(day, month, year);
    return (temp - 1 + MONDAY) % 7;
}
//month月day日是year年的第几天
int day_in_year(int day, int month, int year)
{
    int leap = is_leap(year);
    for (int i = 1; i < month; i++)
        day += days_in_month[leap][i];
    return day;
}
//从1900到实参年份共经过多少闰年
int leap_years_since1900(int year)
{
    int count = 0;
    for (int i = 1900; i < year; i++)
    {
        if (is_leap(i))
            count++;
    }
    return count;
}
//判断闰年
bool is_leap(int year)
{
    bool leap = (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) ? true : false;
    return leap;
}