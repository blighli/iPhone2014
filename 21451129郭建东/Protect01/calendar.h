//
//  calendar.h
//  Protect01
//
//  Created by guo on 14-10-6.
//  Copyright (c) 2014年 guo. All rights reserved.
//

#ifndef Protect01_calendar_h
#define Protect01_calendar_h
typedef struct _DATE2WEEKDAY {
	int date;
	int weekday;
} DATE2WEEKDAY;
int GregorianCalendar(int year, int month, DATE2WEEKDAY *date2weekday);


#endif
