//
//  Calender_peng.m
//  OC_Assignment_1
//  Copyright (c) 2014年 pengcheng. All rights reserved.
//

#import "Calender_peng.h"

@implementation Calender_peng


+ (void)printMonth:(int) month andYear:(int) year
{
   
    int dayCount;//记录天数
    int blankCount;//记录输出行的字符数
    
    NSString * s_month;
    
    switch (month) {
        case 1:
            s_month=@"一";
            break;
        case 2:
            s_month=@"二";
            break;
        case 3:
            s_month=@"三";
            break;
        case 4:
            s_month=@"四";
            break;
        case 5:
            s_month=@"五";
            break;
        case 6:
            s_month=@"六";
            break;
        case 7:
            s_month=@"七";
            break;
        case 8:
            s_month=@"八";
            break;
        case 9:
            s_month=@"九";
            break;
        case 10:
            s_month=@"十";
            break;
        case 11:
            s_month=@"十一";
            break;
        case 12:
            s_month=@"十二";
            break;
        default:
            break;
    }
    
    NSLog(@"\n     %@月 %d \n",s_month,year);
    NSLog(@"日 一 二 三 四 五 六 \n");
    //NSData * today=[NSData data];
    
    
    long weekd=[Calender_peng firstWeekDay:month andYear:year];
    
    for (int j=1; j<weekd; j++) {
         NSLog(@"   ");
        blankCount+=3;
    }
   
    dayCount=[Calender_peng getDayCount:month andYear:year];
    
    
    
    for (int i=1; i<=dayCount; i++) {
        if(i<10)
        {
            NSLog(@" %d ",i);//输出1~9天
        }
        else
        {
            NSLog(@"%d ",i);//输出剩余天
        }
        
        blankCount+=3;
        
        if (blankCount%21==0) {//每行填满20个字符后换行
            NSLog(@"\n");
        }
    }
    
    
}


+ (void)printYear:(int) year
{
    int dayCount;//记录天数
    
    NSString * str[12][42]={};
    
    for (int i=0; i<12; i++) {
        for (int j=0; j<42; j++) {
            str[i][j]=@"   ";
        }
    }
    
    
    for (int i=0; i<12; i++) //将整年每个月份的日历按照字符串的方式存入数组
    {
        long weekday = [Calender_peng firstWeekDay:i+1 andYear:year];
        dayCount =[Calender_peng getDayCount:i+1 andYear:year];
        for (int j=0; j<dayCount; j++)
        {
            //for (int k=1; k<=dayCount; k++) {//这里错了。。。按照str的方式存储
            NSString * xx;
            if (j<9) {
                xx=[NSString stringWithFormat:@" %d ",j+1]; //用stringWithFormat初始化字符串
            }
            else
            {
                xx=[NSString stringWithFormat:@"%d ",j+1];
            }
            str[i][j+weekday-1]=xx;
        }
    }

    
    for (int line=1; line<33; line++) {//按照行输出
        switch (line) {
            case 1:
                NSLog(@"\n        一月                   二月                  三月\n");
                break;
            case 9:
                NSLog(@"        七月                   八月                  九月\n");
                break;
            case 17:
                NSLog(@"        七月                   八月                  九月\n");
                break;
            case 25:
                NSLog(@"        十月                  十一月                 十二月\n");
                break;
            case 2:
            case 10:
            case 18:
            case 26:
                NSLog(@"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六 \n");
                break;
            case 3:
                for (int i=1; i<=6; i++) {
                    for (int j=0;j<3;j++)
                    {
                        for (int k=7*(i-1); k<7*i; k++) {//输出此月第一周日历
                            NSLog(@"%@",str[j][k]);
                        }
                        NSLog(@" ");//每周日历后面加一个空格
                    }
                    NSLog(@"\n");//每行输出结束后换行
                }
                break;
            case 11:
                for (int i=1; i<=6; i++) {
                    for (int j=3;j<6;j++)
                    {
                        for (int k=7*(i-1); k<7*i; k++) {//输出此月第一周日历
                            NSLog(@"%@",str[j][k]);
                        }
                        NSLog(@" ");//每周日历后面加一个空格
                    }
                    NSLog(@"\n");//每行输出结束后换行
                }
                break;
            case 19:
                for (int i=1; i<=6; i++) {
                    for (int j=6;j<9;j++)
                    {
                        for (int k=7*(i-1); k<7*i; k++) {//输出此月第一周日历
                            NSLog(@"%@",str[j][k]);
                        }
                        NSLog(@" ");//每周日历后面加一个空格
                    }
                    NSLog(@"\n");//每行输出结束后换行
                }
                break;
            case 27:
                for (int i=1; i<=6; i++) {
                    for (int j=9;j<12;j++)
                    {
                        for (int k=7*(i-1); k<7*i; k++) {//输出此月第一周日历
                            NSLog(@"%@",str[j][k]);
                        }
                        NSLog(@" ");//每周日历后面加一个空格
                    }
                    NSLog(@"\n");//每行输出结束后换行
                }
                break;
            default:
                break;
        }
    }
    
    
}

/*实验品
void printWeekLine(int month, NSString * str[12][])
{
    for (int i=1; i<=6; i++) {
        for (int j=9;j<12;j++)
        {
            for (int k=7*(i-1); k<7*i; k++) {//输出此月第一周日历
                NSLog(@"%@",str[j][k]);
            }
            NSLog(@" ");//每周日历后面加一个空格
        }
        NSLog(@"\n");//每行输出结束后换行
    }
}
*/



+(int) getDayCount:(int)month andYear:(int)year//获得当月的天数
{
    int dayCount;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            dayCount=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            dayCount=30;
        case 2:
            if ((year%4==0&& year%100!=0)||year%400==0)
            {
                dayCount=28;
            }
            else
                dayCount=29;
        default:
            NSLog(@"月份错误！");
    }
    return dayCount;
}

+ (int) firstWeekDay:(int)month andYear:(int)year//得到月份的第一天是周几
{
    NSDateComponents * thisDate=[[NSDateComponents alloc] init];
    [thisDate setYear:year];
    [thisDate setMonth:month];
    [thisDate setDay:1];
    
    NSCalendar * thiscal=[[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDate *date=[thiscal dateFromComponents:thisDate];
    
    NSUInteger weekd=[thiscal ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    
    return weekd;
}

@end
