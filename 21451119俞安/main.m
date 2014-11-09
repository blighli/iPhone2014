//
//  main.m
//  homework1
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "date1.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
       
        NSLog(@"%d",argc);
        if(argc==2)
        {
            NSCalendar *calander=[NSCalendar calendarWithIdentifier:NSGregorianCalendar];
            NSDateComponents *currentDateCom=[calander components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate date]];
            
            NSUInteger currentYear=[currentDateCom year];
            
            NSUInteger currentMonth=[currentDateCom month];
            
            date1 *cal=[[date1 alloc] initWithyear:currentYear];
            [cal printcalanderformonth:currentMonth];
            //输出当月日历
        
        
        }
        else if(argc==3)
        {
            NSUInteger currentYear=atoi(argv[2]);
            if(currentYear<=0 || currentYear>9999)
            {
                printf("Cal: year %ld 不在1-9999之间\r\n",currentYear);
            } else
            {
                date1 *cal=[[date1 alloc] initWithyear:currentYear];
                [cal printallyear];
            }
        }else if(argc==4)
        {
            NSLog(@"%s",argv[2]);
            
            if(strcmp(argv[2],"-m")==0)
            {
                NSCalendar *calander=[NSCalendar calendarWithIdentifier:NSGregorianCalendar];
                NSDateComponents *currentDateCom=[calander components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate date]];
                
                NSInteger currentYear=[currentDateCom year];
                int currentMonth=atoi(argv[3]);
            
                if(currentMonth>0 && currentMonth<=12)
                {
                    date1 *cal=[[date1 alloc] initWithyear:currentYear];
                    [cal printcalanderformonth:currentMonth];
                }else
                {
                    printf("%d 不在1-12之间\r\n",currentMonth);
                }
            }else
            {
                
                int currentMonth=atoi(argv[2]);
                int currentYear=atoi(argv[3]);
                if(currentMonth>0 && currentMonth<=12)
                {
                    if(currentYear>0 && currentYear<9999)
                    {
                        date1 *cal=[[date1 alloc] initWithyear:currentYear];
                        [cal printcalanderformonth:currentMonth];
                    }else
                    {
                        printf("%d 不在1-12之间\r\n",currentYear);
                    }
                }else
                {
                    printf("%d is 不在1-12之间\r\n",currentMonth);
                }
            }
        }else
        {
            printf("cal: illegal option\r\n");
            printf("usage: cal [-jy] [[month] year]\r\n");
            printf("cal [-j] [-m month] [year]\r\n");
        }
    }
    return 0;
}


    

