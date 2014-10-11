//
//  calendar.c
//  Protect01
//
//  Created by guo on 14-10-6.
//  Copyright (c) 2014年 guo. All rights reserved.
//
#include "calendar.h"

int YEAR[ 2 ][ 12 ] = {
	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
	{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
};

int GregorianCalendar(int year, int month, DATE2WEEKDAY *date2weekday)
{
	int leap = 0;
	int firstday = 1;  
    
	int days = 0;      
    
	
	if ((((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0))
	{
		leap = 1;
	}
    
	
	days = 0;
    
	
	for (int n = 1753; n < year; n++)
	{
        if ((((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0))
            {
                leap = 1;
            }
            
            
            days = 0;
            
            
            for (int n = 1753; n < year; n++)
            {
                if ((((n % 4) == 0) && ((n % 100) != 0)) || ((n % 400) == 0))
                {
                    days += 2;
                } else {
                    days++;
                }
            }
       
	/* yearƒÍ1‘¬1»’ */
	firstday = (firstday + days) % 7;
    
	/* º∆À„month‘¬1»’µƒ–«∆⁄ ˝ */
	for (int i = 0; i < month - 1; i++)
	{
		firstday += YEAR[ leap ][ i ];
	}
    
	/* yearƒÍmonth‘¬1»’ */
	firstday = firstday % 7;
    
	/* month‘¬ */
	for (int i = 0; i < YEAR[ leap ][ month - 1 ]; i++)
	{
		date2weekday->date = i + 1;
		date2weekday->weekday = (firstday + i) % 7;
        
		date2weekday++;
	}
    
	/* ∑µªÿµ±‘¬ÃÏ ˝ */
	return YEAR[ leap ][ month - 1 ];
 }
}
