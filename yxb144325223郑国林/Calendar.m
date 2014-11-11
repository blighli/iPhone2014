//
//  Calendar.m
//  Perject1
//
//  Created by Mac on 14-10-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//
#import "Calendar.h"

@implementation Module

char *months[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
 //NSString *months=@"一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月";未实现

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

- (void) setFirstDay:(int) day andMonth:(int)month1 andYear:(int) year1
{
    firstDay=day;
    month=month1;
    posation=month-1;
    year=year1;
    if(month1==1||month1==3||month1==5||month1==7||month1==8||month1==10||month1==12)
    {
        days=31;
    }
    else if(month1!=2)
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
    int psw=posation/4*7*2+1;
    int col=posation%4*22+5;
    int col2;
    printf("%c[%d;%df",0x1b,psw,col+6);
    psw++;
    printf("%s %d",months[month-1],year);
    printf("%c[%d;%df",0x1b,psw,col);
    printf("日 一 二 三 四 五 六");
    int i=1;
    bool move=YES;
    while(i<days)
    {
        
        col2=col;
        psw+=1;
        if(move)
            col2+=firstDay*3;
        printf("%c[%d;%df",0x1b,psw,col2);
        for(int j=0;j<7&&i<=days;j++)
        { 
            if(move)
            {
                j+=firstDay;
                move=NO;
            }
            printf("%2d ",i++);
        }
        psw++;
    }
}

- (void) resetPosation
{
    posation=0;
}

@end

@implementation Calendar

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

- (int) forFirstDay:(int) day1 andMonth:(int) month1
{
    int y=year;
    if (month1==1||month1==-1) {
        month1=13;
        y--;
    }
    else if(month1==2)
    {
        month1=14;
        y--;
    }
    int c=y/100;
    y=y-c*100;
    int week=(day1+2*month1+3*(month1+1)/5+y+y/4-y/100+y/400+1);
    week%=7;
    return (week);
}
//计算当月第一天是星期几

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
