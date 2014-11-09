//
//  Calendar.m
//  Project1
//
//  Created by 陈晟豪 on 14-10-11.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

- (id)init
{
    //每月有31天和30天的月份数组
    thirty_one = @[@"1",@"3",@"5",@"7",@"8",@"10",@"12"];
    thirty = @[@"4",@"6",@"9",@"11"];
    month_array = @[@" 一月",@" 二月",@" 三月",@" 四月",@" 五月",@" 六月",@" 七月",@" 八月",@" 九月",@" 十月",@"十一月",@"十二月"];
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    now=[NSDate date];
    comps = [[NSDateComponents alloc] init];
    unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    dateFormatter = [[NSDateFormatter alloc] init];
    
    comps = [calendar components:unitFlags fromDate:now];
    
    week = [comps weekday];
    //本日是周几
    week = week - 1;
    if(week == 0)
    {
        week =7;
    }
    
    return self;
}

//显示月历 y:年 m:月 d:日
- (void)showCalendar:(NSInteger)y setMonth:(NSInteger)m setDay:(NSInteger)d
{

    if(y != 0)
    {
        //设置年份
        year = y;
    }
    else
    {
        //设置为本年
        year=[comps year];
    }
    
    if(m != 0)
    {
        //设置月份
        month = m;
    }
    else
    {
        //设置为本月
        month = [comps month];
    }
    
    day = d;
    
    //设置格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld",year,month,day];
    date2 = [dateFormatter dateFromString:dateString];
    
    //求出两天间隔
    NSTimeInterval intervalTime = [date2 timeIntervalSinceDate:now];
    NSInteger interval = ((NSInteger)intervalTime)/(3600*24);
    
    //算出月首是周几
    NSInteger firstDay;
    if(interval < 0)
    {
        interval = -interval;
        firstDay = week-(interval%7);
        if(firstDay <= 0)
        {
            firstDay = firstDay + 7;
        }
    }
    else
    {
        interval = interval + 1;
        firstDay = (interval+week)%7;
        if(firstDay == 0)
        {
            firstDay = 7;
        }
    }
    
    thisMonth = [[NSString alloc]initWithFormat:@"%ld",month];

    if([thirty_one indexOfObject:thisMonth] != NSNotFound)
    {
        //显示该月月历（31天）
        [self showMonth:firstDay dayOfMonth:31 setNumber:1 setMonth:month];
    }
    else if ([thirty indexOfObject:thisMonth] != NSNotFound)
    {
        //显示该月月历（30天）
        [self showMonth:firstDay dayOfMonth:30 setNumber:1 setMonth:month];
    }
    else
    {
        if(year%4 == 0)
        {
            //显示该月月历（29天）
            [self showMonth:firstDay dayOfMonth:29 setNumber:1 setMonth:month];
        }
        else
        {
            //显示该月月历（28天）
            [self showMonth:firstDay dayOfMonth:28 setNumber:1 setMonth:month];
        }
    }
 
}

//显示某年年历 y:年
- (void)showYearCalendar:(NSInteger)y
{
    for(int i=0;i<12;i++)
    {
        //清空数组
        if(i%3 == 0)
        {
            for(int j=0;j<6;j++)
            {
                memset(month1[j], 0, 7);
                memset(month2[j], 0, 7);
                memset(month3[j], 0, 7);
            }
        }
        
        //设置年份
        year = y;

        //设置月份
        month = i+1;
        
        //设置为月首
        day = 1;
        
        //设置格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [[NSString alloc] initWithFormat:@"%ld-%ld-%ld",year,month,day];
        date2 = [dateFormatter dateFromString:dateString];
        
        //求出两天间隔
        NSTimeInterval intervalTime = [date2 timeIntervalSinceDate:now];
        NSInteger interval = ((NSInteger)intervalTime)/(3600*24);
        
        //算出月首是周几
        NSInteger firstDay;
        if(interval < 0)
        {
            interval = -interval;
            firstDay = week-(interval%7);
            if(firstDay < 0)
            {
                firstDay = firstDay + 7;
            }
        }
        else
        {
            interval = interval + 1;
            firstDay = (interval+week)%7;
            if(firstDay == 0)
            {
                firstDay = 7;
            }
        }
        
        thisMonth = [[NSString alloc]initWithFormat:@"%ld",month];

        if([thirty_one indexOfObject:thisMonth] != NSNotFound)
        {
           //该月31天
           [self showMonth:firstDay dayOfMonth:31 setNumber:(i%3)+2 setMonth:i+1];
        }
        else if ([thirty indexOfObject:thisMonth] != NSNotFound)
        {
            //该月有30天
            [self showMonth:firstDay dayOfMonth:30 setNumber:(i%3)+2 setMonth:i+1];
        }
        else
        {
            if(year%4 == 0)
            {
                //该月有29天
                [self showMonth:firstDay dayOfMonth:29 setNumber:(i%3)+2 setMonth:i+1];
            }
            else
            {
                //该月有28天
                [self showMonth:firstDay dayOfMonth:28 setNumber:(i%3)+2 setMonth:i+1];
            }
        }
    }
}

