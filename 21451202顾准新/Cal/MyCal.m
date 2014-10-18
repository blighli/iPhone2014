//
//  MyCal.m
//  Cal
//
//  Created by 顾准新 on 14-10-10.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "MyCal.h"

@implementation MyCal

char *months[12]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

//判断是否为闰年
//参数y :年份
-(BOOL) judgeYear:(int)y
{
    if((y%4==0 && y%100!=0) || (y%100==0 && y%400==0))
        return TRUE;
    else
        return FALSE;
}

//计算某年某月一号为星期几
//参数y :年份
//参数m :月份
-(int) calWkdYear:(int)y Month:(int)m
{
    int ds=0;
    int mthd[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    if([self judgeYear:y])
    {
        mthd[2]=29;
    }
    for(int i=1;i<m;i++)
    {
        ds+=mthd[i];
    }
    ds++;
    int rst=y-1+(int)((y-1)/4)-(int)((y-1)/100)+(int)((y-1)/400)+ds;
    int wkd=rst%7;
 //   printf("%d\n",wkd);
    return wkd;
}

//初始化某年某月的月历
//参数y :年份
//参数m :月份
-(void) setCalWithYear:(int)y Month:(int)m
{
    year=y;
    month=m;
    int wk= [self calWkdYear:y Month:m];
 //   printf("%d\n",wk);
    int mthd[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    int mtd = mthd[m];
    for (int i=0; i<5; i++) {
        for(int j=0;j<7;j++){
            cal[i][j] = 0;
        }
        
    }
    
    int date=1;
    int i=0,j=0;
    for(int k=wk;k<mtd+wk;k++)
    {
        
        i=k/7;
        j=k%7;
        cal[i][j]=date;
        date++;
    }
   // [self printCal];
}

-(id) init
{
    if(self=[super init]){
        for (int i=0; i<5; i++) {
            for(int j=0;j<7;j++){
                cal[i][j] = 0;
            }
            
        }
    }
    return (self);
}
/*
-(id) initWithYear:(int)y Month:(int) m
{
    if(self=[super init]){
        [self setCalWithYear:y Month:m];
    }
    return (self);
}
*/

//打印月历
-(void) printCal
{
    printf("%12s %d",months[month],year);
    printf("日 一 二 三 四 五 六");
    printf("\n");
    for(int i=0;i<5;i++)
    {
        for(int j=0;j<7;j++)
        {
            if(cal[i][j]!=0)
            {
                if (cal[i][j]<10) {
                     printf(" %d ",cal[i][j]);
                } else{
                     printf("%d ",cal[i][j]);
                }
               
            }
            else
            {
                printf("   ");
            }
        }
        printf("\n");
    }
    printf("\n");
}

-(void) pritnYear
{
    int calBuff[12][5][7];
    for(int i=0;i<12;i++){
        [self setCalWithYear:year Month:i];
        for(int j=0;j<5;j++){
            for(int k=0;k<7;k++)
            {
                calBuff[i][j][k]=cal[j][k];
            }
        }
    }
    char buff[12][5][21];
    for(int i=0;i<12;i++){
       // [self setCalWithYear:year Month:i];
        for(int j=0;j<5;j++){
            for(int k=0;k<7;k++){
                if(calBuff[i][j][k]!=0)
                {
                    if(calBuff[i][j][k]<10) {
                        buff[i][j][k*3]=' ';
                        buff[i][j][k*3+1]=calBuff[i][j][k]+'0';
                        buff[i][j][k*3+2]=' ';
                    } else{
                        buff[i][j][k*3]=(calBuff[i][j][k]/10)+'0';
                        buff[i][j][k*3+1]=(calBuff[i][j][k]%10)+'0';
                        buff[i][j][k*3+2]=' ';
                    }
                    
                }
                else
                {
                    buff[i][j][k*3]=' ';
                    buff[i][j][k*3+1]=' ';
                    buff[i][j][k*3+2]=' ';
                }
            }
        }
    }
    //char buff[28][63];
    printf("%30d",year);
    for(int i=0;i<4;i++)
    {
        printf("%12s%24s%24s\n",months[i],months[i+1],months[i+2]);
        printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        for(int j=0;j<5;j++)
        {
            printf("%s%s%s\n",buff[i%3][j],buff[i*3+1][j],buff[i*3+2][j]);
        }
        
    }
    
    //for(int i=0;i<28;i++){}
    
}

@end
