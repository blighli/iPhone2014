#include <string.h>
#include <stdio.h>

#define MAXDAYS 42  //7 * 6 = 42
#define MONDAY 1  //1900年1月1日是星期1
#define SPACE -1

char month_name[13][10] = {"","January", "February", "March", "April", "May", "June", 
							"July", "August", "September", "October", "November", "December" };

int days_in_month[2][13] = {
	{ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
	{ 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
};

int empty[MAXDAYS] = {
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE,
	SPACE, SPACE, SPACE, SPACE, SPACE, SPACE, SPACE
};

//函数声明
int day_in_week(int day, int month, int year);
bool is_leap(int year);
int leap_years_since1900(int year);
int day_in_year(int day, int month, int year);
void day_array(int month, int year, int *days);

//打印月历
void show_cal(int month, int year)
{
	printf("          %d      %s\n", year,month_name[month]);
	printf("  SUN  MON  TUE  WEN  THU  FRI  SAT\n");
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

//在6*7阵列中填写日期
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
//求某日期是星期几(0为星期日)
int day_in_week(int day, int month, int year) {
	int temp = (year - 1900) * 365 + leap_years_since1900(year)
		+ day_in_year(day, month, year);
	return (temp - 1 + MONDAY) % 7;
}
//求M月D日是Y年的第几天
int day_in_year(int day, int month, int year) 
{
	int leap = is_leap(year);
	for (int i = 1; i < month; i++)
		day += days_in_month[leap][i];
	return day;
}
//1900年至X年之间有几个闰年（不包括X）
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