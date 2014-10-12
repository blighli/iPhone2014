//
//  LearnCalendar.m
//  DisplayCalendar
//
//  Created by Chencheng on 14-10-7.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "LearnCalendar.h"

@implementation LearnCalendar
 -(NSInteger) firstWeekday:(NSInteger)month :(NSInteger)year//判断每个月第一天是星期几
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday-1;
}
-(NSInteger) days:(NSInteger)month :(NSInteger)year//判断指定月份的天数
{
    NSInteger day;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
        {
            day=31;
            break;
        }
        case 4:
        case 6:
        case 9:
        case 11:
        {
            day=30;
            break;
        }
        case 2:
        {
            if(year%400==0||(year%4==0&&year%100!=0))//判断指定年份是不是闰年
                 day=29;
            else
                day=28;
            break;
        }
        default:
            break;
    }
    return day;
}
-(void)outputCalendar:(NSInteger)x:(NSInteger)y
{
    printf("SUN MON TUE WED THU TRI SAT\n");//用星期的英文来代表星期，因为中文不好对齐
    int flag=1,sum=0;//flag判断，sum用于统计输出个数，方便换行
    for(int i=1;i<=y;i++)
    {
        if(flag==1)
        {
            
            for(int j=1;j<=x%7;j++)//先输出每个月第一天前面的空格
            {
                printf("    ");
                sum++;
                
            }
            if(x==6)//第一行该换行了
            {
                printf("%3d\n",i);//输出每个月第一天的位置
                sum=0;
            }
             else
             {
                printf("%3d ",i);//输出每个月第一天的位置
                 sum++;
             }
            
            flag=0;
        }
        else
        {
            if(sum==6)//sum=6表示该换行了
            {
              printf("%3d\n",i);
              sum=0;
            }
            else
            {
              printf("%3d ",i);//sum<6表示还没输出7个，不用换行
              sum++;
            }
        }
    }
    printf("\n");
}
-(void) CalendarwithMonth:(NSInteger)month andYear:(NSInteger)year//显示指定年月的月历
{
    [self DisplayCalendar:month :year ];
}

-(void)CalendarwithYear:(NSInteger)year//显示指定年的月历
{
    for(NSInteger i=1;i<=12;i++)
        [self DisplayCalendar:i :year ];
}
-(void)DisplayCalendar:(NSInteger)month :(NSInteger)year//输出月历
{
    NSInteger firweek=[self firstWeekday:month :year];
    NSInteger day=[self days:month :year];
    printf("        %d年%d月\n",year,month);
    [self outputCalendar:firweek :day];
}
@end
