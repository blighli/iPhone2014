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
    int row=posation/3*8+2;
    int col=posation%3*22+5;
    int col2;
    char *m_month[12]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    printf("%c[%d;%df",0x1b,row,col+6);
    row++;
    printf("%s  %d",m_month[month-1],year);
    printf("%c[%d;%df",0x1b,row,col);
    printf("日 一 二 三 四 五 六");
    row++;
    int i=1;
    bool move=YES;
    while(i<days)
    {
        //错点
        col2=col;
        if(move)
            col2+=firstDay*3;
        printf("%c[%d;%df",0x1b,row,col2);
        for(int j=0;j<7&&i<=days;j++)
        {
            if(move)
            {
                j+=firstDay;
                move=NO;
            }
            printf("%2d ",i++);
        }
        row++;
    }
}//模块化输出

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
    //int week=y+y/4+c/4-2*c+26*(m+1)/10+d-1;
    int week=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400+1);
    week%=7;
    return (week);
}//计算当月第一天是周几，由于改版而有多余参数

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
    //[md[0] setOutput];
    //NSLog(@"zhou,zhou,zhou:%d",[self forFirstDay:1 andMonth:1]);
}

@end
