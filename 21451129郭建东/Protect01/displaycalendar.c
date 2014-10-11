//
//  displaycalendar.c
//  Protect01
//
//  Created by guo on 14-10-6.
//  Copyright (c) 2014年 guo. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

#include "displaycalendar.h"

/* –«∆⁄ */
#define WEEKDAY "Su Mo Tu We Th Fr Sa"

/*  ˝◊÷µƒASCII¬Î–Œ Ω */
char NUM[ 10 ] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

/* ‘¬∑› */
char *MONTHSTR[ 12 ] = {
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
};

/* œ‘ æ»’¿˙∫Ø ˝ ∞¥‘¬ */
int displaymonth(int year, int month)
{
	int line = 0;                     /* –– */
    
	int days = 0;                         /* ∑µªÿ÷µ£¨ ‰»Î‘¬∑›µƒÃÏ ˝               */
	DATE2WEEKDAY date2weekday[ 31 ];  /* ∑µªÿ÷µ£¨ ‰»Î‘¬∑›µƒ»’∆⁄∫Õ–«∆⁄∂‘”¶πÿœµ */
    
	/* œ‘ æ”√ */
	char BUFF[ 6 ][ 21 ] = {          /* 20 spaces */
		"                    ", "                    ",
		"                    ", "                    ",
		"                    ",	"                    "
	};
    
	/* ≈–∂œ ‰»Îµƒ≤Œ ˝£¨ºÚµ•≈–∂œ */
	if ((year < 1) || (year > 9999))
	{
		return -1;
	}
    
	/* ≈–∂œ ‰»Îµƒ≤Œ ˝£¨ºÚµ•≈–∂œ */
	if ((month < 1) || (month > 12))
	{
		return -1;
	}
    
    days = GregorianCalendar( year, month, &date2weekday[ 0 ] );
	
    
	/* ≥ı ºªØ */
	line = 0;
    
	/* …Ë÷√√ø––œ‘ æµƒƒ⁄»› */
	for (int i = 0; i < days; i++)
	{
		BUFF[ line ][ date2weekday[ i ].weekday * 3 ]  = NUM[ date2weekday[ i ].date / 10 ];
		BUFF[ line ][ date2weekday[ i ].weekday * 3 + 1 ] = NUM[ date2weekday[ i ].date % 10 ];
        
		if (date2weekday[ i ].weekday == 6)
		{
			line++;
		}
	}
    
	/* œ‘ æ */
	printf( "   %s %4d\n", MONTHSTR[ month - 1], year );
	printf( "%s\n", WEEKDAY );
    
	for (int i = 0; i < 6; i++)
	{
		printf( "%s\n", BUFF[ i ] );
	}
    
	return 0;
}

/* œ‘ æ»’¿˙∫Ø ˝ ∞¥ƒÍ */
int displayyear(int year)
{
	int line = 0;                  /* –– */
	MONTHDAY monthday[ 12 ];       /* ƒÍ */
    
	/* œ‘ æ”√ */
	char BUFF[ 12 ][ 6 ][ 21 ] = {          /* 20 spaces */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 1 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 2 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 3 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 4 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 5 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 6 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 7 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 8 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 9 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 10 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }, /* 11 */
		{ "                    ", "                    ",
            "                    ", "                    ",
            "                    ", "                    " }  /* 12 */
	};
    
	
	if ((year < 1) || (year > 9999))
	{
		return -1;
	}
    
    /* ≈–∂œ ‰»ÎµƒƒÍ∑›£¨µ˜”√  ”√µƒ¿˙∑® */
	
	 if (year > 1752) {
		/* ∏Ò¿Ô¿˙(GregorianCalendar) 1753 - ... */
		for (int i = 0; i < 12; i++)
		{
			monthday[ i ].days = GregorianCalendar( year, i + 1, &(monthday[ i ].date2weekday[ 0 ]) );
		}
	}
    
	for (int month = 0; month < 12; month++)
	{
		/* ≥ı ºªØ */
		line = 0;
        
		/* …Ë÷√√ø––œ‘ æµƒƒ⁄»› */
		for (int i = 0; i < monthday[ month ].days; i++)
		{
			BUFF[ month ][ line ][ monthday[ month ].date2weekday[ i ].weekday * 3 ]
            = NUM[ monthday[ month ].date2weekday[ i ].date / 10 ];
			BUFF[ month ][ line ][ monthday[ month ].date2weekday[ i ].weekday * 3 + 1 ]
            = NUM[ monthday[ month ].date2weekday[ i ].date % 10 ];
            
			if (monthday[ month ].date2weekday[ i ].weekday == 6)
			{
				line++;
			}
		}
	}
    
	printf( "                                 %d\n\n", year );
    
	for (int i = 0; i < 4; i++)
	{
		printf( "   %10s             %10s             %10s\n",
               MONTHSTR[ i * 3 ], MONTHSTR[ i * 3 + 1 ], MONTHSTR[ i * 3 + 2 ] );
        
		printf( "%s   %s   %s\n",
               WEEKDAY, WEEKDAY, WEEKDAY );
        
		for (int j = 0; j < 6; j++)
		{
			printf( "%s   %s   %s\n",
                   BUFF[ i * 3 ][ j ],
                   BUFF[ i * 3 + 1 ][ j ],
                   BUFF[ i * 3 + 2 ][ j ] );
		}
	}
}

