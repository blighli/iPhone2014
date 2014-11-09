//
//  Header.m
//  cal
//
//  Created by Mac on 14-10-13.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

@implementation Month


    -(void) setYear:(int)y{
        
        year=y;
    }
    -(void) setMonth:(int)m{
        
        month=m;
    }
    -(void) setDays:(int)d{
        
        days=d;
    }
    -(void) setFirstday:(int)f{
        
        firstday=f;
    }

-(void) Countdays:(int)y andmonth:(int)m{
    
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
        days=31;
    }else if(month==4||month==6||month==9||month==11)
    {
        days=30;
    }else if(month==2&&((y%4==0)&&(y%100!=0)||y%400==0)){
        days=29;
    }else
    {
        days=28;
    }
    
}

-(int) CountFirstdays:(int)y andmonth:(int)m anddays:(int)d{
    if(m==1||m==-1)
    {
        m=13;
        y--;
    }else if(m==2){
        m=14;
        y--;
    }
    int a=y/100;
    y=y-a*100;
    int datetime=(d+2*month+3*(month+1)/5+y+y/4-y/100+y/400+1);
    datetime%=7;
    firstday=datetime;
    return(datetime);
    
    
}

-(void)setOutput:(int)y andmonth:(int)m anddays:(int)d andfirstday:(int)f{
    int b,c,posation;
    posation=m-1;
    b=posation/3;
    c=posation%3;
    int point;
    bool flags=false;
    point=Date[b*6][c*7];
    
    int i=1;
    while(i<=days)
    {
        for(int k=b*6;k<b*6+6;k++)
        {
            for(int j=c*7;j<c*7+7;j++)
            {
                
                if(!flags)
                {
                    j+=firstday;
                    flags=true;
                }
                if(i<=days)
                    Date[k][j]=i++;
            }
            
        }
   
    }
}


-(void) Output
{
    bool flag=true;
    for(int x=0;x<24;x++)
    {
        
        if(!(x%6)&&argc==2)
            printf(" 日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
        else if(flag)
        {
            printf(" 日 一 二 三 四 五 六\n");
            flag=false;
        }
        for(int y=0;y<21;y++)
        {
            if(!((y)%7))
                printf(" ");
            if(Date[x][y]==0)
            {
                printf("   ");
            }else{
                printf("%2d ",Date[x][y]);
            }
        }
        printf("\n");
    }
    
}

@end



@implementation Cal

-(void)OutputAll{
    
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    int now_year=(int)[comps year];
    int now_month=(int)[comps month];
    for(int i=0;i<12;i++)
        month[i]=[Month new];
    switch(argc){
        case 1:
            [month[1] setYear:now_year];
            [month[1] setMonth:now_month];
            [month[1] Countdays:now_year andmonth:now_month];
            [month[1] CountFirstdays:now_year andmonth:now_month anddays:1];
            [month[1] setOutput:now_year andmonth:1 anddays:1 andfirstday:1];
            [month[1] Output];
            break;
        case 2:
            for(int k=0;k<12;k++)
            {
                [month[k] setYear:argv1];
                [month[k] setMonth:k+1];
                [month[k] Countdays:argv1 andmonth:k+1];
                [month[k] CountFirstdays:argv1 andmonth:k+1 anddays:1];
                [month[k] setOutput:argv1 andmonth:k+1 anddays:1 andfirstday:1];
                
            }
            [month[1] Output];
            break;
        case 3:
            [month[1] setYear:argv2];
            [month[1] setMonth:argv1];
            [month[1] Countdays:argv2 andmonth:argv1];
            [month[1] CountFirstdays:argv2 andmonth:argv1 anddays:1];
            [month[1] setOutput:argv2 andmonth:1 anddays:1 andfirstday:1];
            [month[1] Output];
            
    }
    
}


-(void) setCanshuNum:(int)num{
    argc=num;
}
-(void) setArgv1:(int)agv1{
    argv1=agv1;
}
-(void) setArgv2:(int) agv2{
    argv2=agv2;
}




@end