//输出日历 firstDay：本日周几 dom：每月天数 num：标记 mon：月份
- (void)showMonth:(NSInteger)firstDay dayOfMonth:(NSInteger)dom setNumber:(NSInteger)num setMonth:(NSInteger)mon
{
    if(num == 1)
    {
        printf("    %s %ld        \n",[[month_array objectAtIndex:mon-1]UTF8String],year);
        printf("日 一 二 三 四 五 六 \n");
        //显示单月月历
        if(firstDay != 7)
        {
            for(int i=1;i<=firstDay;i++)
            {
                printf("   ");
            }
        }
        for(int i=1;i<=dom;i++)
        {
            printf("%2d ",i);
            if(i%7==(7-firstDay))
            {
                printf("\n");
            }
        }
        if(firstDay != (35%dom))
        {
            printf("\n");
        }
    }
    else
    {
        //显示年历
        for(int j=0;j<6;j++)
        {
            for(int k=j*7;k<j*7+7;k++)
            {
                if(k<(firstDay%7) || k>(dom-1+(firstDay%7)))
                {
                    if(num == 2)
                    {
                        month1[j][k%7] = 0;
                    }
                    else if(num == 3)
                    {
                        month2[j][k%7] = 0;
                    }
                    else if (num == 4)
                    {
                        month3[j][k%7] = 0;
                    }
                }
                else
                {
                    if(num == 2)
                    {
                        month1[j][k%7] = k+1-(firstDay%7);
                    }
                    else if(num == 3)
                    {
                        month2[j][k%7] = k+1-(firstDay%7);
                    }
                    else if(num == 4)
                    {
                        month3[j][k%7] = k+1-(firstDay%7);
                    }
                }
            }
        }
        
        if(num == 4)
        {
            if(mon == 3)
            {
                printf("                          %ld\n",year);
                printf("\n");
            }
            printf("        %s                %s                %s       \n",[[month_array objectAtIndex:mon-3]UTF8String],[[month_array objectAtIndex:mon-2]UTF8String],[[month_array objectAtIndex:mon-1]UTF8String]);
            printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
            for(int j=0;j<6;j++)
            {
                for(int k=j*7;k<j*7+7;k++)
                {
                    if(month1[j][k%7] == 0)
                    {
                        if(k%7 == 6)
                            printf("    ");
                        else
                            printf("   ");
                    }
                    else
                    {
                        if(k%7 == 6)
                            printf("%2d  ",month1[j][k%7]);
                        else
                            printf("%2d ",month1[j][k%7]);
                    }
                }
                for(int k=j*7;k<j*7+7;k++)
                {
                    if(month2[j][k%7] == 0)
                    {
                        if(k%7 == 6)
                            printf("    ");
                        else
                            printf("   ");
                    }
                    else
                    {
                        if(k%7 == 6)
                            printf("%2d  ",month2[j][k%7]);
                        else
                            printf("%2d ",month2[j][k%7]);
                    }
                }
                for(int k=j*7;k<j*7+7;k++)
                {
                    if(month3[j][k%7] == 0)
                    {
                        if(k%7 == 6)
                            printf("    ");
                        else
                            printf("   ");
                    }
                    else
                    {
                        if(k%7 == 6)
                            printf("%2d  ",month3[j][k%7]);
                        else
                            printf("%2d ",month3[j][k%7]);
                    }
                }
                printf("\n");
            }
        }
    }
}
@end
