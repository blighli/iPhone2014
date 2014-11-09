//
//  Calculator.m
//  Project1
//
//  Created by 江山 on 10/10/14.
//  Copyright (c) 2014 江山. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (BOOL)isLeap:(int)year{
    BOOL leap;
    leap= year>1753? (year%4==0&&year%100!=0)||year%400==0 :year%4==0;
    return leap;
}

- (int)yearCal:(int)year {
    int day=0, i=1;
    while(i<year)
    {
        if([self isLeap:i])
        {
            day++;
        }
        day++;
        i++;
    }
    if(year<1753){
        return (day+6)%7;
    }else{
        return (day+2)%7;
    }
}

- (int)monthCal:(int)year :(int)month {
    int lenth[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    int day=[self yearCal:year];
    int i = 1;
    while(i<month)
    {
        day+=lenth[i-1];
        i++;
    }
    if(month>2&&[self isLeap:year])
    {
        day++;
    }
    if(year==1752&&month>9){
        day+=3;
    }
    return day%7;
}

@end

