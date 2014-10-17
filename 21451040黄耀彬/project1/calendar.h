#ifndef CALENDAR_H
#define CALENDAR_H 

#define LEAPYEAR 2
#define NOTLEAPYEAR 1
#define SPECIALYEAR -2

#define BEGINDAYOFWEEK 6
#define DAYOFWEEK 7

#define MAXROW 7
#define MAXCOLUMN 100

#define QUERYYEAR 0x1
#define QUERYMONTH 0x2

int isLeapYear(int);
int getfirstDayOfYear(int);
int getFirstDayOfMonth(int, int);
int monthNameLength(int);
void getCalendar(int, int, char[][MAXCOLUMN]);
void printCalendar(char[][MAXCOLUMN]);
void clearCalendar(char[][MAXCOLUMN]);
void myCalendar(int, int, int);


#endif