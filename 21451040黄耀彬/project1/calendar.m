#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "calendar.h"

int firstDayOfYear = -1;
int firstDayOfMonth = -1;
int dayOfMonth[] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

int main(int argc, char* argv[])
{
	time_t timep;
	struct tm *p;
	int year;
	int month;
	switch (argc)
	{
	case 1:
		time(&timep);
		p=localtime(&timep);
		myCalendar(1900 + p->tm_year, 1 + p->tm_mon, QUERYMONTH);
        break;
	case 2:
		year = atoi(argv[1]);
		if (year != 0)
			myCalendar(year, 0, QUERYYEAR);
		else
			printf("cal: year %d not in range 1..9999\n", year);
		break;
	case 3:
		if (strcmp(argv[1], "-m") == 0)
		{
			month = atoi(argv[2]);
            time(&timep);
            p=localtime(&timep);
			if (month > 0 && month <= 12)
				myCalendar(1900 + p->tm_year, month, QUERYMONTH);
			else
				printf("cal: %d is neither a month number (1..12)\n", month);
		}
		else
		{
			month = atoi(argv[1]);
			year = atoi(argv[2]);
			if (year == 0)
				printf("cal: %d is neither a month number (1..12)\n", month);
			else if (month <= 0 || month > 12)
				printf("cal: %d is neither a month number (1..12)\n", month);
			else
				myCalendar(year, month, QUERYMONTH);
		}
		break;
	default:
		break;
	}
}

int isLeapYear(int year)
{
	return year == 1752 ? SPECIALYEAR : (year % 4 == 0 && (year % 100 != 0 || year <= 1752)) || year % 400 == 0 ? LEAPYEAR : NOTLEAPYEAR;
}

int getFirstDayOfYear(int year)
{
	int i;
	int totalOffset = 0;
	for (i = 1; i < year; i++)
	{
		totalOffset += isLeapYear(i);
	}
	return (BEGINDAYOFWEEK + totalOffset) % DAYOFWEEK;
}

int getFirstDayOfMonth(int year, int month)
{
	int totalOffset = firstDayOfYear;

	int currentYear = isLeapYear(year);

	if (currentYear == LEAPYEAR || currentYear==SPECIALYEAR)
		dayOfMonth[2] = 29;

	if (currentYear == SPECIALYEAR)
		dayOfMonth[9] = 19;

	if (firstDayOfMonth == -1)
	{
		for (int j = 1; j < month; j++)
		{
			totalOffset += dayOfMonth[j];
		}
	}
	else
	{
		totalOffset = firstDayOfMonth;
		totalOffset += dayOfMonth[month - 1];
	}
	return totalOffset%DAYOFWEEK;
}

int monthNameLength(int month)
{
    if(month<10)
        return 4;
    else
        return 6;
}

void getCalendar(int dayOfWeek, int day, char result[][MAXCOLUMN])
{
	int currentLine = 0;
	char tmp[10];
	int i;
	int lineLength = strlen(result[0]);
    lineLength-=(lineLength/27)*7;
	strcat(result[currentLine++], "日 一 二 三 四 五 六");
	for (i = 0; i < 3 * dayOfWeek; i++)
		strcat(result[currentLine], " ");
	for (i = 1; i <= day; i++)
	{
		if (day == 19 && i>2)
			sprintf(tmp, "%2d", i + 11);
		else
			sprintf(tmp, "%2d", i);
		strcat(result[currentLine], tmp);
		if ((i + dayOfWeek) % DAYOFWEEK == 0)
		{
			currentLine++;
			while ((int)strlen(result[currentLine]) < lineLength)
			{
				strcat(result[currentLine], " ");
			}
		}
		else
			strcat(result[currentLine], " ");
	}
}

void myCalendar(int year, int month, int queryType)
{
	char result[MAXROW][MAXCOLUMN];
	char monthName[12][10] =
	{
		"一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"
	};
	int i, j, k,len;
	char tmpStr[20];

	firstDayOfYear = getFirstDayOfYear(year);

	if (queryType == QUERYYEAR)
	{
		sprintf(tmpStr, "%d", year);
		for (i = 0; i < (int)(64 - strlen(tmpStr)) / 2; i++)
			printf(" ");
		printf("%d\n\n", year);
		for (i = 0; i < 4; i++)
		{
			clearCalendar(result);
			for (j = 0; j <= 2; j++)
			{
				len = monthNameLength(j+i*3);
				for (k = 0; k < (20 - len) / 2; k++)
					printf(" ");
				printf("%s", monthName[j + i * 3]);
				for (k = 0; k < (20 - len) / 2; k++)
					printf(" ");
				if (j != 2)
					printf("  ");
				else
					printf("\n");
			}

			for (j = 1; j <= 3; j++)
			{
				firstDayOfMonth = getFirstDayOfMonth(year, i * 3 + j);
				getCalendar(firstDayOfMonth, dayOfMonth[i * 3 + j], result);
				if (j != 3)
				{
					for (k = 0; k < MAXROW; k++)
						strcat(result[k], "  ");
				}
			}
			printCalendar(result);
		}
	}
	else
	{
		sprintf(tmpStr, "%s %d", monthName[month - 1], year);
        for (i = 0; i < (int)(20 - strlen(tmpStr)+monthNameLength(month-1)/2) / 2; i++)
			printf(" ");
		printf("%s\n", tmpStr);
		firstDayOfMonth = getFirstDayOfMonth(year, month);
		clearCalendar(result);
		getCalendar(firstDayOfMonth, dayOfMonth[month], result);
		printCalendar(result);
	}
}

void printCalendar(char result[][MAXCOLUMN])
{
	int i;
	for (i = 0; i < MAXROW; i++)
	{
		printf("%s", result[i]);
        printf("\n");
	}
}

void clearCalendar(char result[][MAXCOLUMN])
{
	int i;
	for (i = 0; i < MAXROW; i++)
		result[i][0] = '\0';
}