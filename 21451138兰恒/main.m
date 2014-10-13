//
//  main.m
//  Foundation_code
//
//  Created by lh on 14-10-12.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string.h>
#import <stdlib.h>
int monthDay[13] ={29,31,28,31,30,31,30,31,31,30,31,30,31};
char *monthHan[13]={" ","一","二","三","四","五","六","七","八","九","十","十一","十二"};

void processCal(NSInteger year,NSInteger month);
void proessAllmonth(NSInteger year);
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        int prnum = argc;
        if(prnum < 1)
        {
            printf("exit");
            exit(0);
        }
        else
        {
          
                switch (prnum)
                {
                    case 1:
                    {
                        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit |NSYearCalendarUnit fromDate:[NSDate date]];
                        
                        NSInteger month= [components month];
                        
                        NSInteger year= [components year];
                        
                        processCal(year,month);
                        
                        break;
                    }
                    case 2:
                    {
                        int  y = atoi(argv[1]);
                        NSInteger year = y;
                        proessAllmonth(year);
                        
                        break;
                    }
                    case 3:
                    {
                        if(!strcasecmp(argv[1],"-m"))
                        {
                            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit |NSYearCalendarUnit fromDate:[NSDate date]];
                            NSInteger year= [components year];
                            int x = atoi(argv[2]);
                            NSInteger month = x;
                            processCal(year,month);
                        }
                        else
                        {
                            int x = atoi(argv[1]);
                            int y = atoi(argv[2]);
                            NSInteger month = x;
                            NSInteger year =y;
                            processCal(year,month);
                            
                        }
                        
                        
                        break;
                    }
                    default:
                        break;
                }
            
        }
        
    }
    return 0;
}

void processCal(NSInteger year,NSInteger month)
{
    int day = 0,i;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    if(((year%4==0 && year%100!=0)||(year%400==0)) && month == 2)
    {
        day = monthDay[0];
    }
    else
    {
        day = monthDay[month];
    }
    day += (weekday-1);
    //printf("%ld,%ld,%ld,%d\n",year,month,weekday,day);
    printf("      %s月  %ld\n",monthHan[month],year);
    printf("日 一 二 三 四 五 六\n");
    for(i = 1;i <= day;i++)
    {
        if(i < weekday)
        {
            printf("   ");
        }
        else
        {
            printf("%2ld ",i - weekday+1);
            if(i % 7 == 0)
                printf("\n");
                
            
        }
        
    }
    printf("\n");
    

}

void proessAllmonth(NSInteger year)
{
    int i,j,k,m,n;
    int days[3] = {0};
    NSInteger weekdays[3] ={0};
    printf("                           %ld                         \n\n",year);
    for(i =0;i < 12;i++)
    {
        if(i % 3 == 0)
        {
            printf("        %s月                 %s月                 %s月\n",monthHan[i+1],monthHan[i+2],monthHan[i+3]);
            printf("日 一 二 三 四 五 六   日 一 二 三 四 五 六   日 一 二 三 四 五 六\n");
            
            for(k = 0;k<3;k++)
            {
                NSDateComponents *comps = [[NSDateComponents alloc] init];
                [comps setDay:1];
                [comps setMonth:i+k+1];
                [comps setYear:year];
                NSCalendar *gregorian = [[NSCalendar alloc]
                                         initWithCalendarIdentifier:NSGregorianCalendar];
                NSDate *date = [gregorian dateFromComponents:comps];
                NSDateComponents *weekdayComponents =
                [gregorian components:NSWeekdayCalendarUnit fromDate:date];
                NSInteger weekday = [weekdayComponents weekday];
                 
                if(((year % 4==0 && year % 100!=0)||(year % 400==0)) && i+k+1 == 2)
                {
                    days[k] = monthDay[0];
                }
                else
                {
                    days[k] = monthDay[i+k+1];
                }
                weekdays[k] = weekday;
                //printf("%ld\n",days[k]);
                
            }
            for(j = 0;j< 6;j++)
            {
                for(m = 0;m < 3;m++)
                {
                    for(n = 0;n < 7;n++)
                    {
                        if((j==0 && n<weekdays[m] -1)  || (j==4 && ((4*7+n -weekdays[m]+2) > days[m])) || (j==5 && ((5*7+n-weekdays[m] + 2 )> days[m])))
                            printf("   ");
                        else
                        {
                            printf("%2ld ",(j *7 )+ n-weekdays[m] +2);
                            
                            
                        }

                        
                    }
                                   
                    if(n == 7)
                        printf("  ");
                }
            
                if(m == 3)
                    printf("\n");
            }
        }
    }
    
 
    
    
    
    
}
