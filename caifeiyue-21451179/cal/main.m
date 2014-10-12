//
//  main.m
//  cal
//
//  Created by 蔡飞跃 on 14-10-9.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取某个月天数
int Days(long int month,long int year)
{
    int days;
    
    if (month==2)
    {
        if (year%4!=0)
            days=28;
        else if(year%100!=0 || year%400==0)
            days=29;
        else
            days=28;
    }
    else if (month==4 || month==6 || month==9 || month==11)
        days=30;
    else
        days=31;
    
    return days;
}

//获取某个月第一天的星期
long int Weekday(long int month,long int year)
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld",month,1,(long)year];
    date = [formatter dateFromString:firstDay];
    comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    NSInteger weekday = [comps weekday];

    return weekday;
}

//输出月份格式
void Printmonth(long int month)
{
    switch(month){
        case 1:
            printf("一");
            break;
        case 2:
            printf("二");
            break;
        case 3:
            printf("三");
            break;
        case 4:
            printf("四");
            break;
        case 5:
            printf("五");
            break;
        case 6:
            printf("六");
            break;
        case 7:
            printf("七");
            break;
        case 8:
            printf("八");
            break;
        case 9:
            printf("九");
            break;
        case 10:
            printf("十");
            break;
        case 11:
            printf("十一");
            break;
        case 12:
            printf("十二");
            break;
        default:
            break;
    }
    
    printf("月");
}

//输出某月月历
void Output(long int weekday,int days)
{
    int i;
    
    printf("日 一 二 三 四 五 六\n");
    
    for(i=0;i<weekday-1;i++)
        printf("   ");
    //printf(" ");
    
    for (i=1;i<=days;i++)
    {
        printf("%2i",i);
        if ((i+weekday-1)%7 != 0)
            printf(" ");
        else  printf("\n");
    }
    
    printf("\n");
}



//主函数
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        
        //获取当前年份
        comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
        NSInteger year = [comps year];
        
        //获取当前月份
        comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
        NSInteger month = [comps month];
        
        //输出测试结果
        if(argc==1)   //输出当月月历
        {
            printf("     ");
            Printmonth(month);
            printf(" %li\n",year);
            Output(Weekday(month,year),Days(month,year));
        }
        else if (argc==2)   //输出某年整年的月历
        {
            year=atoi(argv[1]);
            
            printf("       %li\n",year);
            for(month=1;month<=12;month++)
            {
                printf("       ");
                Printmonth(month);
                printf("\n");
                Output(Weekday(month,year),Days(month,year));
            }
        }
        else if (argc==3)
        {
            char* p="-m";
            
            if ((strcmp(argv[1],p))==0)   //输出当年某月的月历
            {
                month=atoi(argv[2]);
                
                if(month>=1 && month<=12)
                {
                    printf("     ");
                    Printmonth(month);
                    printf(" %li\n",year);
                    Output(Weekday(month,year),Days(month,year));
                }
                else
                    printf("输入信息有误，无法识别.\n");
            }
            else   //输出特定年月的月历
            {
                month=atoi(argv[1]);
                year=atoi(argv[2]);
                
                if (month>=1 && month<=12)
                {
                    printf("     ");
                    Printmonth(month);
                    printf(" %li\n",year);
                    Output(Weekday(month,year),Days(month,year));
                }
                else
                    printf("输入信息有误，无法识别.\n");
            }
        }
    }
    return 0;
}





