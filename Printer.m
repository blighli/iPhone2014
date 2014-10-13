//
//  Printer.c
//  Project1
//
//  Created by 江山 on 10/11/14.
//  Copyright (c) 2014 江山. All rights reserved.
//

#import "Printer.h"
#import "Calculator.h"

@implementation Printer

int lenth[12]={31,28,31,30,31,30,31,31,30,31,30,31};

char* name[12]={"January","February","March","April","May","June","July","August","September","October","November","December"};

-(void) yearPrint: (int)year{

        int n;
        if (year<10) {
            n=31;
        }else if(year>=10&&year<1000){
            n=30;
        }else if(year>=1000){
            n=29;
        }
        for(int i=0; i<n; i++){
            printf(" ");
        }
        printf("%d\n\n", year);
        Calculator *cal=[Calculator new];
    
    
        printf("      January               February               March\n");
        printf("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");    
        int len[3]={31,28,31};
        if([cal isLeap:year]){
            len[1]=29;
        }
        int day[3];
        for(int i=0; i<3; i++){
            day[i]=[cal monthCal:year :i+1];
        }
        [self numPrint:len :day];
    
    
        printf("       April                  May                   June\n");
        printf("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
        for(int i=3; i<6; i++){
            len[i-3]=lenth[i];
            day[i-3]=[cal monthCal:year :i+1];
        }
        [self numPrint:len :day];
    
    printf("        July                 August              September\n");
    printf("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa\n");
    if(year==1752){
        printf("          1  2  3  4                     1         1  2 14 15 16\n");
        printf(" 5  6  7  8  9 10 11   2  3  4  5  6  7  8  17 18 19 20 21 22 23\n");
        printf("12 13 14 15 16 17 18   9 10 11 12 13 14 15  24 25 26 27 28 29 30\n");
        printf("19 20 21 22 23 24 25  16 17 18 19 20 21 22\n");
        printf("26 27 28 29 30 31     23 24 25 26 27 28 29\n");
        printf("                      30 31\n");
        
    }else{
        for(int i=6; i<9; i++){
            len[i-6]=lenth[i];
            day[i-6]=[cal monthCal:year :i+1];
        }
        [self numPrint:len :day];
    }
    
    
    printf("      October               November              December\n");
    printf("Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu    We Th Fr Sa\n");
    for(int i=9; i<12; i++){
        len[i-9]=lenth[i];
        day[i-9]=[cal monthCal:year :i+1];
    }
    [self numPrint:len :day];

}

-(void) monthPrint: (int)year :(int)month{
    int n=(15-strlen(name[month-1]))/2;
    int i;
    for(i=0; i<n; i++)
    {
        printf(" ");
    }
    printf("%s %d\n", name[month-1], year);
    printf("Su Mo Tu We Th Fr Sa\n") ;
    Calculator *cal=[Calculator new];
    int enter=[cal monthCal:year :month];
    i=0;
    while(i<enter)
    {
        printf("   ");
        i++;
    }
    i=1;
    enter++;
    while(i<lenth[month-1]+1)
    {
        if(i<10)
        {
            printf(" %d ", i);
        }else
        {
            printf("%d ", i);
        }
        if(enter%7==0)
        {
            printf("\n");
        }
        enter++;
        i++;
    }
}

-(void) numPrint:(int[3]) len :(int[3]) day{
    int temp[3];
    for(int i=0; i<3; i++){
        for(int j=0; j<day[i]; j++){
            printf("   ");
        }
        for(int j=0; j<7-day[i]; j++){
            printf(" %d ",j+1);
            temp[i]=j+2;
        }
        printf(" ");
    }
    printf("\n");
    while(temp[0]<=len[0]||temp[1]<=len[1]||temp[2]<=len[2]){
        for(int i=0; i<3; i++){
            for(int j=0; j<7; j++){
                if(temp[i]<10){
                    printf(" %d ", temp[i]);temp[i]++;
                }else if(temp[i]<=len[i]){
                    printf("%d ", temp[i]);temp[i]++;
                }else{
                    printf("   ");
                }
            }
            printf(" ");
        }
        printf("\n");
    }
}

@end
