//
//  ShowCalendar.m
//  ZhouXiang
//
//  Created by 周翔 on 14-10-16.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShowCalendar.h"

@implementation ShowCalendar

const char *Month[] = {"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

-(void) printOneMonthCalendar:(int) month Year:(int) year

{
    
    NSLog(@"        %d %d",month,year);
    
    NSLog(@"日  一  二  三  四  五  六");
    
    int i,j=1,k=1;
    
    int nums = [self SumOfMonth:month Year:year];
    
    int start =[self FirstDate:month Year:year];
    
    for (i=1; i<=start-1; i++)
        
    printf("  ");
    
    for(i=start;i<=7;i++)
    
    printf(" %d\n",i);
    
    j++;
    
    for (i=j; i<=nums; i++,k++)
        
        if (k%7==0)
            
            printf("\n");
    
            
        else
            
            printf(" %d",i);
    
    
    
    
}

-(void) printWholeYearCalendar:(int) month Year:(int) year

{
    
    int l = 1, n = 1;
    
    for(l;l<=12;l++,n++)
    {
    if (n%3==0)
            
        printf("\n");
    
    else
    
    
        NSLog(@"     %s  %d",Month[l],year);
    
    
        NSLog(@"日  一  二  三  四  五  六");
    
    
        int i,j=1,k=1;
    
    
        int nums = [self SumOfMonth:month Year:year];
    
    
        int start =[self FirstDate:month Year:year];
    
    
        for (i=1; i<=start-1; i++)
        
        
            printf("  ");
    
    
        for(i=start;i<=7;i++)
        
        
            printf(" %d\n",i);
    
    
        j++;
    
    
        for (i=j; i<=nums; i++,k++)
        
        
            if (k%7==0)
            
            
                printf("\n");
    
    
        
            else
            
            
                printf(" %d",i);
        
    }
    
    
    
}

-(int) SumOfMonth:(int) month Year:(int) year

{
 
    int sums;
    
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
        
    {
        
        sums = 31;
        
    }
    
    if (month==4||month==6||month==9||month==11)
    
    {
        
        sums = 30;
        
    }
    
    if(month==2)
        
    {
    
        if(year%400==0||(year%4==0&&year%100!=0))
            
            sums = 29;
        
        else
            
            sums = 28;
        
    }
    
    return sums;
    
}

-(int) FirstDate:(int) month Year:(int) year

{
    
    NSDateComponents *compts = [[NSDateComponents alloc] init];
    
    [compts setDay:1];
    
    [compts setMonth:month];
    
    [compts setYear:year];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [calendar dateFromComponents:compts];
    
    NSDateComponents *wcompts = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    NSInteger firstday = [wcompts weekday];
    
    firstday -= firstday;
    
    return firstday;
    
    
}

@end
