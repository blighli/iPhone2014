//
//  main.m
//  lcPro1
//
//  Created by guest on 14-10-3.
//  Copyright (c) 2014年 guest. All rights reserved.
//

#import <Foundation/Foundation.h>

int daysOfMonth(int m,int y)      //m为月份，y为年，得到y年m月的天数
{
    int days[]={0,31,28,31,30,31,30,31,31,30,31,30,31};
    if((y%4==0&&y%100!=0)||y%400==0)
        days[2]=29;
    return days[m];
}

int weekOfFirst(int m,int y)   //y年m月的第一天的星期数
{
    int c,w;
    if(m==1||m==2){
        y--;
        m+=12;
    }
    c=y/100;
    y%=100;
    w=(y+y/4+c/4-2*c+(m+1)*26/10)%7;
    w=(w+7)%7;                 //蔡勒公式
    return w;
}

void printLine(int line,int m,int y)    //输出y年m月第line行
{
    int w,d,now;
    w=weekOfFirst(m,y);
    d=daysOfMonth(m,y);
    if(line==0)
        printf("日 一 二 三 四 五 六 ");
    else {
        for(int i=1;i<=7;i++)
        {
            now=(line-1)*7-w+i;
            if(now<1||now>d)
                printf("   ");
            else
                printf("%2d ",now);
        }
    }
    printf(" ");
}


int main(int argc, const char * argv[])
{
    int month=-1;
    int year=-1;
    int error=0;
    char *monthName[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger curYear = [comps year];
    NSInteger curMonth = [comps month];
    switch(argc){
        case 1:
            month=curMonth;
            year=curYear;
            break;
        case 2:
            year=atoi(argv[1]);
            if (year<1||year>9999) {
                printf("cal: year %d not in range 1..9999\n",year);
                error=1;
            }
            break;
        case 3:
            if (strcmp(argv[1],"-m")==0){
                month=atoi(argv[2]);
				year=curYear;
            }
            else 
            {
                month=atoi(argv[1]);
                year=atoi(argv[2]);
                if(year<1||year>9999){
                printf("cal: year %d not in range 1..9999\n",year);
                error=1;
                break;
                }
            }
            if(month<1||month>12){
                error=1;
                printf("cal: %d is neither a month number (1..12) nor a name\n",month);
            }
            break; 
    
    }

    if(error==0){
        if(month!=-1){
            printf("     %s %4d     \n",monthName[month-1],year);
            for (int i=0;i<7;i++){
                printLine(i,month,year);
                printf("\n");
            }
        }
        else{
            printf("                             %4d\n\n",year);
          for(int i=0;i<4;i++){
            printf("        %s                   %s                 %s\n",monthName[3*i],monthName[3*i+1],monthName[3*i+2]);
            for(int j=0;j<7;j++){
                for(int k=1;k<4;k++)
                    printLine(j,3*i+k,year);
                printf("\n");
            }
         }
       }
    }
return 0;
}

