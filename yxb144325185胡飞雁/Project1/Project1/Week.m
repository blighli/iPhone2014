//
//  Week.m
//  Project1
//
//  Created by  sephiroth on 14-10-7.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "Week.h"

@implementation Module

- (NSString*) description
{
    return (output);
}

-(id) init
{
    if (self=[super init]) {
        firstDay=-1;
        month=-1;
        year=2014;
        posation=1;
        days=0;
    }
    return (self);
}

- (void) setFirstDay:(int) day andMonth:(int)m andYear:(int) y
{
    firstDay=day;
    month=m;
    posation=month-1;
    year=y;
    if(m==1||m==3||m==5||m==7||m==8||m==10||m==12)
    {
        days=31;
    }
    else if(m!=2)
    {
        days=30;
    }
    else
    {
        if((!(year%4)&&year%100)||(!(year%400)))
            days=29;
        days=28;
    }
}


- (void) setOutput
{
    int j,n;
    printf("%d月  %d\n",month,year);
    printf("日  一  二  三  四  五  六\n");
    
    for(int i=0;i<firstDay;i++){
        printf("    ");
    }
    j=firstDay;
    while(j<7)
    {
        j++;
        printf("%2d  ",j);
    }
    printf("\n");
    n=j;
    while(n<days)
    {
        for (int k=0;k<7&&n<days;k++ ) {
            n++;
            printf("%2d  ",n);
        }
        printf("\n");
      
    }
    
}

- (void) resetPosation
{
    posation=0;
}

@end

@implementation Week

- (id) init
{
    if (self=[super init]) {
        year=-1;
        month=-1;
        num=-1;
        for (int i=0; i<12; i++) {
            md[i]=[Module new];
        }
    }
    return (self);
}

- (void) setYear:(int) newYear
{
    year=newYear;
    for(int i=0;i<12;i++)
    {
        [md[i] setFirstDay:[self forFirstDay:1 andMonth:i+1] andMonth:i+1 andYear:year];
    }
}

- (void) setMonth:(int) newMonth
{
    month=newMonth;
}

- (void) setNum:(int) newNum
{
    num=newNum;
}

- (int) forFirstDay:(int) d andMonth:(int) m
{
    int y=year;
    if (m==1||m==-1) {
        m=13;
        y--;
    }
    else if(m==2)
    {
        m=14;
        y--;
    }
    int c=y/100;
    y=y-c*100;
    int week=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400+1);
    week%=7;
    return (week);
}

- (void) print
{
    if (month>0) {
        [md[month-1] resetPosation];
        [md[month-1] setOutput];
    }
    else
    {
        for(int i=0;i<12;i++)
        {
            [md[i] setOutput];
        }
    }

}

@end
