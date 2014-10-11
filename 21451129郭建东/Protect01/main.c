//
//  main.c
//  Protect01
//
//  Created by guo on 14-10-6.
//  Copyright (c) 2014年 guo. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "calendar.h"
#include "displaycalendar.h"
int main(){
	int year = 0;
	int month = 0;
	time_t tt;
	struct tm *Time;
    
    char str[15];
    gets(str);
    fflush(stdin);
    
    char str1[12];
    char str2[12];
    char str3[4] = {'c','a','l'};
   
    for (int s = 0; s<3; s++) {
        if (str[s]!= str3[s]) {
            printf( "Plear type in this way: cal [[month] year]\n The Range of the year between 1753~9999" );            return -1;
        }
    }
    
   // printf("%d__________________",d);
    int j = 0;
    int z = 0;
    //printf("%s",str);
    int k =0;
    k = strlen(str);
    
    switch (k) {
        case 3:                            // Type:    cal
            time( &tt );
            Time = gmtime( &tt );
            
            year = Time->tm_year + 1900;
            month = Time->tm_mon + 1;
            
            displaymonth( year, month );
            
            break;
        case 8:                            //   Type:  cal 2014
            for (int i=4; i<8; i++) {
                str1[j++] = str[i];
            }
            //printf("%s",str1);
            year = atoi(str1);
           // printf("%d",year);
            if ((year < 1) || (year > 9999))
            {
                 printf( "Plear type in this way: cal [[month] year]\n The Range of the year bettwn 1753~9999" );  
                
                return -1;
            }
            //show the calendar by year
            displayyear( year );
            break;  
        case 11:                             //Type: cal m 2014
            for (int i=7; i<11; i++) {
                str1[j++] = str[i];
            }
            for (int i=4; i<6; i++) {
                str2[z++] = str[i];
            }
            // tranform the string to the int(Powerful)
            year = atoi(str1);
            month = atoi(str2);
            
            if (year < 1 || year > 9999)
            {
                printf( "Plear type in this way: cal [[month] year]\n The Range of the year bettwn 1753~9999" );                
                return -1;
            }
            
            if (month < 1 || month > 12)
            {
                printf( "Plear type in this way: cal [[month] year]\n The Range of the month bettwn 1~12" );
                return -1;
            }
            
            //show the year and  month 
            displaymonth( year, month );
            //printf("%d,%d",year,month);
            
            break;
        default:
            printf( "Plear type in this way: cal [[month] year]\n The Range of the month bettwn 1~12 \n" );
            printf("The Range of the year bettwn 1753~9999");
            break;
    }

    return 0;
}
/*
  int strlen(char s[]){
    
        int i =0;
        while (s[i]!='\0') {
            i++;
        }
        return i;
    }
*/






