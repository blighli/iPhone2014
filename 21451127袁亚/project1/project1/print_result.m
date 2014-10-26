//
//  print_result.m
//  project1
//
//  Created by Frank Yuan on 10/25/12.
//  Copyright (c) 2012 Frank Yuan. All rights reserved.
//

#import "print_result.h"

@implementation print_result{
    
}
@synthesize m_month,m_year;
-(void)showResult{
    if (![self isValid]) {
        NSLog(@"Invalid arguments!");
        return;
    }
    int year=m_year;
    int month=m_month;
    printf("     %d年%2d月\n",year,month);
    printf(" 日 一 二 三 四 五 六\n");
    NSCalendar* cal=[NSCalendar currentCalendar];
    NSUInteger previousday=0;
        NSDateComponents* comps=[[NSDateComponents alloc]init];
        [comps setYear:year];
        [comps setMonth:month];
        [comps setDay:1];
        NSCalendar* g=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate* now=[g dateFromComponents:comps];
        NSUInteger firstday=[cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:now];
    for (int i=1; i<firstday; i++) {
        printf("   ");
    }
    for (int j=1; j<32; j++) {
        [comps setDay:j];
        now=[g dateFromComponents:comps];
        NSUInteger day=[cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:now];
        NSUInteger totalday=[cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
        if(totalday<previousday){
            printf("\n");
            return;
        }else{
            previousday=totalday;
        }
        printf("%2d ",j);
        if(day==7){
            printf("\n");
        }
    }
    printf("\n");
}
-(BOOL)isValid{
    int year=[self m_year];
    int month=[self m_month];
    if(year<0 || month>12 ||month<1)return NO;
    return YES;
}
-(id)init{
    self=[super init];
    [self setM_month:0];
    [self setM_year:0];
    return self;
}
@end
