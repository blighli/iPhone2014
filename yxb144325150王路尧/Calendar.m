//
//  calendar.m
//  project_1
//
//  Created by 王路尧 on 14-10-10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "calendar.h"

@implementation Module

-(NSString*) description
{
    return(output);
}

-(id) init
{
    if(self=[super init]){
        firstday=-1;
        month=-1;
        year=2014;
        posation=1;
        days=0;
    }
    return(self);
}

-(void)setFirstday:(int)day andMonth:(int)m andYear:(int)y
{
    firstday=day;
    month=m;
    posation=month-1;
    year=y;
    if(m==1||m==3||m==5||m==7||m==8||m==10||m==12){
        
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

-(void)setOutput
{
    int row=posation/3*7*2+1;
    int col=posation%3*22+5;
    int col2;
    printf("%c[%d;%df",0x1b,row,col+6);
    row++;
    printf("%d月  %d",month,year);
    printf("%c[%d;%df",0x1b,row,col);
    printf("日 一 二 三 四 五 六");
    int i=1;
    bool move=YES;
    while(i<days)
    {
        col2=col;
        row+=1;
        if(move)
            col2+=firstday*3;
        printf("%c[%d;%df",0x1b,row,col2);
        for(int j=0;j<7&&i<=days;j++)
        {
            if(move)
            {
                j+=firstday;
                move=NO;
            }
            printf("%2d ",i++);
        }
        row++;
    }
}

-(void)resetPosation
{
    posation=0;
}

@end

@implementation calendar

-(id) init
{
    if(self=[super init]){
        year=-1;
        month=-1;
        num=-1;
        for(int i=0; i<12; i++){
            md[i]=[Module new];
        }
    }
    return(self);
}

-(void)setYear:(int)newYear
{
    year=newYear;
    for(int i=0;i<12;i++)
    {
        [md[i] setFirstday:[self forFirstday:1 andMonth:i+1]
                  andMonth:i+1 andYear:year];
    }
}

-(void)setMonth:(int) newMonth
{
    month=newMonth;
}

-(void)setNum:(int) newNum
{
    num=newNum;
}

-(int) forFirstday:(int) d andMonth:(int) m
{
    int y=year;
    if(m==1||m==-1){
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
    return(week);
}

-(void)print
{
    if(month>0){
        [md[month-1]resetPosation];
        [md[month-1]setOutput];
    }
    else
    {
        for (int i=0; i<12; i++) {
            [md[i]setOutput];
        }
    }

}

@end