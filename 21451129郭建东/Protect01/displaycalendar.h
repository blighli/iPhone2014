//
//  displaycalendar.h
//  Protect01
//
//  Created by guo on 14-10-6.
//  Copyright (c) 2014年 guo. All rights reserved.
//

#ifndef Protect01_displaycalendar_h
#define Protect01_displaycalendar_h
#include "calendar.h"

typedef struct _MONTHDAY {
	int days;
	DATE2WEEKDAY date2weekday[ 31 ];
} MONTHDAY;


int displaymonth(int year, int month);

int displayyear(int year);

#endif
